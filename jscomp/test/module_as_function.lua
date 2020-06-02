console = {log = print};

Nightmare = require "night";

v = Nightmare(do
      show: true
    end);

exports = {}
exports.v = v;
--[[ v Not a pure module ]]
