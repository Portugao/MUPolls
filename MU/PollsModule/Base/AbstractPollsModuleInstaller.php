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

namespace MU\PollsModule\Base;

use Doctrine\DBAL\Connection;
use RuntimeException;
use Zikula\Core\AbstractExtensionInstaller;

/**
 * Installer base class.
 */
abstract class AbstractPollsModuleInstaller extends AbstractExtensionInstaller
{
    /**
     * Install the MUPollsModule application.
     *
     * @return boolean True on success, or false
     *
     * @throws RuntimeException Thrown if database tables can not be created or another error occurs
     */
    public function install()
    {
        $logger = $this->container->get('logger');
    
        // create all tables from according entity definitions
        try {
            $this->schemaTool->create($this->listEntityClasses());
        } catch (\Exception $exception) {
            $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
            $logger->error('{app}: Could not create the database tables during installation. Error details: {errorMessage}.', ['app' => 'MUPollsModule', 'errorMessage' => $exception->getMessage()]);
    
            return false;
        }
    
        // set up all our vars with initial values
        $this->setVar('kindOfVoting',  'session' );
        $this->setVar('optionEntriesPerPage', '10');
        $this->setVar('linkOwnOptionsOnAccountPage', true);
        $this->setVar('pollEntriesPerPage', '10');
        $this->setVar('linkOwnPollsOnAccountPage', true);
        $this->setVar('voteEntriesPerPage', '10');
        $this->setVar('linkOwnVotesOnAccountPage', true);
        $this->setVar('enabledFinderTypes', [ 'option' ,  'poll' ,  'vote' ]);
    
        // initialisation successful
        return true;
    }
    
    /**
     * Upgrade the MUPollsModule application from an older version.
     *
     * If the upgrade fails at some point, it returns the last upgraded version.
     *
     * @param integer $oldVersion Version to upgrade from
     *
     * @return boolean True on success, false otherwise
     *
     * @throws RuntimeException Thrown if database tables can not be updated
     */
    public function upgrade($oldVersion)
    {
    /*
        $logger = $this->container->get('logger');
    
        // Upgrade dependent on old version number
        switch ($oldVersion) {
            case '1.0.0':
                // do something
                // ...
                // update the database schema
                try {
                    $this->schemaTool->update($this->listEntityClasses());
                } catch (\Exception $exception) {
                    $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
                    $logger->error('{app}: Could not update the database tables during the upgrade. Error details: {errorMessage}.', ['app' => 'MUPollsModule', 'errorMessage' => $exception->getMessage()]);
    
                    return false;
                }
        }
    
        // Note there are several helpers available for making migrating your extension from Zikula 1.3 to 1.4 easier.
        // The following convenience methods are each responsible for a single aspect of upgrading to Zikula 1.4.x.
    
        // here is a possible usage example
        // of course 1.2.3 should match the number you used for the last stable 1.3.x module version.
        /* if ($oldVersion = '1.2.3') {
            // rename module for all modvars
            $this->updateModVarsTo14();
            
            // update extension information about this app
            $this->updateExtensionInfoFor14();
            
            // rename existing permission rules
            $this->renamePermissionsFor14();
            
            // rename all tables
            $this->renameTablesFor14();
            
            // remove event handler definitions from database
            $this->dropEventHandlersFromDatabase();
            
            // update module name in the hook tables
            $this->updateHookNamesFor14();
            
            // update module name in the workflows table
            $this->updateWorkflowsFor14();
        } * /
    
        // remove obsolete persisted hooks from the database
        //$this->hookApi->uninstallSubscriberHooks($this->bundle->getMetaData());
    */
    
        // update successful
        return true;
    }
    
    /**
     * Renames the module name for variables in the module_vars table.
     */
    protected function updateModVarsTo14()
    {
        $conn = $this->getConnection();
        $conn->update('module_vars', ['modname' => 'MUPollsModule'], ['modname' => 'Polls']);
    }
    
    /**
     * Renames this application in the core's extensions table.
     */
    protected function updateExtensionInfoFor14()
    {
        $conn = $this->getConnection();
        $conn->update('modules', ['name' => 'MUPollsModule', 'directory' => 'MU/PollsModule'], ['name' => 'Polls']);
    }
    
