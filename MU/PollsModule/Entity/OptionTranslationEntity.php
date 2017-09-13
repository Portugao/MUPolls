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

use MU\PollsModule\Entity\Base\AbstractOptionTranslationEntity as BaseEntity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Entity extension domain class storing option translations.
 *
 * This is the concrete translation class for option entities.
 *
 * @ORM\Entity(repositoryClass="MU\PollsModule\Entity\Repository\OptionTranslationRepository")
 * @ORM\Table(name="mu_polls_option_translation",
 *     indexes={
 *         @ORM\Index(name="translations_lookup_idx", columns={
 *             "locale", "object_class", "foreign_key"
 *         })
 *     }
 * )
 */
class OptionTranslationEntity extends BaseEntity
{
    // feel free to add your own methods here
}
