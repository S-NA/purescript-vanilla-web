"use strict";

exports.textContent_ = function(node) {
    var cont = node.textContent;
    if (cont == null) {
        return "";
    } else {
        return cont;
    }
}
exports.childNodes = function(node) {
    return function() {
        return node.childNodes;
    }
}
exports.appendChild_ = function(p, c) {
    return p.appendChild(c);
}

exports.nodeListLength_ = function(pure, list) {
    return pure(list.length);
}
exports.nodeListItem_ = function(pure, index, list) {
    if (index < 0 || index >= list.length) {
        throw new ReferenceError("Accessing NodeList item out of bounds");
    }
    return pure(list.item(index));
}
exports.traverseNodeList_ = function(ret, func, list) {
    for (var i = 0; i < list.length; ++i) {
        func(list[i]);
    }
    return ret;
}

exports.querySelector_ = function(q, node) {
    return node.querySelector(q);
}
exports.querySelectorAll_ = function(q, node) {
    return node.querySelectorAll(q);
}