    /**
     * Renames all permission rules stored for this app.
     */
    protected function renamePermissionsFor14()
    {
        $conn = $this->getConnection();
        $componentLength = strlen('Polls') + 1;
    
        $conn->executeQuery("
            UPDATE group_perms
            SET component = CONCAT('MUPollsModule', SUBSTRING(component, $componentLength))
            WHERE component LIKE 'Polls%';
        ");
    }
    
    /**
     * Renames all (existing) tables of this app.
     */
    protected function renameTablesFor14()
    {
        $conn = $this->getConnection();
    
        $oldPrefix = 'polls_';
        $oldPrefixLength = strlen($oldPrefix);
        $newPrefix = 'mu_polls_';
    
        $sm = $conn->getSchemaManager();
        $tables = $sm->listTables();
        foreach ($tables as $table) {
            $tableName = $table->getName();
            if (substr($tableName, 0, $oldPrefixLength) != $oldPrefix) {
                continue;
            }
    
            $newTableName = str_replace($oldPrefix, $newPrefix, $tableName);
    
            $conn->executeQuery("
                RENAME TABLE $tableName
                TO $newTableName;
            ");
        }
    }
    
    /**
     * Removes event handlers from database as they are now described by service definitions and managed by dependency injection.
     */
    protected function dropEventHandlersFromDatabase()
    {
        \EventUtil::unregisterPersistentModuleHandlers('Polls');
    }
    
    /**
     * Updates the module name in the hook tables.
     */
    protected function updateHookNamesFor14()
    {
        $conn = $this->getConnection();
    
        $conn->update('hook_area', ['owner' => 'MUPollsModule'], ['owner' => 'Polls']);
    
        $componentLength = strlen('subscriber.polls') + 1;
        $conn->executeQuery("
            UPDATE hook_area
            SET areaname = CONCAT('subscriber.mupollsmodule', SUBSTRING(areaname, $componentLength))
            WHERE areaname LIKE 'subscriber.polls%';
        ");
    
        $conn->update('hook_binding', ['sowner' => 'MUPollsModule'], ['sowner' => 'Polls']);
    
        $conn->update('hook_runtime', ['sowner' => 'MUPollsModule'], ['sowner' => 'Polls']);
    
        $componentLength = strlen('polls') + 1;
        $conn->executeQuery("
            UPDATE hook_runtime
            SET eventname = CONCAT('mupollsmodule', SUBSTRING(eventname, $componentLength))
            WHERE eventname LIKE 'polls%';
        ");
    
        $conn->update('hook_subscriber', ['owner' => 'MUPollsModule'], ['owner' => 'Polls']);
    
        $componentLength = strlen('polls') + 1;
        $conn->executeQuery("
            UPDATE hook_subscriber
            SET eventname = CONCAT('mupollsmodule', SUBSTRING(eventname, $componentLength))
            WHERE eventname LIKE 'polls%';
        ");
    }
    
    /**
     * Updates the module name in the workflows table.
     */
    protected function updateWorkflowsFor14()
    {
        $conn = $this->getConnection();
        $conn->update('workflows', ['module' => 'MUPollsModule'], ['module' => 'Polls']);
        $conn->update('workflows', ['obj_table' => 'OptionEntity'], ['module' => 'MUPollsModule', 'obj_table' => 'option']);
        $conn->update('workflows', ['obj_table' => 'PollEntity'], ['module' => 'MUPollsModule', 'obj_table' => 'poll']);
        $conn->update('workflows', ['obj_table' => 'VoteEntity'], ['module' => 'MUPollsModule', 'obj_table' => 'vote']);
    }
    
    /**
     * Returns connection to the database.
     *
     * @return Connection the current connection
     */
    protected function getConnection()
    {
        $entityManager = $this->container->get('doctrine.orm.default_entity_manager');
    
        return $entityManager->getConnection();
    }
    
    /**
     * Uninstall MUPollsModule.
     *
     * @return boolean True on success, false otherwise
     *
     * @throws RuntimeException Thrown if database tables or stored workflows can not be removed
     */
    public function uninstall()
    {
        $logger = $this->container->get('logger');
    
        try {
            $this->schemaTool->drop($this->listEntityClasses());
        } catch (\Exception $exception) {
            $this->addFlash('error', $this->__('Doctrine Exception') . ': ' . $exception->getMessage());
            $logger->error('{app}: Could not remove the database tables during uninstallation. Error details: {errorMessage}.', ['app' => 'MUPollsModule', 'errorMessage' => $exception->getMessage()]);
    
            return false;
        }
    
        // remove all module vars
        $this->delVars();
    
        // uninstallation successful
        return true;
    }
    
    /**
     * Build array with all entity classes for MUPollsModule.
     *
     * @return array list of class names
     */
    protected function listEntityClasses()
    {
        $classNames = [];
        $classNames[] = 'MU\PollsModule\Entity\OptionEntity';
        $classNames[] = 'MU\PollsModule\Entity\OptionTranslationEntity';
        $classNames[] = 'MU\PollsModule\Entity\PollEntity';
        $classNames[] = 'MU\PollsModule\Entity\PollTranslationEntity';
        $classNames[] = 'MU\PollsModule\Entity\VoteEntity';
        $classNames[] = 'MU\PollsModule\Entity\HookAssignmentEntity';
    
        return $classNames;
    }
}
