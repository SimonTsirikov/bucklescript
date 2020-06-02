--[['use strict';]]

Oo = require "../../lib/js/oo";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

shared = {"x"};

shared_1 = {"get_x"};

shared_2 = {
  "incr",
  "get_money"
};

function x0_init(__class) do
  v = CamlinternalOO.new_variable(__class, "");
  x = CamlinternalOO.new_variable(__class, "x");
  return (function (env, self, v_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[v] = v_1;
      self_1[x] = v_1 + 2 | 0;
      return self_1;
    end end);
end end

x0 = CamlinternalOO.make_class(0, x0_init);

function x_init(__class) do
  v = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_1, shared);
  get_x = ids[0];
  x = ids[1];
  CamlinternalOO.set_method(__class, get_x, (function (self$2) do
          return self$2[x];
        end end));
  return (function (env, self, v_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[v] = v_1;
      self_1[x] = v_1;
      return self_1;
    end end);
end end

x = CamlinternalOO.make_class(shared_1, x_init);

v = Curry._2(x[0], 0, 3);

u = Oo.copy(v);

if (Caml_oo_curry.js1(291546447, 1, v) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "class_repr.ml",
      30,
      9
    }
  })
end
 end 

if (Caml_oo_curry.js1(291546447, 2, u) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "class_repr.ml",
      32,
      9
    }
  })
end
 end 

function xx_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_2, {"money"});
  incr = ids[0];
  get_money = ids[1];
  money = ids[2];
  CamlinternalOO.set_methods(__class, {
        get_money,
        (function (self$3) do
            return self$3[money];
          end end),
        incr,
        (function (self$3) do
            copy = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$3));
            copy[money] = 2 * self$3[x] + Curry._1(self$3[0][get_money], self$3);
            return copy;
          end end)
      });
  return (function (env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      self_1[money] = x_1;
      return self_1;
    end end);
end end

xx = CamlinternalOO.make_class(shared_2, xx_init);

v1 = Curry._2(xx[0], 0, 3);

v2 = Caml_oo_curry.js1(-977586732, 3, v1);

if (Caml_oo_curry.js1(-804710761, 4, v1) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "class_repr.ml",
      44,
      9
    }
  })
end
 end 

console.log(--[[ tuple ]]{
      Caml_oo_curry.js1(-804710761, 5, v1),
      Caml_oo_curry.js1(-804710761, 6, v2)
    });

if (Caml_oo_curry.js1(-804710761, 7, v2) ~= 9) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "class_repr.ml",
      52,
      9
    }
  })
end
 end 

function point_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, {
        "get_x5",
        "get_x"
      }, shared);
  get_x5 = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function (self$4) do
            return self$4[x];
          end end),
        get_x5,
        (function (self$4) do
            return Curry._1(self$4[0][get_x], self$4) + 5 | 0;
          end end)
      });
  return (function (env, self) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = 0;
      return self_1;
    end end);
end end

point = CamlinternalOO.make_class({
      "get_x",
      "get_x5"
    }, point_init);

v_1 = Curry._1(point[0], 0);

if (Caml_oo_curry.js1(590348294, 8, v_1) ~= 5) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "class_repr.ml",
      99,
      2
    }
  })
end
 end 

function xx0_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_2, {
        "money",
        "a0",
        "a1",
        "a2"
      });
  incr = ids[0];
  get_money = ids[1];
  money = ids[2];
  a0 = ids[3];
  a1 = ids[4];
  a2 = ids[5];
  CamlinternalOO.set_methods(__class, {
        get_money,
        (function (self$5) do
            return self$5[money];
          end end),
        incr,
        (function (self$5) do
            copy = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$5));
            copy[money] = 2 * self$5[x] + Curry._1(self$5[0][get_money], self$5);
            copy[a0] = 2;
            return copy;
          end end)
      });
  return (function (env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      self_1[money] = x_1;
      self_1[a0] = 0;
      self_1[a1] = 1;
      self_1[a2] = 2;
      return self_1;
    end end);
end end

xx0 = CamlinternalOO.make_class(shared_2, xx0_init);

exports.x0 = x0;
exports.x = x;
exports.u = u;
exports.xx = xx;
exports.v1 = v1;
exports.v2 = v2;
exports.point = point;
exports.v = v_1;
exports.xx0 = xx0;
--[[ x0 Not a pure module ]]
