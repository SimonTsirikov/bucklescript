'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_array = require("../../lib/js/caml_array.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Pervasives = require("../../lib/js/pervasives.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");

shared = [
  "move",
  "get_x",
  "get_offset"
];

shared$1 = [
  "move",
  "get_offset",
  "get_x"
];

shared$2 = [
  "move",
  "print",
  "get_x"
];

shared$3 = ["x"];

shared$4 = [
  "bump",
  "move",
  "get_x"
];

shared$5 = [
  "move",
  "get_x"
];

shared$6 = [
  "print",
  "move",
  "get_x"
];

shared$7 = [
  "bump",
  "get_x",
  "move"
];

shared$8 = ["move"];

shared$9 = [
  "register",
  "n",
  "len"
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

function point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$5, shared$3);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$1) do
            return self$1[x];
          end),
        move,
        (function (self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[ () ]--0;
          end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      self$1[x] = x_init$1;
      return self$1;
    end);
end

point = CamlinternalOO.make_class(shared$5, point_init);

p = Curry._2(point[0], 0, 7);

eq("File \"class3_test.ml\", line 17, characters 12-19", Caml_oo_curry.js1(291546447, 1, p), 7);

function adjusted_point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  origin = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared, shared$3);
  move = ids[0];
  get_x = ids[1];
  get_offset = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$2) do
            return self$2[x];
          end),
        get_offset,
        (function (self$2) do
            return self$2[x] - self$2[origin] | 0;
          end),
        move,
        (function (self$2, d) do
            self$2[x] = self$2[x] + d | 0;
            return --[ () ]--0;
          end)
      ]);
  return (function (env, self, x_init$1) do
      origin$1 = Caml_int32.imul(x_init$1 / 10 | 0, 10);
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[origin] = origin$1;
      self$1[x_init] = x_init$1;
      self$1[x] = origin$1;
      return self$1;
    end);
end

adjusted_point = CamlinternalOO.make_class(shared$1, adjusted_point_init);

tmp = Curry._2(adjusted_point[0], 0, 31);

eq("File \"class3_test.ml\", line 28, characters 13-20", Caml_oo_curry.js1(291546447, 2, tmp), 30);

function new_init(obj_init, self, x_init) do
  return Curry._2(obj_init, self, Caml_int32.imul(x_init / 10 | 0, 10));
end

partial_arg = point[0];

function adjusted_point2_000(param, param$1) do
  return new_init(partial_arg, param, param$1);
end

function adjusted_point2_001(table) do
  env_init = Curry._1(point[1], table);
  return (function (envs) do
      partial_arg = Curry._1(env_init, envs);
      return (function (param, param$1) do
          return new_init(partial_arg, param, param$1);
        end);
    end);
end

adjusted_point2_002 = point[2];

adjusted_point2_003 = point[3];

adjusted_point2 = --[ class ]--[
  adjusted_point2_000,
  adjusted_point2_001,
  adjusted_point2_002,
  adjusted_point2_003
];

tmp$1 = Curry._2(adjusted_point2_000, 0, 31);

eq("File \"class3_test.ml\", line 33, characters 12-19", Caml_oo_curry.js1(291546447, 3, tmp$1), 30);

function printable_point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$6, shared$3);
  print = ids[0];
  move = ids[1];
  get_x = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$4) do
            return self$4[x];
          end),
        move,
        (function (self$4, d) do
            self$4[x] = self$4[x] + d | 0;
            return --[ () ]--0;
          end),
        print,
        (function (self$4) do
            return Curry._1(self$4[0][get_x], self$4);
          end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      self$1[x] = x_init$1;
      return self$1;
    end);
end

printable_point = CamlinternalOO.make_class(shared$2, printable_point_init);

p$1 = Curry._2(printable_point[0], 0, 7);

eq("File \"class3_test.ml\", line 49, characters 11-18", Caml_oo_curry.js1(-930392019, 4, p$1), 7);

ints = do
  contents: --[ [] ]--0
end;

$$class = CamlinternalOO.create_table(shared$9);

ids = CamlinternalOO.get_method_labels($$class, shared$9);

