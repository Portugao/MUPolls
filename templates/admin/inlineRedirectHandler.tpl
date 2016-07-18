{* purpose of this template: close an iframe from within this iframe *}
<!DOCTYPE html>
<html xml:lang="{lang}" lang="{lang}" dir="{langdirection}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        {$jcssConfig}
        <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
        <script type="text/javascript" src="{$baseurl}modules/MUPolls/javascript/MUPolls_editFunctions.js"></script>
    </head>
    <body>
        <script type="text/javascript">
        /* <![CDATA[ */
            // close window from parent document
            document.observe('dom:loaded', function() {
                mUMUPollsCloseWindowFromInside('{{$idPrefix}}', {{if $commandName eq 'create'}}{{$itemId}}{{else}}0{{/if}});
            });
        /* ]]> */
        </script>
    </body>
</html>
