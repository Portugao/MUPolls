<?php
/**
 * Polls.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @author Michael Ueberschaer <info@homepages-mit-zikula.de>.
 * @link https://homepages-mit-zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio (https://modulestudio.de).
 */

namespace MU\PollsModule\Controller\Base;

use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Zikula\Core\Controller\AbstractController;

/**
 * Ajax controller base class.
 */
abstract class AbstractAjaxController extends AbstractController
{
    
    /**
     * Retrieve item list for finder selections in Forms, Content type plugin and Scribite.
     *
     * @param string $ot      Name of currently used object type
     * @param string $sort    Sorting field
     * @param string $sortdir Sorting direction
     *
     * @return JsonResponse
     */
    public function getItemListFinderAction(Request $request)
    {
        if (!$this->hasPermission('MUPollsModule::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
        
        $objectType = $request->query->getAlnum('ot', 'poll');
        $controllerHelper = $this->get('mu_polls_module.controller_helper');
        $contextArgs = ['controller' => 'ajax', 'action' => 'getItemListFinder'];
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $contextArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $contextArgs);
        }
        
        $repository = $this->get('mu_polls_module.entity_factory')->getRepository($objectType);
        $entityDisplayHelper = $this->get('mu_polls_module.entity_display_helper');
        $descriptionFieldName = $entityDisplayHelper->getDescriptionFieldName($objectType);
        
        $sort = $request->query->getAlnum('sort', '');
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
        
        $sdir = strtolower($request->query->getAlpha('sortdir', ''));
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }
        
        $where = ''; // filters are processed inside the repository class
        $searchTerm = $request->query->get('q', '');
        $sortParam = $sort . ' ' . $sdir;
        
        $entities = [];
        if ($searchTerm != '') {
            list ($entities, $totalAmount) = $repository->selectSearch($searchTerm, [], $sortParam, 1, 50);
        } else {
            $entities = $repository->selectWhere($where, $sortParam);
        }
        
        $slimItems = [];
        $component = 'MUPollsModule:' . ucfirst($objectType) . ':';
        foreach ($entities as $item) {
            $itemId = $item->getKey();
            if (!$this->hasPermission($component, $itemId . '::', ACCESS_READ)) {
                continue;
            }
            $slimItems[] = $this->prepareSlimItem($repository, $objectType, $item, $itemId, $descriptionFieldName);
        }
        
