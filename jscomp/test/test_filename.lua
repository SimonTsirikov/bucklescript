console = {log = print};

List = require "../../lib/js/list";
Filename = require "../../lib/js/filename";

u = Filename.chop_extension;

v = List.length;

exports = {}
exports.u = u;
exports.v = v;
--[[ Filename Not a pure module ]]
