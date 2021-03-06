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

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the concrete entity class for poll entities.
  * @Gedmo\TranslationEntity(class="MUPolls_Entity_PollTranslation")
 * @ORM\Entity(repositoryClass="MUPolls_Entity_Repository_Poll")
 * @ORM\Table(name="mupolls_poll",
 *     indexes={
 *         @ORM\Index(name="workflowstateindex", columns={"workflowState"})
 *     }
 * )
 * @ORM\HasLifecycleCallbacks
 */
class MUPolls_Entity_Poll extends MUPolls_Entity_Base_AbstractPoll
{
    // feel free to add your own methods here

    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     *
     * @ORM\PostLoad
     * @see MUPolls_Entity_Poll::performPostLoadCallback()
     * @return void
     */
    public function postLoadCallback()
    {
        $this->performPostLoadCallback();
    }
    
    /**
     * Pre-Process the data prior to an insert operation.
     *
     * @ORM\PrePersist
     * @see MUPolls_Entity_Poll::performPrePersistCallback()
     * @return void
     */
    public function prePersistCallback()
    {
        $this->performPrePersistCallback();
    }
    
    /**
     * Post-Process the data after an insert operation.
     *
     * @ORM\PostPersist
     * @see MUPolls_Entity_Poll::performPostPersistCallback()
     * @return void
     */
    public function postPersistCallback()
    {
        $this->performPostPersistCallback();
    }
    
    /**
     * Pre-Process the data prior a delete operation.
     *
     * @ORM\PreRemove
     * @see MUPolls_Entity_Poll::performPreRemoveCallback()
     * @return void
     */
    public function preRemoveCallback()
    {
        $this->performPreRemoveCallback();
    }
    
    /**
     * Post-Process the data after a delete.
     *
     * @ORM\PostRemove
     * @see MUPolls_Entity_Poll::performPostRemoveCallback()
     * @return void
     */
    public function postRemoveCallback()
    {
        $this->performPostRemoveCallback();
    }
    
    /**
     * Pre-Process the data prior to an update operation.
     *
     * @ORM\PreUpdate
     * @see MUPolls_Entity_Poll::performPreUpdateCallback()
     * @return void
     */
    public function preUpdateCallback()
    {
        $this->performPreUpdateCallback();
    }
    
    /**
     * Post-Process the data after an update operation.
     *
     * @ORM\PostUpdate
     * @see MUPolls_Entity_Poll::performPostUpdateCallback()
     * @return void
     */
    public function postUpdateCallback()
    {
        $this->performPostUpdateCallback();
    }
}
