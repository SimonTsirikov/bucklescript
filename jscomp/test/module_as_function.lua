--[['use strict';]]

Nightmare = require "night";

v = Nightmare(do
      show: true
    end);

exports.v = v;
--[[ v Not a pure module ]]
