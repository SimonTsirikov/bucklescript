--[['use strict';]]

Caml_exceptions = require "../../lib/js/caml_exceptions";

Custom_inline = Caml_exceptions.create("Test_literal.Custom_inline");

v = {
  Custom_inline,
  1,
  2
};

vv = {
  1,
  2,
  3
};

long_v = {
  1,
  2,
  3,
  4,
  5,
  6
};

long_int_v = {
  1,
  2,
  3,
  4,
  5,
  6
};

short_int_v = {1};

empty = {};

exports.Custom_inline = Custom_inline;
exports.v = v;
exports.vv = vv;
exports.long_v = long_v;
exports.long_int_v = long_int_v;
exports.short_int_v = short_int_v;
exports.empty = empty;
--[[ No side effect ]]
