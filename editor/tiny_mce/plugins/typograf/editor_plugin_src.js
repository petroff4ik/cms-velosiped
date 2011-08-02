/**
 * $RCSfile: editor_plugin_src.js,v $
 * $Revision: 1.3 $
 * $Date: 2006/03/27 17:41:43 $
 *
 * @author Alexandr Shvets
 *
 */

(function() {
  tinymce.create('tinymce.plugins.typograf', {
    getInfo : function() {
      return {
        longname : 'Russian Typograf',
        author : 'Alexandr Shvets',
        authorurl : 'http://drupaldance.com/',
        infourl : 'http://drupaldance.com/russian-typograf-for-tinyMCE',
        version : '1.0'
      };
    },

    init : function(ed, url) {
      ed.addCommand('mceInsertTypography', function(ui, v) {
        if (ui) {
          editor_text = ed.getContent();
          strip = editor_text.replace(/<&#91;^>&#93;*>/g, "");
          if (strip.length) {
            ed.windowManager.open({
              file : url + '/typograf.html',
              width : 700,
              height : 580,
              scrollbars : 'yes',
              inline : 1
              }, {
                plugin_url : url,
                text : editor_text
              }
            );
          } else {
            alert('Введите немного текста, для начала.');
          }
        }
        else {
          ed.setContent(v.html);
        }
      });

      ed.addButton('typograf', {title : 'typograf.insert', cmd : 'mceInsertTypography', image : url + '/img/typograf.gif', ui : true});
    }
  });

  // Register plugin
  tinymce.PluginManager.add('typograf', tinymce.plugins.typograf);
})();