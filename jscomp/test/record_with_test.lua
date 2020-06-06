console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";

v = {
  syntax = nil,
  imports = 0,
  file_options = 0,
  package = 0,
  messages = 0,
  enums = 0,
  extends = 0
};

u_v = {
  syntax = nil,
  imports = 0,
  file_options = 0,
  package = 0,
  messages = 0,
  enums = 0,
  extends = 0
};

function f(g, h) do
  init = Curry._1(g, h);
  return {
          syntax = init.syntax,
          imports = 0,
          file_options = init.file_options,
          package = init.package,
          messages = init.messages,
          enums = init.enums,
          extends = init.extends
        };
end end

suites_000 = --[[ tuple ]]{
  "eq_with",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                v,
                u_v
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Record_with_test", suites);

uv = {
  syntax = nil,
  imports = 1,
  file_options = 0,
  package = 0,
  messages = 0,
  enums = 0,
  extends = 0
};

exports = {}
exports.v = v;
exports.uv = uv;
exports.u_v = u_v;
exports.f = f;
exports.suites = suites;
--[[  Not a pure module ]]
