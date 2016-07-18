{* Purpose of this template: Display a popup selector of votes for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select vote'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUPolls/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MUPolls/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */
    </script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.ImageViewer.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/MUPolls/javascript/MUPolls_finder.js"></script>
    {if $editorName eq 'tinymce'}
        <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
    {/if}
</head>
<body>
    <p>{gt text='Switch to'}:
    <a href="{modurl modname='MUPolls' type='external' func='finder' objectType='option' editor=$editorName}" title="{gt text='Search and select option'}">{gt text='Options'}</a> | 
    <a href="{modurl modname='MUPolls' type='external' func='finder' objectType='poll' editor=$editorName}" title="{gt text='Search and select poll'}">{gt text='Polls'}</a>
    </p>
    <form action="{$ourEntry|default:'index.php'}" id="mUPollsSelectorForm" method="get" class="z-form">
    <div>
        <input type="hidden" name="module" value="MUPolls" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select vote'}</legend>

            <div class="z-formrow">
                <label for="mUPollsPasteAs">{gt text='Paste as'}:</label>
                <select id="mUPollsPasteAs" name="pasteas">
                    <option value="1">{gt text='Link to the vote'}</option>
                    <option value="2">{gt text='ID of vote'}</option>
                </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="mUPollsObjectId">{gt text='Vote'}:</label>
                    <div id="mupollsItemContainer">
                        <ul>
                        {foreach item='vote' from=$items}
                            <li>
                                {assign var='itemId' value=$vote.id}
                                <a href="#" onclick="mUPolls.finder.selectItem({$itemId})" onkeypress="mUPolls.finder.selectItem({$itemId})">{$vote->getTitleFromDisplayPattern()}</a>
                                <input type="hidden" id="url{$itemId}" value="{modurl modname='MUPolls' type='user' func='display' ot='vote'  id=$vote.id fqurl=true}" />
                                <input type="hidden" id="title{$itemId}" value="{$vote->getTitleFromDisplayPattern()|replace:"\"":""}" />
                                <input type="hidden" id="desc{$itemId}" value="{capture assign='description'}{/capture}{$description|strip_tags|replace:"\"":""}" />
                            </li>
                        {foreachelse}
                            <li>{gt text='No entries found.'}</li>
                        {/foreach}
                        </ul>
                    </div>
            </div>

            <div class="z-formrow">
                <label for="mUPollsSort">{gt text='Sort by'}:</label>
                <select id="mUPollsSort" name="sort" class="z-floatleft" style="width: 100px; margin-right: 10px">
                    <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                    <option value="idOfOption"{if $sort eq 'idOfOption'} selected="selected"{/if}>{gt text='Id of option'}</option>
                    <option value="idOfPoll"{if $sort eq 'idOfPoll'} selected="selected"{/if}>{gt text='Id of poll'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="mUPollsSortDir" name="sortdir" style="width: 100px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="mUPollsPageSize">{gt text='Page size'}:</label>
                <select id="mUPollsPageSize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="mUPollsSearchTerm">{gt text='Search for'}:</label>
                <input type="text" id="mUPollsSearchTerm" name="q" class="z-floatleft" style="width: 150px; margin-right: 10px" />
                <input type="button" id="mUPollsSearchGo" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>
            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
            <input type="submit" id="mUPollsSubmit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="mUPollsCancel" name="cancelButton" value="{gt text='Cancel'}" />
            <br />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            mUPolls.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="mupolls-finderform">
        <fieldset>
            {modfunc modname='MUPolls' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
