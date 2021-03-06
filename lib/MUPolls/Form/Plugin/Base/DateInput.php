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
 * Date value input. Not ready for datetime fields, only for raw dates.
 *
 * You can also use all of the features from the Zikula_Form_Plugin_DateInput plugin since
 * the date input inherits from it.
 */
class MUPolls_Form_Plugin_Base_DateInput extends Zikula_Form_Plugin_DateInput
{
    /**
     * Get filename of this file.
     * The information is used to re-establish the plugins on postback.
     *
     * @return string
     */
    public function getFilename()
    {
        return __FILE__;
    }

    /**
     * Create event handler.
     *
     * @param Zikula_Form_View $view    Reference to Zikula_Form_View object.
     * @param array            &$params Parameters passed from the Smarty plugin function.
     *
     * @see    Zikula_Form_AbstractPlugin
     * @return void
     */
    public function create(Zikula_Form_View $view, &$params)
    {
        $this->readOnly = isset($params['readOnly']) ? $params['readOnly'] : false;

        // let parent plugin do the work in detail
        parent::create($view, $params);
    }

    /**
     * Helper method to determine css class.
     *
     * @see Zikula_Form_Plugin_TextInput
     *
     * @return string the list of css classes to apply
     */
    protected function getStyleClass()
    {
        $class = parent::getStyleClass();

        return str_replace('z-form-text', 'z-form-date', $class);
    }

    /**
     * Render event handler.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     *
     * @return string The rendered output
     */
    public function render(Zikula_Form_View $view)
    {
        if (!empty($this->defaultValue) && !$view->isPostBack()/* && empty($this->text)*/) {
            $d = strtolower($this->defaultValue);
            $now = getdate();
            $date = null;

            if ($d == 'now') {
                $date = time();
            } elseif ($d == 'today') {
                $date = mktime(0, 0, 0, $now['mon'], $now['mday'], $now['year']);
            } elseif ($d == 'monthstart') {
                $date = mktime(0, 0, 0, $now['mon'], 1, $now['year']);
            } elseif ($d == 'monthend') {
                $daysInMonth = date('t');
                $date = mktime(0, 0, 0, $now['mon'], $daysInMonth, $now['year']);
            } elseif ($d == 'yearstart') {
                $date = mktime(0, 0, 0, 1, 1, $now['year']);
            } elseif ($d == 'yearend') {
                $date = mktime(0, 0, 0, 12, 31, $now['year']);
            } elseif ($d == 'custom') {
                $date = strtotime($this->initDate);
            }

            if ($date != null) {
                $this->text = DateUtil::getDatetime($date, $this->ifFormat, false);
            } else {
                $this->text = __('Unknown date');
            }
        }

        if ($view->isPostBack() && !empty($this->text)) {
            $date = strtotime($this->text);
            $this->text = DateUtil::getDatetime($date, $this->ifFormat, false);
        }

        if (strlen($this->text) > 10) {
            $this->text = substr($this->text, 0, 10);
        }

        $defaultDate = new \DateTime($this->text);
        list ($dateFormat, $dateFormatJs) = $this->getDateFormat();

        include_once 'lib/viewplugins/function.jquery_datepicker.php';

        $params = array(
            'defaultdate' => $defaultDate,
            'displayelement' => $this->getId(),
            'readonly' => $this->readOnly,
            'displayformat_datetime' => $dateFormat,
            'displayformat_javascript' => $dateFormatJs
        );

        $result = smarty_function_jquery_datepicker($params, $view);

        $attributes = $this->renderAttributes($view) . ' class="' . $this->getStyleClass() . '" ';
        $idNamePattern = 'id="' . $this->getId() . '" name="' . $this->getId() . '" ';
        $result = str_replace($idNamePattern, $idNamePattern . $attributes, $result);

        return $result;
    }

    /**
     * Returns required date formats for PHP date and JavaScript.
     *
     * @return array List of date formats.
     */
    protected function getDateFormat()
    {
        $dateFormat = str_replace('%', '', $this->ifFormat);
        $dateFormatJs = str_replace(array('Y', 'm', 'd'), array('yy', 'mm', 'dd'), $dateFormat);

        return array($dateFormat, $dateFormatJs);
    }
}
