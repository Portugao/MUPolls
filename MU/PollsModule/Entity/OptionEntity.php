<?php
/**
 * Polls.
 *
 * @copyright Michael Ueberschaer (MU)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @author Michael Ueberschaer <kontakt@webdesign-in-bremen.com>.
 * @link http://webdesign-in-bremen.com
 * @link http://zikula.org
 * @version Generated by ModuleStudio (http://modulestudio.de).
 */

namespace MU\PollsModule\Entity;

use MU\PollsModule\Entity\Base\AbstractOptionEntity as BaseEntity;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for option entities.
 * @Gedmo\TranslationEntity(class="MU\PollsModule\Entity\OptionTranslationEntity")
 * @ORM\Entity(repositoryClass="MU\PollsModule\Entity\Repository\OptionRepository")
 * @ORM\Table(name="mu_polls_option",
 *     indexes={
 *         @ORM\Index(name="workflowstateindex", columns={"workflowState"})
 *     }
 * )
 */
class OptionEntity extends BaseEntity
{
    // feel free to add your own methods here
}
