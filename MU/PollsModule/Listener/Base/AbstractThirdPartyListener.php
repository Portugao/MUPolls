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
use Symfony\Component\HttpKernel\HttpKernelInterface;
use Zikula\Common\Collection\Collectible\PendingContentCollectible;
use Zikula\Common\Collection\Container;
use Zikula\Core\Event\GenericEvent;
use MU\PollsModule\Helper\WorkflowHelper;

/**
 * Event handler implementation class for special purposes and 3rd party api support.
 */
abstract class AbstractThirdPartyListener implements EventSubscriberInterface
{
    /**
     * @var WorkflowHelper
     */
    protected $workflowHelper;
    
    /**
     * ThirdPartyListener constructor.
     *
     * @param WorkflowHelper $workflowHelper WorkflowHelper service instance
     *
     * @return void
     */
    public function __construct(WorkflowHelper $workflowHelper)
    {
        $this->workflowHelper = $workflowHelper;
    }
    
    /**
     * Makes our handlers known to the event system.
     */
    public static function getSubscribedEvents()
    {
        return [
            'get.pending_content'                     => ['pendingContentListener', 5],
        ];
    }
    
    /**
     * Listener for the `get.pending_content` event which collects information from modules
     * about pending content items waiting for approval.
     *
     * You can access general data available in the event.
     *
     * The event name:
     *     `echo 'Event: ' . $event->getName();`
     *
     * @param GenericEvent $event The event instance
     */
    public function pendingContentListener(GenericEvent $event)
    {
        $collection = new Container('MUPollsModule');
        $amounts = $this->workflowHelper->collectAmountOfModerationItems();
        if (count($amounts) > 0) {
            foreach ($amounts as $amountInfo) {
                $aggregateType = $amountInfo['aggregateType'];
                $description = $amountInfo['description'];
                $amount = $amountInfo['amount'];
                $route = 'mupollsmodule_' . strtolower($amountInfo['objectType']) . '_adminview';
                $routeArgs = [
                    'workflowState' => $amountInfo['state']
                ];
                $item = new PendingContentCollectible($aggregateType, $description, $amount, $route, $routeArgs);
                $collection->add($item);
            }
        
            // add collected items for pending content
            if ($collection->count() > 0) {
                $event->getSubject()->add($collection);
            }
        }
    }
}