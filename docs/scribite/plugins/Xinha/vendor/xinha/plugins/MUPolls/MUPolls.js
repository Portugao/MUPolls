// MUPolls plugin for Xinha
// developed by Michael Ueberschaer
//
// requires MUPolls module (http://webdesign-in-bremen.com)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function MUPolls(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'MUPolls',
        tooltip  : 'Insert MUPolls object',
     // image    : _editor_url + 'plugins/MUPolls/img/ed_MUPolls.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=MUPolls&type=external&func=finder&editor=xinha';
            MUPollsFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('MUPolls', 'insertimage', 1);
}

MUPolls._pluginInfo = {
    name          : 'MUPolls for xinha',
    version       : '1.0.0',
    developer     : 'Michael Ueberschaer',
    developer_url : 'http://webdesign-in-bremen.com',
    sponsor       : 'ModuleStudio 0.7.0',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
