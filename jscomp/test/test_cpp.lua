--[['use strict';]]

Caml_primitive = require "../../lib/js/caml_primitive";

f = Caml_primitive.caml_int_compare;

exports.f = f;
--[[ No side effect ]]
