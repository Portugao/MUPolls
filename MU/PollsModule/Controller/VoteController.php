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

namespace MU\PollsModule\Controller;

use MU\PollsModule\Controller\Base\AbstractVoteController;

use RuntimeException;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Zikula\ThemeModule\Engine\Annotation\Theme;
use MU\PollsModule\Entity\VoteEntity;

/**
 * Vote controller class providing navigation and interaction functionality.
 */
class VoteController extends AbstractVoteController
{
    /**
     * @inheritDoc
     *
     * @Route("/admin/votes",
     *        methods = {"GET"}
     * )
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function adminIndexAction(Request $request)
    {
        return parent::adminIndexAction($request);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/votes",
     *        methods = {"GET"}
     * )
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function indexAction(Request $request)
    {
        return parent::indexAction($request);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/admin/votes/view/{sort}/{sortdir}/{pos}/{num}.{_format}",
     *        requirements = {"sortdir" = "asc|desc|ASC|DESC", "pos" = "\d+", "num" = "\d+", "_format" = "html|rss"},
     *        defaults = {"sort" = "", "sortdir" = "asc", "pos" = 1, "num" = 10, "_format" = "html"},
     *        methods = {"GET"}
     * )
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     * @param string $sort         Sorting field
     * @param string $sortdir      Sorting direction
     * @param int    $pos          Current pager position
     * @param int    $num          Amount of entries to display
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function adminViewAction(Request $request, $sort, $sortdir, $pos, $num)
    {
        return parent::adminViewAction($request, $sort, $sortdir, $pos, $num);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/votes/view/{sort}/{sortdir}/{pos}/{num}.{_format}",
     *        requirements = {"sortdir" = "asc|desc|ASC|DESC", "pos" = "\d+", "num" = "\d+", "_format" = "html|rss"},
     *        defaults = {"sort" = "", "sortdir" = "asc", "pos" = 1, "num" = 10, "_format" = "html"},
     *        methods = {"GET"}
     * )
     *
     * @param Request $request Current request instance
     * @param string $sort         Sorting field
     * @param string $sortdir      Sorting direction
     * @param int    $pos          Current pager position
     * @param int    $num          Amount of entries to display
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function viewAction(Request $request, $sort, $sortdir, $pos, $num)
    {
        return parent::viewAction($request, $sort, $sortdir, $pos, $num);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/admin/vote/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"_format" = "html"},
     *        methods = {"GET"}
     * )
     * @ParamConverter("vote", class="MUPollsModule:VoteEntity", options = {"repository_method" = "selectById", "mapping": {"id": "id"}, "map_method_signature" = true})
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     * @param VoteEntity $vote Treated vote instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if vote to be displayed isn't found
     */
    public function adminDisplayAction(Request $request, VoteEntity $vote)
    {
        return parent::adminDisplayAction($request, $vote);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/vote/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"_format" = "html"},
     *        methods = {"GET"}
     * )
     * @ParamConverter("vote", class="MUPollsModule:VoteEntity", options = {"repository_method" = "selectById", "mapping": {"id": "id"}, "map_method_signature" = true})
     *
     * @param Request $request Current request instance
     * @param VoteEntity $vote Treated vote instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if vote to be displayed isn't found
     */
    public function displayAction(Request $request, VoteEntity $vote)
    {
        return parent::displayAction($request, $vote);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/admin/vote/edit/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"id" = "0", "_format" = "html"},
     *        methods = {"GET", "POST"}
     * )
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by form handler if vote to be edited isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function adminEditAction(Request $request)
    {
        return parent::adminEditAction($request);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/vote/edit/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"id" = "0", "_format" = "html"},
     *        methods = {"GET", "POST"}
     * )
     *
     * @param Request $request Current request instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by form handler if vote to be edited isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function editAction(Request $request)
    {
        return parent::editAction($request);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/admin/vote/delete/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"_format" = "html"},
     *        methods = {"GET", "POST"}
     * )
     * @ParamConverter("vote", class="MUPollsModule:VoteEntity", options = {"repository_method" = "selectById", "mapping": {"id": "id"}, "map_method_signature" = true})
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     * @param VoteEntity $vote Treated vote instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if vote to be deleted isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function adminDeleteAction(Request $request, VoteEntity $vote)
    {
        return parent::adminDeleteAction($request, $vote);
    }
    
    /**
     * @inheritDoc
     *
     * @Route("/vote/delete/{id}.{_format}",
     *        requirements = {"id" = "\d+", "_format" = "html"},
     *        defaults = {"_format" = "html"},
     *        methods = {"GET", "POST"}
     * )
     * @ParamConverter("vote", class="MUPollsModule:VoteEntity", options = {"repository_method" = "selectById", "mapping": {"id": "id"}, "map_method_signature" = true})
     *
     * @param Request $request Current request instance
     * @param VoteEntity $vote Treated vote instance
     *
     * @return Response Output
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     * @throws NotFoundHttpException Thrown by param converter if vote to be deleted isn't found
     * @throws RuntimeException      Thrown if another critical error occurs (e.g. workflow actions not available)
     */
    public function deleteAction(Request $request, VoteEntity $vote)
    {
        return parent::deleteAction($request, $vote);
    }
    
    /**
     * Process status changes for multiple items.
     *
     * This function processes the items selected in the admin view page.
     * Multiple items may have their state changed or be deleted.
     *
     * @Route("/admin/votes/handleSelectedEntries",
     *        methods = {"POST"}
     * )
     * @Theme("admin")
     *
     * @param Request $request Current request instance
     *
     * @return RedirectResponse
     *
     * @throws RuntimeException Thrown if executing the workflow action fails
     */
    public function adminHandleSelectedEntriesAction(Request $request)
    {
        return parent::adminHandleSelectedEntriesAction($request);
    }
    
    /**
     * Process status changes for multiple items.
     *
     * This function processes the items selected in the admin view page.
     * Multiple items may have their state changed or be deleted.
     *
     * @Route("/votes/handleSelectedEntries",
     *        methods = {"POST"}
     * )
     *
     * @param Request $request Current request instance
     *
     * @return RedirectResponse
     *
     * @throws RuntimeException Thrown if executing the workflow action fails
     */
    public function handleSelectedEntriesAction(Request $request)
    {
        return parent::handleSelectedEntriesAction($request);
    }
    
    /**
     * This method cares for a redirect within an inline frame.
     *
     * @Route("/vote/handleInlineRedirect/{idPrefix}/{commandName}/{id}",
     *        requirements = {"id" = "\d+"},
     *        defaults = {"commandName" = "", "id" = 0},
     *        methods = {"GET"}
     * )
     *
     * @param string  $idPrefix    Prefix for inline window element identifier
     * @param string  $commandName Name of action to be performed (create or edit)
     * @param integer $id          Identifier of created vote (used for activating auto completion after closing the modal window)
     *
     * @return PlainResponse Output
     */
    public function handleInlineRedirectAction($idPrefix, $commandName, $id = 0)
    {
        return parent::handleInlineRedirectAction($idPrefix, $commandName, $id);
    }
    
    // feel free to add your own controller methods here
}