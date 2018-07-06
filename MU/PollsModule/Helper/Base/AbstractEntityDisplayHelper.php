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

namespace MU\PollsModule\Helper\Base;

use IntlDateFormatter;
use Symfony\Component\HttpFoundation\RequestStack;
use Zikula\Common\Translator\TranslatorInterface;
use MU\PollsModule\Entity\OptionEntity;
use MU\PollsModule\Entity\PollEntity;
use MU\PollsModule\Entity\VoteEntity;
use MU\PollsModule\Helper\ListEntriesHelper;

/**
 * Entity display helper base class.
 */
abstract class AbstractEntityDisplayHelper
{
    /**
     * @var TranslatorInterface
     */
    protected $translator;

    /**
     * @var ListEntriesHelper Helper service for managing list entries
     */
    protected $listEntriesHelper;

    /**
     * @var IntlDateFormatter Formatter for dates
     */
    protected $dateFormatter;

    /**
     * EntityDisplayHelper constructor.
     *
     * @param TranslatorInterface $translator        Translator service instance
     * @param RequestStack        $requestStack      RequestStack service instance
     * @param ListEntriesHelper   $listEntriesHelper Helper service for managing list entries
     */
    public function __construct(
        TranslatorInterface $translator,
        RequestStack $requestStack,
        ListEntriesHelper $listEntriesHelper
    ) {
        $this->translator = $translator;
        $this->listEntriesHelper = $listEntriesHelper;
        $locale = null !== $requestStack->getCurrentRequest() ? $requestStack->getCurrentRequest()->getLocale() : null;
        $this->dateFormatter = new IntlDateFormatter($locale, IntlDateFormatter::NONE, IntlDateFormatter::NONE);
    }

    /**
     * Returns the formatted title for a given entity.
     *
     * @param object $entity The given entity instance
     *
     * @return string The formatted title
     */
    public function getFormattedTitle($entity)
    {
        if ($entity instanceof OptionEntity) {
            return $this->formatOption($entity);
        }
        if ($entity instanceof PollEntity) {
            return $this->formatPoll($entity);
        }
        if ($entity instanceof VoteEntity) {
            return $this->formatVote($entity);
        }
    
        return '';
    }
    
    /**
     * Returns the formatted title for a given entity.
     *
     * @param OptionEntity $entity The given entity instance
     *
     * @return string The formatted title
     */
    protected function formatOption(OptionEntity $entity)
    {
        return $this->translator->__f('%title%', [
            '%title%' => $entity->getTitle()
        ]);
    }
    
    /**
     * Returns the formatted title for a given entity.
     *
     * @param PollEntity $entity The given entity instance
     *
     * @return string The formatted title
     */
    protected function formatPoll(PollEntity $entity)
    {
        return $this->translator->__f('%title%', [
            '%title%' => $entity->getTitle()
        ]);
    }
    
    /**
     * Returns the formatted title for a given entity.
     *
     * @param VoteEntity $entity The given entity instance
     *
     * @return string The formatted title
     */
    protected function formatVote(VoteEntity $entity)
    {
        return $this->translator->__f('%idOfOption%', [
            '%idOfOption%' => $entity->getIdOfOption()
        ]);
    }
    
    /**
     * Returns name of the field used as title / name for entities of this repository.
     *
     * @param string $objectType Name of treated entity type
     *
     * @return string Name of field to be used as title
     */
    public function getTitleFieldName($objectType)
    {
        if ($objectType == 'option') {
            return 'title';
        }
        if ($objectType == 'poll') {
            return 'title';
        }
        if ($objectType == 'vote') {
            return '';
        }
    
        return '';
    }
    
    /**
     * Returns name of the field used for describing entities of this repository.
     *
     * @param string $objectType Name of treated entity type
     *
     * @return string Name of field to be used as description
     */
    public function getDescriptionFieldName($objectType)
    {
        if ($objectType == 'option') {
            return 'title';
        }
        if ($objectType == 'poll') {
            return 'description';
        }
        if ($objectType == 'vote') {
            return '';
        }
    
        return '';
    }
    
    /**
     * Returns name of the date(time) field to be used for representing the start
     * of this object. Used for providing meta data to the tag module.
     *
     * @param string $objectType Name of treated entity type
     *
     * @return string Name of field to be used as date
     */
    public function getStartDateFieldName($objectType)
    {
        if ($objectType == 'option') {
            return 'createdDate';
        }
        if ($objectType == 'poll') {
            return 'dateOfStart';
        }
        if ($objectType == 'vote') {
            return 'createdDate';
        }
    
        return '';
    }
}
