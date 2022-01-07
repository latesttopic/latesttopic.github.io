
!function(a){"use strict";function b(a){return(a||"").toLowerCase()}var c="2.1.6";a.fn.cycle=function(c){var d;return 0!==this.length||a.isReady?this.each(function(){var d,e,f,g,h=a(this),i=a.fn.cycle.log;if(!h.data("cycle.opts")){(h.data("cycle-log")===!1||c&&c.log===!1||e&&e.log===!1)&&(i=a.noop),i("--c2 init--"),d=h.data();for(var j in d)d.hasOwnProperty(j)&&/^cycle[A-Z]+/.test(j)&&(g=d[j],f=j.match(/^cycle(.*)/)[1].replace(/^[A-Z]/,b),i(f+":",g,"("+typeof g+")"),d[f]=g);e=a.extend({},a.fn.cycle.defaults,d,c||{}),e.timeoutId=0,e.paused=e.paused||!1,e.container=h,e._maxZ=e.maxZ,e.API=a.extend({_container:h},a.fn.cycle.API),e.API.log=i,e.API.trigger=function(a,b){return e.container.trigger(a,b),e.API},h.data("cycle.opts",e),h.data("cycle.API",e.API),e.API.trigger("cycle-bootstrap",[e,e.API]),e.API.addInitialSlides(),e.API.preInitSlideshow(),e.slides.length&&e.API.initSlideshow()}}):(d={s:this.selector,c:this.context},a.fn.cycle.log("requeuing slideshow (dom not ready)"),a(function(){a(d.s,d.c).cycle(c)}),this)},a.fn.cycle.API={opts:function(){return this._container.data("cycle.opts")},addInitialSlides:function(){var b=this.opts(),c=b.slides;b.slideCount=0,b.slides=a(),c=c.jquery?c:b.container.find(c),b.random&&c.sort(function(){return Math.random()-.5}),b.API.add(c)},preInitSlideshow:function(){var b=this.opts();b.API.trigger("cycle-pre-initialize",[b]);var c=a.fn.cycle.transitions[b.fx];c&&a.isFunction(c.preInit)&&c.preInit(b),b._preInitialized=!0},postInitSlideshow:function(){var b=this.opts();b.API.trigger("cycle-post-initialize",[b]);var c=a.fn.cycle.transitions[b.fx];c&&a.isFunction(c.postInit)&&c.postInit(b)},initSlideshow:function(){var b,c=this.opts(),d=c.container;c.API.calcFirstSlide(),"static"==c.container.css("position")&&c.container.css("position","relative"),a(c.slides[c.currSlide]).css({opacity:1,display:"block",visibility:"visible"}),c.API.stackSlides(c.slides[c.currSlide],c.slides[c.nextSlide],!c.reverse),c.pauseOnHover&&(c.pauseOnHover!==!0&&(d=a(c.pauseOnHover)),d.hover(function(){c.API.pause(!0)},function(){c.API.resume(!0)})),c.timeout&&(b=c.API.getSlideOpts(c.currSlide),c.API.queueTransition(b,b.timeout+c.delay)),c._initialized=!0,c.API.updateView(!0),c.API.trigger("cycle-initialized",[c]),c.API.postInitSlideshow()},pause:function(b){var c=this.opts(),d=c.API.getSlideOpts(),e=c.hoverPaused||c.paused;b?c.hoverPaused=!0:c.paused=!0,e||(c.container.addClass("cycle-paused"),c.API.trigger("cycle-paused",[c]).log("cycle-paused"),d.timeout&&(clearTimeout(c.timeoutId),c.timeoutId=0,c._remainingTimeout-=a.now()-c._lastQueue,(c._remainingTimeout<0||isNaN(c._remainingTimeout))&&(c._remainingTimeout=void 0)))},resume:function(a){var b=this.opts(),c=!b.hoverPaused&&!b.paused;a?b.hoverPaused=!1:b.paused=!1,c||(b.container.removeClass("cycle-paused"),0===b.slides.filter(":animated").length&&b.API.queueTransition(b.API.getSlideOpts(),b._remainingTimeout),b.API.trigger("cycle-resumed",[b,b._remainingTimeout]).log("cycle-resumed"))},add:function(b,c){var d,e=this.opts(),f=e.slideCount,g=!1;"string"==a.type(b)&&(b=a.trim(b)),a(b).each(function(){var b,d=a(this);c?e.container.prepend(d):e.container.append(d),e.slideCount++,b=e.API.buildSlideOpts(d),e.slides=c?a(d).add(e.slides):e.slides.add(d),e.API.initSlide(b,d,--e._maxZ),d.data("cycle.opts",b),e.API.trigger("cycle-slide-added",[e,b,d])}),e.API.updateView(!0),g=e._preInitialized&&2>f&&e.slideCount>=1,g&&(e._initialized?e.timeout&&(d=e.slides.length,e.nextSlide=e.reverse?d-1:1,e.timeoutId||e.API.queueTransition(e)):e.API.initSlideshow())},calcFirstSlide:function(){var a,b=this.opts();a=parseInt(b.startingSlide||0,10),(a>=b.slides.length||0>a)&&(a=0),b.currSlide=a,b.reverse?(b.nextSlide=a-1,b.nextSlide<0&&(b.nextSlide=b.slides.length-1)):(b.nextSlide=a+1,b.nextSlide==b.slides.length&&(b.nextSlide=0))},calcNextSlide:function(){var a,b=this.opts();b.reverse?(a=b.nextSlide-1<0,b.nextSlide=a?b.slideCount-1:b.nextSlide-1,b.currSlide=a?0:b.nextSlide+1):(a=b.nextSlide+1==b.slides.length,b.nextSlide=a?0:b.nextSlide+1,b.currSlide=a?b.slides.length-1:b.nextSlide-1)},calcTx:function(b,c){var d,e=b;return e._tempFx?d=a.fn.cycle.transitions[e._tempFx]:c&&e.manualFx&&(d=a.fn.cycle.transitions[e.manualFx]),d||(d=a.fn.cycle.transitions[e.fx]),e._tempFx=null,this.opts()._tempFx=null,d||(d=a.fn.cycle.transitions.fade,e.API.log('Transition "'+e.fx+'" not found.  Using fade.')),d},prepareTx:function(a,b){var c,d,e,f,g,h=this.opts();return h.slideCount<2?void(h.timeoutId=0):(!a||h.busy&&!h.manualTrump||(h.API.stopTransition(),h.busy=!1,clearTimeout(h.timeoutId),h.timeoutId=0),void(h.busy||(0!==h.timeoutId||a)&&(d=h.slides[h.currSlide],e=h.slides[h.nextSlide],f=h.API.getSlideOpts(h.nextSlide),g=h.API.calcTx(f,a),h._tx=g,a&&void 0!==f.manualSpeed&&(f.speed=f.manualSpeed),h.nextSlide!=h.currSlide&&(a||!h.paused&&!h.hoverPaused&&h.timeout)?(h.API.trigger("cycle-before",[f,d,e,b]),g.before&&g.before(f,d,e,b),c=function(){h.busy=!1,h.container.data("cycle.opts")&&(g.after&&g.after(f,d,e,b),h.API.trigger("cycle-after",[f,d,e,b]),h.API.queueTransition(f),h.API.updateView(!0))},h.busy=!0,g.transition?g.transition(f,d,e,b,c):h.API.doTransition(f,d,e,b,c),h.API.calcNextSlide(),h.API.updateView()):h.API.queueTransition(f))))},doTransition:function(b,c,d,e,f){var g=b,h=a(c),i=a(d),j=function(){i.animate(g.animIn||{opacity:1},g.speed,g.easeIn||g.easing,f)};i.css(g.cssBefore||{}),h.animate(g.animOut||{},g.speed,g.easeOut||g.easing,function(){h.css(g.cssAfter||{}),g.sync||j()}),g.sync&&j()},queueTransition:function(b,c){var d=this.opts(),e=void 0!==c?c:b.timeout;return 0===d.nextSlide&&0===--d.loop?(d.API.log("terminating; loop=0"),d.timeout=0,e?setTimeout(function(){d.API.trigger("cycle-finished",[d])},e):d.API.trigger("cycle-finished",[d]),void(d.nextSlide=d.currSlide)):void 0!==d.continueAuto&&(d.continueAuto===!1||a.isFunction(d.continueAuto)&&d.continueAuto()===!1)?(d.API.log("terminating automatic transitions"),d.timeout=0,void(d.timeoutId&&clearTimeout(d.timeoutId))):void(e&&(d._lastQueue=a.now(),void 0===c&&(d._remainingTimeout=b.timeout),d.paused||d.hoverPaused||(d.timeoutId=setTimeout(function(){d.API.prepareTx(!1,!d.reverse)},e))))},stopTransition:function(){var a=this.opts();a.slides.filter(":animated").length&&(a.slides.stop(!1,!0),a.API.trigger("cycle-transition-stopped",[a])),a._tx&&a._tx.stopTransition&&a._tx.stopTransition(a)},advanceSlide:function(a){var b=this.opts();return clearTimeout(b.timeoutId),b.timeoutId=0,b.nextSlide=b.currSlide+a,b.nextSlide<0?b.nextSlide=b.slides.length-1:b.nextSlide>=b.slides.length&&(b.nextSlide=0),b.API.prepareTx(!0,a>=0),!1},buildSlideOpts:function(c){var d,e,f=this.opts(),g=c.data()||{};for(var h in g)g.hasOwnProperty(h)&&/^cycle[A-Z]+/.test(h)&&(d=g[h],e=h.match(/^cycle(.*)/)[1].replace(/^[A-Z]/,b),f.API.log("["+(f.slideCount-1)+"]",e+":",d,"("+typeof d+")"),g[e]=d);g=a.extend({},a.fn.cycle.defaults,f,g),g.slideNum=f.slideCount;try{delete g.API,delete g.slideCount,delete g.currSlide,delete g.nextSlide,delete g.slides}catch(i){}return g},getSlideOpts:function(b){var c=this.opts();void 0===b&&(b=c.currSlide);var d=c.slides[b],e=a(d).data("cycle.opts");return a.extend({},c,e)},initSlide:function(b,c,d){var e=this.opts();c.css(b.slideCss||{}),d>0&&c.css("zIndex",d),isNaN(b.speed)&&(b.speed=a.fx.speeds[b.speed]||a.fx.speeds._default),b.sync||(b.speed=b.speed/2),c.addClass(e.slideClass)},updateView:function(a,b){var c=this.opts();if(c._initialized){var d=c.API.getSlideOpts(),e=c.slides[c.currSlide];!a&&b!==!0&&(c.API.trigger("cycle-update-view-before",[c,d,e]),c.updateView<0)||(c.slideActiveClass&&c.slides.removeClass(c.slideActiveClass).eq(c.currSlide).addClass(c.slideActiveClass),a&&c.hideNonActive&&c.slides.filter(":not(."+c.slideActiveClass+")").css("visibility","hidden"),0===c.updateView&&setTimeout(function(){c.API.trigger("cycle-update-view",[c,d,e,a])},d.speed/(c.sync?2:1)),0!==c.updateView&&c.API.trigger("cycle-update-view",[c,d,e,a]),a&&c.API.trigger("cycle-update-view-after",[c,d,e]))}},getComponent:function(b){var c=this.opts(),d=c[b];return"string"==typeof d?/^\s*[\>|\+|~]/.test(d)?c.container.find(d):a(d):d.jquery?d:a(d)},stackSlides:function(b,c,d){var e=this.opts();b||(b=e.slides[e.currSlide],c=e.slides[e.nextSlide],d=!e.reverse),a(b).css("zIndex",e.maxZ);var f,g=e.maxZ-2,h=e.slideCount;if(d){for(f=e.currSlide+1;h>f;f++)a(e.slides[f]).css("zIndex",g--);for(f=0;f<e.currSlide;f++)a(e.slides[f]).css("zIndex",g--)}else{for(f=e.currSlide-1;f>=0;f--)a(e.slides[f]).css("zIndex",g--);for(f=h-1;f>e.currSlide;f--)a(e.slides[f]).css("zIndex",g--)}a(c).css("zIndex",e.maxZ-1)},getSlideIndex:function(a){return this.opts().slides.index(a)}},a.fn.cycle.log=function(){window.console&&console.log&&console.log("[cycle2] "+Array.prototype.join.call(arguments," "))},a.fn.cycle.version=function(){return"Cycle2: "+c},a.fn.cycle.transitions={custom:{},none:{before:function(a,b,c,d){a.API.stackSlides(c,b,d),a.cssBefore={opacity:1,visibility:"visible",display:"block"}}},fade:{before:function(b,c,d,e){var f=b.API.getSlideOpts(b.nextSlide).slideCss||{};b.API.stackSlides(c,d,e),b.cssBefore=a.extend(f,{opacity:0,visibility:"visible",display:"block"}),b.animIn={opacity:1},b.animOut={opacity:0}}},fadeout:{before:function(b,c,d,e){var f=b.API.getSlideOpts(b.nextSlide).slideCss||{};b.API.stackSlides(c,d,e),b.cssBefore=a.extend(f,{opacity:1,visibility:"visible",display:"block"}),b.animOut={opacity:0}}},scrollHorz:{before:function(a,b,c,d){a.API.stackSlides(b,c,d);var e=a.container.css("overflow","hidden").width();a.cssBefore={left:d?e:-e,top:0,opacity:1,visibility:"visible",display:"block"},a.cssAfter={zIndex:a._maxZ-2,left:0},a.animIn={left:0},a.animOut={left:d?-e:e}}}},a.fn.cycle.defaults={allowWrap:!0,autoSelector:".cycle-slideshow[data-cycle-auto-init!=false]",delay:0,easing:null,fx:"fade",hideNonActive:!0,loop:0,manualFx:void 0,manualSpeed:void 0,manualTrump:!0,maxZ:100,pauseOnHover:!1,reverse:!1,slideActiveClass:"cycle-slide-active",slideClass:"cycle-slide",slideCss:{position:"absolute",top:0,left:0},slides:"> img",speed:500,startingSlide:0,sync:!0,timeout:4e3,updateView:0},a(document).ready(function(){a(a.fn.cycle.defaults.autoSelector).cycle()})}(jQuery),/*! Cycle2 autoheight plugin; Copyright (c) M.Alsup, 2012; version: 20130913 */
function(a){"use strict";function b(b,d){var e,f,g,h=d.autoHeight;if("container"==h)f=a(d.slides[d.currSlide]).outerHeight(),d.container.height(f);else if(d._autoHeightRatio)d.container.height(d.container.width()/d._autoHeightRatio);else if("calc"===h||"number"==a.type(h)&&h>=0){if(g="calc"===h?c(b,d):h>=d.slides.length?0:h,g==d._sentinelIndex)return;d._sentinelIndex=g,d._sentinel&&d._sentinel.remove(),e=a(d.slides[g].cloneNode(!0)),e.removeAttr("id name rel").find("[id],[name],[rel]").removeAttr("id name rel"),e.css({position:"static",visibility:"hidden",display:"block"}).prependTo(d.container).addClass("cycle-sentinel cycle-slide").removeClass("cycle-slide-active"),e.find("*").css("visibility","hidden"),d._sentinel=e}}function c(b,c){var d=0,e=-1;return c.slides.each(function(b){var c=a(this).height();c>e&&(e=c,d=b)}),d}function d(b,c,d,e){var f=a(e).outerHeight();c.container.animate({height:f},c.autoHeightSpeed,c.autoHeightEasing)}function e(c,f){f._autoHeightOnResize&&(a(window).off("resize orientationchange",f._autoHeightOnResize),f._autoHeightOnResize=null),f.container.off("cycle-slide-added cycle-slide-removed",b),f.container.off("cycle-destroyed",e),f.container.off("cycle-before",d),f._sentinel&&(f._sentinel.remove(),f._sentinel=null)}a.extend(a.fn.cycle.defaults,{autoHeight:0,autoHeightSpeed:250,autoHeightEasing:null}),a(document).on("cycle-initialized",function(c,f){function g(){b(c,f)}var h,i=f.autoHeight,j=a.type(i),k=null;("string"===j||"number"===j)&&(f.container.on("cycle-slide-added cycle-slide-removed",b),f.container.on("cycle-destroyed",e),"container"==i?f.container.on("cycle-before",d):"string"===j&&/\d+\:\d+/.test(i)&&(h=i.match(/(\d+)\:(\d+)/),h=h[1]/h[2],f._autoHeightRatio=h),"number"!==j&&(f._autoHeightOnResize=function(){clearTimeout(k),k=setTimeout(g,50)},a(window).on("resize orientationchange",f._autoHeightOnResize)),setTimeout(g,30))})}(jQuery),/*! caption plugin for Cycle2;  version: 20130306 */
function(a){"use strict";a.extend(a.fn.cycle.defaults,{caption:"> .cycle-caption",captionTemplate:"{{slideNum}} / {{slideCount}}",overlay:"> .cycle-overlay",overlayTemplate:"<div>{{title}}</div><div>{{desc}}</div>",captionModule:"caption"}),a(document).on("cycle-update-view",function(b,c,d,e){if("caption"===c.captionModule){a.each(["caption","overlay"],function(){var a=this,b=d[a+"Template"],f=c.API.getComponent(a);f.length&&b?(f.html(c.API.tmpl(b,d,c,e)),f.show()):f.hide()})}}),a(document).on("cycle-destroyed",function(b,c){var d;a.each(["caption","overlay"],function(){var a=this,b=c[a+"Template"];c[a]&&b&&(d=c.API.getComponent("caption"),d.empty())})})}(jQuery),/*! command plugin for Cycle2;  version: 20140415 */
function(a){"use strict";var b=a.fn.cycle;a.fn.cycle=function(c){var d,e,f,g=a.makeArray(arguments);return"number"==a.type(c)?this.cycle("goto",c):"string"==a.type(c)?this.each(function(){var h;return d=c,f=a(this).data("cycle.opts"),void 0===f?void b.log('slideshow must be initialized before sending commands; "'+d+'" ignored'):(d="goto"==d?"jump":d,e=f.API[d],a.isFunction(e)?(h=a.makeArray(g),h.shift(),e.apply(f.API,h)):void b.log("unknown command: ",d))}):b.apply(this,arguments)},a.extend(a.fn.cycle,b),a.extend(b.API,{next:function(){var a=this.opts();if(!a.busy||a.manualTrump){var b=a.reverse?-1:1;a.allowWrap===!1&&a.currSlide+b>=a.slideCount||(a.API.advanceSlide(b),a.API.trigger("cycle-next",[a]).log("cycle-next"))}},prev:function(){var a=this.opts();if(!a.busy||a.manualTrump){var b=a.reverse?1:-1;a.allowWrap===!1&&a.currSlide+b<0||(a.API.advanceSlide(b),a.API.trigger("cycle-prev",[a]).log("cycle-prev"))}},destroy:function(){this.stop();var b=this.opts(),c=a.isFunction(a._data)?a._data:a.noop;clearTimeout(b.timeoutId),b.timeoutId=0,b.API.stop(),b.API.trigger("cycle-destroyed",[b]).log("cycle-destroyed"),b.container.removeData(),c(b.container[0],"parsedAttrs",!1),b.retainStylesOnDestroy||(b.container.removeAttr("style"),b.slides.removeAttr("style"),b.slides.removeClass(b.slideActiveClass)),b.slides.each(function(){var d=a(this);d.removeData(),d.removeClass(b.slideClass),c(this,"parsedAttrs",!1)})},jump:function(a,b){var c,d=this.opts();if(!d.busy||d.manualTrump){var e=parseInt(a,10);if(isNaN(e)||0>e||e>=d.slides.length)return void d.API.log("goto: invalid slide index: "+e);if(e==d.currSlide)return void d.API.log("goto: skipping, already on slide",e);d.nextSlide=e,clearTimeout(d.timeoutId),d.timeoutId=0,d.API.log("goto: ",e," (zero-index)"),c=d.currSlide<d.nextSlide,d._tempFx=b,d.API.prepareTx(!0,c)}},stop:function(){var b=this.opts(),c=b.container;clearTimeout(b.timeoutId),b.timeoutId=0,b.API.stopTransition(),b.pauseOnHover&&(b.pauseOnHover!==!0&&(c=a(b.pauseOnHover)),c.off("mouseenter mouseleave")),b.API.trigger("cycle-stopped",[b]).log("cycle-stopped")},reinit:function(){var a=this.opts();a.API.destroy(),a.container.cycle()},remove:function(b){for(var c,d,e=this.opts(),f=[],g=1,h=0;h<e.slides.length;h++)c=e.slides[h],h==b?d=c:(f.push(c),a(c).data("cycle.opts").slideNum=g,g++);d&&(e.slides=a(f),e.slideCount--,a(d).remove(),b==e.currSlide?e.API.advanceSlide(1):b<e.currSlide?e.currSlide--:e.currSlide++,e.API.trigger("cycle-slide-removed",[e,b,d]).log("cycle-slide-removed"),e.API.updateView())}}),a(document).on("click.cycle","[data-cycle-cmd]",function(b){b.preventDefault();var c=a(this),d=c.data("cycle-cmd"),e=c.data("cycle-context")||".cycle-slideshow";a(e).cycle(d,c.data("cycle-arg"))})}(jQuery),/*! hash plugin for Cycle2;  version: 20130905 */
function(a){"use strict";function b(b,c){var d;return b._hashFence?void(b._hashFence=!1):(d=window.location.hash.substring(1),void b.slides.each(function(e){if(a(this).data("cycle-hash")==d){if(c===!0)b.startingSlide=e;else{var f=b.currSlide<e;b.nextSlide=e,b.API.prepareTx(!0,f)}return!1}}))}a(document).on("cycle-pre-initialize",function(c,d){b(d,!0),d._onHashChange=function(){b(d,!1)},a(window).on("hashchange",d._onHashChange)}),a(document).on("cycle-update-view",function(a,b,c){c.hash&&"#"+c.hash!=window.location.hash&&(b._hashFence=!0,window.location.hash=c.hash)}),a(document).on("cycle-destroyed",function(b,c){c._onHashChange&&a(window).off("hashchange",c._onHashChange)})}(jQuery),/*! loader plugin for Cycle2;  version: 20131121 */
function(a){"use strict";a.extend(a.fn.cycle.defaults,{loader:!1}),a(document).on("cycle-bootstrap",function(b,c){function d(b,d){function f(b){var f;"wait"==c.loader?(h.push(b),0===j&&(h.sort(g),e.apply(c.API,[h,d]),c.container.removeClass("cycle-loading"))):(f=a(c.slides[c.currSlide]),e.apply(c.API,[b,d]),f.show(),c.container.removeClass("cycle-loading"))}function g(a,b){return a.data("index")-b.data("index")}var h=[];if("string"==a.type(b))b=a.trim(b);else if("array"===a.type(b))for(var i=0;i<b.length;i++)b[i]=a(b[i])[0];b=a(b);var j=b.length;j&&(b.css("visibility","hidden").appendTo("body").each(function(b){function g(){0===--i&&(--j,f(k))}var i=0,k=a(this),l=k.is("img")?k:k.find("img");return k.data("index",b),l=l.filter(":not(.cycle-loader-ignore)").filter(':not([src=""])'),l.length?(i=l.length,void l.each(function(){this.complete?g():a(this).load(function(){g()}).on("error",function(){0===--i&&(c.API.log("slide skipped; img not loaded:",this.src),0===--j&&"wait"==c.loader&&e.apply(c.API,[h,d]))})})):(--j,void h.push(k))}),j&&c.container.addClass("cycle-loading"))}var e;c.loader&&(e=c.API.add,c.API.add=d)})}(jQuery),/*! pager plugin for Cycle2;  version: 20140415 */
function(a){"use strict";function b(b,c,d){var e,f=b.API.getComponent("pager");f.each(function(){var f=a(this);if(c.pagerTemplate){var g=b.API.tmpl(c.pagerTemplate,c,b,d[0]);e=a(g).appendTo(f)}else e=f.children().eq(b.slideCount-1);e.on(b.pagerEvent,function(a){b.pagerEventBubble||a.preventDefault(),b.API.page(f,a.currentTarget)})})}function c(a,b){var c=this.opts();if(!c.busy||c.manualTrump){var d=a.children().index(b),e=d,f=c.currSlide<e;c.currSlide!=e&&(c.nextSlide=e,c._tempFx=c.pagerFx,c.API.prepareTx(!0,f),c.API.trigger("cycle-pager-activated",[c,a,b]))}}a.extend(a.fn.cycle.defaults,{pager:"> .cycle-pager",pagerActiveClass:"cycle-pager-active",pagerEvent:"click.cycle",pagerEventBubble:void 0,pagerTemplate:"<span>&bull;</span>"}),a(document).on("cycle-bootstrap",function(a,c,d){d.buildPagerLink=b}),a(document).on("cycle-slide-added",function(a,b,d,e){b.pager&&(b.API.buildPagerLink(b,d,e),b.API.page=c)}),a(document).on("cycle-slide-removed",function(b,c,d){if(c.pager){var e=c.API.getComponent("pager");e.each(function(){var b=a(this);a(b.children()[d]).remove()})}}),a(document).on("cycle-update-view",function(b,c){var d;c.pager&&(d=c.API.getComponent("pager"),d.each(function(){a(this).children().removeClass(c.pagerActiveClass).eq(c.currSlide).addClass(c.pagerActiveClass)}))}),a(document).on("cycle-destroyed",function(a,b){var c=b.API.getComponent("pager");c&&(c.children().off(b.pagerEvent),b.pagerTemplate&&c.empty())})}(jQuery),/*! prevnext plugin for Cycle2;  version: 20140408 */
function(a){"use strict";a.extend(a.fn.cycle.defaults,{next:"> .cycle-next",nextEvent:"click.cycle",disabledClass:"disabled",prev:"> .cycle-prev",prevEvent:"click.cycle",swipe:!1}),a(document).on("cycle-initialized",function(a,b){if(b.API.getComponent("next").on(b.nextEvent,function(a){a.preventDefault(),b.API.next()}),b.API.getComponent("prev").on(b.prevEvent,function(a){a.preventDefault(),b.API.prev()}),b.swipe){var c=b.swipeVert?"swipeUp.cycle":"swipeLeft.cycle swipeleft.cycle",d=b.swipeVert?"swipeDown.cycle":"swipeRight.cycle swiperight.cycle";b.container.on(c,function(){b._tempFx=b.swipeFx,b.API.next()}),b.container.on(d,function(){b._tempFx=b.swipeFx,b.API.prev()})}}),a(document).on("cycle-update-view",function(a,b){if(!b.allowWrap){var c=b.disabledClass,d=b.API.getComponent("next"),e=b.API.getComponent("prev"),f=b._prevBoundry||0,g=void 0!==b._nextBoundry?b._nextBoundry:b.slideCount-1;b.currSlide==g?d.addClass(c).prop("disabled",!0):d.removeClass(c).prop("disabled",!1),b.currSlide===f?e.addClass(c).prop("disabled",!0):e.removeClass(c).prop("disabled",!1)}}),a(document).on("cycle-destroyed",function(a,b){b.API.getComponent("prev").off(b.nextEvent),b.API.getComponent("next").off(b.prevEvent),b.container.off("swipeleft.cycle swiperight.cycle swipeLeft.cycle swipeRight.cycle swipeUp.cycle swipeDown.cycle")})}(jQuery),/*! progressive loader plugin for Cycle2;  version: 20130315 */
function(a){"use strict";a.extend(a.fn.cycle.defaults,{progressive:!1}),a(document).on("cycle-pre-initialize",function(b,c){if(c.progressive){var d,e,f=c.API,g=f.next,h=f.prev,i=f.prepareTx,j=a.type(c.progressive);if("array"==j)d=c.progressive;else if(a.isFunction(c.progressive))d=c.progressive(c);else if("string"==j){if(e=a(c.progressive),d=a.trim(e.html()),!d)return;if(/^(\[)/.test(d))try{d=a.parseJSON(d)}catch(k){return void f.log("error parsing progressive slides",k)}else d=d.split(new RegExp(e.data("cycle-split")||"\n")),d[d.length-1]||d.pop()}i&&(f.prepareTx=function(a,b){var e,f;return a||0===d.length?void i.apply(c.API,[a,b]):void(b&&c.currSlide==c.slideCount-1?(f=d[0],d=d.slice(1),c.container.one("cycle-slide-added",function(a,b){setTimeout(function(){b.API.advanceSlide(1)},50)}),c.API.add(f)):b||0!==c.currSlide?i.apply(c.API,[a,b]):(e=d.length-1,f=d[e],d=d.slice(0,e),c.container.one("cycle-slide-added",function(a,b){setTimeout(function(){b.currSlide=1,b.API.advanceSlide(-1)},50)}),c.API.add(f,!0)))}),g&&(f.next=function(){var a=this.opts();if(d.length&&a.currSlide==a.slideCount-1){var b=d[0];d=d.slice(1),a.container.one("cycle-slide-added",function(a,b){g.apply(b.API),b.container.removeClass("cycle-loading")}),a.container.addClass("cycle-loading"),a.API.add(b)}else g.apply(a.API)}),h&&(f.prev=function(){var a=this.opts();if(d.length&&0===a.currSlide){var b=d.length-1,c=d[b];d=d.slice(0,b),a.container.one("cycle-slide-added",function(a,b){b.currSlide=1,b.API.advanceSlide(-1),b.container.removeClass("cycle-loading")}),a.container.addClass("cycle-loading"),a.API.add(c,!0)}else h.apply(a.API)})}})}(jQuery),/*! tmpl plugin for Cycle2;  version: 20121227 */
function(a){"use strict";a.extend(a.fn.cycle.defaults,{tmplRegex:"{{((.)?.*?)}}"}),a.extend(a.fn.cycle.API,{tmpl:function(b,c){var d=new RegExp(c.tmplRegex||a.fn.cycle.defaults.tmplRegex,"g"),e=a.makeArray(arguments);return e.shift(),b.replace(d,function(b,c){var d,f,g,h,i=c.split(".");for(d=0;d<e.length;d++)if(g=e[d]){if(i.length>1)for(h=g,f=0;f<i.length;f++)g=h,h=h[i[f]]||c;else h=g[c];if(a.isFunction(h))return h.apply(g,e);if(void 0!==h&&null!==h&&h!=c)return h}return c})}})}(jQuery);
!function(a){"use strict";a.extend(a.fn.cycle.defaults,{centerHorz:!1,centerVert:!1}),a(document).on("cycle-pre-initialize",function(b,c){function d(){clearTimeout(i),i=setTimeout(g,50)}function e(){clearTimeout(i),clearTimeout(j),a(window).off("resize orientationchange",d)}function f(){c.slides.each(h)}function g(){h.apply(c.container.find("."+c.slideActiveClass)),clearTimeout(j),j=setTimeout(f,50)}function h(){var b=a(this),d=c.container.width(),e=c.container.height(),f=b.outerWidth(),g=b.outerHeight();f&&(c.centerHorz&&d>=f&&b.css("marginLeft",(d-f)/2),c.centerVert&&e>=g&&b.css("marginTop",(e-g)/2))}if(c.centerHorz||c.centerVert){var i,j;a(window).on("resize orientationchange load",d),c.container.on("cycle-destroyed",e),c.container.on("cycle-initialized cycle-slide-added cycle-slide-removed",function(){d()}),g()}})}(jQuery);
!function(a){"use strict";a.event.special.swipe=a.event.special.swipe||{scrollSupressionThreshold:10,durationThreshold:1e3,horizontalDistanceThreshold:30,verticalDistanceThreshold:75,setup:function(){var b=a(this);b.bind("touchstart",function(c){function d(b){if(g){var c=b.originalEvent.touches?b.originalEvent.touches[0]:b;e={time:(new Date).getTime(),coords:[c.pageX,c.pageY]},Math.abs(g.coords[0]-e.coords[0])>a.event.special.swipe.scrollSupressionThreshold&&b.preventDefault()}}var e,f=c.originalEvent.touches?c.originalEvent.touches[0]:c,g={time:(new Date).getTime(),coords:[f.pageX,f.pageY],origin:a(c.target)};b.bind("touchmove",d).one("touchend",function(){b.unbind("touchmove",d),g&&e&&e.time-g.time<a.event.special.swipe.durationThreshold&&Math.abs(g.coords[0]-e.coords[0])>a.event.special.swipe.horizontalDistanceThreshold&&Math.abs(g.coords[1]-e.coords[1])<a.event.special.swipe.verticalDistanceThreshold&&g.origin.trigger("swipe").trigger(g.coords[0]>e.coords[0]?"swipeleft":"swiperight"),g=e=void 0})})}},a.event.special.swipeleft=a.event.special.swipeleft||{setup:function(){a(this).bind("swipe",a.noop)}},a.event.special.swiperight=a.event.special.swiperight||a.event.special.swipeleft}(jQuery);
!function(a){"use strict";a.fn.cycle.transitions.tileSlide=a.fn.cycle.transitions.tileBlind={before:function(b,c,d,e){b.API.stackSlides(c,d,e),a(c).css({display:"block",visibility:"visible"}),b.container.css("overflow","hidden"),b.tileDelay=b.tileDelay||"tileSlide"==b.fx?100:125,b.tileCount=b.tileCount||7,b.tileVertical=b.tileVertical!==!1,b.container.data("cycleTileInitialized")||(b.container.on("cycle-destroyed",a.proxy(this.onDestroy,b.API)),b.container.data("cycleTileInitialized",!0))},transition:function(b,c,d,e,f){function g(a){m.eq(a).animate(t,{duration:b.speed,easing:b.easing,complete:function(){(e?p-1===a:0===a)&&b._tileAniCallback()}}),setTimeout(function(){(e?p-1!==a:0!==a)&&g(e?a+1:a-1)},b.tileDelay)}b.slides.not(c).not(d).css("visibility","hidden");var h,i,j,k,l,m=a(),n=a(c),o=a(d),p=b.tileCount,q=b.tileVertical,r=b.container.height(),s=b.container.width();q?(i=Math.floor(s/p),k=s-i*(p-1),j=l=r):(i=k=s,j=Math.floor(r/p),l=r-j*(p-1)),b.container.find(".cycle-tiles-container").remove();var t,u={left:0,top:0,overflow:"hidden",position:"absolute",margin:0,padding:0};t=q?"tileSlide"==b.fx?{top:r}:{width:0}:"tileSlide"==b.fx?{left:s}:{height:0};var v=a('<div class="cycle-tiles-container"></div>');v.css({zIndex:n.css("z-index"),overflow:"visible",position:"absolute",top:0,left:0,direction:"ltr"}),v.insertBefore(d);for(var w=0;p>w;w++)h=a("<div></div>").css(u).css({width:p-1===w?k:i,height:p-1===w?l:j,marginLeft:q?w*i:0,marginTop:q?0:w*j}).append(n.clone().css({position:"relative",maxWidth:"none",width:n.width(),margin:0,padding:0,marginLeft:q?-(w*i):0,marginTop:q?0:-(w*j)})),m=m.add(h);v.append(m),n.css("visibility","hidden"),o.css({opacity:1,display:"block",visibility:"visible"}),g(e?0:p-1),b._tileAniCallback=function(){o.css({display:"block",visibility:"visible"}),n.css("visibility","hidden"),v.remove(),f()}},stopTransition:function(a){a.container.find("*").stop(!0,!0),a._tileAniCallback&&a._tileAniCallback()},onDestroy:function(){var a=this.opts();a.container.find(".cycle-tiles-container").remove()}}}(jQuery);
device_width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;

$(document).ready(function() {
	
	function heartbeat() {
        jQuery.ajax({
           type: "GET",
           cache: false,
           url: "/heartbeat",
           timeout: 5000
        });     
        setTimeout(heartbeat,240000);
        return false; 
	}
    setTimeout(heartbeat,240000);

    $('input.focus, select.focus, textarea.focus').putCursorAtEnd();

    $('.notification-bar-close').click(function() {
        jQuery.ajax({
           type: "GET",
           cache: false,
           url: "/notification-bar/close",
           timeout: 5000
        });     
        $('.notification-bar').remove();
    });

    $('#cookie-consent-bar-choose-cookies-link').click(function() {
        $('#cookie-consent-bar-all-cookies').remove();
        $('#cookie-consent-bar-choose-cookies').removeClass('hidden');
    });

    $('#cookie-consent-bar-accept-all-cookies-button').click(function() {
        var settings = 'necessary|preferences|analytics|marketing';
        jQuery.ajax({
           type: "GET",
           cache: false,
           url: "/cookie-consent/save?settings=" + settings,
           timeout: 5000
        });  
        try {
            cookieConsentGoogleAnalytics(settings);
        }
        catch(error) {}
        try {
            cookieConsentFacebookPixel(settings);
        }
        catch(error) {}
        cookieConsentScripts(settings);
        $('.cookie-consent-bar').remove();
    });

    $('#cookie-consent-bar-accept-selected-cookies-button').click(function() {
        var settings = "necessary";
        if($('#cookie-consent-bar-option-preferences').is(':checked')) {
            settings += '|preferences';
        }
        if($('#cookie-consent-bar-option-analytics').is(':checked')) {
            settings += '|analytics';      
        }
        if($('#cookie-consent-bar-option-marketing').is(':checked')) {
            settings += '|marketing';
        }
        jQuery.ajax({
           type: "GET",
           cache: false,
           url: "/cookie-consent/save?settings=" + settings,
           timeout: 5000
        });       
        try {
            cookieConsentGoogleAnalytics(settings);
        }
        catch(error) {}      
        try {
            cookieConsentFacebookPixel(settings);
        }
        catch(error) {}   
        cookieConsentScripts(settings);              
        $('.cookie-consent-bar').remove();
    });

});

function cookieConsentScripts(settings) {
    $('script[type="text/plain"]').each(function() {
        var cookie_consent_required = $(this).data("cookie-consent-required");
        if(typeof cookie_consent_required != "undefined") {
            cookie_consent_required = cookie_consent_required.split(' ');
            var enable_script = true;
            var i;
            for (i = 0; i < cookie_consent_required.length; i++) {
                if(settings.indexOf(cookie_consent_required[i]) == -1) {
                    enable_script = false;
                    break;
                }  
            }
            if(enable_script) {
                $(this).attr('type','text/javascript');
                $(this).clone().appendTo($(this).parent());
            }
        }                
    });
}

function getCartItemCount() {
    return $.ajax({
        type: "GET",
        url: '/cart?action=item_count',
        timeout: 5000,
        cache: false
    });
}          

$.fn.putCursorAtEnd = function() {
    return this.each(function() {
        $(this).focus();
        if (this.setSelectionRange && /text|search|password|tel|url/i.test(this.type || '')) {
            var len = $(this).val().length * 2;
            this.setSelectionRange(len, len);
        }
        else {
            $(this).val($(this).val());
        }
        this.scrollTop = 999999;
    });
};

$.fn.disableAndChangeOnSubmit = function(elementid,text){
	
	$('#'+elementid).removeAttr('disabled');
	
	$(this).submit(function(){
		$('#'+elementid).attr('disabled',true).addClass('disabled').attr('value',text).html('<i class="fal fa-lg fa-spinner-third fa-spin"></i>' + text);
	});
	
	return this;

};

$('.image-gallery-item.hover').hover(
    function() {
        $(this).find('.caption').show('slideUp');
    },
    function() {
        $(this).find('.caption').hide();
    }
);

$('.image-list, .testimonial-panel, .person-membership-type-panel, .image-gallery, .product-panel, .event-panel, .product-category-panel, .blog-panel, .instagram-gallery').each(function() {

    if($(this).hasClass('horizontal')) {

        var num_per_row = 1;
        
        if($(this).parents('.container_12').length) {
            if($(this).hasClass('small')) {
                var grid_size = 3;
            }    
            else {
                var grid_size = 4;
            }
            if($(this).parents('.grid_3').length) {
                if(grid_size==3) {
                    num_per_row = 1;
                }     
                else if(grid_size==4) {
                    num_per_row = 1;
                }     
            }       
            else if($(this).parents('.grid_4').length) {
                if(grid_size==3) {
                    num_per_row = 1;
                }     
                else if(grid_size==4) {
                    num_per_row = 1;
                }     
            }
            else if($(this).parents('.grid_6').length) {
                if(grid_size==3) {
                    num_per_row = 2;
                }     
                else if(grid_size==4) {
                    num_per_row = 1;
                }           
            }   
            else if($(this).parents('.grid_8').length) {
                if(grid_size==3) {
                    num_per_row = 2;
                }     
                else if(grid_size==4) {
                    num_per_row = 2;
                }           
            }   
            else if($(this).parents('.grid_9').length) {
                if(grid_size==3) {
                    num_per_row = 3;
                }     
                else if(grid_size==4) {
                    num_per_row = 2;
                }           
            }           
            else if($(this).parents('.grid_12').length) {
                if(grid_size==3) {
                    num_per_row = 4;
                }     
                else if(grid_size==4) {
                    num_per_row = 3;
                }           
            }   
        }        
        
        $(this).find('.image-list-item, .testimonial-panel-listing, .person-membership-type-panel-listing, .image-gallery-item, .instagram-gallery-item, .product-panel-listing, .product-category-panel-listing, .event-panel-listing, .blog-panel-listing').each(function(index) {
            var position = index + 1;
            $(this).addClass('grid_' + grid_size);
            if(position % num_per_row == 0) {
                $(this).addClass('omega').after('<div class="clear"/>'); 
            }
            if((position-1) % num_per_row == 0) {
                $(this).addClass('alpha'); 
            }
        }); 
    
    }
    else {
        
        if($(this).parents('.container_12').length) {
            if($(this).parents('.grid_6').length) {
                if($(this).hasClass('small')) {
                    $(this).find('.image').addClass('grid_3').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_3').addClass('omega');
                }
                else {
                    $(this).find('.image').addClass('grid_4').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_2').addClass('omega');
                }
            }       
            else if($(this).parents('.grid_8').length) {
                if($(this).hasClass('small')) {
                    $(this).find('.image').addClass('grid_3').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_5').addClass('omega');
                }
                else {
                    $(this).find('.image').addClass('grid_4').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_4').addClass('omega');                
                }
            }   
            else if($(this).parents('.grid_9').length) {
                if($(this).hasClass('small')) {
                    $(this).find('.image').addClass('grid_3').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_6').addClass('omega');
                }
                else {
                    $(this).find('.image').addClass('grid_4').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_5').addClass('omega');
                }
            }           
            else if($(this).parents('.grid_12').length) {
                if($(this).hasClass('small')) {
                    $(this).find('.image').addClass('grid_3').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_9').addClass('omega');
                }
                else {
                    $(this).find('.image').addClass('grid_4').addClass('alpha');
                    $(this).find('.image').siblings('.info').addClass('grid_8').addClass('omega');
                }
            }
        }
    }
});

$('.subscribe-form, .contact-form').each(function() {
    if($(this).parents('.grid_3, .grid_4').length) {
        $(this).find('.h-captcha').attr('data-size', 'compact');
    }
});
(function($,window,undefined){var TRUE=true,FALSE=false,NULL=null,QTIP,PLUGINS,MOUSE,usedIDs={},uitooltip='ui-tooltip',widget='ui-widget',disabled='ui-state-disabled',selector='div.qtip.'+uitooltip,defaultClass=uitooltip+'-default',focusClass=uitooltip+'-focus',hoverClass=uitooltip+'-hover',fluidClass=uitooltip+'-fluid',hideOffset='-31000px',replaceSuffix='_replacedByqTip',oldtitle='oldtitle',trackingBound;function log(){log.history=log.history||[];log.history.push(arguments);if('object'===typeof console){var c=console[console.warn?'warn':'log'],args=Array.prototype.slice.call(arguments),a;if(typeof arguments[0]==='string'){args[0]='qTip2: '+args[0];}
a=c.apply?c.apply(console,args):c(args);}}
function sanitizeOptions(opts)
{var content;if(!opts||'object'!==typeof opts){return FALSE;}
if(opts.metadata===NULL||'object'!==typeof opts.metadata){opts.metadata={type:opts.metadata};}
if('content'in opts){if(opts.content===NULL||'object'!==typeof opts.content||opts.content.jquery){opts.content={text:opts.content};}
content=opts.content.text||FALSE;if(!$.isFunction(content)&&((!content&&!content.attr)||content.length<1||('object'===typeof content&&!content.jquery))){opts.content.text=FALSE;}
if('title'in opts.content){if(opts.content.title===NULL||'object'!==typeof opts.content.title){opts.content.title={text:opts.content.title};}
content=opts.content.title.text||FALSE;if(!$.isFunction(content)&&((!content&&!content.attr)||content.length<1||('object'===typeof content&&!content.jquery))){opts.content.title.text=FALSE;}}}
if('position'in opts){if(opts.position===NULL||'object'!==typeof opts.position){opts.position={my:opts.position,at:opts.position};}}
if('show'in opts){if(opts.show===NULL||'object'!==typeof opts.show){if(opts.show.jquery){opts.show={target:opts.show};}
else{opts.show={event:opts.show};}}}
if('hide'in opts){if(opts.hide===NULL||'object'!==typeof opts.hide){if(opts.hide.jquery){opts.hide={target:opts.hide};}
else{opts.hide={event:opts.hide};}}}
if('style'in opts){if(opts.style===NULL||'object'!==typeof opts.style){opts.style={classes:opts.style};}}
$.each(PLUGINS,function(){if(this.sanitize){this.sanitize(opts);}});return opts;}
function QTip(target,options,id,attr)
{var self=this,docBody=document.body,tooltipID=uitooltip+'-'+id,isPositioning=0,isDrawing=0,tooltip=$(),namespace='.qtip-'+id,elements,cache;self.id=id;self.rendered=FALSE;self.elements=elements={target:target};self.timers={img:{}};self.options=options;self.checks={};self.plugins={};self.cache=cache={event:{},target:$(),disabled:FALSE,attr:attr,onTarget:FALSE};function convertNotation(notation)
{var i=0,obj,option=options,levels=notation.split('.');while(option=option[levels[i++]]){if(i<levels.length){obj=option;}}
return[obj||options,levels.pop()];}
function setWidget(){var on=options.style.widget;tooltip.toggleClass(widget,on).toggleClass(defaultClass,options.style['default']&&!on);elements.content.toggleClass(widget+'-content',on);if(elements.titlebar){elements.titlebar.toggleClass(widget+'-header',on);}
if(elements.button){elements.button.toggleClass(uitooltip+'-icon',!on);}}
function removeTitle(reposition)
{if(elements.title){elements.titlebar.remove();elements.titlebar=elements.title=elements.button=NULL;if(reposition!==FALSE){self.reposition();}}}
function createButton()
{var button=options.content.title.button,isString=typeof button==='string',close=isString?button:'Close tooltip';if(elements.button){elements.button.remove();}
if(button.jquery){elements.button=button;}
else{elements.button=$('<a />',{'class':'ui-state-default ui-tooltip-close '+(options.style.widget?'':uitooltip+'-icon'),'title':close,'aria-label':close}).prepend($('<span />',{'class':'ui-icon ui-icon-close','html':'&times;'}));}
elements.button.appendTo(elements.titlebar).attr('role','button').click(function(event){if(!tooltip.hasClass(disabled)){self.hide(event);}
return FALSE;});self.redraw();}
function createTitle()
{var id=tooltipID+'-title';if(elements.titlebar){removeTitle();}
elements.titlebar=$('<div />',{'class':uitooltip+'-titlebar '+(options.style.widget?'ui-widget-header':'')}).append(elements.title=$('<div />',{'id':id,'class':uitooltip+'-title','aria-atomic':TRUE})).insertBefore(elements.content).delegate('.ui-tooltip-close','mousedown keydown mouseup keyup mouseout',function(event){$(this).toggleClass('ui-state-active ui-state-focus',event.type.substr(-4)==='down');}).delegate('.ui-tooltip-close','mouseover mouseout',function(event){$(this).toggleClass('ui-state-hover',event.type==='mouseover');});if(options.content.title.button){createButton();}
else if(self.rendered){self.redraw();}}
function updateButton(button)
{var elem=elements.button,title=elements.title;if(!self.rendered){return FALSE;}
if(!button){elem.remove();}
else{if(!title){createTitle();}
createButton();}}
function updateTitle(content,reposition)
{var elem=elements.title;if(!self.rendered||!content){return FALSE;}
if($.isFunction(content)){content=content.call(target,cache.event,self);}
if(content===FALSE){return removeTitle(FALSE);}
else if(content.jquery&&content.length>0){elem.empty().append(content.css({display:'block'}));}
else{elem.html(content);}
self.redraw();if(reposition!==FALSE&&self.rendered&&tooltip.is(':visible')){self.reposition(cache.event);}}
function updateContent(content,reposition)
{var elem=elements.content;if(!self.rendered||!content){return FALSE;}
if($.isFunction(content)){content=content.call(target,cache.event,self)||'';}
if(content.jquery&&content.length>0){elem.empty().append(content.css({display:'block'}));}
else{elem.html(content);}
function detectImages(next){var images,srcs={};function imageLoad(image){if(image){delete srcs[image.src];clearTimeout(self.timers.img[image.src]);$(image).unbind(namespace);}
if($.isEmptyObject(srcs)){self.redraw();if(reposition!==FALSE){self.reposition(cache.event);}
next();}}
if((images=elem.find('img:not([height]):not([width])')).length===0){return imageLoad();}
images.each(function(i,elem){if(srcs[elem.src]!==undefined){return;}
var iterations=0,maxIterations=3;(function timer(){if(elem.height||elem.width||(iterations>maxIterations)){return imageLoad(elem);}
iterations+=1;self.timers.img[elem.src]=setTimeout(timer,700);}());$(elem).bind('error'+namespace+' load'+namespace,function(){imageLoad(this);});srcs[elem.src]=elem;});}
if(self.rendered<0){tooltip.queue('fx',detectImages);}
else{isDrawing=0;detectImages($.noop);}
return self;}
function assignEvents()
{var posOptions=options.position,targets={show:options.show.target,hide:options.hide.target,viewport:$(posOptions.viewport),document:$(document),body:$(document.body),window:$(window)},events={show:$.trim(''+options.show.event).split(' '),hide:$.trim(''+options.hide.event).split(' ')},IE6=$.browser.msie&&parseInt($.browser.version,10)===6;function showMethod(event)
{if(tooltip.hasClass(disabled)){return FALSE;}
clearTimeout(self.timers.show);clearTimeout(self.timers.hide);var callback=function(){self.toggle(TRUE,event);};if(options.show.delay>0){self.timers.show=setTimeout(callback,options.show.delay);}
else{callback();}}
function hideMethod(event)
{if(tooltip.hasClass(disabled)||isPositioning||isDrawing){return FALSE;}
var relatedTarget=$(event.relatedTarget||event.target),ontoTooltip=relatedTarget.closest(selector)[0]===tooltip[0],ontoTarget=relatedTarget[0]===targets.show[0];clearTimeout(self.timers.show);clearTimeout(self.timers.hide);if((posOptions.target==='mouse'&&ontoTooltip)||(options.hide.fixed&&((/mouse(out|leave|move)/).test(event.type)&&(ontoTooltip||ontoTarget)))){try{event.preventDefault();event.stopImmediatePropagation();}catch(e){}return;}
if(options.hide.delay>0){self.timers.hide=setTimeout(function(){self.hide(event);},options.hide.delay);}
else{self.hide(event);}}
function inactiveMethod(event)
{if(tooltip.hasClass(disabled)){return FALSE;}
clearTimeout(self.timers.inactive);self.timers.inactive=setTimeout(function(){self.hide(event);},options.hide.inactive);}
function repositionMethod(event){if(tooltip.is(':visible')){self.reposition(event);}}
tooltip.bind('mouseenter'+namespace+' mouseleave'+namespace,function(event){var state=event.type==='mouseenter';if(state){self.focus(event);}
tooltip.toggleClass(hoverClass,state);});if(options.hide.fixed){targets.hide=targets.hide.add(tooltip);tooltip.bind('mouseover'+namespace,function(){if(!tooltip.hasClass(disabled)){clearTimeout(self.timers.hide);}});}
if(/mouse(out|leave)/i.test(options.hide.event)){if(options.hide.leave==='window'){targets.window.bind('mouseout'+namespace+' blur'+namespace,function(event){if(/select|option/.test(event.target)&&!event.relatedTarget){self.hide(event);}});}}
else if(/mouse(over|enter)/i.test(options.show.event)){targets.hide.bind('mouseleave'+namespace,function(event){clearTimeout(self.timers.show);});}
if((''+options.hide.event).indexOf('unfocus')>-1){targets.body.bind('mousedown'+namespace,function(event){var $target=$(event.target),enabled=!tooltip.hasClass(disabled)&&tooltip.is(':visible');if($target[0]!==tooltip[0]&&$target.parents(selector).length===0&&!$target.closest(target).length&&!$target.attr('disabled')){self.hide(event);}});}
if('number'===typeof options.hide.inactive){targets.show.bind('qtip-'+id+'-inactive',inactiveMethod);$.each(QTIP.inactiveEvents,function(index,type){targets.hide.add(elements.tooltip).bind(type+namespace+'-inactive',inactiveMethod);});}
$.each(events.hide,function(index,type){var showIndex=$.inArray(type,events.show),targetHide=$(targets.hide);if((showIndex>-1&&targetHide.add(targets.show).length===targetHide.length)||type==='unfocus')
{targets.show.bind(type+namespace,function(event){if(tooltip.is(':visible')){hideMethod(event);}
else{showMethod(event);}});delete events.show[showIndex];}
else{targets.hide.bind(type+namespace,hideMethod);}});$.each(events.show,function(index,type){targets.show.bind(type+namespace,showMethod);});if('number'===typeof options.hide.distance){targets.show.add(tooltip).bind('mousemove'+namespace,function(event){var origin=cache.origin||{},limit=options.hide.distance,abs=Math.abs;if(abs(event.pageX-origin.pageX)>=limit||abs(event.pageY-origin.pageY)>=limit){self.hide(event);}});}
if(posOptions.target==='mouse'){targets.show.bind('mousemove'+namespace,function(event){MOUSE={pageX:event.pageX,pageY:event.pageY,type:'mousemove'};});if(posOptions.adjust.mouse){if(options.hide.event){tooltip.bind('mouseleave'+namespace,function(event){if((event.relatedTarget||event.target)!==targets.show[0]){self.hide(event);}});elements.target.bind('mouseenter'+namespace+' mouseleave'+namespace,function(event){cache.onTarget=event.type==='mouseenter';});}
targets.document.bind('mousemove'+namespace,function(event){if(cache.onTarget&&!tooltip.hasClass(disabled)&&tooltip.is(':visible')){self.reposition(event||MOUSE);}});}}
if(posOptions.adjust.resize||targets.viewport.length){($.event.special.resize?targets.viewport:targets.window).bind('resize'+namespace,repositionMethod);}
if(targets.viewport.length||(IE6&&tooltip.css('position')==='fixed')){targets.viewport.bind('scroll'+namespace,repositionMethod);}}
function unassignEvents()
{var targets=[options.show.target[0],options.hide.target[0],self.rendered&&elements.tooltip[0],options.position.container[0],options.position.viewport[0],window,document];if(self.rendered){$([]).pushStack($.grep(targets,function(i){return typeof i==='object';})).unbind(namespace);}
else{options.show.target.unbind(namespace+'-create');}}
self.checks.builtin={'^id$':function(obj,o,v){var id=v===TRUE?QTIP.nextid:v,tooltipID=uitooltip+'-'+id;if(id!==FALSE&&id.length>0&&!$('#'+tooltipID).length){tooltip[0].id=tooltipID;elements.content[0].id=tooltipID+'-content';elements.title[0].id=tooltipID+'-title';}},'^content.text$':function(obj,o,v){updateContent(v);},'^content.title.text$':function(obj,o,v){if(!v){return removeTitle();}
if(!elements.title&&v){createTitle();}
updateTitle(v);},'^content.title.button$':function(obj,o,v){updateButton(v);},'^position.(my|at)$':function(obj,o,v){if('string'===typeof v){obj[o]=new PLUGINS.Corner(v);}},'^position.container$':function(obj,o,v){if(self.rendered){tooltip.appendTo(v);}},'^show.ready$':function(){if(!self.rendered){self.render(1);}
else{self.toggle(TRUE);}},'^style.classes$':function(obj,o,v){tooltip.attr('class',uitooltip+' qtip ui-helper-reset '+v);},'^style.widget|content.title':setWidget,'^events.(render|show|move|hide|focus|blur)$':function(obj,o,v){tooltip[($.isFunction(v)?'':'un')+'bind']('tooltip'+o,v);},'^(show|hide|position).(event|target|fixed|inactive|leave|distance|viewport|adjust)':function(){var posOptions=options.position;tooltip.attr('tracking',posOptions.target==='mouse'&&posOptions.adjust.mouse);unassignEvents();assignEvents();}};$.extend(self,{render:function(show)
{if(self.rendered){return self;}
var text=options.content.text,title=options.content.title.text,posOptions=options.position,callback=$.Event('tooltiprender');$.attr(target[0],'aria-describedby',tooltipID);tooltip=elements.tooltip=$('<div/>',{'id':tooltipID,'class':uitooltip+' qtip ui-helper-reset '+defaultClass+' '+options.style.classes+' '+uitooltip+'-pos-'+options.position.my.abbrev(),'width':options.style.width||'','height':options.style.height||'','tracking':posOptions.target==='mouse'&&posOptions.adjust.mouse,'role':'alert','aria-live':'polite','aria-atomic':FALSE,'aria-describedby':tooltipID+'-content','aria-hidden':TRUE}).toggleClass(disabled,cache.disabled).data('qtip',self).appendTo(options.position.container).append(elements.content=$('<div />',{'class':uitooltip+'-content','id':tooltipID+'-content','aria-atomic':TRUE}));self.rendered=-1;isDrawing=1;isPositioning=1;if(title){createTitle();if(!$.isFunction(title)){updateTitle(title,FALSE);}}
if(!$.isFunction(text)){updateContent(text,FALSE);}
self.rendered=TRUE;setWidget();$.each(options.events,function(name,callback){if($.isFunction(callback)){tooltip.bind(name==='toggle'?'tooltipshow tooltiphide':'tooltip'+name,callback);}});$.each(PLUGINS,function(){if(this.initialize==='render'){this(self);}});assignEvents();tooltip.queue('fx',function(next){callback.originalEvent=cache.event;tooltip.trigger(callback,[self]);isDrawing=0;isPositioning=0;self.redraw();if(options.show.ready||show){self.toggle(TRUE,cache.event,FALSE);}
next();});return self;},get:function(notation)
{var result,o;switch(notation.toLowerCase())
{case'dimensions':result={height:tooltip.outerHeight(),width:tooltip.outerWidth()};break;case'offset':result=PLUGINS.offset(tooltip,options.position.container);break;default:o=convertNotation(notation.toLowerCase());result=o[0][o[1]];result=result.precedance?result.string():result;break;}
return result;},set:function(option,value)
{var rmove=/^position\.(my|at|adjust|target|container)|style|content|show\.ready/i,rdraw=/^content\.(title|attr)|style/i,reposition=FALSE,redraw=FALSE,checks=self.checks,name;function callback(notation,args){var category,rule,match;for(category in checks){for(rule in checks[category]){if(match=(new RegExp(rule,'i')).exec(notation)){args.push(match);checks[category][rule].apply(self,args);}}}}
if('string'===typeof option){name=option;option={};option[name]=value;}
else{option=$.extend(TRUE,{},option);}
$.each(option,function(notation,value){var obj=convertNotation(notation.toLowerCase()),previous;previous=obj[0][obj[1]];obj[0][obj[1]]='object'===typeof value&&value.nodeType?$(value):value;option[notation]=[obj[0],obj[1],value,previous];reposition=rmove.test(notation)||reposition;redraw=rdraw.test(notation)||redraw;});sanitizeOptions(options);isPositioning=isDrawing=1;$.each(option,callback);isPositioning=isDrawing=0;if(tooltip.is(':visible')&&self.rendered){if(reposition){self.reposition(options.position.target==='mouse'?NULL:cache.event);}
if(redraw){self.redraw();}}
return self;},toggle:function(state,event)
{if(!self.rendered){return state?self.render(1):self;}
var type=state?'show':'hide',opts=options[type],visible=tooltip.is(':visible'),sameTarget=!event||options[type].target.length<2||cache.target[0]===event.target,posOptions=options.position,contentOptions=options.content,delay,callback;if((typeof state).search('boolean|number')){state=!visible;}
if(!tooltip.is(':animated')&&visible===state&&sameTarget){return self;}
if(event){if((/over|enter/).test(event.type)&&(/out|leave/).test(cache.event.type)&&event.target===options.show.target[0]&&tooltip.has(event.relatedTarget).length){return self;}
cache.event=$.extend({},event);}
callback=$.Event('tooltip'+type);callback.originalEvent=event?cache.event:NULL;tooltip.trigger(callback,[self,90]);if(callback.isDefaultPrevented()){return self;}
$.attr(tooltip[0],'aria-hidden',!!!state);if(state){cache.origin=$.extend({},MOUSE);self.focus(event);if($.isFunction(contentOptions.text)){updateContent(contentOptions.text,FALSE);}
if($.isFunction(contentOptions.title.text)){updateTitle(contentOptions.title.text,FALSE);}
if(!trackingBound&&posOptions.target==='mouse'&&posOptions.adjust.mouse){$(document).bind('mousemove.qtip',function(event){MOUSE={pageX:event.pageX,pageY:event.pageY,type:'mousemove'};});trackingBound=TRUE;}
self.reposition(event,arguments[2]);if((callback.solo=!!opts.solo)){$(selector,opts.solo).not(tooltip).qtip('hide',callback);}}
else{clearTimeout(self.timers.show);delete cache.origin;if(trackingBound&&!$(selector+'[tracking="true"]:visible',opts.solo).not(tooltip).length){$(document).unbind('mousemove.qtip');trackingBound=FALSE;}
self.blur(event);}
function after(){if(state){if($.browser.msie){tooltip[0].style.removeAttribute('filter');}
tooltip.css('overflow','');if('string'===typeof opts.autofocus){$(opts.autofocus,tooltip).focus();}
callback=$.Event('tooltipvisible');callback.originalEvent=event?cache.event:NULL;tooltip.trigger(callback,[self]);opts.target.trigger('qtip-'+id+'-inactive');}
else{tooltip.css({display:'',visibility:'',opacity:'',left:'',top:''});}}
if(sameTarget){tooltip.stop(0,1);}
if(opts.effect===FALSE){tooltip[type]();after.call(tooltip);}
else if($.isFunction(opts.effect)){opts.effect.call(tooltip,self);tooltip.queue('fx',function(n){after();n();});}
else{tooltip.fadeTo(90,state?1:0,after);}
if(state){opts.target.trigger('qtip-'+id+'-inactive');}
return self;},show:function(event){return self.toggle(TRUE,event);},hide:function(event){return self.toggle(FALSE,event);},focus:function(event)
{if(!self.rendered){return self;}
var qtips=$(selector),curIndex=parseInt(tooltip[0].style.zIndex,10),newIndex=QTIP.zindex+qtips.length,cachedEvent=$.extend({},event),focusedElem,callback;if(!tooltip.hasClass(focusClass))
{callback=$.Event('tooltipfocus');callback.originalEvent=cachedEvent;tooltip.trigger(callback,[self,newIndex]);if(!callback.isDefaultPrevented()){if(curIndex!==newIndex){qtips.each(function(){if(this.style.zIndex>curIndex){this.style.zIndex=this.style.zIndex-1;}});qtips.filter('.'+focusClass).qtip('blur',cachedEvent);}
tooltip.addClass(focusClass)[0].style.zIndex=newIndex;}}
return self;},blur:function(event){var cachedEvent=$.extend({},event),callback;tooltip.removeClass(focusClass);callback=$.Event('tooltipblur');callback.originalEvent=cachedEvent;tooltip.trigger(callback,[self]);return self;},reposition:function(event,effect)
{if(!self.rendered||isPositioning){return self;}
isPositioning=1;var target=options.position.target,posOptions=options.position,my=posOptions.my,at=posOptions.at,adjust=posOptions.adjust,method=adjust.method.split(' '),elemWidth=tooltip.outerWidth(),elemHeight=tooltip.outerHeight(),targetWidth=0,targetHeight=0,callback=$.Event('tooltipmove'),fixed=tooltip.css('position')==='fixed',viewport=posOptions.viewport,position={left:0,top:0},container=posOptions.container,flipoffset=FALSE,tip=self.plugins.tip,readjust={horizontal:method[0],vertical:(method[1]=method[1]||method[0]),enabled:viewport.jquery&&target[0]!==window&&target[0]!==docBody&&adjust.method!=='none',left:function(posLeft){var isShift=readjust.horizontal==='shift',viewportScroll=-container.offset.left+viewport.offset.left+viewport.scrollLeft,myWidth=my.x==='left'?elemWidth:my.x==='right'?-elemWidth:-elemWidth/2,atWidth=at.x==='left'?targetWidth:at.x==='right'?-targetWidth:-targetWidth/2,tipWidth=tip&&tip.size?tip.size.width||0:0,tipAdjust=tip&&tip.corner&&tip.corner.precedance==='x'&&!isShift?tipWidth:0,overflowLeft=viewportScroll-posLeft+tipAdjust,overflowRight=posLeft+elemWidth-viewport.width-viewportScroll+tipAdjust,offset=myWidth-(my.precedance==='x'||my.x===my.y?atWidth:0)-(at.x==='center'?targetWidth/2:0),isCenter=my.x==='center';if(isShift){tipAdjust=tip&&tip.corner&&tip.corner.precedance==='y'?tipWidth:0;offset=(my.x==='left'?1:-1)*myWidth-tipAdjust;position.left+=overflowLeft>0?overflowLeft:overflowRight>0?-overflowRight:0;position.left=Math.max(-container.offset.left+viewport.offset.left+(tipAdjust&&tip.corner.x==='center'?tip.offset:0),posLeft-offset,Math.min(Math.max(-container.offset.left+viewport.offset.left+viewport.width,posLeft+offset),position.left));}
else{if(overflowLeft>0&&(my.x!=='left'||overflowRight>0)){position.left-=offset;}
else if(overflowRight>0&&(my.x!=='right'||overflowLeft>0)){position.left-=isCenter?-offset:offset;}
if(position.left!==posLeft&&isCenter){position.left-=adjust.x;}
if(position.left<viewportScroll&&-position.left>overflowRight){position.left=posLeft;}}
return position.left-posLeft;},top:function(posTop){var isShift=readjust.vertical==='shift',viewportScroll=-container.offset.top+viewport.offset.top+viewport.scrollTop,myHeight=my.y==='top'?elemHeight:my.y==='bottom'?-elemHeight:-elemHeight/2,atHeight=at.y==='top'?targetHeight:at.y==='bottom'?-targetHeight:-targetHeight/2,tipHeight=tip&&tip.size?tip.size.height||0:0,tipAdjust=tip&&tip.corner&&tip.corner.precedance==='y'&&!isShift?tipHeight:0,overflowTop=viewportScroll-posTop+tipAdjust,overflowBottom=posTop+elemHeight-viewport.height-viewportScroll+tipAdjust,offset=myHeight-(my.precedance==='y'||my.x===my.y?atHeight:0)-(at.y==='center'?targetHeight/2:0),isCenter=my.y==='center';if(isShift){tipAdjust=tip&&tip.corner&&tip.corner.precedance==='x'?tipHeight:0;offset=(my.y==='top'?1:-1)*myHeight-tipAdjust;position.top+=overflowTop>0?overflowTop:overflowBottom>0?-overflowBottom:0;position.top=Math.max(-container.offset.top+viewport.offset.top+(tipAdjust&&tip.corner.x==='center'?tip.offset:0),posTop-offset,Math.min(Math.max(-container.offset.top+viewport.offset.top+viewport.height,posTop+offset),position.top));}
else{if(overflowTop>0&&(my.y!=='top'||overflowBottom>0)){position.top-=offset;}
else if(overflowBottom>0&&(my.y!=='bottom'||overflowTop>0)){position.top-=isCenter?-offset:offset;}
if(position.top!==posTop&&isCenter){position.top-=adjust.y;}
if(position.top<0&&-position.top>overflowBottom){position.top=posTop;}}
return position.top-posTop;}},win;if($.isArray(target)&&target.length===2){at={x:'left',y:'top'};position={left:target[0],top:target[1]};}
else if(target==='mouse'&&((event&&event.pageX)||cache.event.pageX)){at={x:'left',y:'top'};event=(event&&(event.type==='resize'||event.type==='scroll')?cache.event:event&&event.pageX&&event.type==='mousemove'?event:MOUSE&&MOUSE.pageX&&(adjust.mouse||!event||!event.pageX)?{pageX:MOUSE.pageX,pageY:MOUSE.pageY}:!adjust.mouse&&cache.origin&&cache.origin.pageX&&options.show.distance?cache.origin:event)||event||cache.event||MOUSE||{};position={top:event.pageY,left:event.pageX};}
else{if(target==='event'){if(event&&event.target&&event.type!=='scroll'&&event.type!=='resize'){target=cache.target=$(event.target);}
else{target=cache.target;}}
else{target=cache.target=$(target.jquery?target:elements.target);}
target=$(target).eq(0);if(target.length===0){return self;}
else if(target[0]===document||target[0]===window){targetWidth=PLUGINS.iOS?window.innerWidth:target.width();targetHeight=PLUGINS.iOS?window.innerHeight:target.height();if(target[0]===window){position={top:(viewport||target).scrollTop(),left:(viewport||target).scrollLeft()};}}
else if(target.is('area')&&PLUGINS.imagemap){position=PLUGINS.imagemap(target,at,readjust.enabled?method:FALSE);}
else if(target[0].namespaceURI==='http://www.w3.org/2000/svg'&&PLUGINS.svg){position=PLUGINS.svg(target,at);}
else{targetWidth=target.outerWidth();targetHeight=target.outerHeight();position=PLUGINS.offset(target,container);}
if(position.offset){targetWidth=position.width;targetHeight=position.height;flipoffset=position.flipoffset;position=position.offset;}
if((PLUGINS.iOS<4.1&&PLUGINS.iOS>3.1)||PLUGINS.iOS==4.3||(!PLUGINS.iOS&&fixed)){win=$(window);position.left-=win.scrollLeft();position.top-=win.scrollTop();}
position.left+=at.x==='right'?targetWidth:at.x==='center'?targetWidth/2:0;position.top+=at.y==='bottom'?targetHeight:at.y==='center'?targetHeight/2:0;}
position.left+=adjust.x+(my.x==='right'?-elemWidth:my.x==='center'?-elemWidth/2:0);position.top+=adjust.y+(my.y==='bottom'?-elemHeight:my.y==='center'?-elemHeight/2:0);if(readjust.enabled){viewport={elem:viewport,height:viewport[(viewport[0]===window?'h':'outerH')+'eight'](),width:viewport[(viewport[0]===window?'w':'outerW')+'idth'](),scrollLeft:fixed?0:viewport.scrollLeft(),scrollTop:fixed?0:viewport.scrollTop(),offset:viewport.offset()||{left:0,top:0}};container={elem:container,scrollLeft:container.scrollLeft(),scrollTop:container.scrollTop(),offset:container.offset()||{left:0,top:0}};position.adjusted={left:readjust.horizontal!=='none'?readjust.left(position.left):0,top:readjust.vertical!=='none'?readjust.top(position.top):0};if(position.adjusted.left+position.adjusted.top){tooltip.attr('class',tooltip[0].className.replace(/ui-tooltip-pos-\w+/i,uitooltip+'-pos-'+my.abbrev()));}
if(flipoffset&&position.adjusted.left){position.left+=flipoffset.left;}
if(flipoffset&&position.adjusted.top){position.top+=flipoffset.top;}}
else{position.adjusted={left:0,top:0};}
callback.originalEvent=$.extend({},event);tooltip.trigger(callback,[self,position,viewport.elem||viewport]);if(callback.isDefaultPrevented()){return self;}
delete position.adjusted;if(effect===FALSE||isNaN(position.left)||isNaN(position.top)||target==='mouse'||!$.isFunction(posOptions.effect)){tooltip.css(position);}
else if($.isFunction(posOptions.effect)){posOptions.effect.call(tooltip,self,$.extend({},position));tooltip.queue(function(next){$(this).css({opacity:'',height:''});if($.browser.msie){this.style.removeAttribute('filter');}
next();});}
isPositioning=0;return self;},redraw:function()
{if(self.rendered<1||isDrawing){return self;}
var container=options.position.container,perc,width,max,min;isDrawing=1;if(options.style.height){tooltip.css('height',options.style.height);}
if(options.style.width){tooltip.css('width',options.style.width);}
else{tooltip.css('width','').addClass(fluidClass);width=tooltip.width()+1;max=tooltip.css('max-width')||'';min=tooltip.css('min-width')||'';perc=(max+min).indexOf('%')>-1?container.width()/100:0;max=((max.indexOf('%')>-1?perc:1)*parseInt(max,10))||width;min=((min.indexOf('%')>-1?perc:1)*parseInt(min,10))||0;width=max+min?Math.min(Math.max(width,min),max):width;tooltip.css('width',Math.round(width)).removeClass(fluidClass);}
isDrawing=0;return self;},disable:function(state)
{if('boolean'!==typeof state){state=!(tooltip.hasClass(disabled)||cache.disabled);}
if(self.rendered){tooltip.toggleClass(disabled,state);$.attr(tooltip[0],'aria-disabled',state);}
else{cache.disabled=!!state;}
return self;},enable:function(){return self.disable(FALSE);},destroy:function()
{var t=target[0],title=$.attr(t,oldtitle),elemAPI=target.data('qtip');if(self.rendered){tooltip.remove();$.each(self.plugins,function(){if(this.destroy){this.destroy();}});}
clearTimeout(self.timers.show);clearTimeout(self.timers.hide);unassignEvents();if(!elemAPI||self===elemAPI){$.removeData(t,'qtip');if(options.suppress&&title){$.attr(t,'title',title);target.removeAttr(oldtitle);}
target.removeAttr('aria-describedby');}
target.unbind('.qtip-'+id);delete usedIDs[self.id];return target;}});}
function init(id,opts)
{var obj,posOptions,attr,config,title,elem=$(this),docBody=$(document.body),newTarget=this===document?docBody:elem,metadata=(elem.metadata)?elem.metadata(opts.metadata):NULL,metadata5=opts.metadata.type==='html5'&&metadata?metadata[opts.metadata.name]:NULL,html5=elem.data(opts.metadata.name||'qtipopts');try{html5=typeof html5==='string'?(new Function("return "+html5))():html5;}
catch(e){log('Unable to parse HTML5 attribute data: '+html5);}
config=$.extend(TRUE,{},QTIP.defaults,opts,typeof html5==='object'?sanitizeOptions(html5):NULL,sanitizeOptions(metadata5||metadata));posOptions=config.position;config.id=id;if('boolean'===typeof config.content.text){attr=elem.attr(config.content.attr);if(config.content.attr!==FALSE&&attr){config.content.text=attr;}
else{log('Unable to locate content for tooltip! Aborting render of tooltip on element: ',elem);return FALSE;}}
if(!posOptions.container.length){posOptions.container=docBody;}
if(posOptions.target===FALSE){posOptions.target=newTarget;}
if(config.show.target===FALSE){config.show.target=newTarget;}
if(config.show.solo===TRUE){config.show.solo=docBody;}
if(config.hide.target===FALSE){config.hide.target=newTarget;}
if(config.position.viewport===TRUE){config.position.viewport=posOptions.container;}
posOptions.at=new PLUGINS.Corner(posOptions.at);posOptions.my=new PLUGINS.Corner(posOptions.my);if($.data(this,'qtip')){if(config.overwrite){elem.qtip('destroy');}
else if(config.overwrite===FALSE){return FALSE;}}
if(config.suppress&&(title=$.attr(this,'title'))){$(this).removeAttr('title').attr(oldtitle,title);}
obj=new QTip(elem,config,id,!!attr);$.data(this,'qtip',obj);elem.bind('remove.qtip-'+id,function(){obj.destroy();});return obj;}
QTIP=$.fn.qtip=function(options,notation,newValue)
{var command=(''+options).toLowerCase(),returned=NULL,args=$.makeArray(arguments).slice(1),event=args[args.length-1],opts=this[0]?$.data(this[0],'qtip'):NULL;if((!arguments.length&&opts)||command==='api'){return opts;}
else if('string'===typeof options)
{this.each(function()
{var api=$.data(this,'qtip');if(!api){return TRUE;}
if(event&&event.timeStamp){api.cache.event=event;}
if((command==='option'||command==='options')&&notation){if($.isPlainObject(notation)||newValue!==undefined){api.set(notation,newValue);}
else{returned=api.get(notation);return FALSE;}}
else if(api[command]){api[command].apply(api[command],args);}});return returned!==NULL?returned:this;}
else if('object'===typeof options||!arguments.length)
{opts=sanitizeOptions($.extend(TRUE,{},options));return QTIP.bind.call(this,opts,event);}};QTIP.bind=function(opts,event)
{return this.each(function(i){var options,targets,events,namespace,api,id;id=$.isArray(opts.id)?opts.id[i]:opts.id;id=!id||id===FALSE||id.length<1||usedIDs[id]?QTIP.nextid++:(usedIDs[id]=id);namespace='.qtip-'+id+'-create';api=init.call(this,id,opts);if(api===FALSE){return TRUE;}
options=api.options;$.each(PLUGINS,function(){if(this.initialize==='initialize'){this(api);}});targets={show:options.show.target,hide:options.hide.target};events={show:$.trim(''+options.show.event).replace(/ /g,namespace+' ')+namespace,hide:$.trim(''+options.hide.event).replace(/ /g,namespace+' ')+namespace};if(/mouse(over|enter)/i.test(events.show)&&!/mouse(out|leave)/i.test(events.hide)){events.hide+=' mouseleave'+namespace;}
targets.show.bind('mousemove'+namespace,function(event){MOUSE={pageX:event.pageX,pageY:event.pageY,type:'mousemove'};api.cache.onTarget=TRUE;});function hoverIntent(event){function render(){api.render(typeof event==='object'||options.show.ready);targets.show.add(targets.hide).unbind(namespace);}
if(api.cache.disabled){return FALSE;}
api.cache.event=$.extend({},event);api.cache.target=event?$(event.target):[undefined];if(options.show.delay>0){clearTimeout(api.timers.show);api.timers.show=setTimeout(render,options.show.delay);if(events.show!==events.hide){targets.hide.bind(events.hide,function(){clearTimeout(api.timers.show);});}}
else{render();}}
targets.show.bind(events.show,hoverIntent);if(options.show.ready||options.prerender){hoverIntent(event);}});};PLUGINS=QTIP.plugins={Corner:function(corner){corner=(''+corner).replace(/([A-Z])/,' $1').replace(/middle/gi,'center').toLowerCase();this.x=(corner.match(/left|right/i)||corner.match(/center/)||['inherit'])[0].toLowerCase();this.y=(corner.match(/top|bottom|center/i)||['inherit'])[0].toLowerCase();var f=corner.charAt(0);this.precedance=(f==='t'||f==='b'?'y':'x');this.string=function(){return this.precedance==='y'?this.y+this.x:this.x+this.y;};this.abbrev=function(){var x=this.x.substr(0,1),y=this.y.substr(0,1);return x===y?x:(x==='c'||(x!=='c'&&y!=='c'))?y+x:x+y;};this.clone=function(){return{x:this.x,y:this.y,precedance:this.precedance,string:this.string,abbrev:this.abbrev,clone:this.clone};};},offset:function(elem,container){var pos=elem.offset(),docBody=document.body,parent=container,scrolled,coffset,overflow;function scroll(e,i){pos.left+=i*e.scrollLeft();pos.top+=i*e.scrollTop();}
if(parent){do{if(parent.css('position')!=='static'){coffset=parent.position();pos.left-=coffset.left+(parseInt(parent.css('borderLeftWidth'),10)||0)+(parseInt(parent.css('marginLeft'),10)||0);pos.top-=coffset.top+(parseInt(parent.css('borderTopWidth'),10)||0)+(parseInt(parent.css('marginTop'),10)||0);if(!scrolled&&(overflow=parent.css('overflow'))!=='hidden'&&overflow!=='visible'){scrolled=parent;}}
if(parent[0]===docBody){break;}}
while(parent=parent.offsetParent());if(scrolled&&scrolled[0]!==docBody){scroll(scrolled,1);}}
return pos;},iOS:parseFloat((''+(/CPU.*OS ([0-9_]{1,3})|(CPU like).*AppleWebKit.*Mobile/i.exec(navigator.userAgent)||[0,''])[1]).replace('undefined','3_2').replace('_','.'))||FALSE,fn:{attr:function(attr,val){if(this.length){var self=this[0],title='title',api=$.data(self,'qtip');if(attr===title&&api&&'object'===typeof api&&api.options.suppress){if(arguments.length<2){return $.attr(self,oldtitle);}
else{if(api&&api.options.content.attr===title&&api.cache.attr){api.set('content.text',val);}
return this.attr(oldtitle,val);}}}
return $.fn['attr'+replaceSuffix].apply(this,arguments);},clone:function(keepData){var titles=$([]),title='title',elems=$.fn['clone'+replaceSuffix].apply(this,arguments);if(!keepData){elems.filter('['+oldtitle+']').attr('title',function(){return $.attr(this,oldtitle);}).removeAttr(oldtitle);}
return elems;},remove:$.ui?NULL:function(selector,keepData){if($.ui){return;}
$(this).each(function(){if(!keepData){if(!selector||$.filter(selector,[this]).length){$('*',this).add(this).each(function(){$(this).triggerHandler('remove');});}}});}}};$.each(PLUGINS.fn,function(name,func){if(!func||$.fn[name+replaceSuffix]){return TRUE;}
var old=$.fn[name+replaceSuffix]=$.fn[name];$.fn[name]=function(){return func.apply(this,arguments)||old.apply(this,arguments);};});QTIP.version='nightly';QTIP.nextid=0;QTIP.inactiveEvents='click dblclick mousedown mouseup mousemove mouseleave mouseenter'.split(' ');QTIP.zindex=15000;QTIP.defaults={prerender:FALSE,id:FALSE,overwrite:TRUE,suppress:TRUE,content:{text:TRUE,attr:'title',title:{text:FALSE,button:FALSE}},position:{my:'top left',at:'bottom right',target:FALSE,container:FALSE,viewport:FALSE,adjust:{x:0,y:0,mouse:TRUE,resize:TRUE,method:'flip flip'},effect:function(api,pos,viewport){$(this).animate(pos,{duration:200,queue:FALSE});}},show:{target:FALSE,event:'mouseenter',effect:TRUE,delay:90,solo:FALSE,ready:FALSE,autofocus:FALSE},hide:{target:FALSE,event:'mouseleave',effect:TRUE,delay:0,fixed:FALSE,inactive:FALSE,leave:'window',distance:FALSE},style:{classes:'',widget:FALSE,width:FALSE,height:FALSE,'default':TRUE},events:{render:NULL,move:NULL,show:NULL,hide:NULL,toggle:NULL,visible:NULL,focus:NULL,blur:NULL}};function Ajax(api)
{var self=this,tooltip=api.elements.tooltip,opts=api.options.content.ajax,namespace='.qtip-ajax',rscript=/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi,first=TRUE;api.checks.ajax={'^content.ajax':function(obj,name,v){if(name==='ajax'){opts=v;}
if(name==='once'){self.init();}
else if(opts&&opts.url){self.load();}
else{tooltip.unbind(namespace);}}};$.extend(self,{init:function(){if(opts&&opts.url){tooltip.unbind(namespace)[opts.once?'one':'bind']('tooltipshow'+namespace,self.load);}
return self;},load:function(event,first){var hasSelector=opts.url.indexOf(' '),url=opts.url,selector,hideFirst=opts.once&&!opts.loading&&first;if(hideFirst){try{event.preventDefault();}catch(e){}}
else if(event&&event.isDefaultPrevented()){return self;}
if(hasSelector>-1){selector=url.substr(hasSelector);url=url.substr(0,hasSelector);}
function after(){if(hideFirst){api.show(event.originalEvent);first=FALSE;}
if($.isFunction(opts.complete)){opts.complete.apply(this,arguments);}}
function successHandler(content){if(selector){content=$('<div/>').append(content.replace(rscript,"")).find(selector);}
api.set('content.text',content);}
function errorHandler(xh,status,error){if(xh.status===0){return;}
api.set('content.text',status+': '+error);}
$.ajax($.extend({success:successHandler,error:errorHandler,context:api},opts,{url:url,complete:after}));}});self.init();}
PLUGINS.ajax=function(api)
{var self=api.plugins.ajax;return'object'===typeof self?self:(api.plugins.ajax=new Ajax(api));};PLUGINS.ajax.initialize='render';PLUGINS.ajax.sanitize=function(options)
{var content=options.content,opts;if(content&&'ajax'in content){opts=content.ajax;if(typeof opts!=='object'){opts=options.content.ajax={url:opts};}
if('boolean'!==typeof opts.once&&opts.once){opts.once=!!opts.once;}}};$.extend(TRUE,QTIP.defaults,{content:{ajax:{loading:TRUE,once:TRUE}}});PLUGINS.imagemap=function(area,corner,flip)
{if(!area.jquery){area=$(area);}
var shape=(area[0].shape||area.attr('shape')).toLowerCase(),baseCoords=(area[0].coords||area.attr('coords')).split(','),coords=[],image=$('img[usemap="#'+area.parent('map').attr('name')+'"]'),imageOffset=image.offset(),result={width:0,height:0,offset:{top:1e10,right:0,bottom:0,left:1e10}},i=0,next=0,dimensions;function polyCoordinates(result,coords,corner)
{var i=0,compareX=1,compareY=1,realX=0,realY=0,newWidth=result.width,newHeight=result.height;while(newWidth>0&&newHeight>0&&compareX>0&&compareY>0)
{newWidth=Math.floor(newWidth/2);newHeight=Math.floor(newHeight/2);if(corner.x==='left'){compareX=newWidth;}
else if(corner.x==='right'){compareX=result.width-newWidth;}
else{compareX+=Math.floor(newWidth/2);}
if(corner.y==='top'){compareY=newHeight;}
else if(corner.y==='bottom'){compareY=result.height-newHeight;}
else{compareY+=Math.floor(newHeight/2);}
i=coords.length;while(i--)
{if(coords.length<2){break;}
realX=coords[i][0]-result.offset.left;realY=coords[i][1]-result.offset.top;if((corner.x==='left'&&realX>=compareX)||(corner.x==='right'&&realX<=compareX)||(corner.x==='center'&&(realX<compareX||realX>(result.width-compareX)))||(corner.y==='top'&&realY>=compareY)||(corner.y==='bottom'&&realY<=compareY)||(corner.y==='center'&&(realY<compareY||realY>(result.height-compareY)))){coords.splice(i,1);}}}
return{left:coords[0][0],top:coords[0][1]};}
imageOffset.left+=Math.ceil((image.outerWidth()-image.width())/2);imageOffset.top+=Math.ceil((image.outerHeight()-image.height())/2);if(shape==='poly'){i=baseCoords.length;while(i--)
{next=[parseInt(baseCoords[--i],10),parseInt(baseCoords[i+1],10)];if(next[0]>result.offset.right){result.offset.right=next[0];}
if(next[0]<result.offset.left){result.offset.left=next[0];}
if(next[1]>result.offset.bottom){result.offset.bottom=next[1];}
if(next[1]<result.offset.top){result.offset.top=next[1];}
coords.push(next);}}
else{coords=$.map(baseCoords,function(coord){return parseInt(coord,10);});}
switch(shape)
{case'rect':result={width:Math.abs(coords[2]-coords[0]),height:Math.abs(coords[3]-coords[1]),offset:{left:Math.min(coords[0],coords[2]),top:Math.min(coords[1],coords[3])}};break;case'circle':result={width:coords[2]+2,height:coords[2]+2,offset:{left:coords[0],top:coords[1]}};break;case'poly':$.extend(result,{width:Math.abs(result.offset.right-result.offset.left),height:Math.abs(result.offset.bottom-result.offset.top)});if(corner.string()==='centercenter'){result.offset={left:result.offset.left+(result.width/2),top:result.offset.top+(result.height/2)};}
else{result.offset=polyCoordinates(result,coords.slice(),corner);if(flip&&(flip[0]==='flip'||flip[1]==='flip')){result.flipoffset=polyCoordinates(result,coords.slice(),{x:corner.x==='left'?'right':corner.x==='right'?'left':'center',y:corner.y==='top'?'bottom':corner.y==='bottom'?'top':'center'});result.flipoffset.left-=result.offset.left;result.flipoffset.top-=result.offset.top;}}
result.width=result.height=0;break;}
result.offset.left+=imageOffset.left;result.offset.top+=imageOffset.top;return result;};function calculateTip(corner,width,height)
{var width2=Math.ceil(width/2),height2=Math.ceil(height/2),tips={bottomright:[[0,0],[width,height],[width,0]],bottomleft:[[0,0],[width,0],[0,height]],topright:[[0,height],[width,0],[width,height]],topleft:[[0,0],[0,height],[width,height]],topcenter:[[0,height],[width2,0],[width,height]],bottomcenter:[[0,0],[width,0],[width2,height]],rightcenter:[[0,0],[width,height2],[0,height]],leftcenter:[[width,0],[width,height],[0,height2]]};tips.lefttop=tips.bottomright;tips.righttop=tips.bottomleft;tips.leftbottom=tips.topright;tips.rightbottom=tips.topleft;return tips[corner.string()];}
function Tip(qTip,command)
{var self=this,opts=qTip.options.style.tip,elems=qTip.elements,tooltip=elems.tooltip,cache={top:0,left:0},size={width:opts.width,height:opts.height},color={},border=opts.border||0,namespace='.qtip-tip',hasCanvas=!!($('<canvas />')[0]||{}).getContext;self.corner=NULL;self.mimic=NULL;self.border=border;self.offset=opts.offset;self.size=size;qTip.checks.tip={'^position.my|style.tip.(corner|mimic|border)$':function(){if(!self.init()){self.destroy();}
qTip.reposition();},'^style.tip.(height|width)$':function(){size={width:opts.width,height:opts.height};self.create();self.update();qTip.reposition();},'^content.title.text|style.(classes|widget)$':function(){if(elems.tip){self.update();}}};function reposition(event,api,pos,viewport){if(!elems.tip){return;}
var newCorner=self.corner.clone(),adjust=pos.adjusted,method=qTip.options.position.adjust.method.split(' '),horizontal=method[0],vertical=method[1]||method[0],shift={left:FALSE,top:FALSE,x:0,y:0},offset,css={},props;if(self.corner.fixed!==TRUE){if(horizontal==='shift'&&newCorner.precedance==='x'&&adjust.left&&newCorner.y!=='center'){newCorner.precedance=newCorner.precedance==='x'?'y':'x';}
else if(horizontal==='flip'&&adjust.left){newCorner.x=newCorner.x==='center'?(adjust.left>0?'left':'right'):(newCorner.x==='left'?'right':'left');}
if(vertical==='shift'&&newCorner.precedance==='y'&&adjust.top&&newCorner.x!=='center'){newCorner.precedance=newCorner.precedance==='y'?'x':'y';}
else if(vertical==='flip'&&adjust.top){newCorner.y=newCorner.y==='center'?(adjust.top>0?'top':'bottom'):(newCorner.y==='top'?'bottom':'top');}
if(newCorner.string()!==cache.corner.string()&&(cache.top!==adjust.top||cache.left!==adjust.left)){self.update(newCorner,FALSE);}}
offset=self.position(newCorner,adjust);if(offset.right!==undefined){offset.left=-offset.right;}
if(offset.bottom!==undefined){offset.top=-offset.bottom;}
offset.user=Math.max(0,opts.offset);if(shift.left=(horizontal==='shift'&&!!adjust.left)){if(newCorner.x==='center'){css['margin-left']=shift.x=offset['margin-left']-adjust.left;}
else{props=offset.right!==undefined?[adjust.left,-offset.left]:[-adjust.left,offset.left];if((shift.x=Math.max(props[0],props[1]))>props[0]){pos.left-=adjust.left;shift.left=FALSE;}
css[offset.right!==undefined?'right':'left']=shift.x;}}
if(shift.top=(vertical==='shift'&&!!adjust.top)){if(newCorner.y==='center'){css['margin-top']=shift.y=offset['margin-top']-adjust.top;}
else{props=offset.bottom!==undefined?[adjust.top,-offset.top]:[-adjust.top,offset.top];if((shift.y=Math.max(props[0],props[1]))>props[0]){pos.top-=adjust.top;shift.top=FALSE;}
css[offset.bottom!==undefined?'bottom':'top']=shift.y;}}
elems.tip.css(css).toggle(!((shift.x&&shift.y)||(newCorner.x==='center'&&shift.y)||(newCorner.y==='center'&&shift.x)));pos.left-=offset.left.charAt?offset.user:horizontal!=='shift'||shift.top||!shift.left&&!shift.top?offset.left:0;pos.top-=offset.top.charAt?offset.user:vertical!=='shift'||shift.left||!shift.left&&!shift.top?offset.top:0;cache.left=adjust.left;cache.top=adjust.top;cache.corner=newCorner.clone();}
function borderWidth(corner,side,backup){side=!side?corner[corner.precedance]:side;var isFluid=tooltip.hasClass(fluidClass),isTitleTop=elems.titlebar&&corner.y==='top',elem=isTitleTop?elems.titlebar:elems.content,css='border-'+side+'-width',val;tooltip.addClass(fluidClass);val=parseInt(elem.css(css),10);val=(backup?val||parseInt(tooltip.css(css),10):val)||0;tooltip.toggleClass(fluidClass,isFluid);return val;}
function borderRadius(corner){var isTitleTop=elems.titlebar&&corner.y==='top',elem=isTitleTop?elems.titlebar:elems.content,moz=$.browser.mozilla,prefix=moz?'-moz-':$.browser.webkit?'-webkit-':'',side=corner.y+(moz?'':'-')+corner.x,css=prefix+(moz?'border-radius-'+side:'border-'+side+'-radius');return parseInt(elem.css(css),10)||parseInt(tooltip.css(css),10)||0;}
function calculateSize(corner){var y=corner.precedance==='y',width=size[y?'width':'height'],height=size[y?'height':'width'],isCenter=corner.string().indexOf('center')>-1,base=width*(isCenter?0.5:1),pow=Math.pow,round=Math.round,bigHyp,ratio,result,smallHyp=Math.sqrt(pow(base,2)+pow(height,2)),hyp=[(border/base)*smallHyp,(border/height)*smallHyp];hyp[2]=Math.sqrt(pow(hyp[0],2)-pow(border,2));hyp[3]=Math.sqrt(pow(hyp[1],2)-pow(border,2));bigHyp=smallHyp+hyp[2]+hyp[3]+(isCenter?0:hyp[0]);ratio=bigHyp/smallHyp;result=[round(ratio*height),round(ratio*width)];return{height:result[y?0:1],width:result[y?1:0]};}
$.extend(self,{init:function()
{var enabled=self.detectCorner()&&(hasCanvas||$.browser.msie);if(enabled){self.create();self.update();tooltip.unbind(namespace).bind('tooltipmove'+namespace,reposition);}
return enabled;},detectCorner:function()
{var corner=opts.corner,posOptions=qTip.options.position,at=posOptions.at,my=posOptions.my.string?posOptions.my.string():posOptions.my;if(corner===FALSE||(my===FALSE&&at===FALSE)){return FALSE;}
else{if(corner===TRUE){self.corner=new PLUGINS.Corner(my);}
else if(!corner.string){self.corner=new PLUGINS.Corner(corner);self.corner.fixed=TRUE;}}
cache.corner=new PLUGINS.Corner(self.corner.string());return self.corner.string()!=='centercenter';},detectColours:function(actual){var i,fill,border,tip=elems.tip.css('cssText',''),corner=actual||self.corner,precedance=corner[corner.precedance],borderSide='border-'+precedance+'-color',borderSideCamel='border'+precedance.charAt(0)+precedance.substr(1)+'Color',invalid=/rgba?\(0, 0, 0(, 0)?\)|transparent|#123456/i,backgroundColor='background-color',transparent='transparent',important=' !important',bodyBorder=$(document.body).css('color'),contentColour=qTip.elements.content.css('color'),useTitle=elems.titlebar&&(corner.y==='top'||(corner.y==='center'&&tip.position().top+(size.height/2)+opts.offset<elems.titlebar.outerHeight(1))),colorElem=useTitle?elems.titlebar:elems.content;tooltip.addClass(fluidClass);color.fill=fill=tip.css(backgroundColor);color.border=border=tip[0].style[borderSideCamel]||tip.css(borderSide)||tooltip.css(borderSide);if(!fill||invalid.test(fill)){color.fill=colorElem.css(backgroundColor)||transparent;if(invalid.test(color.fill)){color.fill=tooltip.css(backgroundColor)||fill;}}
if(!border||invalid.test(border)||border===bodyBorder){color.border=colorElem.css(borderSide)||transparent;if(invalid.test(color.border)){color.border=border;}}
$('*',tip).add(tip).css('cssText',backgroundColor+':'+transparent+important+';border:0'+important+';');tooltip.removeClass(fluidClass);},create:function()
{var width=size.width,height=size.height,vml;if(elems.tip){elems.tip.remove();}
elems.tip=$('<div />',{'class':'ui-tooltip-tip'}).css({width:width,height:height}).prependTo(tooltip);if(hasCanvas){$('<canvas />').appendTo(elems.tip)[0].getContext('2d').save();}
else{vml='<vml:shape coordorigin="0,0" style="display:inline-block; position:absolute; behavior:url(#default#VML);"></vml:shape>';elems.tip.html(vml+vml);$('*',elems.tip).bind('click mousedown',function(event){event.stopPropagation();});}},update:function(corner,position)
{var tip=elems.tip,inner=tip.children(),width=size.width,height=size.height,regular='px solid ',transparent='px dashed transparent',mimic=opts.mimic,round=Math.round,precedance,context,coords,translate,newSize;if(!corner){corner=cache.corner||self.corner;}
if(mimic===FALSE){mimic=corner;}
else{mimic=new PLUGINS.Corner(mimic);mimic.precedance=corner.precedance;if(mimic.x==='inherit'){mimic.x=corner.x;}
else if(mimic.y==='inherit'){mimic.y=corner.y;}
else if(mimic.x===mimic.y){mimic[corner.precedance]=corner[corner.precedance];}}
precedance=mimic.precedance;self.detectColours(corner);if(color.border!=='transparent'&&color.border!=='#123456'){border=borderWidth(corner,NULL,TRUE);if(opts.border===0&&border>0){color.fill=color.border;}
self.border=border=opts.border!==TRUE?opts.border:border;}
else{self.border=border=0;}
coords=calculateTip(mimic,width,height);self.size=newSize=calculateSize(corner);tip.css(newSize);if(corner.precedance==='y'){translate=[round(mimic.x==='left'?border:mimic.x==='right'?newSize.width-width-border:(newSize.width-width)/2),round(mimic.y==='top'?newSize.height-height:0)];}
else{translate=[round(mimic.x==='left'?newSize.width-width:0),round(mimic.y==='top'?border:mimic.y==='bottom'?newSize.height-height-border:(newSize.height-height)/2)];}
if(hasCanvas){inner.attr(newSize);context=inner[0].getContext('2d');context.restore();context.save();context.clearRect(0,0,3000,3000);context.translate(translate[0],translate[1]);context.beginPath();context.moveTo(coords[0][0],coords[0][1]);context.lineTo(coords[1][0],coords[1][1]);context.lineTo(coords[2][0],coords[2][1]);context.closePath();context.fillStyle=color.fill;context.strokeStyle=color.border;context.lineWidth=border*2;context.lineJoin='miter';context.miterLimit=100;if(border){context.stroke();}
context.fill();}
else{coords='m'+coords[0][0]+','+coords[0][1]+' l'+coords[1][0]+','+coords[1][1]+' '+coords[2][0]+','+coords[2][1]+' xe';translate[2]=border&&/^(r|b)/i.test(corner.string())?parseFloat($.browser.version,10)===8?2:1:0;inner.css({antialias:''+(mimic.string().indexOf('center')>-1),left:translate[0]-(translate[2]*Number(precedance==='x')),top:translate[1]-(translate[2]*Number(precedance==='y')),width:width+border,height:height+border}).each(function(i){var $this=$(this);$this[$this.prop?'prop':'attr']({coordsize:(width+border)+' '+(height+border),path:coords,fillcolor:color.fill,filled:!!i,stroked:!!!i}).css({display:border||i?'block':'none'});if(!i&&$this.html()===''){$this.html('<vml:stroke weight="'+(border*2)+'px" color="'+color.border+'" miterlimit="1000" joinstyle="miter" '+' style="behavior:url(#default#VML); display:inline-block;" />');}});}
if(position!==FALSE){self.position(corner);}},position:function(corner)
{var tip=elems.tip,position={},userOffset=Math.max(0,opts.offset),precedance,dimensions,corners;if(opts.corner===FALSE||!tip){return FALSE;}
corner=corner||self.corner;precedance=corner.precedance;dimensions=calculateSize(corner);corners=[corner.x,corner.y];if(precedance==='x'){corners.reverse();}
$.each(corners,function(i,side){var b,br;if(side==='center'){b=precedance==='y'?'left':'top';position[b]='50%';position['margin-'+b]=-Math.round(dimensions[precedance==='y'?'width':'height']/2)+userOffset;}
else{b=borderWidth(corner,side,TRUE);br=borderRadius(corner);position[side]=i?border?borderWidth(corner,side):0:userOffset+(br>b?br:0);}});position[corner[precedance]]-=dimensions[precedance==='x'?'width':'height'];tip.css({top:'',bottom:'',left:'',right:'',margin:''}).css(position);return position;},destroy:function()
{if(elems.tip){elems.tip.remove();}
tooltip.unbind(namespace);}});self.init();}
PLUGINS.tip=function(api)
{var self=api.plugins.tip;return'object'===typeof self?self:(api.plugins.tip=new Tip(api));};PLUGINS.tip.initialize='render';PLUGINS.tip.sanitize=function(options)
{var style=options.style,opts;if(style&&'tip'in style){opts=options.style.tip;if(typeof opts!=='object'){options.style.tip={corner:opts};}
if(!(/string|boolean/i).test(typeof opts.corner)){opts.corner=TRUE;}
if(typeof opts.width!=='number'){delete opts.width;}
if(typeof opts.height!=='number'){delete opts.height;}
if(typeof opts.border!=='number'&&opts.border!==TRUE){delete opts.border;}
if(typeof opts.offset!=='number'){delete opts.offset;}}};$.extend(TRUE,QTIP.defaults,{style:{tip:{corner:TRUE,mimic:FALSE,width:6,height:6,border:TRUE,offset:0}}});PLUGINS.svg=function(svg,corner)
{var doc=$(document),elem=svg[0],result={width:0,height:0,offset:{top:1e10,left:1e10}},box,mtx,root,point,tPoint;if(elem.getBBox&&elem.parentNode){box=elem.getBBox();mtx=elem.getScreenCTM();root=elem.farthestViewportElement||elem;if(!root.createSVGPoint){return result;}
point=root.createSVGPoint();point.x=box.x;point.y=box.y;tPoint=point.matrixTransform(mtx);result.offset.left=tPoint.x;result.offset.top=tPoint.y;point.x+=box.width;point.y+=box.height;tPoint=point.matrixTransform(mtx);result.width=tPoint.x-result.offset.left;result.height=tPoint.y-result.offset.top;result.offset.left+=doc.scrollLeft();result.offset.top+=doc.scrollTop();}
return result;};function Modal(api)
{var self=this,options=api.options.show.modal,elems=api.elements,tooltip=elems.tooltip,overlaySelector='#qtip-overlay',globalNamespace='.qtipmodal',namespace=globalNamespace+api.id,attr='is-modal-qtip',docBody=$(document.body),overlay;api.checks.modal={'^show.modal.(on|blur)$':function(){self.init();elems.overlay.toggle(tooltip.is(':visible'));}};$.extend(self,{init:function()
{if(!options.on){return self;}
overlay=self.create();tooltip.attr(attr,TRUE).css('z-index',PLUGINS.modal.zindex+$(selector+'['+attr+']').length).unbind(globalNamespace).unbind(namespace).bind('tooltipshow'+globalNamespace+' tooltiphide'+globalNamespace,function(event,api,duration){var oEvent=event.originalEvent;if(event.target===tooltip[0]){if(oEvent&&event.type==='tooltiphide'&&/mouse(leave|enter)/.test(oEvent.type)&&$(oEvent.relatedTarget).closest(overlay[0]).length){try{event.preventDefault();}catch(e){}}
else if(!oEvent||(oEvent&&!oEvent.solo)){self[event.type.replace('tooltip','')](event,duration);}}}).bind('tooltipfocus'+globalNamespace,function(event){if(event.isDefaultPrevented()||event.target!==tooltip[0]){return;}
var qtips=$(selector).filter('['+attr+']'),newIndex=PLUGINS.modal.zindex+qtips.length,curIndex=parseInt(tooltip[0].style.zIndex,10);overlay[0].style.zIndex=newIndex-1;qtips.each(function(){if(this.style.zIndex>curIndex){this.style.zIndex-=1;}});qtips.end().filter('.'+focusClass).qtip('blur',event.originalEvent);tooltip.addClass(focusClass)[0].style.zIndex=newIndex;try{event.preventDefault();}catch(e){}}).bind('tooltiphide'+globalNamespace,function(event){if(event.target===tooltip[0]){$('['+attr+']').filter(':visible').not(tooltip).last().qtip('focus',event);}});if(options.escape){$(window).unbind(namespace).bind('keydown'+namespace,function(event){if(event.keyCode===27&&tooltip.hasClass(focusClass)){api.hide(event);}});}
if(options.blur){elems.overlay.unbind(namespace).bind('click'+namespace,function(event){if(tooltip.hasClass(focusClass)){api.hide(event);}});}
return self;},create:function()
{var elem=$(overlaySelector);if(elem.length){return(elems.overlay=elem.insertAfter($(selector).last()));}
overlay=elems.overlay=$('<div />',{id:overlaySelector.substr(1),html:'<div></div>',mousedown:function(){return FALSE;}}).insertAfter($(selector).last());function resize(){overlay.css({height:$(window).height(),width:$(window).width()});}
$(window).unbind(globalNamespace).bind('resize'+globalNamespace,resize);resize();return overlay;},toggle:function(event,state,duration)
{if(event&&event.isDefaultPrevented()){return self;}
var effect=options.effect,type=state?'show':'hide',visible=overlay.is(':visible'),modals=$('['+attr+']').filter(':visible').not(tooltip),zindex;if(!overlay){overlay=self.create();}
if((overlay.is(':animated')&&visible===state)||(!state&&modals.length)){return self;}
if(state){overlay.css({left:0,top:0});overlay.toggleClass('blurs',options.blur);docBody.bind('focusin'+namespace,function(event){var target=$(event.target),container=target.closest('.qtip'),targetOnTop=container.length<1?FALSE:(parseInt(container[0].style.zIndex,10)>parseInt(tooltip[0].style.zIndex,10));if(!targetOnTop&&($(event.target).closest(selector)[0]!==tooltip[0])){tooltip.find('input:visible').filter(':first').focus();}});}
else{docBody.undelegate('*','focusin'+namespace);}
overlay.stop(TRUE,FALSE);if($.isFunction(effect)){effect.call(overlay,state);}
else if(effect===FALSE){overlay[type]();}
else{overlay.fadeTo(parseInt(duration,10)||90,state?1:0,function(){if(!state){$(this).hide();}});}
if(!state){overlay.queue(function(next){overlay.css({left:'',top:''});next();});}
return self;},show:function(event,duration){return self.toggle(event,TRUE,duration);},hide:function(event,duration){return self.toggle(event,FALSE,duration);},destroy:function()
{var delBlanket=overlay;if(delBlanket){delBlanket=$('['+attr+']').not(tooltip).length<1;if(delBlanket){elems.overlay.remove();$(window).unbind(globalNamespace);}
else{elems.overlay.unbind(globalNamespace+api.id);}
docBody.undelegate('*','focusin'+namespace);}
return tooltip.removeAttr(attr).unbind(globalNamespace);}});self.init();}
PLUGINS.modal=function(api){var self=api.plugins.modal;return'object'===typeof self?self:(api.plugins.modal=new Modal(api));};PLUGINS.modal.initialize='render';PLUGINS.modal.sanitize=function(opts){if(opts.show){if(typeof opts.show.modal!=='object'){opts.show.modal={on:!!opts.show.modal};}
else if(typeof opts.show.modal.on==='undefined'){opts.show.modal.on=TRUE;}}};PLUGINS.modal.zindex=QTIP.zindex+1000;$.extend(TRUE,QTIP.defaults,{show:{modal:{on:FALSE,effect:TRUE,blur:TRUE,escape:TRUE}}});function BGIFrame(api)
{var self=this,elems=api.elements,tooltip=elems.tooltip,namespace='.bgiframe-'+api.id;$.extend(self,{init:function()
{elems.bgiframe=$('<iframe class="ui-tooltip-bgiframe" frameborder="0" tabindex="-1" src="javascript:\'\';" '+' style="display:block; position:absolute; z-index:-1; filter:alpha(opacity=0); '+'-ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";"></iframe>');elems.bgiframe.appendTo(tooltip);tooltip.bind('tooltipmove'+namespace,self.adjust);},adjust:function()
{var dimensions=api.get('dimensions'),plugin=api.plugins.tip,tip=elems.tip,tipAdjust,offset;offset=parseInt(tooltip.css('border-left-width'),10)||0;offset={left:-offset,top:-offset};if(plugin&&tip){tipAdjust=(plugin.corner.precedance==='x')?['width','left']:['height','top'];offset[tipAdjust[1]]-=tip[tipAdjust[0]]();}
elems.bgiframe.css(offset).css(dimensions);},destroy:function()
{elems.bgiframe.remove();tooltip.unbind(namespace);}});self.init();}
PLUGINS.bgiframe=function(api)
{var browser=$.browser,self=api.plugins.bgiframe;if($('select, object').length<1||!(browser.msie&&(''+browser.version).charAt(0)==='6')){return FALSE;}
return'object'===typeof self?self:(api.plugins.bgiframe=new BGIFrame(api));};PLUGINS.bgiframe.initialize='render';}(jQuery,window));
(function(C,z,f,r){var q=f(C),n=f(z),b=f.fancybox=function(){b.open.apply(this,arguments)},H=navigator.userAgent.match(/msie/),w=null,s=z.createTouch!==r,t=function(a){return a&&a.hasOwnProperty&&a instanceof f},p=function(a){return a&&"string"===f.type(a)},F=function(a){return p(a)&&0<a.indexOf("%")},l=function(a,d){var e=parseInt(a,10)||0;d&&F(a)&&(e*=b.getViewport()[d]/100);return Math.ceil(e)},x=function(a,b){return l(a,b)+"px"};f.extend(b,{version:"2.1.4",defaults:{padding:15,margin:20,width:800,
height:600,minWidth:100,minHeight:100,maxWidth:9999,maxHeight:9999,autoSize:!0,autoHeight:!1,autoWidth:!1,autoResize:!0,autoCenter:!s,fitToView:!0,aspectRatio:!1,topRatio:0.5,leftRatio:0.5,scrolling:"auto",wrapCSS:"",arrows:!0,closeBtn:!0,closeClick:!1,nextClick:!1,mouseWheel:!0,autoPlay:!1,playSpeed:3E3,preload:3,modal:!1,loop:!0,ajax:{dataType:"html",headers:{"X-fancyBox":!0}},iframe:{scrolling:"auto",preload:!0},swf:{wmode:"transparent",allowfullscreen:"true",allowscriptaccess:"always"},keys:{next:{13:"left",
34:"up",39:"left",40:"up"},prev:{8:"right",33:"down",37:"right",38:"down"},close:[27],play:[32],toggle:[70]},direction:{next:"left",prev:"right"},scrollOutside:!0,index:0,type:null,href:null,content:null,title:null,tpl:{wrap:'<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div></div>',image:'<img class="fancybox-image" src="{href}" alt="" />',iframe:'<iframe id="fancybox-frame{rnd}" name="fancybox-frame{rnd}" class="fancybox-iframe" frameborder="0" vspace="0" hspace="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen'+
(H?' allowtransparency="true"':"")+"></iframe>",error:'<p class="fancybox-error">The requested content cannot be loaded.<br/>Please try again later.</p>',closeBtn:'<a title="Close" class="fancybox-item fancybox-close" href="javascript:;"></a>',next:'<a title="Next" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',prev:'<a title="Previous" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'},openEffect:"fade",openSpeed:250,openEasing:"swing",openOpacity:!0,
openMethod:"zoomIn",closeEffect:"fade",closeSpeed:250,closeEasing:"swing",closeOpacity:!0,closeMethod:"zoomOut",nextEffect:"elastic",nextSpeed:250,nextEasing:"swing",nextMethod:"changeIn",prevEffect:"elastic",prevSpeed:250,prevEasing:"swing",prevMethod:"changeOut",helpers:{overlay:!0,title:!0},onCancel:f.noop,beforeLoad:f.noop,afterLoad:f.noop,beforeShow:f.noop,afterShow:f.noop,beforeChange:f.noop,beforeClose:f.noop,afterClose:f.noop},group:{},opts:{},previous:null,coming:null,current:null,isActive:!1,
isOpen:!1,isOpened:!1,wrap:null,skin:null,outer:null,inner:null,player:{timer:null,isActive:!1},ajaxLoad:null,imgPreload:null,transitions:{},helpers:{},open:function(a,d){if(a&&(f.isPlainObject(d)||(d={}),!1!==b.close(!0)))return f.isArray(a)||(a=t(a)?f(a).get():[a]),f.each(a,function(e,c){var k={},g,h,j,m,l;"object"===f.type(c)&&(c.nodeType&&(c=f(c)),t(c)?(k={href:c.data("fancybox-href")||c.attr("href"),title:c.data("fancybox-title")||c.attr("title"),isDom:!0,element:c},f.metadata&&f.extend(!0,k,
c.metadata())):k=c);g=d.href||k.href||(p(c)?c:null);h=d.title!==r?d.title:k.title||"";m=(j=d.content||k.content)?"html":d.type||k.type;!m&&k.isDom&&(m=c.data("fancybox-type"),m||(m=(m=c.prop("class").match(/fancybox\.(\w+)/))?m[1]:null));p(g)&&(m||(b.isImage(g)?m="image":b.isSWF(g)?m="swf":"#"===g.charAt(0)?m="inline":p(c)&&(m="html",j=c)),"ajax"===m&&(l=g.split(/\s+/,2),g=l.shift(),l=l.shift()));j||("inline"===m?g?j=f(p(g)?g.replace(/.*(?=#[^\s]+$)/,""):g):k.isDom&&(j=c):"html"===m?j=g:!m&&(!g&&
k.isDom)&&(m="inline",j=c));f.extend(k,{href:g,type:m,content:j,title:h,selector:l});a[e]=k}),b.opts=f.extend(!0,{},b.defaults,d),d.keys!==r&&(b.opts.keys=d.keys?f.extend({},b.defaults.keys,d.keys):!1),b.group=a,b._start(b.opts.index)},cancel:function(){var a=b.coming;a&&!1!==b.trigger("onCancel")&&(b.hideLoading(),b.ajaxLoad&&b.ajaxLoad.abort(),b.ajaxLoad=null,b.imgPreload&&(b.imgPreload.onload=b.imgPreload.onerror=null),a.wrap&&a.wrap.stop(!0,!0).trigger("onReset").remove(),b.coming=null,b.current||
b._afterZoomOut(a))},close:function(a){b.cancel();!1!==b.trigger("beforeClose")&&(b.unbindEvents(),b.isActive&&(!b.isOpen||!0===a?(f(".fancybox-wrap").stop(!0).trigger("onReset").remove(),b._afterZoomOut()):(b.isOpen=b.isOpened=!1,b.isClosing=!0,f(".fancybox-item, .fancybox-nav").remove(),b.wrap.stop(!0,!0).removeClass("fancybox-opened"),b.transitions[b.current.closeMethod]())))},play:function(a){var d=function(){clearTimeout(b.player.timer)},e=function(){d();b.current&&b.player.isActive&&(b.player.timer=
setTimeout(b.next,b.current.playSpeed))},c=function(){d();f("body").unbind(".player");b.player.isActive=!1;b.trigger("onPlayEnd")};if(!0===a||!b.player.isActive&&!1!==a){if(b.current&&(b.current.loop||b.current.index<b.group.length-1))b.player.isActive=!0,f("body").bind({"afterShow.player onUpdate.player":e,"onCancel.player beforeClose.player":c,"beforeLoad.player":d}),e(),b.trigger("onPlayStart")}else c()},next:function(a){var d=b.current;d&&(p(a)||(a=d.direction.next),b.jumpto(d.index+1,a,"next"))},
prev:function(a){var d=b.current;d&&(p(a)||(a=d.direction.prev),b.jumpto(d.index-1,a,"prev"))},jumpto:function(a,d,e){var c=b.current;c&&(a=l(a),b.direction=d||c.direction[a>=c.index?"next":"prev"],b.router=e||"jumpto",c.loop&&(0>a&&(a=c.group.length+a%c.group.length),a%=c.group.length),c.group[a]!==r&&(b.cancel(),b._start(a)))},reposition:function(a,d){var e=b.current,c=e?e.wrap:null,k;c&&(k=b._getPosition(d),a&&"scroll"===a.type?(delete k.position,c.stop(!0,!0).animate(k,200)):(c.css(k),e.pos=f.extend({},
e.dim,k)))},update:function(a){var d=a&&a.type,e=!d||"orientationchange"===d;e&&(clearTimeout(w),w=null);b.isOpen&&!w&&(w=setTimeout(function(){var c=b.current;c&&!b.isClosing&&(b.wrap.removeClass("fancybox-tmp"),(e||"load"===d||"resize"===d&&c.autoResize)&&b._setDimension(),"scroll"===d&&c.canShrink||b.reposition(a),b.trigger("onUpdate"),w=null)},e&&!s?0:300))},toggle:function(a){b.isOpen&&(b.current.fitToView="boolean"===f.type(a)?a:!b.current.fitToView,s&&(b.wrap.removeAttr("style").addClass("fancybox-tmp"),
b.trigger("onUpdate")),b.update())},hideLoading:function(){n.unbind(".loading");f("#fancybox-loading").remove()},showLoading:function(){var a,d;b.hideLoading();a=f('<div id="fancybox-loading"><div></div></div>').click(b.cancel).appendTo("body");n.bind("keydown.loading",function(a){if(27===(a.which||a.keyCode))a.preventDefault(),b.cancel()});b.defaults.fixed||(d=b.getViewport(),a.css({position:"absolute",top:0.5*d.h+d.y,left:0.5*d.w+d.x}))},getViewport:function(){var a=b.current&&b.current.locked||
!1,d={x:q.scrollLeft(),y:q.scrollTop()};a?(d.w=a[0].clientWidth,d.h=a[0].clientHeight):(d.w=s&&C.innerWidth?C.innerWidth:q.width(),d.h=s&&C.innerHeight?C.innerHeight:q.height());return d},unbindEvents:function(){b.wrap&&t(b.wrap)&&b.wrap.unbind(".fb");n.unbind(".fb");q.unbind(".fb")},bindEvents:function(){var a=b.current,d;a&&(q.bind("orientationchange.fb"+(s?"":" resize.fb")+(a.autoCenter&&!a.locked?" scroll.fb":""),b.update),(d=a.keys)&&n.bind("keydown.fb",function(e){var c=e.which||e.keyCode,k=
e.target||e.srcElement;if(27===c&&b.coming)return!1;!e.ctrlKey&&(!e.altKey&&!e.shiftKey&&!e.metaKey&&(!k||!k.type&&!f(k).is("[contenteditable]")))&&f.each(d,function(d,k){if(1<a.group.length&&k[c]!==r)return b[d](k[c]),e.preventDefault(),!1;if(-1<f.inArray(c,k))return b[d](),e.preventDefault(),!1})}),f.fn.mousewheel&&a.mouseWheel&&b.wrap.bind("mousewheel.fb",function(d,c,k,g){for(var h=f(d.target||null),j=!1;h.length&&!j&&!h.is(".fancybox-skin")&&!h.is(".fancybox-wrap");)j=h[0]&&!(h[0].style.overflow&&
"hidden"===h[0].style.overflow)&&(h[0].clientWidth&&h[0].scrollWidth>h[0].clientWidth||h[0].clientHeight&&h[0].scrollHeight>h[0].clientHeight),h=f(h).parent();if(0!==c&&!j&&1<b.group.length&&!a.canShrink){if(0<g||0<k)b.prev(0<g?"down":"left");else if(0>g||0>k)b.next(0>g?"up":"right");d.preventDefault()}}))},trigger:function(a,d){var e,c=d||b.coming||b.current;if(c){f.isFunction(c[a])&&(e=c[a].apply(c,Array.prototype.slice.call(arguments,1)));if(!1===e)return!1;c.helpers&&f.each(c.helpers,function(d,
e){e&&(b.helpers[d]&&f.isFunction(b.helpers[d][a]))&&(e=f.extend(!0,{},b.helpers[d].defaults,e),b.helpers[d][a](e,c))});f.event.trigger(a+".fb")}},isImage:function(a){return p(a)&&a.match(/(^data:image\/.*,)|(\.(jp(e|g|eg)|gif|png|bmp|webp)((\?|#).*)?$)/i)},isSWF:function(a){return p(a)&&a.match(/\.(swf)((\?|#).*)?$/i)},_start:function(a){var d={},e,c;a=l(a);e=b.group[a]||null;if(!e)return!1;d=f.extend(!0,{},b.opts,e);e=d.margin;c=d.padding;"number"===f.type(e)&&(d.margin=[e,e,e,e]);"number"===f.type(c)&&
(d.padding=[c,c,c,c]);d.modal&&f.extend(!0,d,{closeBtn:!1,closeClick:!1,nextClick:!1,arrows:!1,mouseWheel:!1,keys:null,helpers:{overlay:{closeClick:!1}}});d.autoSize&&(d.autoWidth=d.autoHeight=!0);"auto"===d.width&&(d.autoWidth=!0);"auto"===d.height&&(d.autoHeight=!0);d.group=b.group;d.index=a;b.coming=d;if(!1===b.trigger("beforeLoad"))b.coming=null;else{c=d.type;e=d.href;if(!c)return b.coming=null,b.current&&b.router&&"jumpto"!==b.router?(b.current.index=a,b[b.router](b.direction)):!1;b.isActive=
!0;if("image"===c||"swf"===c)d.autoHeight=d.autoWidth=!1,d.scrolling="visible";"image"===c&&(d.aspectRatio=!0);"iframe"===c&&s&&(d.scrolling="scroll");d.wrap=f(d.tpl.wrap).addClass("fancybox-"+(s?"mobile":"desktop")+" fancybox-type-"+c+" fancybox-tmp "+d.wrapCSS).appendTo(d.parent||"body");f.extend(d,{skin:f(".fancybox-skin",d.wrap),outer:f(".fancybox-outer",d.wrap),inner:f(".fancybox-inner",d.wrap)});f.each(["Top","Right","Bottom","Left"],function(a,b){d.skin.css("padding"+b,x(d.padding[a]))});b.trigger("onReady");
if("inline"===c||"html"===c){if(!d.content||!d.content.length)return b._error("content")}else if(!e)return b._error("href");"image"===c?b._loadImage():"ajax"===c?b._loadAjax():"iframe"===c?b._loadIframe():b._afterLoad()}},_error:function(a){f.extend(b.coming,{type:"html",autoWidth:!0,autoHeight:!0,minWidth:0,minHeight:0,scrolling:"no",hasError:a,content:b.coming.tpl.error});b._afterLoad()},_loadImage:function(){var a=b.imgPreload=new Image;a.onload=function(){this.onload=this.onerror=null;b.coming.width=
this.width;b.coming.height=this.height;b._afterLoad()};a.onerror=function(){this.onload=this.onerror=null;b._error("image")};a.src=b.coming.href;!0!==a.complete&&b.showLoading()},_loadAjax:function(){var a=b.coming;b.showLoading();b.ajaxLoad=f.ajax(f.extend({},a.ajax,{url:a.href,error:function(a,e){b.coming&&"abort"!==e?b._error("ajax",a):b.hideLoading()},success:function(d,e){"success"===e&&(a.content=d,b._afterLoad())}}))},_loadIframe:function(){var a=b.coming,d=f(a.tpl.iframe.replace(/\{rnd\}/g,
(new Date).getTime())).attr("scrolling",s?"auto":a.iframe.scrolling).attr("src",a.href);f(a.wrap).bind("onReset",function(){try{f(this).find("iframe").hide().attr("src","//about:blank").end().empty()}catch(a){}});a.iframe.preload&&(b.showLoading(),d.one("load",function(){f(this).data("ready",1);s||f(this).bind("load.fb",b.update);f(this).parents(".fancybox-wrap").width("100%").removeClass("fancybox-tmp").show();b._afterLoad()}));a.content=d.appendTo(a.inner);a.iframe.preload||b._afterLoad()},_preloadImages:function(){var a=
b.group,d=b.current,e=a.length,c=d.preload?Math.min(d.preload,e-1):0,f,g;for(g=1;g<=c;g+=1)f=a[(d.index+g)%e],"image"===f.type&&f.href&&((new Image).src=f.href)},_afterLoad:function(){var a=b.coming,d=b.current,e,c,k,g,h;b.hideLoading();if(a&&!1!==b.isActive)if(!1===b.trigger("afterLoad",a,d))a.wrap.stop(!0).trigger("onReset").remove(),b.coming=null;else{d&&(b.trigger("beforeChange",d),d.wrap.stop(!0).removeClass("fancybox-opened").find(".fancybox-item, .fancybox-nav").remove());b.unbindEvents();
e=a.content;c=a.type;k=a.scrolling;f.extend(b,{wrap:a.wrap,skin:a.skin,outer:a.outer,inner:a.inner,current:a,previous:d});g=a.href;switch(c){case "inline":case "ajax":case "html":a.selector?e=f("<div>").html(e).find(a.selector):t(e)&&(e.data("fancybox-placeholder")||e.data("fancybox-placeholder",f('<div class="fancybox-placeholder"></div>').insertAfter(e).hide()),e=e.show().detach(),a.wrap.bind("onReset",function(){f(this).find(e).length&&e.hide().replaceAll(e.data("fancybox-placeholder")).data("fancybox-placeholder",
!1)}));break;case "image":e=a.tpl.image.replace("{href}",g);break;case "swf":e='<object id="fancybox-swf" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"><param name="movie" value="'+g+'"></param>',h="",f.each(a.swf,function(a,b){e+='<param name="'+a+'" value="'+b+'"></param>';h+=" "+a+'="'+b+'"'}),e+='<embed src="'+g+'" type="application/x-shockwave-flash" width="100%" height="100%"'+h+"></embed></object>"}(!t(e)||!e.parent().is(a.inner))&&a.inner.append(e);b.trigger("beforeShow");
a.inner.css("overflow","yes"===k?"scroll":"no"===k?"hidden":k);b._setDimension();b.reposition();b.isOpen=!1;b.coming=null;b.bindEvents();if(b.isOpened){if(d.prevMethod)b.transitions[d.prevMethod]()}else f(".fancybox-wrap").not(a.wrap).stop(!0).trigger("onReset").remove();b.transitions[b.isOpened?a.nextMethod:a.openMethod]();b._preloadImages()}},_setDimension:function(){var a=b.getViewport(),d=0,e=!1,c=!1,e=b.wrap,k=b.skin,g=b.inner,h=b.current,c=h.width,j=h.height,m=h.minWidth,u=h.minHeight,n=h.maxWidth,
v=h.maxHeight,s=h.scrolling,q=h.scrollOutside?h.scrollbarWidth:0,y=h.margin,p=l(y[1]+y[3]),r=l(y[0]+y[2]),z,A,t,D,B,G,C,E,w;e.add(k).add(g).width("auto").height("auto").removeClass("fancybox-tmp");y=l(k.outerWidth(!0)-k.width());z=l(k.outerHeight(!0)-k.height());A=p+y;t=r+z;D=F(c)?(a.w-A)*l(c)/100:c;B=F(j)?(a.h-t)*l(j)/100:j;if("iframe"===h.type){if(w=h.content,h.autoHeight&&1===w.data("ready"))try{w[0].contentWindow.document.location&&(g.width(D).height(9999),G=w.contents().find("body"),q&&G.css("overflow-x",
"hidden"),B=G.height())}catch(H){}}else if(h.autoWidth||h.autoHeight)g.addClass("fancybox-tmp"),h.autoWidth||g.width(D),h.autoHeight||g.height(B),h.autoWidth&&(D=g.width()),h.autoHeight&&(B=g.height()),g.removeClass("fancybox-tmp");c=l(D);j=l(B);E=D/B;m=l(F(m)?l(m,"w")-A:m);n=l(F(n)?l(n,"w")-A:n);u=l(F(u)?l(u,"h")-t:u);v=l(F(v)?l(v,"h")-t:v);G=n;C=v;h.fitToView&&(n=Math.min(a.w-A,n),v=Math.min(a.h-t,v));A=a.w-p;r=a.h-r;h.aspectRatio?(c>n&&(c=n,j=l(c/E)),j>v&&(j=v,c=l(j*E)),c<m&&(c=m,j=l(c/E)),j<u&&
(j=u,c=l(j*E))):(c=Math.max(m,Math.min(c,n)),h.autoHeight&&"iframe"!==h.type&&(g.width(c),j=g.height()),j=Math.max(u,Math.min(j,v)));if(h.fitToView)if(g.width(c).height(j),e.width(c+y),a=e.width(),p=e.height(),h.aspectRatio)for(;(a>A||p>r)&&(c>m&&j>u)&&!(19<d++);)j=Math.max(u,Math.min(v,j-10)),c=l(j*E),c<m&&(c=m,j=l(c/E)),c>n&&(c=n,j=l(c/E)),g.width(c).height(j),e.width(c+y),a=e.width(),p=e.height();else c=Math.max(m,Math.min(c,c-(a-A))),j=Math.max(u,Math.min(j,j-(p-r)));q&&("auto"===s&&j<B&&c+y+
q<A)&&(c+=q);g.width(c).height(j);e.width(c+y);a=e.width();p=e.height();e=(a>A||p>r)&&c>m&&j>u;c=h.aspectRatio?c<G&&j<C&&c<D&&j<B:(c<G||j<C)&&(c<D||j<B);f.extend(h,{dim:{width:x(a),height:x(p)},origWidth:D,origHeight:B,canShrink:e,canExpand:c,wPadding:y,hPadding:z,wrapSpace:p-k.outerHeight(!0),skinSpace:k.height()-j});!w&&(h.autoHeight&&j>u&&j<v&&!c)&&g.height("auto")},_getPosition:function(a){var d=b.current,e=b.getViewport(),c=d.margin,f=b.wrap.width()+c[1]+c[3],g=b.wrap.height()+c[0]+c[2],c={position:"absolute",
top:c[0],left:c[3]};d.autoCenter&&d.fixed&&!a&&g<=e.h&&f<=e.w?c.position="fixed":d.locked||(c.top+=e.y,c.left+=e.x);c.top=x(Math.max(c.top,c.top+(e.h-g)*d.topRatio));c.left=x(Math.max(c.left,c.left+(e.w-f)*d.leftRatio));return c},_afterZoomIn:function(){var a=b.current;a&&(b.isOpen=b.isOpened=!0,b.wrap.css("overflow","visible").addClass("fancybox-opened"),b.update(),(a.closeClick||a.nextClick&&1<b.group.length)&&b.inner.css("cursor","pointer").bind("click.fb",function(d){!f(d.target).is("a")&&!f(d.target).parent().is("a")&&
(d.preventDefault(),b[a.closeClick?"close":"next"]())}),a.closeBtn&&f(a.tpl.closeBtn).appendTo(b.skin).bind("click.fb",function(a){a.preventDefault();b.close()}),a.arrows&&1<b.group.length&&((a.loop||0<a.index)&&f(a.tpl.prev).appendTo(b.outer).bind("click.fb",b.prev),(a.loop||a.index<b.group.length-1)&&f(a.tpl.next).appendTo(b.outer).bind("click.fb",b.next)),b.trigger("afterShow"),!a.loop&&a.index===a.group.length-1?b.play(!1):b.opts.autoPlay&&!b.player.isActive&&(b.opts.autoPlay=!1,b.play()))},_afterZoomOut:function(a){a=
a||b.current;f(".fancybox-wrap").trigger("onReset").remove();f.extend(b,{group:{},opts:{},router:!1,current:null,isActive:!1,isOpened:!1,isOpen:!1,isClosing:!1,wrap:null,skin:null,outer:null,inner:null});b.trigger("afterClose",a)}});b.transitions={getOrigPosition:function(){var a=b.current,d=a.element,e=a.orig,c={},f=50,g=50,h=a.hPadding,j=a.wPadding,m=b.getViewport();!e&&(a.isDom&&d.is(":visible"))&&(e=d.find("img:first"),e.length||(e=d));t(e)?(c=e.offset(),e.is("img")&&(f=e.outerWidth(),g=e.outerHeight())):
(c.top=m.y+(m.h-g)*a.topRatio,c.left=m.x+(m.w-f)*a.leftRatio);if("fixed"===b.wrap.css("position")||a.locked)c.top-=m.y,c.left-=m.x;return c={top:x(c.top-h*a.topRatio),left:x(c.left-j*a.leftRatio),width:x(f+j),height:x(g+h)}},step:function(a,d){var e,c,f=d.prop;c=b.current;var g=c.wrapSpace,h=c.skinSpace;if("width"===f||"height"===f)e=d.end===d.start?1:(a-d.start)/(d.end-d.start),b.isClosing&&(e=1-e),c="width"===f?c.wPadding:c.hPadding,c=a-c,b.skin[f](l("width"===f?c:c-g*e)),b.inner[f](l("width"===
f?c:c-g*e-h*e))},zoomIn:function(){var a=b.current,d=a.pos,e=a.openEffect,c="elastic"===e,k=f.extend({opacity:1},d);delete k.position;c?(d=this.getOrigPosition(),a.openOpacity&&(d.opacity=0.1)):"fade"===e&&(d.opacity=0.1);b.wrap.css(d).animate(k,{duration:"none"===e?0:a.openSpeed,easing:a.openEasing,step:c?this.step:null,complete:b._afterZoomIn})},zoomOut:function(){var a=b.current,d=a.closeEffect,e="elastic"===d,c={opacity:0.1};e&&(c=this.getOrigPosition(),a.closeOpacity&&(c.opacity=0.1));b.wrap.animate(c,
{duration:"none"===d?0:a.closeSpeed,easing:a.closeEasing,step:e?this.step:null,complete:b._afterZoomOut})},changeIn:function(){var a=b.current,d=a.nextEffect,e=a.pos,c={opacity:1},f=b.direction,g;e.opacity=0.1;"elastic"===d&&(g="down"===f||"up"===f?"top":"left","down"===f||"right"===f?(e[g]=x(l(e[g])-200),c[g]="+=200px"):(e[g]=x(l(e[g])+200),c[g]="-=200px"));"none"===d?b._afterZoomIn():b.wrap.css(e).animate(c,{duration:a.nextSpeed,easing:a.nextEasing,complete:b._afterZoomIn})},changeOut:function(){var a=
b.previous,d=a.prevEffect,e={opacity:0.1},c=b.direction;"elastic"===d&&(e["down"===c||"up"===c?"top":"left"]=("up"===c||"left"===c?"-":"+")+"=200px");a.wrap.animate(e,{duration:"none"===d?0:a.prevSpeed,easing:a.prevEasing,complete:function(){f(this).trigger("onReset").remove()}})}};b.helpers.overlay={defaults:{closeClick:!0,speedOut:200,showEarly:!0,css:{},locked:!s,fixed:!0},overlay:null,fixed:!1,create:function(a){a=f.extend({},this.defaults,a);this.overlay&&this.close();this.overlay=f('<div class="fancybox-overlay"></div>').appendTo("body");
this.fixed=!1;a.fixed&&b.defaults.fixed&&(this.overlay.addClass("fancybox-overlay-fixed"),this.fixed=!0)},open:function(a){var d=this;a=f.extend({},this.defaults,a);this.overlay?this.overlay.unbind(".overlay").width("auto").height("auto"):this.create(a);this.fixed||(q.bind("resize.overlay",f.proxy(this.update,this)),this.update());a.closeClick&&this.overlay.bind("click.overlay",function(a){f(a.target).hasClass("fancybox-overlay")&&(b.isActive?b.close():d.close())});this.overlay.css(a.css).show()},
close:function(){f(".fancybox-overlay").remove();q.unbind("resize.overlay");this.overlay=null;!1!==this.margin&&(f("body").css("margin-right",this.margin),this.margin=!1);this.el&&this.el.removeClass("fancybox-lock")},update:function(){var a="100%",b;this.overlay.width(a).height("100%");H?(b=Math.max(z.documentElement.offsetWidth,z.body.offsetWidth),n.width()>b&&(a=n.width())):n.width()>q.width()&&(a=n.width());this.overlay.width(a).height(n.height())},onReady:function(a,b){f(".fancybox-overlay").stop(!0,
!0);this.overlay||(this.margin=n.height()>q.height()||"scroll"===f("body").css("overflow-y")?f("body").css("margin-right"):!1,this.el=z.all&&!z.querySelector?f("html"):f("body"),this.create(a));a.locked&&this.fixed&&(b.locked=this.overlay.append(b.wrap),b.fixed=!1);!0===a.showEarly&&this.beforeShow.apply(this,arguments)},beforeShow:function(a,b){b.locked&&(this.el.addClass("fancybox-lock"),!1!==this.margin&&f("body").css("margin-right",l(this.margin)+b.scrollbarWidth));this.open(a)},onUpdate:function(){this.fixed||
this.update()},afterClose:function(a){this.overlay&&!b.isActive&&this.overlay.fadeOut(a.speedOut,f.proxy(this.close,this))}};b.helpers.title={defaults:{type:"float",position:"bottom"},beforeShow:function(a){var d=b.current,e=d.title,c=a.type;f.isFunction(e)&&(e=e.call(d.element,d));if(p(e)&&""!==f.trim(e)){d=f('<div class="fancybox-title fancybox-title-'+c+'-wrap">'+e+"</div>");switch(c){case "inside":c=b.skin;break;case "outside":c=b.wrap;break;case "over":c=b.inner;break;default:c=b.skin,d.appendTo("body"),
H&&d.width(d.width()),d.wrapInner('<span class="child"></span>'),b.current.margin[2]+=Math.abs(l(d.css("margin-bottom")))}d["top"===a.position?"prependTo":"appendTo"](c)}}};f.fn.fancybox=function(a){var d,e=f(this),c=this.selector||"",k=function(g){var h=f(this).blur(),j=d,k,l;!g.ctrlKey&&(!g.altKey&&!g.shiftKey&&!g.metaKey)&&!h.is(".fancybox-wrap")&&(k=a.groupAttr||"data-fancybox-group",l=h.attr(k),l||(k="rel",l=h.get(0)[k]),l&&(""!==l&&"nofollow"!==l)&&(h=c.length?f(c):e,h=h.filter("["+k+'="'+l+
'"]'),j=h.index(this)),a.index=j,!1!==b.open(h,a)&&g.preventDefault())};a=a||{};d=a.index||0;!c||!1===a.live?e.unbind("click.fb-start").bind("click.fb-start",k):n.undelegate(c,"click.fb-start").delegate(c+":not('.fancybox-item, .fancybox-nav')","click.fb-start",k);this.filter("[data-fancybox-start=1]").trigger("click");return this};n.ready(function(){f.scrollbarWidth===r&&(f.scrollbarWidth=function(){var a=f('<div style="width:50px;height:50px;overflow:auto"><div/></div>').appendTo("body"),b=a.children(),
b=b.innerWidth()-b.height(99).innerWidth();a.remove();return b});if(f.support.fixedPosition===r){var a=f.support,d=f('<div style="position:fixed;top:20px;"></div>').appendTo("body"),e=20===d[0].offsetTop||15===d[0].offsetTop;d.remove();a.fixedPosition=e}f.extend(b.defaults,{scrollbarWidth:f.scrollbarWidth(),fixed:f.support.fixedPosition,parent:f("body")})})})(window,document,jQuery);
"function"!==typeof Object.create&&(Object.create=function(d){function h(){}h.prototype=d;return new h});
(function(d,h,l,m){var k={init:function(b,a){var c=this;c.elem=a;c.$elem=d(a);c.imageSrc=c.$elem.data("zoom-image")?c.$elem.data("zoom-image"):c.$elem.attr("src");c.options=d.extend({},d.fn.elevateZoom.options,b);c.options.tint&&(c.options.lensColour="none",c.options.lensOpacity="1");"inner"==c.options.zoomType&&(c.options.showLens=!1);c.$elem.parent().removeAttr("title").removeAttr("alt");c.zoomImage=c.imageSrc;c.refresh(1);d("#"+c.options.gallery+" a").click(function(a){c.options.galleryActiveClass&&
(d("#"+c.options.gallery+" a").removeClass(c.options.galleryActiveClass),d(this).addClass(c.options.galleryActiveClass));a.preventDefault();d(this).data("zoom-image")?c.zoomImagePre=d(this).data("zoom-image"):c.zoomImagePre=d(this).data("image");c.swaptheimage(d(this).data("image"),c.zoomImagePre);return!1})},refresh:function(b){var a=this;setTimeout(function(){a.fetch(a.imageSrc)},b||a.options.refresh)},fetch:function(b){var a=this,c=new Image;c.onload=function(){a.largeWidth=c.width;a.largeHeight=
c.height;a.startZoom();a.currentImage=a.imageSrc;a.options.onZoomedImageLoaded(a.$elem)};c.src=b},startZoom:function(){var b=this;b.nzWidth=b.$elem.width();b.nzHeight=b.$elem.height();b.isWindowActive=!1;b.isLensActive=!1;b.isTintActive=!1;b.overWindow=!1;b.options.imageCrossfade&&(b.zoomWrap=b.$elem.wrap('<div style="height:'+b.nzHeight+"px;width:"+b.nzWidth+'px;" class="zoomWrapper" />'),b.$elem.css("position","absolute"));b.zoomLock=1;b.scrollingLock=!1;b.changeBgSize=!1;b.currentZoomLevel=b.options.zoomLevel;
b.nzOffset=b.$elem.offset();b.widthRatio=b.largeWidth/b.currentZoomLevel/b.nzWidth;b.heightRatio=b.largeHeight/b.currentZoomLevel/b.nzHeight;"window"==b.options.zoomType&&(b.zoomWindowStyle="overflow: hidden;background-position: 0px 0px;text-align:center;background-color: "+String(b.options.zoomWindowBgColour)+";width: "+String(b.options.zoomWindowWidth)+"px;height: "+String(b.options.zoomWindowHeight)+"px;float: left;background-size: "+b.largeWidth/b.currentZoomLevel+"px "+b.largeHeight/b.currentZoomLevel+
"px;display: none;z-index:100;border: "+String(b.options.borderSize)+"px solid "+b.options.borderColour+";background-repeat: no-repeat;position: absolute;");if("inner"==b.options.zoomType){var a=b.$elem.css("border-left-width");b.zoomWindowStyle="overflow: hidden;margin-left: "+String(a)+";margin-top: "+String(a)+";background-position: 0px 0px;width: "+String(b.nzWidth)+"px;height: "+String(b.nzHeight)+"px;float: left;display: none;cursor:"+b.options.cursor+";px solid "+b.options.borderColour+";background-repeat: no-repeat;position: absolute;"}"window"==
b.options.zoomType&&(lensHeight=b.nzHeight<b.options.zoomWindowWidth/b.widthRatio?b.nzHeight:String(b.options.zoomWindowHeight/b.heightRatio),lensWidth=b.largeWidth<b.options.zoomWindowWidth?b.nzWidth:b.options.zoomWindowWidth/b.widthRatio,b.lensStyle="background-position: 0px 0px;width: "+String(b.options.zoomWindowWidth/b.widthRatio)+"px;height: "+String(b.options.zoomWindowHeight/b.heightRatio)+"px;float: right;display: none;overflow: hidden;z-index: 999;-webkit-transform: translateZ(0);opacity:"+
b.options.lensOpacity+";filter: alpha(opacity = "+100*b.options.lensOpacity+"); zoom:1;width:"+lensWidth+"px;height:"+lensHeight+"px;background-color:"+b.options.lensColour+";cursor:"+b.options.cursor+";border: "+b.options.lensBorderSize+"px solid "+b.options.lensBorderColour+";background-repeat: no-repeat;position: absolute;");b.tintStyle="display: block;position: absolute;background-color: "+b.options.tintColour+";filter:alpha(opacity=0);opacity: 0;width: "+b.nzWidth+"px;height: "+b.nzHeight+"px;";
b.lensRound="";"lens"==b.options.zoomType&&(b.lensStyle="background-position: 0px 0px;float: left;display: none;border: "+String(b.options.borderSize)+"px solid "+b.options.borderColour+";width:"+String(b.options.lensSize)+"px;height:"+String(b.options.lensSize)+"px;background-repeat: no-repeat;position: absolute;");"round"==b.options.lensShape&&(b.lensRound="border-top-left-radius: "+String(b.options.lensSize/2+b.options.borderSize)+"px;border-top-right-radius: "+String(b.options.lensSize/2+b.options.borderSize)+
"px;border-bottom-left-radius: "+String(b.options.lensSize/2+b.options.borderSize)+"px;border-bottom-right-radius: "+String(b.options.lensSize/2+b.options.borderSize)+"px;");b.zoomContainer=d('<div class="zoomContainer" style="-webkit-transform: translateZ(0);position:absolute;left:'+b.nzOffset.left+"px;top:"+b.nzOffset.top+"px;height:"+b.nzHeight+"px;width:"+b.nzWidth+'px;"></div>');d("body").append(b.zoomContainer);b.options.containLensZoom&&"lens"==b.options.zoomType&&b.zoomContainer.css("overflow",
"hidden");"inner"!=b.options.zoomType&&(b.zoomLens=d("<div class='zoomLens' style='"+b.lensStyle+b.lensRound+"'>&nbsp;</div>").appendTo(b.zoomContainer).click(function(){b.$elem.trigger("click")}),b.options.tint&&(b.tintContainer=d("<div/>").addClass("tintContainer"),b.zoomTint=d("<div class='zoomTint' style='"+b.tintStyle+"'></div>"),b.zoomLens.wrap(b.tintContainer),b.zoomTintcss=b.zoomLens.after(b.zoomTint),b.zoomTintImage=d('<img style="position: absolute; left: 0px; top: 0px; max-width: none; width: '+
b.nzWidth+"px; height: "+b.nzHeight+'px;" src="'+b.imageSrc+'">').appendTo(b.zoomLens).click(function(){b.$elem.trigger("click")})));isNaN(b.options.zoomWindowPosition)?b.zoomWindow=d("<div style='z-index:999;left:"+b.windowOffsetLeft+"px;top:"+b.windowOffsetTop+"px;"+b.zoomWindowStyle+"' class='zoomWindow'>&nbsp;</div>").appendTo("body").click(function(){b.$elem.trigger("click")}):b.zoomWindow=d("<div style='z-index:999;left:"+b.windowOffsetLeft+"px;top:"+b.windowOffsetTop+"px;"+b.zoomWindowStyle+
"' class='zoomWindow'>&nbsp;</div>").appendTo(b.zoomContainer).click(function(){b.$elem.trigger("click")});b.zoomWindowContainer=d("<div/>").addClass("zoomWindowContainer").css("width",b.options.zoomWindowWidth);b.zoomWindow.wrap(b.zoomWindowContainer);"lens"==b.options.zoomType&&b.zoomLens.css({backgroundImage:"url('"+b.imageSrc+"')"});"window"==b.options.zoomType&&b.zoomWindow.css({backgroundImage:"url('"+b.imageSrc+"')"});"inner"==b.options.zoomType&&b.zoomWindow.css({backgroundImage:"url('"+b.imageSrc+
"')"});b.$elem.bind("touchmove",function(a){a.preventDefault();b.setPosition(a.originalEvent.touches[0]||a.originalEvent.changedTouches[0])});b.zoomContainer.bind("touchmove",function(a){"inner"==b.options.zoomType&&b.showHideWindow("show");a.preventDefault();b.setPosition(a.originalEvent.touches[0]||a.originalEvent.changedTouches[0])});b.zoomContainer.bind("touchend",function(a){b.showHideWindow("hide");b.options.showLens&&b.showHideLens("hide");b.options.tint&&"inner"!=b.options.zoomType&&b.showHideTint("hide")});
b.$elem.bind("touchend",function(a){b.showHideWindow("hide");b.options.showLens&&b.showHideLens("hide");b.options.tint&&"inner"!=b.options.zoomType&&b.showHideTint("hide")});b.options.showLens&&(b.zoomLens.bind("touchmove",function(a){a.preventDefault();b.setPosition(a.originalEvent.touches[0]||a.originalEvent.changedTouches[0])}),b.zoomLens.bind("touchend",function(a){b.showHideWindow("hide");b.options.showLens&&b.showHideLens("hide");b.options.tint&&"inner"!=b.options.zoomType&&b.showHideTint("hide")}));
b.$elem.bind("mousemove",function(a){!1==b.overWindow&&b.setElements("show");if(b.lastX!==a.clientX||b.lastY!==a.clientY)b.setPosition(a),b.currentLoc=a;b.lastX=a.clientX;b.lastY=a.clientY});b.zoomContainer.bind("mousemove",function(a){!1==b.overWindow&&b.setElements("show");if(b.lastX!==a.clientX||b.lastY!==a.clientY)b.setPosition(a),b.currentLoc=a;b.lastX=a.clientX;b.lastY=a.clientY});"inner"!=b.options.zoomType&&b.zoomLens.bind("mousemove",function(a){if(b.lastX!==a.clientX||b.lastY!==a.clientY)b.setPosition(a),
b.currentLoc=a;b.lastX=a.clientX;b.lastY=a.clientY});b.options.tint&&"inner"!=b.options.zoomType&&b.zoomTint.bind("mousemove",function(a){if(b.lastX!==a.clientX||b.lastY!==a.clientY)b.setPosition(a),b.currentLoc=a;b.lastX=a.clientX;b.lastY=a.clientY});"inner"==b.options.zoomType&&b.zoomWindow.bind("mousemove",function(a){if(b.lastX!==a.clientX||b.lastY!==a.clientY)b.setPosition(a),b.currentLoc=a;b.lastX=a.clientX;b.lastY=a.clientY});b.zoomContainer.add(b.$elem).mouseenter(function(){!1==b.overWindow&&
b.setElements("show")}).mouseleave(function(){b.scrollLock||b.setElements("hide")});"inner"!=b.options.zoomType&&b.zoomWindow.mouseenter(function(){b.overWindow=!0;b.setElements("hide")}).mouseleave(function(){b.overWindow=!1});b.minZoomLevel=b.options.minZoomLevel?b.options.minZoomLevel:2*b.options.scrollZoomIncrement;b.options.scrollZoom&&b.zoomContainer.add(b.$elem).bind("mousewheel DOMMouseScroll MozMousePixelScroll",function(a){b.scrollLock=!0;clearTimeout(d.data(this,"timer"));d.data(this,"timer",
setTimeout(function(){b.scrollLock=!1},250));var e=a.originalEvent.wheelDelta||-1*a.originalEvent.detail;a.stopImmediatePropagation();a.stopPropagation();a.preventDefault();0<e/120?b.currentZoomLevel>=b.minZoomLevel&&b.changeZoomLevel(b.currentZoomLevel-b.options.scrollZoomIncrement):b.options.maxZoomLevel?b.currentZoomLevel<=b.options.maxZoomLevel&&b.changeZoomLevel(parseFloat(b.currentZoomLevel)+b.options.scrollZoomIncrement):b.changeZoomLevel(parseFloat(b.currentZoomLevel)+b.options.scrollZoomIncrement);
return!1})},setElements:function(b){if(!this.options.zoomEnabled)return!1;"show"==b&&this.isWindowSet&&("inner"==this.options.zoomType&&this.showHideWindow("show"),"window"==this.options.zoomType&&this.showHideWindow("show"),this.options.showLens&&this.showHideLens("show"),this.options.tint&&"inner"!=this.options.zoomType&&this.showHideTint("show"));"hide"==b&&("window"==this.options.zoomType&&this.showHideWindow("hide"),this.options.tint||this.showHideWindow("hide"),this.options.showLens&&this.showHideLens("hide"),
this.options.tint&&this.showHideTint("hide"))},setPosition:function(b){if(!this.options.zoomEnabled)return!1;this.nzHeight=this.$elem.height();this.nzWidth=this.$elem.width();this.nzOffset=this.$elem.offset();this.options.tint&&"inner"!=this.options.zoomType&&(this.zoomTint.css({top:0}),this.zoomTint.css({left:0}));this.options.responsive&&!this.options.scrollZoom&&this.options.showLens&&(lensHeight=this.nzHeight<this.options.zoomWindowWidth/this.widthRatio?this.nzHeight:String(this.options.zoomWindowHeight/
this.heightRatio),lensWidth=this.largeWidth<this.options.zoomWindowWidth?this.nzWidth:this.options.zoomWindowWidth/this.widthRatio,this.widthRatio=this.largeWidth/this.nzWidth,this.heightRatio=this.largeHeight/this.nzHeight,"lens"!=this.options.zoomType&&(lensHeight=this.nzHeight<this.options.zoomWindowWidth/this.widthRatio?this.nzHeight:String(this.options.zoomWindowHeight/this.heightRatio),lensWidth=this.options.zoomWindowWidth<this.options.zoomWindowWidth?this.nzWidth:this.options.zoomWindowWidth/
this.widthRatio,this.zoomLens.css("width",lensWidth),this.zoomLens.css("height",lensHeight),this.options.tint&&(this.zoomTintImage.css("width",this.nzWidth),this.zoomTintImage.css("height",this.nzHeight))),"lens"==this.options.zoomType&&this.zoomLens.css({width:String(this.options.lensSize)+"px",height:String(this.options.lensSize)+"px"}));this.zoomContainer.css({top:this.nzOffset.top});this.zoomContainer.css({left:this.nzOffset.left});this.mouseLeft=parseInt(b.pageX-this.nzOffset.left);this.mouseTop=
parseInt(b.pageY-this.nzOffset.top);"window"==this.options.zoomType&&(this.Etoppos=this.mouseTop<this.zoomLens.height()/2,this.Eboppos=this.mouseTop>this.nzHeight-this.zoomLens.height()/2-2*this.options.lensBorderSize,this.Eloppos=this.mouseLeft<0+this.zoomLens.width()/2,this.Eroppos=this.mouseLeft>this.nzWidth-this.zoomLens.width()/2-2*this.options.lensBorderSize);"inner"==this.options.zoomType&&(this.Etoppos=this.mouseTop<this.nzHeight/2/this.heightRatio,this.Eboppos=this.mouseTop>this.nzHeight-
this.nzHeight/2/this.heightRatio,this.Eloppos=this.mouseLeft<0+this.nzWidth/2/this.widthRatio,this.Eroppos=this.mouseLeft>this.nzWidth-this.nzWidth/2/this.widthRatio-2*this.options.lensBorderSize);0>=this.mouseLeft||0>this.mouseTop||this.mouseLeft>this.nzWidth||this.mouseTop>this.nzHeight?this.setElements("hide"):(this.options.showLens&&(this.lensLeftPos=String(this.mouseLeft-this.zoomLens.width()/2),this.lensTopPos=String(this.mouseTop-this.zoomLens.height()/2)),this.Etoppos&&(this.lensTopPos=0),
this.Eloppos&&(this.tintpos=this.lensLeftPos=this.windowLeftPos=0),"window"==this.options.zoomType&&(this.Eboppos&&(this.lensTopPos=Math.max(this.nzHeight-this.zoomLens.height()-2*this.options.lensBorderSize,0)),this.Eroppos&&(this.lensLeftPos=this.nzWidth-this.zoomLens.width()-2*this.options.lensBorderSize)),"inner"==this.options.zoomType&&(this.Eboppos&&(this.lensTopPos=Math.max(this.nzHeight-2*this.options.lensBorderSize,0)),this.Eroppos&&(this.lensLeftPos=this.nzWidth-this.nzWidth-2*this.options.lensBorderSize)),
"lens"==this.options.zoomType&&(this.windowLeftPos=String(-1*((b.pageX-this.nzOffset.left)*this.widthRatio-this.zoomLens.width()/2)),this.windowTopPos=String(-1*((b.pageY-this.nzOffset.top)*this.heightRatio-this.zoomLens.height()/2)),this.zoomLens.css({backgroundPosition:this.windowLeftPos+"px "+this.windowTopPos+"px"}),this.changeBgSize&&(this.nzHeight>this.nzWidth?("lens"==this.options.zoomType&&this.zoomLens.css({"background-size":this.largeWidth/this.newvalueheight+"px "+this.largeHeight/this.newvalueheight+
"px"}),this.zoomWindow.css({"background-size":this.largeWidth/this.newvalueheight+"px "+this.largeHeight/this.newvalueheight+"px"})):("lens"==this.options.zoomType&&this.zoomLens.css({"background-size":this.largeWidth/this.newvaluewidth+"px "+this.largeHeight/this.newvaluewidth+"px"}),this.zoomWindow.css({"background-size":this.largeWidth/this.newvaluewidth+"px "+this.largeHeight/this.newvaluewidth+"px"})),this.changeBgSize=!1),this.setWindowPostition(b)),this.options.tint&&"inner"!=this.options.zoomType&&
this.setTintPosition(b),"window"==this.options.zoomType&&this.setWindowPostition(b),"inner"==this.options.zoomType&&this.setWindowPostition(b),this.options.showLens&&(this.fullwidth&&"lens"!=this.options.zoomType&&(this.lensLeftPos=0),this.zoomLens.css({left:this.lensLeftPos+"px",top:this.lensTopPos+"px"})))},showHideWindow:function(b){"show"!=b||this.isWindowActive||(this.options.zoomWindowFadeIn?this.zoomWindow.stop(!0,!0,!1).fadeIn(this.options.zoomWindowFadeIn):this.zoomWindow.show(),this.isWindowActive=
!0);"hide"==b&&this.isWindowActive&&(this.options.zoomWindowFadeOut?this.zoomWindow.stop(!0,!0).fadeOut(this.options.zoomWindowFadeOut):this.zoomWindow.hide(),this.isWindowActive=!1)},showHideLens:function(b){"show"!=b||this.isLensActive||(this.options.lensFadeIn?this.zoomLens.stop(!0,!0,!1).fadeIn(this.options.lensFadeIn):this.zoomLens.show(),this.isLensActive=!0);"hide"==b&&this.isLensActive&&(this.options.lensFadeOut?this.zoomLens.stop(!0,!0).fadeOut(this.options.lensFadeOut):this.zoomLens.hide(),
this.isLensActive=!1)},showHideTint:function(b){"show"!=b||this.isTintActive||(this.options.zoomTintFadeIn?this.zoomTint.css({opacity:this.options.tintOpacity}).animate().stop(!0,!0).fadeIn("slow"):(this.zoomTint.css({opacity:this.options.tintOpacity}).animate(),this.zoomTint.show()),this.isTintActive=!0);"hide"==b&&this.isTintActive&&(this.options.zoomTintFadeOut?this.zoomTint.stop(!0,!0).fadeOut(this.options.zoomTintFadeOut):this.zoomTint.hide(),this.isTintActive=!1)},setLensPostition:function(b){},
setWindowPostition:function(b){var a=this;if(isNaN(a.options.zoomWindowPosition))a.externalContainer=d("#"+a.options.zoomWindowPosition),a.externalContainerWidth=a.externalContainer.width(),a.externalContainerHeight=a.externalContainer.height(),a.externalContainerOffset=a.externalContainer.offset(),a.windowOffsetTop=a.externalContainerOffset.top,a.windowOffsetLeft=a.externalContainerOffset.left;else switch(a.options.zoomWindowPosition){case 1:a.windowOffsetTop=a.options.zoomWindowOffety;a.windowOffsetLeft=
+a.nzWidth;break;case 2:a.options.zoomWindowHeight>a.nzHeight&&(a.windowOffsetTop=-1*(a.options.zoomWindowHeight/2-a.nzHeight/2),a.windowOffsetLeft=a.nzWidth);break;case 3:a.windowOffsetTop=a.nzHeight-a.zoomWindow.height()-2*a.options.borderSize;a.windowOffsetLeft=a.nzWidth;break;case 4:a.windowOffsetTop=a.nzHeight;a.windowOffsetLeft=a.nzWidth;break;case 5:a.windowOffsetTop=a.nzHeight;a.windowOffsetLeft=a.nzWidth-a.zoomWindow.width()-2*a.options.borderSize;break;case 6:a.options.zoomWindowHeight>
a.nzHeight&&(a.windowOffsetTop=a.nzHeight,a.windowOffsetLeft=-1*(a.options.zoomWindowWidth/2-a.nzWidth/2+2*a.options.borderSize));break;case 7:a.windowOffsetTop=a.nzHeight;a.windowOffsetLeft=0;break;case 8:a.windowOffsetTop=a.nzHeight;a.windowOffsetLeft=-1*(a.zoomWindow.width()+2*a.options.borderSize);break;case 9:a.windowOffsetTop=a.nzHeight-a.zoomWindow.height()-2*a.options.borderSize;a.windowOffsetLeft=-1*(a.zoomWindow.width()+2*a.options.borderSize);break;case 10:a.options.zoomWindowHeight>a.nzHeight&&
(a.windowOffsetTop=-1*(a.options.zoomWindowHeight/2-a.nzHeight/2),a.windowOffsetLeft=-1*(a.zoomWindow.width()+2*a.options.borderSize));break;case 11:a.windowOffsetTop=a.options.zoomWindowOffety;a.windowOffsetLeft=-1*(a.zoomWindow.width()+2*a.options.borderSize);break;case 12:a.windowOffsetTop=-1*(a.zoomWindow.height()+2*a.options.borderSize);a.windowOffsetLeft=-1*(a.zoomWindow.width()+2*a.options.borderSize);break;case 13:a.windowOffsetTop=-1*(a.zoomWindow.height()+2*a.options.borderSize);a.windowOffsetLeft=
0;break;case 14:a.options.zoomWindowHeight>a.nzHeight&&(a.windowOffsetTop=-1*(a.zoomWindow.height()+2*a.options.borderSize),a.windowOffsetLeft=-1*(a.options.zoomWindowWidth/2-a.nzWidth/2+2*a.options.borderSize));break;case 15:a.windowOffsetTop=-1*(a.zoomWindow.height()+2*a.options.borderSize);a.windowOffsetLeft=a.nzWidth-a.zoomWindow.width()-2*a.options.borderSize;break;case 16:a.windowOffsetTop=-1*(a.zoomWindow.height()+2*a.options.borderSize);a.windowOffsetLeft=a.nzWidth;break;default:a.windowOffsetTop=
a.options.zoomWindowOffety,a.windowOffsetLeft=a.nzWidth}a.isWindowSet=!0;a.windowOffsetTop+=a.options.zoomWindowOffety;a.windowOffsetLeft+=a.options.zoomWindowOffetx;a.zoomWindow.css({top:a.windowOffsetTop});a.zoomWindow.css({left:a.windowOffsetLeft});"inner"==a.options.zoomType&&(a.zoomWindow.css({top:0}),a.zoomWindow.css({left:0}));a.windowLeftPos=String(-1*((b.pageX-a.nzOffset.left)*a.widthRatio-a.zoomWindow.width()/2));a.windowTopPos=String(-1*((b.pageY-a.nzOffset.top)*a.heightRatio-a.zoomWindow.height()/
2));a.Etoppos&&(a.windowTopPos=0);a.Eloppos&&(a.windowLeftPos=0);a.Eboppos&&(a.windowTopPos=-1*(a.largeHeight/a.currentZoomLevel-a.zoomWindow.height()));a.Eroppos&&(a.windowLeftPos=-1*(a.largeWidth/a.currentZoomLevel-a.zoomWindow.width()));a.fullheight&&(a.windowTopPos=0);a.fullwidth&&(a.windowLeftPos=0);if("window"==a.options.zoomType||"inner"==a.options.zoomType)1==a.zoomLock&&(1>=a.widthRatio&&(a.windowLeftPos=0),1>=a.heightRatio&&(a.windowTopPos=0)),a.largeHeight<a.options.zoomWindowHeight&&(a.windowTopPos=
0),a.largeWidth<a.options.zoomWindowWidth&&(a.windowLeftPos=0),a.options.easing?(a.xp||(a.xp=0),a.yp||(a.yp=0),a.loop||(a.loop=setInterval(function(){a.xp+=(a.windowLeftPos-a.xp)/a.options.easingAmount;a.yp+=(a.windowTopPos-a.yp)/a.options.easingAmount;a.scrollingLock?(clearInterval(a.loop),a.xp=a.windowLeftPos,a.yp=a.windowTopPos,a.xp=-1*((b.pageX-a.nzOffset.left)*a.widthRatio-a.zoomWindow.width()/2),a.yp=-1*((b.pageY-a.nzOffset.top)*a.heightRatio-a.zoomWindow.height()/2),a.changeBgSize&&(a.nzHeight>
a.nzWidth?("lens"==a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"}),a.zoomWindow.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"})):("lens"!=a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvaluewidth+"px "+a.largeHeight/a.newvalueheight+"px"}),a.zoomWindow.css({"background-size":a.largeWidth/a.newvaluewidth+"px "+a.largeHeight/a.newvaluewidth+"px"})),
a.changeBgSize=!1),a.zoomWindow.css({backgroundPosition:a.windowLeftPos+"px "+a.windowTopPos+"px"}),a.scrollingLock=!1,a.loop=!1):(a.changeBgSize&&(a.nzHeight>a.nzWidth?("lens"==a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"}),a.zoomWindow.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"})):("lens"!=a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvaluewidth+
"px "+a.largeHeight/a.newvaluewidth+"px"}),a.zoomWindow.css({"background-size":a.largeWidth/a.newvaluewidth+"px "+a.largeHeight/a.newvaluewidth+"px"})),a.changeBgSize=!1),a.zoomWindow.css({backgroundPosition:a.xp+"px "+a.yp+"px"}))},16))):(a.changeBgSize&&(a.nzHeight>a.nzWidth?("lens"==a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"}),a.zoomWindow.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/
a.newvalueheight+"px"})):("lens"==a.options.zoomType&&a.zoomLens.css({"background-size":a.largeWidth/a.newvaluewidth+"px "+a.largeHeight/a.newvaluewidth+"px"}),a.largeHeight/a.newvaluewidth<a.options.zoomWindowHeight?a.zoomWindow.css({"background-size":a.largeWidth/a.newvaluewidth+"px "+a.largeHeight/a.newvaluewidth+"px"}):a.zoomWindow.css({"background-size":a.largeWidth/a.newvalueheight+"px "+a.largeHeight/a.newvalueheight+"px"})),a.changeBgSize=!1),a.zoomWindow.css({backgroundPosition:a.windowLeftPos+
"px "+a.windowTopPos+"px"}))},setTintPosition:function(b){this.nzOffset=this.$elem.offset();this.tintpos=String(-1*(b.pageX-this.nzOffset.left-this.zoomLens.width()/2));this.tintposy=String(-1*(b.pageY-this.nzOffset.top-this.zoomLens.height()/2));this.Etoppos&&(this.tintposy=0);this.Eloppos&&(this.tintpos=0);this.Eboppos&&(this.tintposy=-1*(this.nzHeight-this.zoomLens.height()-2*this.options.lensBorderSize));this.Eroppos&&(this.tintpos=-1*(this.nzWidth-this.zoomLens.width()-2*this.options.lensBorderSize));
this.options.tint&&(this.fullheight&&(this.tintposy=0),this.fullwidth&&(this.tintpos=0),this.zoomTintImage.css({left:this.tintpos+"px"}),this.zoomTintImage.css({top:this.tintposy+"px"}))},swaptheimage:function(b,a){var c=this,e=new Image;c.options.loadingIcon&&(c.spinner=d("<div style=\"background: url('"+c.options.loadingIcon+"') no-repeat center;height:"+c.nzHeight+"px;width:"+c.nzWidth+'px;z-index: 2000;position: absolute; background-position: center center;"></div>'),c.$elem.after(c.spinner));
c.options.onImageSwap(c.$elem);e.onload=function(){c.largeWidth=e.width;c.largeHeight=e.height;c.zoomImage=a;c.zoomWindow.css({"background-size":c.largeWidth+"px "+c.largeHeight+"px"});c.zoomWindow.css({"background-size":c.largeWidth+"px "+c.largeHeight+"px"});c.swapAction(b,a)};e.src=a},swapAction:function(b,a){var c=this,e=new Image;e.onload=function(){c.nzHeight=e.height;c.nzWidth=e.width;c.options.onImageSwapComplete(c.$elem);c.doneCallback()};e.src=b;c.currentZoomLevel=c.options.zoomLevel;c.options.maxZoomLevel=
!1;"lens"==c.options.zoomType&&c.zoomLens.css({backgroundImage:"url('"+a+"')"});"window"==c.options.zoomType&&c.zoomWindow.css({backgroundImage:"url('"+a+"')"});"inner"==c.options.zoomType&&c.zoomWindow.css({backgroundImage:"url('"+a+"')"});c.currentImage=a;if(c.options.imageCrossfade){var f=c.$elem,g=f.clone();c.$elem.attr("src",b);c.$elem.after(g);g.stop(!0).fadeOut(c.options.imageCrossfade,function(){d(this).remove()});c.$elem.width("auto").removeAttr("width");c.$elem.height("auto").removeAttr("height");
f.fadeIn(c.options.imageCrossfade);c.options.tint&&"inner"!=c.options.zoomType&&(f=c.zoomTintImage,g=f.clone(),c.zoomTintImage.attr("src",a),c.zoomTintImage.after(g),g.stop(!0).fadeOut(c.options.imageCrossfade,function(){d(this).remove()}),f.fadeIn(c.options.imageCrossfade),c.zoomTint.css({height:c.$elem.height()}),c.zoomTint.css({width:c.$elem.width()}));c.zoomContainer.css("height",c.$elem.height());c.zoomContainer.css("width",c.$elem.width());"inner"!=c.options.zoomType||c.options.constrainType||
(c.zoomWrap.parent().css("height",c.$elem.height()),c.zoomWrap.parent().css("width",c.$elem.width()),c.zoomWindow.css("height",c.$elem.height()),c.zoomWindow.css("width",c.$elem.width()))}else c.$elem.attr("src",b),c.options.tint&&(c.zoomTintImage.attr("src",a),c.zoomTintImage.attr("height",c.$elem.height()),c.zoomTintImage.css({height:c.$elem.height()}),c.zoomTint.css({height:c.$elem.height()})),c.zoomContainer.css("height",c.$elem.height()),c.zoomContainer.css("width",c.$elem.width());c.options.imageCrossfade&&
(c.zoomWrap.css("height",c.$elem.height()),c.zoomWrap.css("width",c.$elem.width()));c.options.constrainType&&("height"==c.options.constrainType&&(c.zoomContainer.css("height",c.options.constrainSize),c.zoomContainer.css("width","auto"),c.options.imageCrossfade?(c.zoomWrap.css("height",c.options.constrainSize),c.zoomWrap.css("width","auto"),c.constwidth=c.zoomWrap.width()):(c.$elem.css("height",c.options.constrainSize),c.$elem.css("width","auto"),c.constwidth=c.$elem.width()),"inner"==c.options.zoomType&&
(c.zoomWrap.parent().css("height",c.options.constrainSize),c.zoomWrap.parent().css("width",c.constwidth),c.zoomWindow.css("height",c.options.constrainSize),c.zoomWindow.css("width",c.constwidth)),c.options.tint&&(c.tintContainer.css("height",c.options.constrainSize),c.tintContainer.css("width",c.constwidth),c.zoomTint.css("height",c.options.constrainSize),c.zoomTint.css("width",c.constwidth),c.zoomTintImage.css("height",c.options.constrainSize),c.zoomTintImage.css("width",c.constwidth))),"width"==
c.options.constrainType&&(c.zoomContainer.css("height","auto"),c.zoomContainer.css("width",c.options.constrainSize),c.options.imageCrossfade?(c.zoomWrap.css("height","auto"),c.zoomWrap.css("width",c.options.constrainSize),c.constheight=c.zoomWrap.height()):(c.$elem.css("height","auto"),c.$elem.css("width",c.options.constrainSize),c.constheight=c.$elem.height()),"inner"==c.options.zoomType&&(c.zoomWrap.parent().css("height",c.constheight),c.zoomWrap.parent().css("width",c.options.constrainSize),c.zoomWindow.css("height",
c.constheight),c.zoomWindow.css("width",c.options.constrainSize)),c.options.tint&&(c.tintContainer.css("height",c.constheight),c.tintContainer.css("width",c.options.constrainSize),c.zoomTint.css("height",c.constheight),c.zoomTint.css("width",c.options.constrainSize),c.zoomTintImage.css("height",c.constheight),c.zoomTintImage.css("width",c.options.constrainSize))))},doneCallback:function(){this.options.loadingIcon&&this.spinner.hide();this.nzOffset=this.$elem.offset();this.nzWidth=this.$elem.width();
this.nzHeight=this.$elem.height();this.currentZoomLevel=this.options.zoomLevel;this.widthRatio=this.largeWidth/this.nzWidth;this.heightRatio=this.largeHeight/this.nzHeight;"window"==this.options.zoomType&&(lensHeight=this.nzHeight<this.options.zoomWindowWidth/this.widthRatio?this.nzHeight:String(this.options.zoomWindowHeight/this.heightRatio),lensWidth=this.options.zoomWindowWidth<this.options.zoomWindowWidth?this.nzWidth:this.options.zoomWindowWidth/this.widthRatio,this.zoomLens&&(this.zoomLens.css("width",
lensWidth),this.zoomLens.css("height",lensHeight)))},getCurrentImage:function(){return this.zoomImage},getGalleryList:function(){var b=this;b.gallerylist=[];b.options.gallery?d("#"+b.options.gallery+" a").each(function(){var a="";d(this).data("zoom-image")?a=d(this).data("zoom-image"):d(this).data("image")&&(a=d(this).data("image"));a==b.zoomImage?b.gallerylist.unshift({href:""+a+"",title:d(this).find("img").attr("title")}):b.gallerylist.push({href:""+a+"",title:d(this).find("img").attr("title")})}):
b.gallerylist.push({href:""+b.zoomImage+"",title:d(this).find("img").attr("title")});return b.gallerylist},changeZoomLevel:function(b){this.scrollingLock=!0;this.newvalue=parseFloat(b).toFixed(2);newvalue=parseFloat(b).toFixed(2);maxheightnewvalue=this.largeHeight/(this.options.zoomWindowHeight/this.nzHeight*this.nzHeight);maxwidthtnewvalue=this.largeWidth/(this.options.zoomWindowWidth/this.nzWidth*this.nzWidth);"inner"!=this.options.zoomType&&(maxheightnewvalue<=newvalue?(this.heightRatio=this.largeHeight/
maxheightnewvalue/this.nzHeight,this.newvalueheight=maxheightnewvalue,this.fullheight=!0):(this.heightRatio=this.largeHeight/newvalue/this.nzHeight,this.newvalueheight=newvalue,this.fullheight=!1),maxwidthtnewvalue<=newvalue?(this.widthRatio=this.largeWidth/maxwidthtnewvalue/this.nzWidth,this.newvaluewidth=maxwidthtnewvalue,this.fullwidth=!0):(this.widthRatio=this.largeWidth/newvalue/this.nzWidth,this.newvaluewidth=newvalue,this.fullwidth=!1),"lens"==this.options.zoomType&&(maxheightnewvalue<=newvalue?
(this.fullwidth=!0,this.newvaluewidth=maxheightnewvalue):(this.widthRatio=this.largeWidth/newvalue/this.nzWidth,this.newvaluewidth=newvalue,this.fullwidth=!1)));"inner"==this.options.zoomType&&(maxheightnewvalue=parseFloat(this.largeHeight/this.nzHeight).toFixed(2),maxwidthtnewvalue=parseFloat(this.largeWidth/this.nzWidth).toFixed(2),newvalue>maxheightnewvalue&&(newvalue=maxheightnewvalue),newvalue>maxwidthtnewvalue&&(newvalue=maxwidthtnewvalue),maxheightnewvalue<=newvalue?(this.heightRatio=this.largeHeight/
newvalue/this.nzHeight,this.newvalueheight=newvalue>maxheightnewvalue?maxheightnewvalue:newvalue,this.fullheight=!0):(this.heightRatio=this.largeHeight/newvalue/this.nzHeight,this.newvalueheight=newvalue>maxheightnewvalue?maxheightnewvalue:newvalue,this.fullheight=!1),maxwidthtnewvalue<=newvalue?(this.widthRatio=this.largeWidth/newvalue/this.nzWidth,this.newvaluewidth=newvalue>maxwidthtnewvalue?maxwidthtnewvalue:newvalue,this.fullwidth=!0):(this.widthRatio=this.largeWidth/newvalue/this.nzWidth,this.newvaluewidth=
newvalue,this.fullwidth=!1));scrcontinue=!1;"inner"==this.options.zoomType&&(this.nzWidth>this.nzHeight&&(this.newvaluewidth<=maxwidthtnewvalue?scrcontinue=!0:(scrcontinue=!1,this.fullwidth=this.fullheight=!0)),this.nzHeight>this.nzWidth&&(this.newvaluewidth<=maxwidthtnewvalue?scrcontinue=!0:(scrcontinue=!1,this.fullwidth=this.fullheight=!0)));"inner"!=this.options.zoomType&&(scrcontinue=!0);scrcontinue&&(this.zoomLock=0,this.changeZoom=!0,this.options.zoomWindowHeight/this.heightRatio<=this.nzHeight&&
(this.currentZoomLevel=this.newvalueheight,"lens"!=this.options.zoomType&&"inner"!=this.options.zoomType&&(this.changeBgSize=!0,this.zoomLens.css({height:String(this.options.zoomWindowHeight/this.heightRatio)+"px"})),"lens"==this.options.zoomType||"inner"==this.options.zoomType)&&(this.changeBgSize=!0),this.options.zoomWindowWidth/this.widthRatio<=this.nzWidth&&("inner"!=this.options.zoomType&&this.newvaluewidth>this.newvalueheight&&(this.currentZoomLevel=this.newvaluewidth),"lens"!=this.options.zoomType&&
"inner"!=this.options.zoomType&&(this.changeBgSize=!0,this.zoomLens.css({width:String(this.options.zoomWindowWidth/this.widthRatio)+"px"})),"lens"==this.options.zoomType||"inner"==this.options.zoomType)&&(this.changeBgSize=!0),"inner"==this.options.zoomType&&(this.changeBgSize=!0,this.nzWidth>this.nzHeight&&(this.currentZoomLevel=this.newvaluewidth),this.nzHeight>this.nzWidth&&(this.currentZoomLevel=this.newvaluewidth)));this.setPosition(this.currentLoc)},closeAll:function(){self.zoomWindow&&self.zoomWindow.hide();
self.zoomLens&&self.zoomLens.hide();self.zoomTint&&self.zoomTint.hide()},changeState:function(b){"enable"==b&&(this.options.zoomEnabled=!0);"disable"==b&&(this.options.zoomEnabled=!1)}};d.fn.elevateZoom=function(b){return this.each(function(){var a=Object.create(k);a.init(b,this);d.data(this,"elevateZoom",a)})};d.fn.elevateZoom.options={zoomActivation:"hover",zoomEnabled:!0,preloading:1,zoomLevel:1,scrollZoom:!1,scrollZoomIncrement:0.1,minZoomLevel:!1,maxZoomLevel:!1,easing:!1,easingAmount:12,lensSize:200,
zoomWindowWidth:400,zoomWindowHeight:400,zoomWindowOffetx:0,zoomWindowOffety:0,zoomWindowPosition:1,zoomWindowBgColour:"#fff",lensFadeIn:!1,lensFadeOut:!1,debug:!1,zoomWindowFadeIn:!1,zoomWindowFadeOut:!1,zoomWindowAlwaysShow:!1,zoomTintFadeIn:!1,zoomTintFadeOut:!1,borderSize:4,showLens:!0,borderColour:"#888",lensBorderSize:1,lensBorderColour:"#000",lensShape:"square",zoomType:"window",containLensZoom:!1,lensColour:"white",lensOpacity:0.4,lenszoom:!1,tint:!1,tintColour:"#333",tintOpacity:0.4,gallery:!1,
galleryActiveClass:"zoomGalleryActive",imageCrossfade:!1,constrainType:!1,constrainSize:!1,loadingIcon:!1,cursor:"default",responsive:!0,onComplete:d.noop,onZoomedImageLoaded:function(){},onImageSwap:d.noop,onImageSwapComplete:d.noop}})(jQuery,window,document);
(function(a){"use strict",a.fn.chained=function(b,c){return this.each(function(){var c=this,d=a(c).clone();a(b).each(function(){a(this).bind("change",function(){a(c).html(d.html());var e="";a(b).each(function(){e+="\\"+a(":selected",this).val()}),e=e.substr(1);var f=a(b).first(),g=a(":selected",f).val();a("option",c).each(function(){!a(this).hasClass(e)&&!a(this).hasClass(g)&&a(this).val()!==""&&a(this).remove()}),1===a("option",c).size()&&a(c).val()===""?a(c).attr("disabled","disabled"):a(c).removeAttr("disabled"),a(c).trigger("change")}),a("option:selected",this).length||a("option",this).first().attr("selected","selected"),a(this).trigger("change")})})},a.fn.chainedTo=a.fn.chained})(jQuery)
/*!
 * Legacy browser support
 */

