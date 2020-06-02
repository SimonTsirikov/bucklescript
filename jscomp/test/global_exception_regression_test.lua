--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

v = Caml_builtin_exceptions.not_found;

u = Caml_builtin_exceptions.not_found;

s = Caml_builtin_exceptions.end_of_file;

suites_000 = --[[ tuple ]]{
  "not_found_equal",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                u,
                v
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "not_found_not_equal_end_of_file",
    (function (param) do
        return --[[ Neq ]]Block.__(1, {
                  u,
                  s
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Global_exception_regression_test", suites);

exports.v = v;
exports.u = u;
exports.s = s;
exports.suites = suites;
--[[  Not a pure module ]]
