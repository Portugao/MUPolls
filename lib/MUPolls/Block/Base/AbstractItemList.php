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
 * @version Generated by ModuleStudio (http://modulestudio.de).
 */

/**
 * Generic item list block base class.
 */
abstract class MUPolls_Block_Base_AbstractItemList extends Zikula_Controller_AbstractBlock
{
    /**
     * Initialise the block.
     */
    public function init()
    {
        //SecurityUtil::registerPermissionSchema('MUPolls:ItemListBlock:', 'Block title::');
    }
    
    /**
     * Get information on the block.
     *
     * @return array The block information
     */
    public function info()
    {
        $requirementMessage = '';
        // check if the module is available at all
        if (!ModUtil::available('MUPolls')) {
            $requirementMessage .= $this->__('Notice: This block will not be displayed until you activate the MUPolls module.');
        }
    
        return array(
            'module'          => 'MUPolls',
            'text_type'       => $this->__('MUPolls list view'),
            'text_type_long'  => $this->__('Display list of MUPolls objects.'),
            'allow_multiple'  => true,
            'form_content'    => false,
            'form_refresh'    => false,
            'show_preview'    => true,
            'admin_tableless' => true,
            'requirement'     => $requirementMessage
        );
    }
    
    /**
     * Display the block content.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return string output of the rendered block
     */
    public function display($blockinfo)
    {
        // only show block content if the user has the required permissions
        if (!SecurityUtil::checkPermission('MUPolls:ItemListBlock:', "$blockinfo[title]::", ACCESS_OVERVIEW)) {
            return false;
        }
    
        // check if the module is available at all
        if (!ModUtil::available('MUPolls')) {
            return false;
        }
    
        // get current block content
        $properties = BlockUtil::varsFromContent($blockinfo['content']);
        $properties['bid'] = $blockinfo['bid'];
    
        // set default values for all params which are not properly set
        $defaults = $this->getDefaults();
        $properties = array_merge($defaults, $properties);
    
        ModUtil::initOOModule('MUPolls');
    
        $controllerHelper = new MUPolls_Util_Controller($this->serviceManager);
        $utilArgs = array('name' => 'list');
        if (!isset($properties['objectType']) || !in_array($properties['objectType'], $controllerHelper->getObjectTypes('block', $utilArgs))) {
            $properties['objectType'] = $controllerHelper->getDefaultObjectType('block', $utilArgs);
        }
    
        $objectType = $properties['objectType'];
    
        $entityClass = 'MUPolls_Entity_' . ucfirst($objectType);
        $entityManager = $this->serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);
    
        $this->view->setCaching(Zikula_View::CACHE_ENABLED);
        // set cache id
        $component = 'MUPolls:' . ucfirst($objectType) . ':';
        $instance = '::';
        $accessLevel = ACCESS_READ;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) {
            $accessLevel = ACCESS_COMMENT;
        }
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
            $accessLevel = ACCESS_EDIT;
        }
        $this->view->setCacheId('view|ot_' . $objectType . '_sort_' . $properties['sorting'] . '_amount_' . $properties['amount'] . '_' . $accessLevel);
    
        $template = $this->getDisplayTemplate($properties);
    
        // if page is cached return cached content
        if ($this->view->is_cached($template)) {
            $blockinfo['content'] = $this->view->fetch($template);
    
            return BlockUtil::themeBlock($blockinfo);
        }
    
        // create query
        $where = $properties['filter'];
        $orderBy = $this->getSortParam($properties, $repository);
        $qb = $repository->genericBaseQuery($where, $orderBy);
    
        // get objects from database
        $currentPage = 1;
        $resultsPerPage = $properties['amount'];
        list($query, $count) = $repository->getSelectWherePaginatedQuery($qb, $currentPage, $resultsPerPage);
        $entities = $repository->retrieveCollectionResult($query, $orderBy, true);
    
        // assign block vars and fetched data
        $this->view->assign('vars', $properties)
                   ->assign('objectType', $objectType)
                   ->assign('items', $entities)
                   ->assign($repository->getAdditionalTemplateParameters('block'));
    
        // set a block title
        if (empty($blockinfo['title'])) {
            $blockinfo['title'] = $this->__('MUPolls items');
        }
    
        $blockinfo['content'] = $this->view->fetch($template);
    
        // return the block to the theme
        return BlockUtil::themeBlock($blockinfo);
    }
    
    /**
     * Returns the template used for output.
     *
     * @param array $properties The block properties array
     *
     * @return string the template path
     */
    protected function getDisplayTemplate(array $properties)
    {
        $templateFile = $properties['template'];
        if ($templateFile == 'custom') {
            $templateFile = $properties['customTemplate'];
        }
    
        $templateForObjectType = str_replace('itemlist_', 'itemlist_' . $properties['objectType'] . '_', $templateFile);
    
        $template = '';
        if ($this->view->template_exists('contenttype/' . $templateForObjectType)) {
            $template = 'contenttype/' . $templateForObjectType;
        } elseif ($this->view->template_exists('block/' . $templateForObjectType)) {
            $template = 'block/' . $templateForObjectType;
        } elseif ($this->view->template_exists('contenttype/' . $templateFile)) {
            $template = 'contenttype/' . $templateFile;
        } elseif ($this->view->template_exists('block/' . $templateFile)) {
            $template = 'block/' . $templateFile;
        } else {
            $template = 'block/itemlist.tpl';
        }
    
        return $template;
    }
    
    /**
     * Determines the order by parameter for item selection.
     *
     * @param array               $properties The block properties array
     * @param Doctrine_Repository $repository The repository used for data fetching
     *
     * @return string the sorting clause
     */
    protected function getSortParam(array $properties, $repository)
    {
        if ($properties['sorting'] == 'random') {
            return 'RAND()';
        }
    
        $sortParam = '';
        if ($properties['sorting'] == 'newest') {
            $idFields = ModUtil::apiFunc('MUPolls', 'selection', 'getIdFields', array('ot' => $properties['objectType']));
            if (count($idFields) == 1) {
                $sortParam = $idFields[0] . ' DESC';
            } else {
                foreach ($idFields as $idField) {
                    if (!empty($sortParam)) {
                        $sortParam .= ', ';
                    }
                    $sortParam .= $idField . ' DESC';
                }
            }
        } elseif ($properties['sorting'] == 'default') {
            $sortParam = $repository->getDefaultSortingField() . ' ASC';
        }
    
        return $sortParam;
    }
    
    /**
     * Modify block settings.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return string output of the block editing form
     */
    public function modify($blockinfo)
    {
        // Get current content
        $properties = BlockUtil::varsFromContent($blockinfo['content']);
    
        // set default values for all params which are not properly set
        $defaults = $this->getDefaults();
        $properties = array_merge($defaults, $properties);
    
        $this->view->setCaching(Zikula_View::CACHE_DISABLED);
    
        // assign the appropriate values
        $this->view->assign($properties);
    
        // Return the output that has been generated by this function
        return $this->view->fetch('block/itemlist_modify.tpl');
    }
    
    /**
     * Update block settings.
     *
     * @param array $blockinfo the blockinfo structure
     *
     * @return array the modified blockinfo structure
     */
    public function update($blockinfo)
    {
        // Get current content
        $properties = BlockUtil::varsFromContent($blockinfo['content']);
    
        $properties['objectType'] = $this->request->request->filter('objecttype', 'poll', FILTER_SANITIZE_STRING);
        $properties['sorting'] = $this->request->request->filter('sorting', 'default', FILTER_SANITIZE_STRING);
        $properties['amount'] = (int) $this->request->request->filter('amount', 5, FILTER_VALIDATE_INT);
        $properties['template'] = $this->request->request->get('template', '');
        $properties['customTemplate'] = $this->request->request->get('customtemplate', '');
        $properties['filter'] = $this->request->request->get('filter', '');
    
        $controllerHelper = new MUPolls_Util_Controller($this->serviceManager);
        if (!in_array($properties['objectType'], $controllerHelper->getObjectTypes('block'))) {
            $properties['objectType'] = $controllerHelper->getDefaultObjectType('block');
        }
    
        $primaryRegistry = ModUtil::apiFunc('MUPolls', 'category', 'getPrimaryProperty', array('ot' => $properties['objectType']));
        $properties['catIds'] = array($primaryRegistry => array());
        if (in_array($properties['objectType'], $this->categorisableObjectTypes)) {
            $properties['catIds'] = ModUtil::apiFunc('MUPolls', 'category', 'retrieveCategoriesFromRequest', array('ot' => $properties['objectType']));
        }
    
        // write back the new contents
        $blockinfo['content'] = BlockUtil::varsToContent($properties);
    
        // clear the block cache
        $this->view->clear_cache('block/itemlist_display.tpl');
        $this->view->clear_cache('block/itemlist_' . $properties['objectType'] . '_display.tpl');
        $this->view->clear_cache('block/itemlist_display_description.tpl');
        $this->view->clear_cache('block/itemlist_' . $properties['objectType'] . '_display_description.tpl');
    
        return $blockinfo;
    }
    
    /**
     * Returns default settings for this block.
     *
     * @return array The default settings
     */
    protected function getDefaults()
    {
        $defaults = array(
            'objectType' => 'poll',
            'sorting' => 'default',
            'amount' => 5,
            'template' => 'itemlist_display.tpl',
            'customTemplate' => '',
            'filter' => ''
        );
    
        return $defaults;
    }
    
}
