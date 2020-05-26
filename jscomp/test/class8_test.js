'use strict';

Mt = require("./mt.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");

shared = [
  "leq",
  "value"
];

shared$1 = ["repr"];

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function comparable_001($$class) do
  CamlinternalOO.get_method_label($$class, "leq");
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, $$class);
    end end);
end end

comparable = --[ class ]--[
  0,
  comparable_001,
  0,
  0
];

function money_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, [
        "value",
        "leq"
      ], shared$1);
  value = ids[0];
  leq = ids[1];
  repr = ids[2];
  inh = CamlinternalOO.inherits($$class, 0, ["leq"], 0, comparable, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods($$class, [
        value,
        (function (self$2) do
            return self$2[repr];
          end end),
        leq,
        (function (self$2, p) do
            return self$2[repr] <= Caml_oo_curry.js1(834174833, 1, p);
          end end)
      ]);
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._1(obj_init, self$1);
      self$1[repr] = x$1;
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end end);
end end

money = CamlinternalOO.make_class(shared, money_init);

function money2_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  times = CamlinternalOO.get_method_label($$class, "times");
  inh = CamlinternalOO.inherits($$class, shared$1, 0, shared, money, true);
  obj_init = inh[0];
  repr = inh[1];
  CamlinternalOO.set_method($$class, times, (function (self$3, k) do
          copy = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$3));
          copy[repr] = k * self$3[repr];
          return copy;
        end end));
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end end);
end end

money2 = CamlinternalOO.make_class([
      "leq",
      "times",
      "value"
    ], money2_init);

function min(x, y) do
  if (Caml_oo_curry.js2(5393368, 2, x, y)) then do
    return x;
  end else do
    return y;
  end end 
end end

tmp = min(Curry._2(money[0], 0, 1.0), Curry._2(money[0], 0, 3.0));

eq("File \"class8_test.ml\", line 30, characters 5-12", 1, Caml_oo_curry.js1(834174833, 3, tmp));

tmp$1 = min(Curry._2(money2[0], 0, 5.0), Curry._2(money2[0], 0, 3));

eq("File \"class8_test.ml\", line 35, characters 5-12", 3, Caml_oo_curry.js1(834174833, 4, tmp$1));

Mt.from_pair_suites("Class8_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.comparable = comparable;
exports.money = money;
exports.money2 = money2;
exports.min = min;
--[ money Not a pure module ]--
