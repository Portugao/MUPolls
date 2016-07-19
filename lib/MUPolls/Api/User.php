<?php
/**
 * MUPolls.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MUPolls
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.7.0 (http://modulestudio.de).
 */

/**
 * This is the User api helper class.
 */
class MUPolls_Api_User extends MUPolls_Api_Base_User
{
    /*
     * This function is for getting votes of users saved
     * 
     */
	public function vote($args) 
	{
		$pollId = $args['pollId'];
		$optionId = $args['optionId'];
		
		$entityManager = $this->getEntityManager();
		
		$newVote = new MUPolls_Entity_Vote();
		$newVote->setIdOfPoll($pollId);
		$newVote->setIdOfOption($optionId);
		$newVote->setWorkflowState('approved');
		
		$entityManager->persist($newVote);		
		$entityManager->flush();
		
		$votedMUPoll = SessionUtil::getVar('votedMUPoll');
		if (!$votedMUPoll) {
			$votedMUPoll = array();
			$votedMUPoll[] = $pollId;
			SessionUtil::setVar('votedMUPoll', $votedMUPoll);
		} else {
			$votedMUPoll[] = $pollId;
			SessionUtil::setVar('votedMUPoll', $votedMUPoll);
		}
		
		// we get a workflow helper
		$workflowHelper = new Zikula_Workflow('none', 'MUPolls');
		
		$votesRepository = $entityManager->getRepository('MUPolls_Entity_Vote');
		
		// we set all new votes into workflow table				
		$votes = $votesRepository->selectWhere();
		foreach ($votes as $vote) {
			$voteObject = $votesRepository->selectById($vote['id']);
			$workflowState = WorkflowUtil::getWorkflowState($voteObject, 'mupolls_vote');
			if ($workflowState == 'initial' || $workflowState === false) {
				// we set the datas into the workflow table
				$obj['__WORKFLOW__']['obj_table'] = 'vote';
				$obj['__WORKFLOW__']['obj_idcolumn'] = 'id';
				$obj['id'] = $vote['id'];
				$workflowHelper->registerWorkflow($obj, 'approved');
			}
		}

		
	}
	
	/**
	 * Returns available user panel links.
	 *
	 * @return array Array of user links.
	 */
	public function getLinks()
	{
		$links = array();
	
		$controllerHelper = new MUPolls_Util_Controller($this->serviceManager);
		$utilArgs = array('api' => 'user', 'action' => 'getLinks');
		$allowedObjectTypes = $controllerHelper->getObjectTypes('api', $utilArgs);
	
		$currentType = $this->request->query->filter('type', 'poll', FILTER_SANITIZE_STRING);
		$currentLegacyType = $this->request->query->filter('lct', 'user', FILTER_SANITIZE_STRING);
		$permLevel = in_array('admin', array($currentType, $currentLegacyType)) ? ACCESS_ADMIN : ACCESS_READ;
	
		if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
			$links[] = array(
					'url' => ModUtil::url($this->name, 'admin', 'main'),
					'text' => $this->__('Backend'),
					'title' => $this->__('Switch to administration area.'),
					'class' => 'z-icon-es-options'
			);
		}
	
		if (in_array('poll', $allowedObjectTypes)
			&& SecurityUtil::checkPermission($this->name . ':Poll:', '::', $permLevel)) {
				$links[] = array(
					'url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'poll')),
					'text' => $this->__('Polls'),
					'title' => $this->__('Poll list')
					);
		}
	
				return $links;
	}
}
