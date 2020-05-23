'use strict';

var Sys = require("../../lib/js/sys.js");

var match;

switch (Sys.os_type) do
  case "Cygwin" :
  case "Unix" :
      match = --[ tuple ]--[
        1,
        2
      ];
      break;
  default:
    match = --[ tuple ]--[
      3,
      4
    ];
end

var a = match[0];

var b = match[1];

exports.a = a;
exports.b = b;
--[ match Not a pure module ]--