if(typeof String.prototype.trim !== 'function') {
  String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g, ''); 
  }
}

// Map array support
if ( ![].map ) {
    Array.prototype.map = function ( callback, self ) {
        var array = this, len = array.length, newArray = new Array( len )
        for ( var i = 0; i < len; i++ ) {
            if ( i in array ) {
                newArray[ i ] = callback.call( self, array[ i ], i, array )
            }
        }
        return newArray
    }
}


// Filter array support
if ( ![].filter ) {
    Array.prototype.filter = function( callback ) {
        if ( this == null ) throw new TypeError()
        var t = Object( this ), len = t.length >>> 0
        if ( typeof callback != 'function' ) throw new TypeError()
        var newArray = [], thisp = arguments[ 1 ]
        for ( var i = 0; i < len; i++ ) {
          if ( i in t ) {
            var val = t[ i ]
            if ( callback.call( thisp, val, i, t ) ) newArray.push( val )
          }
        }
        return newArray
    }
}


// Index of array support
if ( ![].indexOf ) {
    Array.prototype.indexOf = function( searchElement ) {
        if ( this == null ) throw new TypeError()
        var t = Object( this ), len = t.length >>> 0
        if ( len === 0 ) return -1
        var n = 0
        if ( arguments.length > 1 ) {
            n = Number( arguments[ 1 ] )
            if ( n != n ) {
                n = 0
            }
            else if ( n !== 0 && n != Infinity && n != -Infinity ) {
                n = ( n > 0 || -1 ) * Math.floor( Math.abs( n ) )
            }
        }
        if ( n >= len ) return -1
        var k = n >= 0 ? n : Math.max( len - Math.abs( n ), 0 )
        for ( ; k < len; k++ ) {
            if ( k in t && t[ k ] === searchElement ) return k
        }
        return -1
    }
}


