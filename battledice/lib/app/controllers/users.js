// Generated by CoffeeScript 1.3.3
(function() {
  var Player, User, mongoose, _;

  mongoose = require('mongoose');

  _ = require('underscore');

  User = mongoose.model('User');

  Player = mongoose.model('Player');

  exports.login = function(req, res) {
    res.render('users/login', {
      title: 'Login',
      message: req.flash('error')
    });
  };

  exports.logout = function(req, res) {
    req.logout();
    res.redirect('/');
  };

  exports.index = function(req, res) {
    console.log('index');
    return User.list(function(err, users) {
      res.render('users/index', {
        users: users,
        message: req.flash('notice')
      });
    });
  };

  exports["new"] = function(req, res) {
    res.render('users/new', {
      user: new User({})
    });
  };

  exports.create = function(req, res) {
    var user;
    user = new User(req.body);
    user.provider = 'local';
    return user.save(function(err) {
      var errorJson, errorKey, k, player, v, _ref;
      if (err) {
        console.log('error');
        _ref = err.errors;
        for (errorKey in _ref) {
          errorJson = _ref[errorKey];
          console.log(errorJson);
        }
        res.render('users/new', {
          errors: (function() {
            var _ref1, _results;
            _ref1 = err.errors;
            _results = [];
            for (k in _ref1) {
              v = _ref1[k];
              _results.push(v.message);
            }
            return _results;
          })(),
          user: user
        });
      } else {
        player = new Player({
          username: user.username
        });
        player.initialize();
        player.save(function(err) {});
        res.redirect('/users');
      }
    });
  };

  exports.user = function(req, res, next, id) {
    User.findById(id).exec(function(err, user) {
      if (err) {
        return next(err);
      }
      if (!user) {
        return next(new Error('Failed to load user'));
      }
      req.profile = user;
      next();
    });
  };

  exports.edit = function(req, res) {
    res.render('users/edit', {
      user: req.profile
    });
  };

  exports.update = function(req, res) {
    var user;
    user = req.profile;
    user.name = req.body.name;
    user.username = req.body.username;
    user.email = req.body.email;
    if (req.body.password) {
      user.password = req.body.password;
    }
    user.save(function(err) {
      if (err) {
        console.log(err);
        res.render('users/edit', {
          user: user,
          errors: err.errors
        });
      } else {
        req.flash('notice', 'User was successfully updated');
        res.redirect('/users');
      }
    });
  };

  exports.destroy = function(req, res) {
    var user;
    user = req.profile;
    user.remove(function(err) {
      req.flash('notice', 'User ' + user.name + ' was successfully deleted.');
      return res.redirect('/users');
    });
  };

}).call(this);