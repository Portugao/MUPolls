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
 * Replaces a given needle id by the corresponding content.
 *
 * @param array $args Arguments array
 *     int nid The needle id
 *
 * @return string Replaced value for the needle
 */
function MUPolls_needleapi_poll_base($args)
{
    // Get arguments from argument array
    $nid = $args['nid'];
    unset($args);

    // cache the results
    static $cache;
    if (!isset($cache)) {
        $cache = array();
    }

    $dom = \ZLanguage::getModuleDomain('MUPolls');

    if (empty($nid)) {
        return '<em>' . \DataUtil::formatForDisplay(__('No correct needle id given.', $dom)) . '</em>';
    }

    if (isset($cache[$nid])) {
        // needle is already in cache array
        return $cache[$nid];
    }

    if (!\ModUtil::available('MUPolls')) {
        $cache[$nid] = '<em>' . \DataUtil::formatForDisplay(__f('Module %s is not available.', array('MUPolls'), $dom)) . '</em>';

        return $cache[$nid];
    }

    // strip application prefix from needle
    $needleId = str_replace('MUPOLLS', '', $nid);

    if ($needleId == 'POLLS') {
        if (!\SecurityUtil::checkPermission('MUPolls:Poll:', '::', ACCESS_READ)) {
            $cache[$nid] = '';

            return $cache[$nid];
        }
    }

    $cache[$nid] = '<a href="' . ModUtil::url('MUPolls', 'poll', 'view') . '" title="' . __('View polls', $dom) . '">' . __('Polls', $dom) . '</a>';
    $needleParts = explode('-', $needleId);
    if ($needleParts[0] != 'POLL' || count($needleParts) < 2) {
        $cache[$nid] = '';

        return $cache[$nid];
    }

    $entityId = (int)$needleParts[1];

    if (!\SecurityUtil::checkPermission('MUPolls:Poll:', $entityId . '::', ACCESS_READ)) {
        $cache[$nid] = '';

        return $cache[$nid];
    }

    $entity = \ModUtil::apiFunc('MUPolls', 'selection', 'getEntity', array('ot' => 'poll', 'id' => $entityId));
    if (null === $entity) {
        $cache[$nid] = '<em>' . __f('Poll with id %s could not be found', array($entityId), $dom) . '</em>';

        return $cache[$nid];
    }

    $title = $entity->getTitleFromDisplayPattern();

    $cache[$nid] = '<a href="' . ModUtil::url('MUPolls', 'poll', 'display', array('id' => $entityId)) . '" title="' . str_replace('"', '', $title) . '">' . $title . '</a>';

    return $cache[$nid];
}
