__console = {log = print};

Curry = require "......lib.js.curry";

function g(x) do
  return Curry._1(x[1], x);
end end

loop = g(--[[ A ]]{g});

x = --[[ A ]]{g};

non_terminate = g(x);

exports = {};
exports.loop = loop;
exports.non_terminate = non_terminate;
return exports;
--[[ loop Not a pure module ]]
