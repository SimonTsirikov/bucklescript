'use strict';

Caml_primitive = require("../../lib/js/caml_primitive.lua");

f = Caml_primitive.caml_int_compare;

exports.f = f;
--[[ No side effect ]]