register = ids[0];

n = ids[1];

len = ids[2];

CamlinternalOO.set_methods($$class, [
      n,
      (function (self$5) do
          return 1;
        end),
      register,
      (function (self$5) do
          ints.contents = --[ :: ]--[
            self$5,
            ints.contents
          ];
          return --[ () ]--0;
        end),
      len,
      (function (self$5) do
          return List.length(ints.contents);
        end)
    ]);

CamlinternalOO.init_class($$class);

my_int = CamlinternalOO.create_object_opt(0, $$class);

Caml_oo_curry.js1(-794843549, 5, my_int);

Caml_oo_curry.js1(-794843549, 6, my_int);

console.log(Caml_oo_curry.js1(5393365, 7, my_int));

v = [
  0,
  3
];

function printable_point2_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  origin = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$6, shared$3);
  print = ids[0];
  move = ids[1];
  get_x = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$6) do
            return self$6[x];
          end),
        move,
        (function (self$6, d) do
            self$6[x] = self$6[x] + d | 0;
            return --[ () ]--0;
          end),
        print,
        (function (self$6) do
            return Pervasives.print_int(Curry._1(self$6[0][get_x], self$6));
          end)
      ]);
  CamlinternalOO.add_initializer($$class, (function (self$6) do
          console.log("initializingFile \"class3_test.ml\", line 76, characters 50-57");
          return Caml_array.caml_array_set(v, 0, self$6[x]);
        end));
  return (function (env, self, x_init$1) do
      origin$1 = Caml_int32.imul(x_init$1 / 10 | 0, 10);
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[origin] = origin$1;
      self$1[x_init] = x_init$1;
      self$1[x] = origin$1;
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

printable_point2 = CamlinternalOO.make_class(shared$2, printable_point2_init);

Curry._2(printable_point2[0], 0, 31);

eq("File \"class3_test.ml\", line 81, characters 12-19", v, [
      30,
      3
    ]);

function abstract_point_001($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.get_method_labels($$class, shared);
  get_x = ids[1];
  get_offset = ids[2];
  CamlinternalOO.set_method($$class, get_offset, (function (self$7) do
          return Curry._1(self$7[0][get_x], self$7) - self$7[x_init] | 0;
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

function vpoint_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$5, shared$3);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  inh = CamlinternalOO.inherits($$class, 0, shared$5, ["get_offset"], abstract_point, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$8) do
            return self$8[x];
          end),
        move,
        (function (self$8, d) do
            self$8[x] = self$8[x] + d | 0;
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

vpoint = CamlinternalOO.make_class(shared$1, vpoint_init);

h = Curry._2(vpoint[0], 0, 3);

Caml_oo_curry.js2(-933174511, 8, h, 32);

v$1 = Caml_oo_curry.js1(-792262820, 9, h);

eq("File \"class3_test.ml\", line 107, characters 12-19", v$1, 32);

function abstract_point2_001($$class) do
  ids = CamlinternalOO.new_methods_variables($$class, shared$8, shared$3);
  move = ids[0];
  x = ids[1];
  CamlinternalOO.set_method($$class, move, (function (self$9, d) do
          self$9[x] = self$9[x] + d | 0;
          return --[ () ]--0;
        end));
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, $$class);
    end);
end

abstract_point2 = --[ class ]--[
  0,
  abstract_point2_001,
  0,
  0
];

function point2_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  get_offset = CamlinternalOO.get_method_label($$class, "get_offset");
  inh = CamlinternalOO.inherits($$class, shared$3, 0, shared$8, abstract_point2, true);
  obj_init = inh[0];
  x = inh[1];
  CamlinternalOO.set_method($$class, get_offset, (function (self$10) do
          return self$10[x] - self$10[x_init] | 0;
        end));
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      Curry._1(obj_init, self$1);
      self$1[x] = x_init$1;
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

point2 = CamlinternalOO.make_class([
      "move",
      "get_offset"
    ], point2_init);

h$1 = Curry._2(point2[0], 0, 3);

Caml_oo_curry.js2(-933174511, 10, h$1, 32);

vv = Caml_oo_curry.js1(-792262820, 11, h$1);

eq("File \"class3_test.ml\", line 128, characters 12-19", vv, 32);

function restricted_point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, [
        "move",
        "get_x",
        "bump"
      ], shared$3);
  move = ids[0];
  get_x = ids[1];
  bump = ids[2];
  x = ids[3];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$11) do
            return self$11[x];
          end),
        move,
        (function (self$11, d) do
            self$11[x] = self$11[x] + d | 0;
            return --[ () ]--0;
          end),
        bump,
        (function (self$11) do
            return Curry._2(self$11[0][move], self$11, 1);
          end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      self$1[x] = x_init$1;
      return self$1;
    end);
