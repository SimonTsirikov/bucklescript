console = {log = print};

Curry = require "../../lib/js/curry";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(param, v) do
  return ((((param.x0 + param.x1 | 0) + param.x2 | 0) + param.x3 | 0) + param.x4 | 0) + v | 0;
end end

function f2(param, param_1) do
  return (((((param.x0 + param.x1 | 0) + param.x2 | 0) + param.x3 | 0) + param.x4 | 0) + param_1.a | 0) + param_1.b | 0;
end end

function f3(param) do
  lhs = param.rank;
  return (function(param) do
      rhs = param.rank;
      if (typeof lhs == "number") then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "fun_pattern_match.ml",
            44,
            9
          }
        })
      end
       end 
      if (typeof rhs == "number") then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "fun_pattern_match.ml",
            44,
            9
          }
        })
      end
       end 
      return Caml_primitive.caml_int_compare(lhs[0], rhs[0]);
    end end);
end end

function f4(param) do
  lhs = param.rank;
  return (function(param) do
      rhs = param.rank;
      if (typeof lhs == "number") then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "fun_pattern_match.ml",
            52,
            9
          }
        })
      end
       end 
      if (typeof rhs == "number") then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "fun_pattern_match.ml",
            52,
            9
          }
        })
      end
       end 
      return Caml_primitive.caml_int_compare(lhs[0], rhs[0]);
    end end);
end end

x = --[[ `A ]]{
  65,
  r
};

function r(param) do
  return x;
end end

match = r(--[[ () ]]0);

v = Curry._1(match[1], --[[ () ]]0);

console.log(v);

exports = {}
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.r = r;
exports.v = v;
--[[ match Not a pure module ]]