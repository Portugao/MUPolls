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
 * The mupollsGetListEntry modifier displays the name
 * or names for a given list item.
 * Example:
 *     {$entity.listField|mupollsGetListEntry:'entityName':'fieldName'}
 *
 * @param string $value      The dropdown value to process
 * @param string $objectType The treated object type
 * @param string $fieldName  The list field's name
 * @param string $delimiter  String used as separator for multiple selections
 *
 * @return string List item name
 */
function smarty_modifier_mupollsGetListEntry($value, $objectType = '', $fieldName = '', $delimiter = ', ')
{
    if ((empty($value) && $value != '0') || empty($objectType) || empty($fieldName)) {
        return $value;
    }

    $serviceManager = ServiceUtil::getManager();
    $helper = new MUPolls_Util_ListEntries($serviceManager);

    return $helper->resolve($value, $objectType, $fieldName, $delimiter);
}
