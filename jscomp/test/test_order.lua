--[['use strict';]]

Caml_primitive = require "../../lib/js/caml_primitive.lua";

compare = Caml_primitive.caml_int_compare;

exports.compare = compare;
--[[ No side effect ]]
