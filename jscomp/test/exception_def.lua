console = {log = print};

Printexc = require "../../lib/js/printexc";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

A = Caml_exceptions.create("Exception_def.A");

A_1 = Caml_exceptions.create("Exception_def.U.A");

U = do
  A: A_1
end;

H = { };

Bx = Caml_exceptions.create("Exception_def.Bx");

Ax = Caml_exceptions.create("Exception_def.Ax");

XXX = Caml_exceptions.create("Exception_def.XXX");

Aa = Caml_builtin_exceptions.match_failure;

v_001 = --[[ tuple ]]{
  "",
  0,
  0
};

v = {
  Aa,
  v_001
};

Printexc.register_printer((function(param) do
        if (param[0] == A) then do
          return "A";
        end
         end 
      end end));

a = 3;

u = Bx;

exports = {}
exports.A = A;
exports.U = U;
exports.H = H;
exports.Bx = Bx;
exports.a = a;
exports.u = u;
exports.Ax = Ax;
exports.XXX = XXX;
exports.Aa = Aa;
exports.v = v;
--[[  Not a pure module ]]