end

restricted_point = CamlinternalOO.make_class([
      "bump",
      "get_x"
    ], restricted_point_init);

p$2 = Curry._2(restricted_point[0], 0, 0);

Caml_oo_curry.js1(-1054863370, 12, p$2);

h$2 = Caml_oo_curry.js1(291546447, 13, p$2);

eq("File \"class3_test.ml\", line 144, characters 12-19", h$2, 1);

function point_again_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  CamlinternalOO.get_method_label($$class, "move");
  inh = CamlinternalOO.inherits($$class, shared$3, 0, shared$7, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

point_again = CamlinternalOO.make_class(shared$4, point_again_init);

p$3 = Curry._2(point_again[0], 0, 3);

Caml_oo_curry.js2(-933174511, 14, p$3, 3);

Caml_oo_curry.js1(-1054863370, 15, p$3);

Caml_oo_curry.js1(-1054863370, 16, p$3);

hh = Caml_oo_curry.js1(291546447, 17, p$3);

eq("File \"class3_test.ml\", line 161, characters 12-19", hh, 8);

function point_again2_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  inh = CamlinternalOO.inherits($$class, shared$3, 0, shared$7, restricted_point, true);
  obj_init = inh[0];
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

point_again2 = CamlinternalOO.make_class(shared$4, point_again2_init);

p$4 = Curry._2(point_again2[0], 0, 3);

Caml_oo_curry.js2(-933174511, 18, p$4, 30);

Caml_oo_curry.js1(-1054863370, 19, p$4);

Caml_oo_curry.js1(-1054863370, 20, p$4);

hhh = Caml_oo_curry.js1(291546447, 21, p$4);

eq("File \"class3_test.ml\", line 177, characters 12-19", hhh, 35);

function point_again3_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  move = CamlinternalOO.get_method_label($$class, "move");
  inh = CamlinternalOO.inherits($$class, shared$3, 0, shared$7, restricted_point, true);
  obj_init = inh[0];
  move$1 = inh[4];
  CamlinternalOO.set_method($$class, move, Curry.__1(move$1));
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

point_again3 = CamlinternalOO.make_class(shared$4, point_again3_init);

p$5 = Curry._2(point_again3[0], 0, 3);

Caml_oo_curry.js2(-933174511, 22, p$5, 300);

Caml_oo_curry.js1(-1054863370, 23, p$5);

Caml_oo_curry.js1(-1054863370, 24, p$5);

hhhh = Caml_oo_curry.js1(291546447, 25, p$5);

eq("File \"class3_test.ml\", line 195, characters 12-19", hhhh, 305);

Mt.from_pair_suites("Class3_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.point = point;
exports.adjusted_point = adjusted_point;
exports.adjusted_point2 = adjusted_point2;
exports.printable_point = printable_point;
exports.my_int = my_int;
exports.printable_point2 = printable_point2;
exports.abstract_point = abstract_point;
exports.vpoint = vpoint;
exports.v = v$1;
exports.abstract_point2 = abstract_point2;
exports.point2 = point2;
exports.vv = vv;
exports.restricted_point = restricted_point;
exports.p = p$2;
exports.h = h$2;
exports.point_again = point_again;
exports.hh = hh;
exports.point_again2 = point_again2;
exports.hhh = hhh;
exports.point_again3 = point_again3;
exports.hhhh = hhhh;
--[ point Not a pure module ]--
