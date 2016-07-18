{* Purpose of this template: Display search options *}
<input type="hidden" id="mUPollsActive" name="active[MUPolls]" value="1" />
<div>
    <input type="checkbox" id="active_mUPollsOptions" name="mUPollsSearchTypes[]" value="option"{if $active_option} checked="checked"{/if} />
    <label for="active_mUPollsOptions">{gt text='Options' domain='module_mupolls'}</label>
</div>
<div>
    <input type="checkbox" id="active_mUPollsPolls" name="mUPollsSearchTypes[]" value="poll"{if $active_poll} checked="checked"{/if} />
    <label for="active_mUPollsPolls">{gt text='Polls' domain='module_mupolls'}</label>
</div>
<div>
    <input type="checkbox" id="active_mUPollsVotes" name="mUPollsSearchTypes[]" value="vote"{if $active_vote} checked="checked"{/if} />
    <label for="active_mUPollsVotes">{gt text='Votes' domain='module_mupolls'}</label>
</div>
