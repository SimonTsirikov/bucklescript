--[['use strict';]]

Nightmare = require "nightmare";

v = Nightmare(do
      show: true
    end);

exports.v = v;
--[[ v Not a pure module ]]
