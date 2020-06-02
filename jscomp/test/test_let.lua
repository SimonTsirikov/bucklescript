console = {log = print};

Pervasives = require "../../lib/js/pervasives";

Pervasives.print_int(3);

b = 3;

exports = {}
exports.b = b;
--[[  Not a pure module ]]
