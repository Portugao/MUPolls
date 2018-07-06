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

namespace MU\PollsModule\Entity;

use MU\PollsModule\Entity\Base\AbstractPollEntity as BaseEntity;
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for poll entities.
 * @Gedmo\TranslationEntity(class="MU\PollsModule\Entity\PollTranslationEntity")
 * @ORM\Entity(repositoryClass="MU\PollsModule\Entity\Repository\PollRepository")
 * @ORM\Table(name="mu_polls_poll",
 *     indexes={
 *         @ORM\Index(name="workflowstateindex", columns={"workflowState"})
 *     }
 * )
 */
class PollEntity extends BaseEntity
{
    // feel free to add your own methods here
}