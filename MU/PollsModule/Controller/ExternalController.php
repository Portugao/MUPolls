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

use MU\PollsModule\Controller\Base\AbstractExternalController;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;

/**
 * Controller for external calls implementation class.
 *
 * @Route("/external")
 */
class ExternalController extends AbstractExternalController
{
    /**
     * Displays one item of a certain object type using a separate template for external usages.
     *
     * @Route("/display/{objectType}/{id}/{source}/{displayMode}",
     *        requirements = {"id" = "\d+", "source" = "block|contentType|scribite", "displayMode" = "link|embed"},
     *        defaults = {"source" = "contentType", "displayMode" = "embed"},
     *        methods = {"GET"}
     * )
     *
     * @param Request $request     The current request
     * @param string  $objectType  The currently treated object type
     * @param int     $id          Identifier of the entity to be shown
     * @param string  $source      Source of this call (block, contentType, scribite)
     * @param string  $displayMode Display mode (link or embed)
     *
     * @return string Desired data output
     */
    public function displayAction(Request $request, $objectType, $id, $source, $displayMode)
    {
        return parent::displayAction($request, $objectType, $id, $source, $displayMode);
    }

    /**
     * Popup selector for Scribite plugins.
     * Finds items of a certain object type.
     *
     * @Route("/finder/{objectType}/{editor}/{sort}/{sortdir}/{pos}/{num}",
     *        requirements = {"editor" = "ckeditor|quill|summernote|tinymce", "sortdir" = "asc|desc", "pos" = "\d+", "num" = "\d+"},
     *        defaults = {"sort" = "", "sortdir" = "asc", "pos" = 1, "num" = 0},
     *        methods = {"GET"},
     *        options={"expose"=true}
     * )
     *
     * @param Request $request    The current request
     * @param string  $objectType The object type
     * @param string  $editor     Name of used Scribite editor
     * @param string  $sort       Sorting field
     * @param string  $sortdir    Sorting direction
     * @param int     $pos        Current pager position
     * @param int     $num        Amount of entries to display
     *
     * @return output The external item finder page
     *
     * @throws AccessDeniedException Thrown if the user doesn't have required permissions
     */
    public function finderAction(Request $request, $objectType, $editor, $sort, $sortdir, $pos = 1, $num = 0)
    {
        return parent::finderAction($request, $objectType, $editor, $sort, $sortdir, $pos, $num);
    }

    // feel free to extend the external controller here
}