        // return response
        return new JsonResponse($slimItems);
    }
    
    /**
     * Builds and returns a slim data array from a given entity.
     *
     * @param EntityRepository $repository       Repository for the treated object type
     * @param string           $objectType       The currently treated object type
     * @param object           $item             The currently treated entity
     * @param string           $itemId           Data item identifier(s)
     * @param string           $descriptionField Name of item description field
     *
     * @return array The slim data representation
     */
    protected function prepareSlimItem($repository, $objectType, $item, $itemId, $descriptionField)
    {
        $previewParameters = [
            $objectType => $item
        ];
        $contextArgs = ['controller' => $objectType, 'action' => 'display'];
        $previewParameters = $this->get('mu_polls_module.controller_helper')->addTemplateParameters($objectType, $previewParameters, 'controllerAction', $contextArgs);
    
        $previewInfo = base64_encode($this->get('twig')->render('@MUPollsModule/External/' . ucfirst($objectType) . '/info.html.twig', $previewParameters));
    
        $title = $this->get('mu_polls_module.entity_display_helper')->getFormattedTitle($item);
        $description = $descriptionField != '' ? $item[$descriptionField] : '';
    
        return [
            'id'          => $itemId,
            'title'       => str_replace('&amp;', '&', $title),
            'description' => $description,
            'previewInfo' => $previewInfo
        ];
    }
    
    /**
     * Searches for entities for auto completion usage.
     *
     * @param Request $request Current request instance
     *
     * @return JsonResponse
     */
    public function getItemListAutoCompletionAction(Request $request)
    {
        if (!$this->hasPermission('MUPollsModule::Ajax', '::', ACCESS_EDIT)) {
            return true;
        }
        
        $objectType = $request->query->getAlnum('ot', 'poll');
        $controllerHelper = $this->get('mu_polls_module.controller_helper');
        $contextArgs = ['controller' => 'ajax', 'action' => 'getItemListAutoCompletion'];
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $contextArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('controllerAction', $contextArgs);
        }
        
        $repository = $this->get('mu_polls_module.entity_factory')->getRepository($objectType);
        $fragment = $request->query->get('fragment', '');
        $exclude = $request->query->get('exclude', '');
        $exclude = !empty($exclude) ? explode(',', str_replace(', ', ',', $exclude)) : [];
        
        // parameter for used sorting field
        $sort = $request->query->get('sort', '');
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
            $request->query->set('sort', $sort);
            // set default sorting in route parameters (e.g. for the pager)
            $routeParams = $request->attributes->get('_route_params');
            $routeParams['sort'] = $sort;
            $request->attributes->set('_route_params', $routeParams);
        }
        $sortParam = $sort . ' asc';
        
        $currentPage = 1;
        $resultsPerPage = 20;
        
        // get objects from database
        list($entities, $objectCount) = $repository->selectSearch($fragment, $exclude, $sortParam, $currentPage, $resultsPerPage);
        
        $resultItems = [];
        
        if ((is_array($entities) || is_object($entities)) && count($entities) > 0) {
            $entityDisplayHelper = $this->get('mu_polls_module.entity_display_helper');
            $descriptionFieldName = $entityDisplayHelper->getDescriptionFieldName($objectType);
            foreach ($entities as $item) {
                $itemTitle = $entityDisplayHelper->getFormattedTitle($item);
                $itemDescription = isset($item[$descriptionFieldName]) && !empty($item[$descriptionFieldName]) ? $item[$descriptionFieldName] : '';//$this->__('No description yet.')
                if (!empty($itemDescription)) {
                    $itemDescription = substr($itemDescription, 0, 50) . '&hellip;';
                }
        
                $resultItem = [
                    'id' => $item->getKey(),
                    'title' => $itemTitle,
                    'description' => $itemDescription,
                    'image' => ''
                ];
        
                $resultItems[] = $resultItem;
            }
        }
        
        return new JsonResponse($resultItems);
    }
    
    /**
     * Attachs a given hook assignment by creating the corresponding assignment data record.
     *
     * @param Request $request Current request instance
     *
     * @return JsonResponse
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function attachHookObjectAction(Request $request)
    {
        if (!$this->hasPermission('MUPollsModule::Ajax', '::', ACCESS_EDIT)) {
            throw new AccessDeniedException();
        }
        
        $subscriberOwner = $request->request->get('owner', '');
        $subscriberAreaId = $request->request->get('areaId', '');
        $subscriberObjectId = $request->request->getInt('objectId', 0);
        $subscriberUrl = $request->request->get('url', '');
        $assignedEntity = $request->request->get('assignedEntity', '');
        $assignedId = $request->request->getInt('assignedId', 0);
        
        if (!$subscriberOwner || !$subscriberAreaId || !$subscriberObjectId || !$assignedEntity || !$assignedId) {
            return new JsonResponse($this->__('Error: invalid input.'), JsonResponse::HTTP_BAD_REQUEST);
        }
        
        $subscriberUrl = !empty($subscriberUrl) ? unserialize($subscriberUrl) : [];
        
        $assignment = new \MU\PollsModule\Entity\HookAssignmentEntity();
        $assignment->setSubscriberOwner($subscriberOwner);
        $assignment->setSubscriberAreaId($subscriberAreaId);
        $assignment->setSubscriberObjectId($subscriberObjectId);
        $assignment->setSubscriberUrl($subscriberUrl);
        $assignment->setAssignedEntity($assignedEntity);
        $assignment->setAssignedId($assignedId);
        $assignment->setUpdatedDate(new \DateTime());
        
        $entityManager = $this->get('mu_polls_module.entity_factory')->getObjectManager();
        $qb = $entityManager->persist($assignment);
        $qb = $entityManager->flush();
        
        // return response
        return new JsonResponse([
            'id' => $assignment->getId()
        ]);
    }
    
    /**
     * Detachs a given hook assignment by removing the corresponding assignment data record.
     *
     * @param Request $request Current request instance
     *
     * @return JsonResponse
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function detachHookObjectAction(Request $request)
    {
        if (!$this->hasPermission('MUPollsModule::Ajax', '::', ACCESS_EDIT)) {
            throw new AccessDeniedException();
        }
        
        $id = $request->request->getInt('id', 0);
        if (!$id) {
            return new JsonResponse($this->__('Error: invalid input.'), JsonResponse::HTTP_BAD_REQUEST);
        }
        
        $entityFactory = $this->get('mu_polls_module.entity_factory');
        $qb = $entityFactory->getObjectManager()->createQueryBuilder();
        $qb->delete('MU\PollsModule\Entity\HookAssignmentEntity', 'tbl')
           ->where('tbl.id = :identifier')
           ->setParameter('identifier', $id);
        
        $query = $qb->getQuery();
        $query->execute();
        
        // return response
        return new JsonResponse([
            'id' => $id
        ]);
    }
}
