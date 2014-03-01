// Generated by CoffeeScript 1.3.3

/*
User: matteo
Copyright © mename 2013 All rights reserved
GameManager
*/


(function() {
  var GameManager, root,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __slice = [].slice;

  GameManager = (function() {

    GameManager.instance = null;

    GameManager.config = null;

    GameManager.DEBUG = false;

    function GameManager() {
      this.update = __bind(this.update, this);
      this.gameModes = new Array();
      GameManager.instance = this;
      GameManager.instance.pushGameMode(new MainMode());
      requestAnimFrame(this.update);
    }

    GameManager.prototype.pushGameMode = function(gameMode) {
      if (this.gameModes.length > 0) {
        this.gameModes[this.gameModes.length - 1].cleanUp();
      }
      gameMode.setUp();
      return this.gameModes.push(gameMode);
    };

    GameManager.prototype.popGameMode = function() {
      var gameMode;
      if (this.gameModes.length > 0) {
        gameMode = this.gameModes.pop();
        if (gameMode != null) {
          gameMode.cleanUp();
        }
      }
      if (this.gameModes.length > 0) {
        return this.gameModes[this.gameModes.length - 1].setUp();
      }
    };

    GameManager.prototype.update = function(time) {
      requestAnimFrame(this.update);
      if (this.gameModes.length > 0) {
        return this.gameModes[this.gameModes.length - 1].update(time);
      }
    };

    GameManager.instantiate = function() {
      var className, classType, params, root;
      className = arguments[0], params = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      root = typeof exports !== "undefined" && exports !== null ? exports : window;
      classType = root[className];
      return (function(func, args, ctor) {
        ctor.prototype = func.prototype;
        var child = new ctor, result = func.apply(child, args), t = typeof result;
        return t == "object" || t == "function" ? result || child : child;
      })(classType, params, function(){});
    };

    return GameManager;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.GameManager = GameManager;

}).call(this);