/*!
 * Cross-Browser Split 1.1.1
 * Copyright 2007-2012 Steven Levithan <stevenlevithan.com>
 * Available under the MIT License
 * http://blog.stevenlevithan.com/archives/cross-browser-split
 */
var nativeSplit = String.prototype.split, compliantExecNpcg = /()??/.exec('')[1] === undefined
String.prototype.split = function(separator, limit) {
    var str = this
    if (Object.prototype.toString.call(separator) !== '[object RegExp]') {
        return nativeSplit.call(str, separator, limit)
    }
    var output = [],
        flags = (separator.ignoreCase ? 'i' : '') +
                (separator.multiline  ? 'm' : '') +
                (separator.extended   ? 'x' : '') +
                (separator.sticky     ? 'y' : ''),
        lastLastIndex = 0,
        separator2, match, lastIndex, lastLength
    separator = new RegExp(separator.source, flags + 'g')
    str += ''
    if (!compliantExecNpcg) {
        separator2 = new RegExp('^' + separator.source + '$(?!\\s)', flags)
    }
    limit = limit === undefined ? -1 >>> 0 : limit >>> 0
    while (match = separator.exec(str)) {
        lastIndex = match.index + match[0].length
        if (lastIndex > lastLastIndex) {
            output.push(str.slice(lastLastIndex, match.index))
            if (!compliantExecNpcg && match.length > 1) {
                match[0].replace(separator2, function () {
                    for (var i = 1; i < arguments.length - 2; i++) {
                        if (arguments[i] === undefined) {
                            match[i] = undefined
                        }
                    }
                })
            }
            if (match.length > 1 && match.index < str.length) {
                Array.prototype.push.apply(output, match.slice(1))
            }
            lastLength = match[0].length
            lastLastIndex = lastIndex
            if (output.length >= limit) {
                break
            }
        }
        if (separator.lastIndex === match.index) {
            separator.lastIndex++
        }
    }
    if (lastLastIndex === str.length) {
        if (lastLength || !separator.test('')) {
            output.push('')
        }
    } else {
        output.push(str.slice(lastLastIndex))
    }
    return output.length > limit ? output.slice(0, limit) : output
};

