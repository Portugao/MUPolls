CKEDITOR.plugins.add('mupolls', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertMUPolls', {
            exec: function (editor) {
                var url = Zikula.Config.baseURL + Zikula.Config.entrypoint + '?module=MUPolls&type=external&func=finder&editor=ckeditor';
                // call method in MUPolls_finder.js and provide current editor
                MUPollsFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('mupolls', {
            label: editor.lang.mupolls.title,
            command: 'insertMUPolls',
         // icon: this.path + 'images/ed_mupolls.png'
            icon: '/images/icons/extrasmall/favorites.png'
        });
    }
});
