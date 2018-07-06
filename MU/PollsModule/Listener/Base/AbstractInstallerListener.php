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

namespace MU\PollsModule\Listener\Base;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Zikula\Core\CoreEvents;
use Zikula\Core\Event\ModuleStateEvent;
use MU\PollsModule\Entity\Factory\EntityFactory;

/**
 * Event handler base class for module installer events.
 */
abstract class AbstractInstallerListener implements EventSubscriberInterface
{
    /**
     * @var EntityFactory
     */
    protected $entityFactory;
    
    /**
     * InstallerListener constructor.
     *
     * @param EntityFactory $entityFactory EntityFactory service instance
     */
    public function __construct(
        EntityFactory $entityFactory
    ) {
        $this->entityFactory = $entityFactory;
    }
    
    /**
     * Makes our handlers known to the event system.
     */
    public static function getSubscribedEvents()
    {
        return [
            CoreEvents::MODULE_INSTALL             => ['moduleInstalled', 5],
            CoreEvents::MODULE_POSTINSTALL         => ['modulePostInstalled', 5],
            CoreEvents::MODULE_UPGRADE             => ['moduleUpgraded', 5],
            CoreEvents::MODULE_ENABLE              => ['moduleEnabled', 5],
            CoreEvents::MODULE_DISABLE             => ['moduleDisabled', 5],
            CoreEvents::MODULE_REMOVE              => ['moduleRemoved', 5]
        ];
    }
    
    /**
     * Listener for the `module.install` event.
     *
     * Called after a module has been successfully installed.
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function moduleInstalled(ModuleStateEvent $event)
    {
    }
    
    /**
     * Listener for the `module.postinstall` event.
     *
     * Called after a module has been installed (on reload of the extensions view).
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function modulePostInstalled(ModuleStateEvent $event)
    {
    }
    
    /**
     * Listener for the `module.upgrade` event.
     *
     * Called after a module has been successfully upgraded.
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function moduleUpgraded(ModuleStateEvent $event)
    {
    }
    
    /**
     * Listener for the `module.enable` event.
     *
     * Called after a module has been successfully enabled.
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function moduleEnabled(ModuleStateEvent $event)
    {
    }
    
    /**
     * Listener for the `module.disable` event.
     *
     * Called after a module has been successfully disabled.
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function moduleDisabled(ModuleStateEvent $event)
    {
    }
    
    /**
     * Listener for the `module.remove` event.
     *
     * Called after a module has been successfully removed.
     * The event allows accessing the module bundle and the extension
     * information array using `$event->getModule()` and `$event->getModInfo()`.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param ModuleStateEvent $event The event instance
     */
    public function moduleRemoved(ModuleStateEvent $event)
    {
        $module = $event->getModule();
        if (null === $module || $module->getName() === 'MUPollsModule') {
            return;
        }
    
        // delete any existing hook assignments for the removed module
        $qb = $this->entityFactory->getObjectManager()->createQueryBuilder();
        $qb->delete('MU\PollsModule\Entity\HookAssignmentEntity', 'tbl')
           ->where('tbl.subscriberOwner = :moduleName')
           ->setParameter('moduleName', $module->getName());
    
        $query = $qb->getQuery();
        $query->execute();
    }
}