(function() {
  var $, cardFromNumber, cardFromType, cards, defaultFormat, formatBackCardNumber, formatBackExpiry, formatCardNumber, formatExpiry, formatForwardExpiry, formatForwardSlash, hasTextSelected, luhnCheck, reFormatCardNumber, restrictCVC, restrictCardNumber, restrictExpiry, restrictNumeric, setCardType,
    __slice = [].slice,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    _this = this;

  $ = jQuery;

  $.payment = {};

  $.payment.fn = {};

  $.fn.payment = function() {
    var args, method;
    method = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return $.payment.fn[method].apply(this, args);
  };

  defaultFormat = /(\d{1,4})/g;

  cards = [
    {
      type: 'maestro',
      pattern: /^(5018|5020|5038|6304|6759|676[1-3])/,
      format: defaultFormat,
      length: [12, 13, 14, 15, 16, 17, 18, 19],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'dinersclub',
      pattern: /^(36|38|30[0-5])/,
      format: defaultFormat,
      length: [14],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'laser',
      pattern: /^(6706|6771|6709)/,
      format: defaultFormat,
      length: [16, 17, 18, 19],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'jcb',
      pattern: /^35/,
      format: defaultFormat,
      length: [16],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'unionpay',
      pattern: /^62/,
      format: defaultFormat,
      length: [16, 17, 18, 19],
      cvcLength: [3],
      luhn: false
    }, {
      type: 'discover',
      pattern: /^(6011|65|64[4-9]|622)/,
      format: defaultFormat,
      length: [16],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'mastercard',
      pattern: /^5[1-5]/,
      format: defaultFormat,
      length: [16],
      cvcLength: [3],
      luhn: true
    }, {
      type: 'amex',
      pattern: /^3[47]/,
      format: /(\d{1,4})(\d{1,6})?(\d{1,5})?/,
      length: [15],
      cvcLength: [3, 4],
      luhn: true
    }, {
      type: 'visa',
      pattern: /^4/,
      format: defaultFormat,
      length: [13, 14, 15, 16],
      cvcLength: [3],
      luhn: true
    }
  ];

  cardFromNumber = function(num) {
    var card, _i, _len;
    num = (num + '').replace(/\D/g, '');
    for (_i = 0, _len = cards.length; _i < _len; _i++) {
      card = cards[_i];
      if (card.pattern.test(num)) {
        return card;
      }
    }
  };

  cardFromType = function(type) {
    var card, _i, _len;
    for (_i = 0, _len = cards.length; _i < _len; _i++) {
      card = cards[_i];
      if (card.type === type) {
        return card;
      }
    }
  };

  luhnCheck = function(num) {
    var digit, digits, odd, sum, _i, _len;
    odd = true;
    sum = 0;
    digits = (num + '').split('').reverse();
    for (_i = 0, _len = digits.length; _i < _len; _i++) {
      digit = digits[_i];
      digit = parseInt(digit, 10);
      if ((odd = !odd)) {
        digit *= 2;
      }
      if (digit > 9) {
        digit -= 9;
      }
      sum += digit;
    }
    return sum % 10 === 0;
  };

  hasTextSelected = function($target) {
    var _ref;
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== $target.prop('selectionEnd')) {
      return true;
    }
    if (typeof document !== "undefined" && document !== null ? (_ref = document.selection) != null ? typeof _ref.createRange === "function" ? _ref.createRange().text : void 0 : void 0 : void 0) {
      return true;
    }
    return false;
  };

  reFormatCardNumber = function(e) {
    var _this = this;
    return setTimeout(function() {
      var $target, value;
      $target = $(e.currentTarget);
      value = $target.val();
      value = $.payment.formatCardNumber(value);
      return $target.val(value);
    });
  };

  formatCardNumber = function(e) {
    var $target, card, digit, length, re, upperLength, value;
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    $target = $(e.currentTarget);
    value = $target.val();
    card = cardFromNumber(value + digit);
    length = (value.replace(/\D/g, '') + digit).length;
    upperLength = 16;
    if (card) {
      upperLength = card.length[card.length.length - 1];
    }
    if (length >= upperLength) {
      return;
    }
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== value.length) {
      return;
    }
    if (card && card.type === 'amex') {
      re = /^(\d{4}|\d{4}\s\d{6})$/;
    } else {
      re = /(?:^|\s)(\d{4})$/;
    }
    if (re.test(value)) {
      e.preventDefault();
      return $target.val(value + ' ' + digit);
    } else if (re.test(value + digit)) {
      e.preventDefault();
      return $target.val(value + digit + ' ');
    }
  };

  formatBackCardNumber = function(e) {
    var $target, value;
    $target = $(e.currentTarget);
    value = $target.val();
    if (e.meta) {
      return;
    }
    if (e.which !== 8) {
      return;
    }
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== value.length) {
      return;
    }
    if (/\d\s$/.test(value)) {
      e.preventDefault();
      return $target.val(value.replace(/\d\s$/, ''));
    } else if (/\s\d?$/.test(value)) {
      e.preventDefault();
      return $target.val(value.replace(/\s\d?$/, ''));
    }
  };

  formatExpiry = function(e) {
    var $target, digit, val;
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    $target = $(e.currentTarget);
    val = $target.val() + digit;
    if (/^\d$/.test(val) && (val !== '0' && val !== '1')) {
      e.preventDefault();
      return $target.val("0" + val + " / ");
    } else if (/^\d\d$/.test(val)) {
      e.preventDefault();
      return $target.val("" + val + " / ");
    }
  };

  formatForwardExpiry = function(e) {
    var $target, digit, val;
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    $target = $(e.currentTarget);
    val = $target.val();
    if (/^\d\d$/.test(val)) {
      return $target.val("" + val + " / ");
    }
  };

  formatForwardSlash = function(e) {
    var $target, slash, val;
    slash = String.fromCharCode(e.which);
    if (slash !== '/') {
      return;
    }
    $target = $(e.currentTarget);
    val = $target.val();
    if (/^\d$/.test(val) && val !== '0') {
      return $target.val("0" + val + " / ");
    }
  };

  formatBackExpiry = function(e) {
    var $target, value;
    if (e.meta) {
      return;
    }
    $target = $(e.currentTarget);
    value = $target.val();
    if (e.which !== 8) {
      return;
    }
    if (($target.prop('selectionStart') != null) && $target.prop('selectionStart') !== value.length) {
      return;
    }
    if (/\d(\s|\/)+$/.test(value)) {
      e.preventDefault();
      return $target.val(value.replace(/\d(\s|\/)*$/, ''));
    } else if (/\s\/\s?\d?$/.test(value)) {
      e.preventDefault();
      return $target.val(value.replace(/\s\/\s?\d?$/, ''));
    }
  };

  restrictNumeric = function(e) {
    var input;
    if (e.metaKey || e.ctrlKey) {
      return true;
    }
    if (e.which === 32) {
      return false;
    }
    if (e.which === 0) {
      return true;
    }
    if (e.which < 33) {
      return true;
    }
    input = String.fromCharCode(e.which);
    return !!/[\d\s]/.test(input);
  };

  restrictCardNumber = function(e) {
    var $target, card, digit, value;
    $target = $(e.currentTarget);
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    if (hasTextSelected($target)) {
      return;
    }
    value = ($target.val() + digit).replace(/\D/g, '');
    card = cardFromNumber(value);
    if (card) {
      return value.length <= card.length[card.length.length - 1];
    } else {
      return value.length <= 16;
    }
  };

  restrictExpiry = function(e) {
    var $target, digit, value;
    $target = $(e.currentTarget);
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    if (hasTextSelected($target)) {
      return;
    }
    value = $target.val() + digit;
    value = value.replace(/\D/g, '');
    if (value.length > 6) {
      return false;
    }
  };

  restrictCVC = function(e) {
    var $target, digit, val;
    $target = $(e.currentTarget);
    digit = String.fromCharCode(e.which);
    if (!/^\d+$/.test(digit)) {
      return;
    }
    val = $target.val() + digit;
    return val.length <= 4;
  };

  setCardType = function(e) {
    var $target, allTypes, card, cardType, val;
    $target = $(e.currentTarget);
    val = $target.val();
    cardType = $.payment.cardType(val) || 'unknown';
    if (!$target.hasClass(cardType)) {
      allTypes = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = cards.length; _i < _len; _i++) {
          card = cards[_i];
          _results.push(card.type);
        }
        return _results;
      })();
      $target.removeClass('unknown');
      $target.removeClass(allTypes.join(' '));
      $target.addClass(cardType);
      $target.toggleClass('identified', cardType !== 'unknown');
      return $target.trigger('payment.cardType', cardType);
    }
  };

  $.payment.fn.formatCardCVC = function() {
    this.payment('restrictNumeric');
    this.on('keypress', restrictCVC);
    return this;
  };

  $.payment.fn.formatCardExpiry = function() {
    this.payment('restrictNumeric');
    this.on('keypress', restrictExpiry);
    this.on('keypress', formatExpiry);
    this.on('keypress', formatForwardSlash);
    this.on('keypress', formatForwardExpiry);
    this.on('keydown', formatBackExpiry);
    return this;
  };

  $.payment.fn.formatCardNumber = function() {
    this.payment('restrictNumeric');
    this.on('keypress', restrictCardNumber);
    this.on('keypress', formatCardNumber);
    this.on('keydown', formatBackCardNumber);
    this.on('keyup', setCardType);
    this.on('paste', reFormatCardNumber);
    return this;
  };

  $.payment.fn.restrictNumeric = function() {
    this.on('keypress', restrictNumeric);
    return this;
  };

  $.payment.fn.cardExpiryVal = function() {
    return $.payment.cardExpiryVal($(this).val());
  };

  $.payment.cardExpiryVal = function(value) {
    var month, prefix, year, _ref;
    value = value.replace(/\s/g, '');
    _ref = value.split('/', 2), month = _ref[0], year = _ref[1];
    if ((year != null ? year.length : void 0) === 2 && /^\d+$/.test(year)) {
      prefix = (new Date).getFullYear();
      prefix = prefix.toString().slice(0, 2);
      year = prefix + year;
    }
    month = parseInt(month, 10);
    year = parseInt(year, 10);
    return {
      month: month,
      year: year
    };
  };

  $.payment.validateCardNumber = function(num) {
    var card, _ref;
    num = (num + '').replace(/\s+|-/g, '');
    if (!/^\d+$/.test(num)) {
      return false;
    }
    card = cardFromNumber(num);
    if (!card) {
      return false;
    }
    return (_ref = num.length, __indexOf.call(card.length, _ref) >= 0) && (card.luhn === false || luhnCheck(num));
  };

  $.payment.validateCardExpiry = function(month, year) {
    var currentTime, expiry, prefix, _ref;
    if (typeof month === 'object' && 'month' in month) {
      _ref = month, month = _ref.month, year = _ref.year;
    }
    if (!(month && year)) {
      return false;
    }
    month = $.trim(month);
    year = $.trim(year);
    if (!/^\d+$/.test(month)) {
      return false;
    }
    if (!/^\d+$/.test(year)) {
      return false;
    }
    if (!(parseInt(month, 10) <= 12)) {
      return false;
    }
    if (year.length === 2) {
      prefix = (new Date).getFullYear();
      prefix = prefix.toString().slice(0, 2);
      year = prefix + year;
    }
    expiry = new Date(year, month);
    currentTime = new Date;
    expiry.setMonth(expiry.getMonth() - 1);
    expiry.setMonth(expiry.getMonth() + 1, 1);
    return expiry > currentTime;
  };

  $.payment.validateCardCVC = function(cvc, type) {
    var _ref, _ref1;
    cvc = $.trim(cvc);
    if (!/^\d+$/.test(cvc)) {
      return false;
    }
    if (type) {
      return _ref = cvc.length, __indexOf.call((_ref1 = cardFromType(type)) != null ? _ref1.cvcLength : void 0, _ref) >= 0;
    } else {
      return cvc.length >= 3 && cvc.length <= 4;
    }
  };

  $.payment.cardType = function(num) {
    var _ref;
    if (!num) {
      return null;
    }
    return ((_ref = cardFromNumber(num)) != null ? _ref.type : void 0) || null;
  };

  $.payment.formatCardNumber = function(num) {
    var card, groups, upperLength, _ref;
    card = cardFromNumber(num);
    if (!card) {
      return num;
    }
    upperLength = card.length[card.length.length - 1];
    num = num.replace(/\D/g, '');
    num = num.slice(0, +upperLength + 1 || 9e9);
    if (card.format.global) {
      return (_ref = num.match(card.format)) != null ? _ref.join(' ') : void 0;
    } else {
      groups = card.format.exec(num);
      if (groups != null) {
        groups.shift();
      }
      return groups != null ? groups.join(' ') : void 0;
    }
  };

}).call(this);
/*! Sidr - v1.2.1 - 2013-11-06
 * https://github.com/artberri/sidr
 * Copyright (c) 2013 Alberto Varela; Licensed MIT */
