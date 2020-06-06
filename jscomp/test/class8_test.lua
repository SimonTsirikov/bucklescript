console = {log = print};

Mt = require "./mt";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";
Caml_exceptions = require "../../lib/js/caml_exceptions";

shared = {
  "leq",
  "value"
};

shared_1 = {"repr"};

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function comparable_001(__class) do
  CamlinternalOO.get_method_label(__class, "leq");
  return (function(env, self) do
      return CamlinternalOO.create_object_opt(self, __class);
    end end);
end end

comparable = --[[ class ]]{
  0,
  comparable_001,
  0,
  0
};

function money_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "value",
        "leq"
      }, shared_1);
  value = ids[0];
  leq = ids[1];
  repr = ids[2];
  inh = CamlinternalOO.inherits(__class, 0, {"leq"}, 0, comparable, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods(__class, {
        value,
        (function(self$2) do
            return self$2[repr];
          end end),
        leq,
        (function(self$2, p) do
            return self$2[repr] <= Caml_oo_curry.js1(834174833, 1, p);
          end end)
      });
  return (function(env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._1(obj_init, self_1);
      self_1[repr] = x_1;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

money = CamlinternalOO.make_class(shared, money_init);

function money2_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  times = CamlinternalOO.get_method_label(__class, "times");
  inh = CamlinternalOO.inherits(__class, shared_1, 0, shared, money, true);
  obj_init = inh[0];
  repr = inh[1];
  CamlinternalOO.set_method(__class, times, (function(self$3, k) do
          copy = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$3));
          copy[repr] = k * self$3[repr];
          return copy;
        end end));
  return (function(env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

money2 = CamlinternalOO.make_class({
      "leq",
      "times",
      "value"
    }, money2_init);

function min(x, y) do
  if (Caml_oo_curry.js2(5393368, 2, x, y)) then do
    return x;
  end else do
    return y;
  end end 
end end

tmp = min(Curry._2(money[0], 0, 1.0), Curry._2(money[0], 0, 3.0));

eq("File \"class8_test.ml\", line 30, characters 5-12", 1, Caml_oo_curry.js1(834174833, 3, tmp));

tmp_1 = min(Curry._2(money2[0], 0, 5.0), Curry._2(money2[0], 0, 3));

eq("File \"class8_test.ml\", line 35, characters 5-12", 3, Caml_oo_curry.js1(834174833, 4, tmp_1));

Mt.from_pair_suites("Class8_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.comparable = comparable;
exports.money = money;
exports.money2 = money2;
exports.min = min;
--[[ money Not a pure module ]]
