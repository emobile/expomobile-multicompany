/*
 * Facebox (for jQuery)
 * version: 1.2 (05/05/2008)
 * @requires jQuery v1.2 or later
 *
 * Examples at http://famspam.com/facebox/
 *
 * Licensed under the MIT:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright 2007, 2008 Chris Wanstrath [ chris@ozmm.org ]
 *
 * Usage:
 *  
 *  jQuery(document).ready(function() {
 *    jQuery('a[rel*=facebox]').facebox() 
 *  })
 *
 *  <a href="#terms" rel="facebox">Terms</a>
 *    Loads the #terms div in the box
 *
 *  <a href="terms.html" rel="facebox">Terms</a>
 *    Loads the terms.html page in the box
 *
 *  <a href="terms.png" rel="facebox">Terms</a>
 *    Loads the terms.png image in the box
 *
 *
 *  You can also use it programmatically:
 * 
 *    jQuery.facebox('some html')
 *
 *  The above will open a facebox with "some html" as the content.
 *    
 *    jQuery.facebox(function($) { 
 *      $.get('blah.html', function(data) { $.facebox(data) })
 *    })
 *
 *  The above will show a loading screen before the passed function is called,
 *  allowing for a better ajaxy experience.
 *
 *  The facebox function can also display an ajax page or image:
 *  
 *    jQuery.facebox({ ajax: 'remote.html' })
 *    jQuery.facebox({ image: 'dude.jpg' })
 *
 *  Want to close the facebox?  Trigger the 'close.facebox' document event:
 *
 *    jQuery(document).trigger('close.facebox')
 *
 *  Facebox also has a bunch of other hooks:
 *
 *    loading.facebox
 *    beforeReveal.facebox
 *    reveal.facebox (aliased as 'afterReveal.facebox')
 *    init.facebox
 *
 *  Simply bind a function to any of these hooks:
 *
 *   $(document).bind('reveal.facebox', function() { ...stuff to do after the facebox and contents are revealed... })
 *
 */
!function(e){function t(t){if(e.facebox.settings.inited)return!0;e.facebox.settings.inited=!0,e(document).trigger("init.facebox"),s();var i=e.facebox.settings.imageTypes.join("|");e.facebox.settings.imageTypesRegexp=new RegExp("."+i+"$","i"),t&&e.extend(e.facebox.settings,t),e("body").append(e.facebox.settings.faceboxHtml);var n=[new Image,new Image];n[0].src=e.facebox.settings.closeImage,n[1].src=e.facebox.settings.loadingImage,e("#facebox").find(".b:first, .bl, .br, .tl, .tr").each(function(){n.push(new Image),n.slice(-1).src=e(this).css("background-image").replace(/url\((.+)\)/,"$1")}),e("#facebox .close").click(e.facebox.close),e("#facebox .close_image").attr("src",e.facebox.settings.closeImage)}function i(){var e,t;return self.pageYOffset?(t=self.pageYOffset,e=self.pageXOffset):document.documentElement&&document.documentElement.scrollTop?(t=document.documentElement.scrollTop,e=document.documentElement.scrollLeft):document.body&&(t=document.body.scrollTop,e=document.body.scrollLeft),new Array(e,t)}function n(){var e;return self.innerHeight?e=self.innerHeight:document.documentElement&&document.documentElement.clientHeight?e=document.documentElement.clientHeight:document.body&&(e=document.body.clientHeight),e}function s(){var t=e.facebox.settings;t.loadingImage=t.loading_image||t.loadingImage,t.closeImage=t.close_image||t.closeImage,t.imageTypes=t.image_types||t.imageTypes,t.faceboxHtml=t.facebox_html||t.faceboxHtml}function a(t,i){if(t.match(/#/)){var n=window.location.href.split("#")[0],s=t.replace(n,"");e.facebox.reveal(e(s).clone().show(),i)}else t.match(e.facebox.settings.imageTypesRegexp)?o(t,i):r(t,i)}function o(t,i){var n=new Image;n.onload=function(){e.facebox.reveal('<div class="image"><img src="'+n.src+'" /></div>',i)},n.src=t}function r(t,i){e.get(t,function(t){e.facebox.reveal(t,i)})}function l(){return 0==e.facebox.settings.overlay||null===e.facebox.settings.opacity}function c(){return l()?void 0:(0==e("facebox_overlay").length&&e("body").append('<div id="facebox_overlay" class="facebox_hide"></div>'),e("#facebox_overlay").hide().addClass("facebox_overlayBG").css("opacity",e.facebox.settings.opacity).click(function(){e(document).trigger("close.facebox")}).fadeIn(200),!1)}function h(){return l()?void 0:(e("#facebox_overlay").fadeOut(200,function(){e("#facebox_overlay").removeClass("facebox_overlayBG"),e("#facebox_overlay").addClass("facebox_hide"),e("#facebox_overlay").remove()}),!1)}e.facebox=function(t,i){e.facebox.loading(),t.ajax?r(t.ajax):t.image?o(t.image):t.div?a(t.div):e.isFunction(t)?t.call(e):e.facebox.reveal(t,i)},e.extend(e.facebox,{settings:{opacity:0,overlay:!0,loadingImage:"resources/images/loading.gif",closeImage:"resources/images/closelabel.gif",imageTypes:["png","jpg","jpeg","gif"],faceboxHtml:'    <div id="facebox" style="display:none;">       <div class="popup">         <table>           <tbody>             <tr>               <td class="tl"/><td class="b"/><td class="tr"/>             </tr>             <tr>               <td class="b"/>               <td class="body">                 <div class="content">                 </div>                 <div class="footer">                   <a href="#" class="close">                     <img src="resources/images/closelabel.gif" title="close" class="close_image" />                   </a>                 </div>               </td>               <td class="b"/>             </tr>             <tr>               <td class="bl"/><td class="b"/><td class="br"/>             </tr>           </tbody>         </table>       </div>     </div>'},loading:function(){return t(),1==e("#facebox .loading").length?!0:(c(),e("#facebox .content").empty(),e("#facebox .body").children().hide().end().append('<div class="loading"><img src="'+e.facebox.settings.loadingImage+'"/></div>'),e("#facebox").css({top:i()[1]+n()/10,left:385.5}).show(),e(document).bind("keydown.facebox",function(t){return 27==t.keyCode&&e.facebox.close(),!0}),e(document).trigger("loading.facebox"),void 0)},reveal:function(t,i){e(document).trigger("beforeReveal.facebox"),i&&e("#facebox .content").addClass(i),e("#facebox .content").append(t),e("#facebox .loading").remove(),e("#facebox .body").children().fadeIn("normal"),e("#facebox").css("left",e(window).width()/2-e("#facebox table").width()/2),e(document).trigger("reveal.facebox").trigger("afterReveal.facebox")},close:function(){return e(document).trigger("close.facebox"),!1}}),e.fn.facebox=function(i){function n(){e.facebox.loading(!0);var t=this.rel.match(/facebox\[?\.(\w+)\]?/);return t&&(t=t[1]),a(this.href,t),!1}return t(i),this.click(n)},e(document).bind("close.facebox",function(){e(document).unbind("keydown.facebox"),e("#facebox").fadeOut(function(){e("#facebox .content").removeClass().addClass("content"),h(),e("#facebox .loading").remove()})})}(jQuery);