(function(e){var t=!1,i=!1,n={isUrl:function(e){var t=RegExp("^(https?:\\/\\/)?((([a-z\\d]([a-z\\d-]*[a-z\\d])*)\\.)+[a-z]{2,}|((\\d{1,3}\\.){3}\\d{1,3}))(\\:\\d+)?(\\/[-a-z\\d%_.~+]*)*(\\?[;&a-z\\d%_.~+=-]*)?(\\#[-a-z\\d_]*)?$","i");return t.test(e)?!0:!1},loadContent:function(e,t){e.html(t)},addPrefix:function(e){var t=e.attr("id"),i=e.attr("class");"string"==typeof t&&""!==t&&e.attr("id",t.replace(/([A-Za-z0-9_.\-]+)/g,"sidr-id-$1")),"string"==typeof i&&""!==i&&"sidr-inner"!==i&&e.attr("class",i.replace(/([A-Za-z0-9_.\-]+)/g,"sidr-class-$1")),e.removeAttr("style")},execute:function(n,s,a){"function"==typeof s?(a=s,s="sidr"):s||(s="sidr");var r,d,l,c=e("#"+s),u=e(c.data("body")),f=e("html"),p=c.outerWidth(!0),g=c.data("speed"),h=c.data("side"),m=c.data("displace"),v=c.data("onOpen"),y=c.data("onClose"),x="sidr"===s?"sidr-open":"sidr-open "+s+"-open";if("open"===n||"toggle"===n&&!c.is(":visible")){if(c.is(":visible")||t)return;if(i!==!1)return o.close(i,function(){o.open(s)}),void 0;t=!0,"left"===h?(r={left:p+"px"},d={left:"0px"}):(r={right:p+"px"},d={right:"0px"}),u.is("body")&&(l=f.scrollTop(),f.css("overflow-x","hidden").scrollTop(l)),m?u.addClass("sidr-animating").css({width:u.width(),position:"absolute"}).animate(r,g,function(){e(this).addClass(x)}):setTimeout(function(){e(this).addClass(x)},g),c.css("display","block").animate(d,g,function(){t=!1,i=s,"function"==typeof a&&a(s),u.removeClass("sidr-animating")}),v()}else{if(!c.is(":visible")||t)return;t=!0,"left"===h?(r={left:0},d={left:"-"+p+"px"}):(r={right:0},d={right:"-"+p+"px"}),u.is("body")&&(l=f.scrollTop(),f.removeAttr("style").scrollTop(l)),u.addClass("sidr-animating").animate(r,g).removeClass(x),c.animate(d,g,function(){c.removeAttr("style").hide(),u.removeAttr("style"),e("html").removeAttr("style"),t=!1,i=!1,"function"==typeof a&&a(s),u.removeClass("sidr-animating")}),y()}}},o={open:function(e,t){n.execute("open",e,t)},close:function(e,t){n.execute("close",e,t)},toggle:function(e,t){n.execute("toggle",e,t)},toogle:function(e,t){n.execute("toggle",e,t)}};e.sidr=function(t){return o[t]?o[t].apply(this,Array.prototype.slice.call(arguments,1)):"function"!=typeof t&&"string"!=typeof t&&t?(e.error("Method "+t+" does not exist on jQuery.sidr"),void 0):o.toggle.apply(this,arguments)},e.fn.sidr=function(t){var i=e.extend({name:"sidr",speed:200,side:"left",source:null,renaming:!0,body:"body",displace:!0,onOpen:function(){},onClose:function(){}},t),s=i.name,a=e("#"+s);if(0===a.length&&(a=e("<div />").attr("id",s).appendTo(e("body"))),a.addClass("sidr").addClass(i.side).data({speed:i.speed,side:i.side,body:i.body,displace:i.displace,onOpen:i.onOpen,onClose:i.onClose}),"function"==typeof i.source){var r=i.source(s);n.loadContent(a,r)}else if("string"==typeof i.source&&n.isUrl(i.source))e.get(i.source,function(e){n.loadContent(a,e)});else if("string"==typeof i.source){var d="",l=i.source.split(",");if(e.each(l,function(t,i){d+='<div class="sidr-inner">'+e(i).html()+"</div>"}),i.renaming){var c=e("<div />").html(d);c.find("*").each(function(t,i){var o=e(i);n.addPrefix(o)}),d=c.html()}n.loadContent(a,d)}else null!==i.source&&e.error("Invalid Sidr Source");return this.each(function(){var t=e(this),i=t.data("sidr");i||(t.data("sidr",s),"ontouchstart"in document.documentElement?(t.bind("touchstart",function(e){e.originalEvent.touches[0],this.touched=e.timeStamp}),t.bind("touchend",function(e){var t=Math.abs(e.timeStamp-this.touched);200>t&&(e.preventDefault(),o.toggle(s))})):t.click(function(e){e.preventDefault(),o.toggle(s)}))})}})(jQuery);
!function(a,b){var c=b(a,a.document);a.lazySizes=c,"object"==typeof module&&module.exports&&(module.exports=c)}(window,function(a,b){"use strict";if(b.getElementsByClassName){var c,d=b.documentElement,e=a.Date,f=a.HTMLPictureElement,g="addEventListener",h="getAttribute",i=a[g],j=a.setTimeout,k=a.requestAnimationFrame||j,l=a.requestIdleCallback,m=/^picture$/i,n=["load","error","lazyincluded","_lazyloaded"],o={},p=Array.prototype.forEach,q=function(a,b){return o[b]||(o[b]=new RegExp("(\\s|^)"+b+"(\\s|$)")),o[b].test(a[h]("class")||"")&&o[b]},r=function(a,b){q(a,b)||a.setAttribute("class",(a[h]("class")||"").trim()+" "+b)},s=function(a,b){var c;(c=q(a,b))&&a.setAttribute("class",(a[h]("class")||"").replace(c," "))},t=function(a,b,c){var d=c?g:"removeEventListener";c&&t(a,b),n.forEach(function(c){a[d](c,b)})},u=function(a,c,d,e,f){var g=b.createEvent("CustomEvent");return g.initCustomEvent(c,!e,!f,d||{}),a.dispatchEvent(g),g},v=function(b,d){var e;!f&&(e=a.picturefill||c.pf)?e({reevaluate:!0,elements:[b]}):d&&d.src&&(b.src=d.src)},w=function(a,b){return(getComputedStyle(a,null)||{})[b]},x=function(a,b,d){for(d=d||a.offsetWidth;d<c.minSize&&b&&!a._lazysizesWidth;)d=b.offsetWidth,b=b.parentNode;return d},y=function(){var a,c,d=[],e=[],f=function(){var b=d;for(d=e,a=!0,c=!1;b.length;)b.shift()();a=!1},g=function(e,g){a&&!g?e.apply(this,arguments):(d.push(e),c||(c=!0,(b.hidden?j:k)(f)))};return g._lsFlush=f,g}(),z=function(a,b){return b?function(){y(a)}:function(){var b=this,c=arguments;y(function(){a.apply(b,c)})}},A=function(a){var b,c=0,d=125,f=666,g=f,h=function(){b=!1,c=e.now(),a()},i=l?function(){l(h,{timeout:g}),g!==f&&(g=f)}:z(function(){j(h)},!0);return function(a){var f;(a=a===!0)&&(g=44),b||(b=!0,f=d-(e.now()-c),0>f&&(f=0),a||9>f&&l?i():j(i,f))}},B=function(a){var b,c,d=99,f=function(){b=null,a()},g=function(){var a=e.now()-c;d>a?j(g,d-a):(l||f)(f)};return function(){c=e.now(),b||(b=j(g,d))}},C=function(){var f,k,l,n,o,x,C,E,F,G,H,I,J,K,L,M=/^img$/i,N=/^iframe$/i,O="onscroll"in a&&!/glebot/.test(navigator.userAgent),P=0,Q=0,R=0,S=-1,T=function(a){R--,a&&a.target&&t(a.target,T),(!a||0>R||!a.target)&&(R=0)},U=function(a,c){var e,f=a,g="hidden"==w(b.body,"visibility")||"hidden"!=w(a,"visibility");for(F-=c,I+=c,G-=c,H+=c;g&&(f=f.offsetParent)&&f!=b.body&&f!=d;)g=(w(f,"opacity")||1)>0,g&&"visible"!=w(f,"overflow")&&(e=f.getBoundingClientRect(),g=H>e.left&&G<e.right&&I>e.top-1&&F<e.bottom+1);return g},V=function(){var a,e,g,i,j,m,n,p,q;if((o=c.loadMode)&&8>R&&(a=f.length)){e=0,S++,null==K&&("expand"in c||(c.expand=d.clientHeight>500&&d.clientWidth>500?500:370),J=c.expand,K=J*c.expFactor),K>Q&&1>R&&S>2&&o>2&&!b.hidden?(Q=K,S=0):Q=o>1&&S>1&&6>R?J:P;for(;a>e;e++)if(f[e]&&!f[e]._lazyRace)if(O)if((p=f[e][h]("data-expand"))&&(m=1*p)||(m=Q),q!==m&&(C=innerWidth+m*L,E=innerHeight+m,n=-1*m,q=m),g=f[e].getBoundingClientRect(),(I=g.bottom)>=n&&(F=g.top)<=E&&(H=g.right)>=n*L&&(G=g.left)<=C&&(I||H||G||F)&&(l&&3>R&&!p&&(3>o||4>S)||U(f[e],m))){if(ba(f[e]),j=!0,R>9)break}else!j&&l&&!i&&4>R&&4>S&&o>2&&(k[0]||c.preloadAfterLoad)&&(k[0]||!p&&(I||H||G||F||"auto"!=f[e][h](c.sizesAttr)))&&(i=k[0]||f[e]);else ba(f[e]);i&&!j&&ba(i)}},W=A(V),X=function(a){r(a.target,c.loadedClass),s(a.target,c.loadingClass),t(a.target,Z)},Y=z(X),Z=function(a){Y({target:a.target})},$=function(a,b){try{a.contentWindow.location.replace(b)}catch(c){a.src=b}},_=function(a){var b,d,e=a[h](c.srcsetAttr);(b=c.customMedia[a[h]("data-media")||a[h]("media")])&&a.setAttribute("media",b),e&&a.setAttribute("srcset",e),b&&(d=a.parentNode,d.insertBefore(a.cloneNode(),a),d.removeChild(a))},aa=z(function(a,b,d,e,f){var g,i,k,l,o,q;(o=u(a,"lazybeforeunveil",b)).defaultPrevented||(e&&(d?r(a,c.autosizesClass):a.setAttribute("sizes",e)),i=a[h](c.srcsetAttr),g=a[h](c.srcAttr),f&&(k=a.parentNode,l=k&&m.test(k.nodeName||"")),q=b.firesLoad||"src"in a&&(i||g||l),o={target:a},q&&(t(a,T,!0),clearTimeout(n),n=j(T,2500),r(a,c.loadingClass),t(a,Z,!0)),l&&p.call(k.getElementsByTagName("source"),_),i?a.setAttribute("srcset",i):g&&!l&&(N.test(a.nodeName)?$(a,g):a.src=g),(i||l)&&v(a,{src:g})),a._lazyRace&&delete a._lazyRace,s(a,c.lazyClass),y(function(){(!q||a.complete)&&(q?T(o):R--,X(o))},!0)}),ba=function(a){var b,d=M.test(a.nodeName),e=d&&(a[h](c.sizesAttr)||a[h]("sizes")),f="auto"==e;(!f&&l||!d||!a.src&&!a.srcset||a.complete||q(a,c.errorClass))&&(b=u(a,"lazyunveilread").detail,f&&D.updateElem(a,!0,a.offsetWidth),a._lazyRace=!0,R++,aa(a,b,f,e,d))},ca=function(){if(!l){if(e.now()-x<999)return void j(ca,999);var a=B(function(){c.loadMode=3,W()});l=!0,c.loadMode=3,W(),i("scroll",function(){3==c.loadMode&&(c.loadMode=2),a()},!0)}};return{_:function(){x=e.now(),f=b.getElementsByClassName(c.lazyClass),k=b.getElementsByClassName(c.lazyClass+" "+c.preloadClass),L=c.hFac,i("scroll",W,!0),i("resize",W,!0),a.MutationObserver?new MutationObserver(W).observe(d,{childList:!0,subtree:!0,attributes:!0}):(d[g]("DOMNodeInserted",W,!0),d[g]("DOMAttrModified",W,!0),setInterval(W,999)),i("hashchange",W,!0),["focus","mouseover","click","load","transitionend","animationend","webkitAnimationEnd"].forEach(function(a){b[g](a,W,!0)}),/d$|^c/.test(b.readyState)?ca():(i("load",ca),b[g]("DOMContentLoaded",W),j(ca,2e4)),f.length?(V(),y._lsFlush()):W()},checkElems:W,unveil:ba}}(),D=function(){var a,d=z(function(a,b,c,d){var e,f,g;if(a._lazysizesWidth=d,d+="px",a.setAttribute("sizes",d),m.test(b.nodeName||""))for(e=b.getElementsByTagName("source"),f=0,g=e.length;g>f;f++)e[f].setAttribute("sizes",d);c.detail.dataAttr||v(a,c.detail)}),e=function(a,b,c){var e,f=a.parentNode;f&&(c=x(a,f,c),e=u(a,"lazybeforesizes",{width:c,dataAttr:!!b}),e.defaultPrevented||(c=e.detail.width,c&&c!==a._lazysizesWidth&&d(a,f,e,c)))},f=function(){var b,c=a.length;if(c)for(b=0;c>b;b++)e(a[b])},g=B(f);return{_:function(){a=b.getElementsByClassName(c.autosizesClass),i("resize",g)},checkElems:g,updateElem:e}}(),E=function(){E.i||(E.i=!0,D._(),C._())};return function(){var b,d={lazyClass:"lazyload",loadedClass:"lazyloaded",loadingClass:"lazyloading",preloadClass:"lazypreload",errorClass:"lazyerror",autosizesClass:"lazyautosizes",srcAttr:"data-src",srcsetAttr:"data-srcset",sizesAttr:"data-sizes",minSize:40,customMedia:{},init:!0,expFactor:1.5,hFac:.8,loadMode:2};c=a.lazySizesConfig||a.lazysizesConfig||{};for(b in d)b in c||(c[b]=d[b]);a.lazySizesConfig=c,j(function(){c.init&&E()})}(),{cfg:c,autoSizer:D,loader:C,init:E,uP:v,aC:r,rC:s,hC:q,fire:u,gW:x,rAF:y}}});