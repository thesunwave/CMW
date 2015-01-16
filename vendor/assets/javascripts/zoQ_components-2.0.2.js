(function() {
  "use strict";
  var z_, zoQ;

  zoQ = zoQ || {};

  this.zoQ = zoQ;

  z_ = z_ || {};

  this.z_ = z_;

}).call(this);

(function() {
  var $body, disabledElements, hoverOff, unLoadHolder;

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

  hoverOff = function() {
    var timer;
    timer = 0;
    $(window).on("scroll", function() {
      clearTimeout(timer);
      if (!$body.hasClass("hoverOff")) {
        $body.addClass("hoverOff");
      }
      timer = setTimeout(function() {
        $body.removeClass("hoverOff");
      }, 500);
    });
  };

  unLoadHolder = function() {
    return $body.removeClass("unloaded");
  };

  disabledElements = function() {
    return $(".disabled").on("click", function(event) {
      return event.preventDefault();
    });
  };

  hoverOff();

  unLoadHolder();

  disabledElements();

}).call(this);

(function() {
  "use strict";
  zoQ.Ajax = (function() {
    var $body, self, _changeSymbol, _setTitle;

    $body = $("body");

    self = Ajax;

    function Ajax(params) {
      if (params == null) {
        params = {};
      }
      self.container = $(params.container);
      $body.on("click", "a", function(event) {
        var href;
        event.preventDefault();
        $(this).addClass("unloaded");
        href = this.href;
        self.prototype.setPage({
          url: href,
          callback: params.callback
        });
        history.pushState("", "New URL: " + href, href);
      });
      window.onpopstate = function() {
        self.prototype.setPage({
          url: location.pathname
        });
      };
    }

    Ajax.prototype.setPage = function(params) {
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
          $body.removeClass("unloaded");
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
      $title = self.container.find("#title");
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
        wrap: params.wrap || $(".alertsWrap"),
        type: params.type || "info",
        addClass: params.addClass || "",
        timeout: params.timeout || 30000,
        message: params.message || "",
        onAdd: params.onAdd || function() {},
        onRemove: params.onRemove || function() {}
      };
      close = {
        target: params.closeTarget || ".close",
        text: params.closeText || "",
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
      $alert = $("<div class=\"alert " + alert.addClass + " " + alert.type + "\"><div class=\"message\">" + alert.message + "</div><div class=\"close " + close.addClass + "\">" + close.text + "</div></div>");
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
        wrap: params.wrap || $(".popupsWrap"),
        addClass: params.addClass || "",
        title: params.title || "",
        content: params.content || "",
        footer: params.footer || '<div class="button removePopup">Закрыть</div>',
        callback: params.callback || function() {}
      };
      _clickRemove(_add(popup));
    };

    Popups.prototype.remove = function($popup) {
      $body.removeClass("noScroll");
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
      $body.addClass("noScroll");
      $popupView = $("<div class=\"overlay\"><div class=\"popup unnessesary " + $popup.addClass + "\"><div class=\"header\">" + $popup.title + "</div><div class=\"content\"><div class=\"popupAlert\"></div>" + $popup.content + "</div><div class=\"footer\">" + $popup.footer + "</div></div></div>");
      $popup.wrap.append($popupView);
      self.popup = $popupView;
      if ($popup.callback && typeof $popup.callback === "function") {
        $popup.callback();
      }
      return $popupView;
    };

    _clickRemove = function($popup) {
      return $popup.on("click", ".removePopup", function() {
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

    Core.version = "2.0.2";

    self = Core;

    function Core(params) {
      var Ajax, Alerts, Popups;
      if (params == null) {
        params = {};
      }
      Alerts = params.Alerts || true;
      Popups = params.Popups || true;
      Ajax = {
        enable: params.AjaxEnable || true,
        container: params.AjaxContainer || "body",
        callback: {
          done: params.AjaxDone || function() {},
          fail: params.AjaxFail || function() {},
          always: params.AjaxAlways || function() {},
          start: params.AjaxStart || function() {},
          end: params.AjaxEnd || function() {}
        }
      };
      _components(Alerts, Popups, Ajax);
      _greeting();
    }

    _components = function(Alerts, Popups, Ajax) {
      if (Alerts) {
        Alerts = new zoQ.Alerts();
        z_.alert = function(params) {
          Alerts.add(params);
        };
        z_.alert_last = function() {
          return Alerts.getLastAlert();
        };
        z_.alert_remove = function(alert, onRemove) {
          Alerts.remove(alert, onRemove);
        };
      }
      if (Popups) {
        Popups = new zoQ.Popups();
        z_.popup = function(params) {
          Popups.add(params);
        };
        z_.popup_last = function() {
          return Popups.getLastPopup();
        };
        z_.popup_remove = function(popup) {
          Popups.remove(popup);
        };
      }
      if (Ajax.enable) {
        Ajax = new zoQ.Ajax({
          container: Ajax.container,
          callback: Ajax.callback
        });
        z_.ajax_setPage = function(url, callback) {
          Ajax.setPage({
            url: url,
            callback: callback
          });
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
