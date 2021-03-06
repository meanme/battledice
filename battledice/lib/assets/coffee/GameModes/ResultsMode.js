// Generated by CoffeeScript 1.3.3

/*
User: mmarinucci
Copyright © mename 2014 All rights reserved
ResultsMode
*/


(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['./../Core/GameMode'], function() {
    var ResultsMode, root;
    ResultsMode = (function(_super) {

      __extends(ResultsMode, _super);

      function ResultsMode() {
        this.update = __bind(this.update, this);
        ResultsMode.__super__.constructor.apply(this, arguments);
      }

      ResultsMode.prototype.setUp = function() {
        ResultsMode.__super__.setUp.call(this);
        $("#results-mode").css('display', 'block');
        return $('#resultBtn').click(function() {
          return GameManager.instance.popGameMode();
        });
      };

      ResultsMode.prototype.cleanUp = function() {
        $("#results-mode").css('display', 'none');
        $('#resultBtn').unbind();
        return ResultsMode.__super__.cleanUp.call(this);
      };

      ResultsMode.prototype.init = function(results) {
        var result, _i, _len, _results;
        $("#matchSummary").empty();
        _results = [];
        for (_i = 0, _len = results.length; _i < _len; _i++) {
          result = results[_i];
          _results.push(this.setupResultDom(result));
        }
        return _results;
      };

      ResultsMode.prototype.setupResultDom = function(result) {
        var hero0, hero1, resultItem;
        resultItem = $('<div></div>').addClass('roundSummary');
        hero0 = $('<div></div>').addClass('hero0');
        hero0.append($('<img/>', {
          src: result.currentHero
        }).addClass('heroPic'));
        hero0.append($('<div></div>').addClass('diceSummary').text(result.currentRoll));
        hero0.append($('<div></div>').addClass('totalDamage').text(result.currentDmg));
        hero1 = $('<div></div>').addClass('hero1');
        hero1.append($('<img/>', {
          src: result.opponentHero
        }).addClass('heroPic'));
        hero1.append($('<div></div>').addClass('diceSummary').text(result.opponentRoll));
        hero1.append($('<div></div>').addClass('totalDamage').text(result.opponentDmg));
        resultItem.append(hero0);
        resultItem.append(hero1);
        resultItem.append($('<div></div>').addClass('outcome').text(result.outcome));
        return $("#matchSummary").append(resultItem);
      };

      ResultsMode.prototype.update = function(time) {};

      return ResultsMode;

    })(GameMode);
    root = typeof exports !== "undefined" && exports !== null ? exports : window;
    return root.ResultsMode = ResultsMode;
  });

}).call(this);
