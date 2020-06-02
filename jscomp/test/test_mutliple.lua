--[['use strict';]]

List = require "../../lib/js/list.lua";

f = List.length(--[[ [] ]]0);

exports.f = f;
--[[ f Not a pure module ]]
