"use strict";

exports.window = window;

exports.setCustomAttribute_ = function(name, val) {
    window[name] = val;
}
exports.getCustomAttribute_ = function(name, val) {
    if (window[name] == null || window[name] == undefined) {
        return val
    } else {
        return window[name];
    }
}
