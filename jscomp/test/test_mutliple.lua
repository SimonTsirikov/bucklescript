console = {log = print};

List = require "../../lib/js/list";

f = List.length(--[[ [] ]]0);

exports = {}
exports.f = f;
--[[ f Not a pure module ]]
