__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
__String = require "......lib.js.string";

function u(v) do
  return v;
end end

s = __String;

N = {
  s = s
};

function v(x) do
  return #x;
end end

suites_000 = --[[ tuple ]]{
  "const",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                1,
                1
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "other",
    (function(param) do
        return --[[ Eq ]]Block.__(0, {
                  3,
                  3
                });
      end end)
  },
  --[[ [] ]]0
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Module_parameter_test", suites);

v0 = 1;

exports = {};
exports.u = u;
exports.N = N;
exports.v0 = v0;
exports.v = v;
exports.suites = suites;
return exports;
--[[  Not a pure module ]]
