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
 * The mupollsObjectTypeSelector plugin provides items for a dropdown selector.
 *
 * Available parameters:
 *   - assign: If set, the results are assigned to the corresponding variable instead of printed out.
 *
 * @param  array            $params All attributes passed to this function from the template
 * @param  Zikula_Form_View $view   Reference to the view object
 *
 * @return string The output of the plugin
 */
function smarty_function_mupollsObjectTypeSelector($params, $view)
{
    $dom = ZLanguage::getModuleDomain('MUPolls');
    $result = array();

    $result[] = array('text' => __('Options', $dom), 'value' => 'option');
    $result[] = array('text' => __('Polls', $dom), 'value' => 'poll');
    $result[] = array('text' => __('Votes', $dom), 'value' => 'vote');

    if (array_key_exists('assign', $params)) {
        $view->assign($params['assign'], $result);

        return;
    }

    return $result;
}
