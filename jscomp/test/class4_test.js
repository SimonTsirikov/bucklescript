'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");

shared = ["x"];

shared$1 = [
  "move",
  "get_x"
];

shared$2 = [
  "bump",
  "get_x"
];

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function restricted_point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, [
        "move",
        "get_x",
        "bump"
      ], shared);
  move = ids[0];
  get_x = ids[1];
  bump = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$1) do
            return self$1[x];
          end),
        move,
        (function (self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[ () ]--0;
          end),
        bump,
        (function (self$1) do
            return Curry._2(self$1[0][move], self$1, 1);
          end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      self$1[x] = x_init$1;
      return self$1;
    end);
end

restricted_point = CamlinternalOO.make_class(shared$2, restricted_point_init);

function restricted_point$prime_init($$class) do
  inh = CamlinternalOO.inherits($$class, 0, 0, shared$2, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x) do
      return Curry._2(obj_init, self, x);
    end);
end

restricted_point$prime = CamlinternalOO.make_class(shared$2, restricted_point$prime_init);

function restricted_point2$prime_init($$class) do
  inh = CamlinternalOO.inherits($$class, 0, 0, shared$2, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x) do
      return Curry._2(obj_init, self, x);
    end);
end

restricted_point2$prime = CamlinternalOO.make_class(shared$2, restricted_point2$prime_init);

Point = do
  restricted_point$prime: restricted_point
end;

function abstract_point_001($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.get_method_labels($$class, [
        "move",
        "get_x",
        "get_offset"
      ]);
  get_x = ids[1];
  get_offset = ids[2];
  CamlinternalOO.set_method($$class, get_offset, (function (self$5) do
          return Curry._1(self$5[0][get_x], self$5) - self$5[x_init] | 0;
        end));
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      return self$1;
    end);
end

abstract_point = --[ class ]--[
  0,
  abstract_point_001,
  0,
  0
];

function point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$1, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  inh = CamlinternalOO.inherits($$class, 0, shared$1, ["get_offset"], abstract_point, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$6) do
            return self$6[x];
          end),
        move,
        (function (self$6, d) do
            self$6[x] = self$6[x] + d | 0;
            return --[ () ]--0;
          end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      Curry._2(obj_init, self$1, x_init$1);
      self$1[x] = x_init$1;
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

point = CamlinternalOO.make_class([
      "move",
      "get_offset",
      "get_x"
    ], point_init);

function colored_point_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  c = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, ["color"], ["c"]);
  color = ids[0];
  c$1 = ids[1];
  inh = CamlinternalOO.inherits($$class, shared, 0, [
        "get_offset",
        "get_x",
        "move"
      ], point, true);
  obj_init = inh[0];
  CamlinternalOO.set_method($$class, color, (function (self$7) do
          return self$7[c$1];
        end));
  return (function (env, self, x$1, c$2) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[c] = c$2;
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      self$1[c$1] = c$2;
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

colored_point = CamlinternalOO.make_class([
      "move",
      "color",
      "get_offset",
      "get_x"
    ], colored_point_init);

p$prime = Curry._3(colored_point[0], 0, 5, "red");

eq("File \"class4_test.ml\", line 67, characters 5-12", --[ tuple ]--[
      5,
      "red"
    ], --[ tuple ]--[
      Caml_oo_curry.js1(291546447, 1, p$prime),
      Caml_oo_curry.js1(-899911325, 2, p$prime)
    ]);

function get_succ_x(p) do
  return Caml_oo_curry.js1(291546447, 3, p) + 1 | 0;
end

eq("File \"class4_test.ml\", line 71, characters 12-19", 6, get_succ_x(p$prime));

function set_x(p) do
  return Caml_oo_curry.js1(-97543333, 4, p);
end

function incr(p) do
  return Curry._1(set_x(p), get_succ_x(p));
end

Mt.from_pair_suites("Class4_test", suites.contents);

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
--[ restricted_point Not a pure module ]--
