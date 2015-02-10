(function() {
  "use strict";
  var z_, zoQ;

  zoQ = zoQ || {};

  this.zoQ = zoQ;

  z_ = z_ || {};

  this.z_ = z_;

}).call(this);

(function() {
  var $body, awaiter, disabledElements, hover;

  $.extend({
    hook: function(hookName) {
      var selector;
      if (!hookName || hookName === "*") {
        selector = "[data-hook]";
      } else {
        selector = "[data-hook~=\"" + hookName + "\"]";
      }
      return $(selector);
    }
  });

  $body = $("body");

  hover = function() {
    var timer;
    timer = 0;
    $(window).on("scroll", function() {
      clearTimeout(timer);
      if (!$body.hasClass("z-hover_no")) {
        $body.addClass("z-hover_yes");
      }
      timer = setTimeout(function() {
        $body.removeClass("z-hover_no");
      }, 500);
    });
  };

  awaiter = function() {
    $body.removeClass("z-unloaded");
  };

  disabledElements = function() {
    $(".g-disabled, .z-disabled").on("click", function(event) {
      event.preventDefault();
    });
  };

  hover();

  awaiter();

  disabledElements();

}).call(this);

(function() {
  "use strict";
  zoQ.Ajax = (function() {
    var $body, self, _callPage, _changeSymbol, _setTitle;

    $body = $("body");

    self = Ajax;

    function Ajax(params) {
      if (params == null) {
        params = {};
      }
      self.container = $(params.container);
      $body.on("click", "a", function(event) {
        event.preventDefault();
        self.prototype.setPage({
          link: $(this),
          callback: params.callback
        });
        self.prototype.history(this.href);
      });
      window.onpopstate = function() {
        self.prototype.setPage({
          url: location.pathname
        });
      };
    }

    Ajax.prototype.setPage = function(params) {
      var href;
      if (params == null) {
        params = {};
      }
      $body.addClass("z-unloaded");
      href = params.link ? params.link.attr("href") : params.url;
      _callPage({
        url: href,
        callback: params.callback
      });
    };

    Ajax.prototype.history = function(url) {
      return history.pushState("", "New URL: " + url, url);
    };

    _callPage = function(params) {
      if (params == null) {
        params = {};
      }
      if (params.url.indexOf(document.domain) > -1 || params.url.indexOf(":") === -1) {
        if (params.callback && params.callback.start && typeof params.callback.start === "function") {
          params.callback.start();
        }
        params.url = _changeSymbol(params.url);
        $.ajax({
          url: params.url,
          type: "GET"
        }).done(function(data) {
          if (params.callback && params.callback.done && typeof params.callback.done === "function") {
            params.callback.done();
          }
          self.container.html(data);
          _setTitle();
        }).fail(function() {
          if (params.callback && params.callback.fail && typeof params.callback.fail === "function") {
            params.callback.fail();
          }
        }).always(function() {
          $body.removeClass("z-unloaded");
          if (params.callback && params.callback.always && typeof params.callback.always === "function") {
            params.callback.always();
          }
          if (params.callback && params.callback.end && typeof params.callback.end === "function") {
            params.callback.end();
          }
        });
      } else {
        window.location.href = params.url;
      }
    };

    _changeSymbol = function(url) {
      if (url.indexOf("?") + 1) {
        return url = "" + url + "&ajax";
      } else {
        return url = "" + url + "?ajax";
      }
    };

    _setTitle = function() {
      var $title;
      $title = self.container.find("#z-title");
      if ($title.length) {
        document.title = unescape($title.val().trim());
      }
    };

    return Ajax;

  })();

}).call(this);

(function() {
  "use strict";
  zoQ.Alerts = (function() {
    var alert, self, _add, _clickRemove, _timeoutRemove;

    function Alerts() {}

    alert = false;

    self = Alerts;

    Alerts.prototype.add = function(params) {
      var $alert, close;
      if (params == null) {
        params = {};
      }
      alert = {
        wrap: params.wrap || $(".z-actions__alerts"),
        type: "z-alert_" + params.type || "z-alert_info",
        addClass: params.addClass || "",
        timeout: params.timeout || 30000,
        message: params.message || "",
        onAdd: params.onAdd || function() {},
        onRemove: params.onRemove || function() {}
      };
      close = {
        target: params.closeTarget || ".z-alert__close",
        addClass: params.closeAddClass || ""
      };
      $alert = _add(alert, close);
      _timeoutRemove($alert, alert.timeout, alert.onRemove);
      _clickRemove($alert, close.target, alert.onRemove);
      if (alert.onAdd && typeof alert.onAdd === "function") {
        alert.onAdd();
      }
    };

    Alerts.prototype.remove = function($alert, onRemove) {
      if (onRemove == null) {
        onRemove = function() {};
      }
      $alert.stop().fadeOut(function() {
        if (onRemove && typeof onRemove === "function") {
          onRemove();
        }
        $alert.remove();
      });
    };

    Alerts.prototype.getLastAlert = function() {
      if (self.alert) {
        return self.alert;
      } else {
        return false;
      }
    };

    _add = function(alert, close) {
      var $alert;
      $alert = $("<div class=\"z-alert " + alert.addClass + " " + alert.type + "\"><div class=\"z-alert__message\">" + alert.message + "</div><div class=\"z-alert__close " + close.addClass + "\"></div></div>");
      alert.wrap.append($alert);
      self.alert = $alert;
      return $alert;
    };

    _timeoutRemove = function($alert, timeout, onRemove) {
      if (timeout) {
        setTimeout(function() {
          self.prototype.remove($alert, onRemove);
        }, timeout);
      }
    };

    _clickRemove = function($alert, target, onRemove) {
      $alert.on("click", target, function() {
        self.prototype.remove($alert, onRemove);
      });
    };

    return Alerts;

  })();

}).call(this);

