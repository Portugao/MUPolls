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

use Doctrine\ORM\Query;
use Doctrine\ORM\Tools\Pagination\Paginator;

/**
 * Paginator switch base class for making 1.3.x modules work with 1.4.
 * Uses the newer Paginator.
 */
abstract class MUPolls_Paginator_Base_AbstractPaginator
{
    /**
     * @var Query The query instance
     */
    private $query;

    /**
     * @var boolean Whether the currently queries entity has relationships or not
     */
    private $hasRelationships;

    /**
     * The constructor.
     *
     * @param Query   $query            The query instance
     * @param boolean $hasRelationships Whether the currently queries entity has relationships or not
     */
    public function __construct(Query $query, $hasRelationships)
    {
        $this->query = $query;
        $this->hasRelationships = $hasRelationships;
    }

    /**
     * Retrieves the paginated results.
     *
     * @return array Paginator object and total amount of rows affected by the query
     */
    public function getResults()
    {
        $paginator = new Paginator($this->query, $this->hasRelationships);
        $count = count($paginator);

        return array($paginator, $count);
    }
}
