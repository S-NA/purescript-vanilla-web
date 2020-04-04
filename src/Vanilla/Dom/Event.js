"use strict";

exports.eventTarget = function(e) {
    return e.target;
}

exports.addEventListener_ = function(eventType, cb, target) {
    target.addEventListener(eventType, cb);
}
exports.removeEventListener_ = function(eventType, cb, target) {
    target.removeEventListener(eventType, cb);
}
exports.dispatchEvent_ = function(eventType, target) {
    return target.dispatchEvent(eventType, cb);
}