(function() {
  "use strict";
  zoQ.Popups = (function() {
    var $body, popup, self, _add, _clickRemove;

    function Popups() {}

    $body = $("body");

    popup = false;

    self = Popups;

    Popups.prototype.add = function(params) {
      if (params == null) {
        params = {};
      }
      popup = {
        wrap: params.wrap || $(".z-actions__popups"),
        addClass: params.addClass || "",
        title: params.title || "",
        content: params.content || "",
        footer: params.footer || '<div class="z-button z-popup__remove">Закрыть</div>',
        callback: params.callback || function() {}
      };
      _clickRemove(_add(popup));
    };

    Popups.prototype.remove = function($popup) {
      $popup.stop().fadeOut(function() {
        $popup.remove();
      });
    };

    Popups.prototype.getLastPopup = function() {
      if (self.popup) {
        return self.popup;
      } else {
        return false;
      }
    };

    _add = function($popup) {
      var $popupView;
      $popupView = $("<div class=\"z-overlay\"><div class=\"z-popup " + $popup.addClass + "\"><div class=\"z-popup__header\">" + $popup.title + "</div><div class=\"z-popup__content\"><div class=\"z-popup__alert\"></div>" + $popup.content + "</div><div class=\"z-popup__footer\">" + $popup.footer + "</div></div></div>");
      $popup.wrap.append($popupView);
      self.popup = $popupView;
      if ($popup.callback && typeof $popup.callback === "function") {
        $popup.callback();
      }
      return $popupView;
    };

    _clickRemove = function($popup) {
      return $popup.on("click", ".z-popup__remove", function() {
        return self.prototype.remove($popup);
      });
    };

    return Popups;

  })();

}).call(this);

(function() {
  "use strict";
  zoQ.Core = (function() {
    var self, _components, _greeting;

    Core.version = "2.1.1";

    self = Core;

    function Core(params) {
      if (params == null) {
        params = {};
      }
      params.Alerts = params.Alerts !== "" ? params.Alerts : true;
      params.Popups = params.Popups !== "" ? params.Popups : true;
      if(params.Ajax){
      params.Ajax.enable = params.Ajax.enable !== "" ? params.Ajax.enable : true;
      params.Ajax.container = params.Ajax.container !== "" ? params.Ajax.container : "body";
      params.Ajax.callback.done = params.Ajax.callback.done !== "" ? params.Ajax.callback.done : function() {};
      params.Ajax.callback.fail = params.Ajax.callback.fail !== "" ? params.Ajax.callback.fail : function() {};
      params.Ajax.callback.always = params.Ajax.callback.always !== "" ? params.Ajax.callback.always : function() {};
      params.Ajax.callback.start = params.Ajax.callback.start !== "" ? params.Ajax.callback.start : function() {};
      params.Ajax.callback.end = params.Ajax.callback.end !== "" ? params.Ajax.callback.end : function() {};
    }
      _components(params);
      _greeting();
    }

    _components = function(params) {
      var Ajax, Alerts, Popups;
      if (params.Alerts) {
        Alerts = new zoQ.Alerts();
        z_.alert = function(alert) {
          Alerts.add(alert);
        };
        z_.alert_last = function() {
          return Alerts.getLastAlert();
        };
        z_.alert_remove = function(alert, onRemove) {
          Alerts.remove(alert, onRemove);
        };
      }
      if (params.Popups) {
        Popups = new zoQ.Popups();
        z_.popup = function(popup) {
          Popups.add(popup);
        };
        z_.popup_last = function() {
          return Popups.getLastPopup();
        };
        z_.popup_remove = function(popup) {
          Popups.remove(popup);
        };
      }
      if (params.Ajax && params.Ajax.enable) {
        Ajax = new zoQ.Ajax({
          container: params.Ajax.container,
          callback: params.Ajax.callback
        });
        z_.ajax_setPage = function(ajaxParams) {
          Ajax.setPage(ajaxParams);
          Ajax.history(ajaxParams.url);
        };
      }
    };

    _greeting = function() {
      var greeting;
      greeting = " zoQ_components v. " + self.version + " ";
      if (/chrome|firefox/i.test(navigator.userAgent.toLowerCase())) {
        return console.log("%c zoQ_components v. " + self.version + " ", ["background: #ff8400", "color: #fff"].join(";"));
      } else {
        return console.log(greeting);
      }
    };

    return Core;

  })();

}).call(this);

(function() {
  "use strict";
  zoQ.Init = (function() {
    function Init(params) {
      new zoQ.Core(params);
      FastClick.attach(document.body);
    }

    return Init;

  })();

}).call(this);
