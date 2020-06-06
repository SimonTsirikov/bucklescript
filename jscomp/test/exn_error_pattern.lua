console = {log = print};

Mt = require "./mt";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function f(match) do
  if (Caml_exceptions.caml_is_extension(match)) then do
    if (match == Caml_builtin_exceptions.not_found) then do
      return 0;
    end else if (match[0] == Caml_builtin_exceptions.invalid_argument or match == Caml_builtin_exceptions.stack_overflow) then do
      return 1;
    end else if (match[0] == Caml_builtin_exceptions.sys_error) then do
      return 2;
    end else do
      return ;
    end end  end  end 
  end
   end 
end end

A = Caml_exceptions.create("Exn_error_pattern.A");

B = Caml_exceptions.create("Exn_error_pattern.B");

function g(match) do
  if (Caml_exceptions.caml_is_extension(match)) then do
    if (match == Caml_builtin_exceptions.not_found or match[0] == Caml_builtin_exceptions.invalid_argument) then do
      return 0;
    end else if (match[0] == Caml_builtin_exceptions.sys_error) then do
      return 2;
    end else if (match[0] == A or match[0] == B) then do
      return match[1];
    end else do
      return ;
    end end  end  end 
  end
   end 
end end

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"exn_error_pattern.ml\", line 34, characters 5-12", f(Caml_builtin_exceptions.not_found), 0);

eq("File \"exn_error_pattern.ml\", line 35, characters 5-12", f({
          Caml_builtin_exceptions.invalid_argument,
          ""
        }), 1);

eq("File \"exn_error_pattern.ml\", line 36, characters 5-12", f(Caml_builtin_exceptions.stack_overflow), 1);

eq("File \"exn_error_pattern.ml\", line 37, characters 5-12", f({
          Caml_builtin_exceptions.sys_error,
          ""
        }), 2);

tmp;

xpcall(function() do
  error(new Error("x"))
end end,function(raw_e) do
  tmp = Caml_js_exceptions.internalToOCamlException(raw_e);
end end)

eq("File \"exn_error_pattern.ml\", line 38, characters 5-12", f(tmp), undefined);

Mt.from_pair_suites("Exn_error_pattern", suites.contents);

exports = {}
exports.f = f;
exports.A = A;
exports.B = B;
exports.g = g;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
