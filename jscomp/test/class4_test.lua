console = {log = print};

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";

shared = {"x"};

shared_1 = {
  "move",
  "get_x"
};

shared_2 = {
  "bump",
  "get_x"
};

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function restricted_point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "move",
        "get_x",
        "bump"
      }, shared);
  move = ids[0];
  get_x = ids[1];
  bump = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function(self$1) do
            return self$1[x];
          end end),
        move,
        (function(self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end),
        bump,
        (function(self$1) do
            return Curry._2(self$1[0][move], self$1, 1);
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

restricted_point = CamlinternalOO.make_class(shared_2, restricted_point_init);

function restricted_point$prime_init(__class) do
  inh = CamlinternalOO.inherits(__class, 0, 0, shared_2, restricted_point, true);
  obj_init = inh[0];
  return (function(env, self, x) do
      return Curry._2(obj_init, self, x);
    end end);
end end

restricted_point$prime = CamlinternalOO.make_class(shared_2, restricted_point$prime_init);

function restricted_point2$prime_init(__class) do
  inh = CamlinternalOO.inherits(__class, 0, 0, shared_2, restricted_point, true);
  obj_init = inh[0];
  return (function(env, self, x) do
      return Curry._2(obj_init, self, x);
    end end);
end end

restricted_point2$prime = CamlinternalOO.make_class(shared_2, restricted_point2$prime_init);

Point = {
  restricted_point$prime = restricted_point
};

function abstract_point_001(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.get_method_labels(__class, {
        "move",
        "get_x",
        "get_offset"
      });
  get_x = ids[1];
  get_offset = ids[2];
  CamlinternalOO.set_method(__class, get_offset, (function(self$5) do
          return Curry._1(self$5[0][get_x], self$5) - self$5[x_init] | 0;
        end end));
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      return self_1;
    end end);
end end

abstract_point = --[[ class ]]{
  0,
  abstract_point_001,
  0,
  0
};

function point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_1, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  inh = CamlinternalOO.inherits(__class, 0, shared_1, {"get_offset"}, abstract_point, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function(self$6) do
            return self$6[x];
          end end),
        move,
        (function(self$6, d) do
            self$6[x] = self$6[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      Curry._2(obj_init, self_1, x_init_1);
      self_1[x] = x_init_1;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

point = CamlinternalOO.make_class({
      "move",
      "get_offset",
      "get_x"
    }, point_init);

function colored_point_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  c = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {"color"}, {"c"});
  color = ids[0];
  c_1 = ids[1];
  inh = CamlinternalOO.inherits(__class, shared, 0, {
        "get_offset",
        "get_x",
        "move"
      }, point, true);
  obj_init = inh[0];
  CamlinternalOO.set_method(__class, color, (function(self$7) do
          return self$7[c_1];
        end end));
  return (function(env, self, x_1, c_2) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[c] = c_2;
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      self_1[c_1] = c_2;
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

colored_point = CamlinternalOO.make_class({
      "move",
      "color",
      "get_offset",
      "get_x"
    }, colored_point_init);

p$prime = Curry._3(colored_point[0], 0, 5, "red");

eq("File \"class4_test.ml\", line 67, characters 5-12", --[[ tuple ]]{
      5,
      "red"
    }, --[[ tuple ]]{
      Caml_oo_curry.js1(291546447, 1, p$prime),
      Caml_oo_curry.js1(-899911325, 2, p$prime)
    });

function get_succ_x(p) do
  return Caml_oo_curry.js1(291546447, 3, p) + 1 | 0;
end end

eq("File \"class4_test.ml\", line 71, characters 12-19", 6, get_succ_x(p$prime));

function set_x(p) do
  return Caml_oo_curry.js1(-97543333, 4, p);
end end

function incr(p) do
  return Curry._1(set_x(p), get_succ_x(p));
end end

Mt.from_pair_suites("Class4_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.restricted_point = restricted_point;
exports.restricted_point$prime = restricted_point$prime;
exports.restricted_point2$prime = restricted_point2$prime;
exports.Point = Point;
exports.abstract_point = abstract_point;
exports.point = point;
exports.colored_point = colored_point;
exports.p$prime = p$prime;
exports.get_succ_x = get_succ_x;
exports.set_x = set_x;
exports.incr = incr;
--[[ restricted_point Not a pure module ]]
