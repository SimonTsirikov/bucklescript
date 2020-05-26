'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

shared = ["x"];

shared$1 = ["m"];

shared$2 = [
  "move",
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

function point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$2, shared);
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

point = CamlinternalOO.make_class(shared$2, point_init);

function colored_point_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  c = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, ["color"], ["c"]);
  color = ids[0];
  c$1 = ids[1];
  inh = CamlinternalOO.inherits($$class, shared, 0, [
        "get_x",
        "move"
      ], point, true);
  obj_init = inh[0];
  CamlinternalOO.set_method($$class, color, (function (self$2) do
          return self$2[c$1];
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
      "get_x"
    ], colored_point_init);

function colored_point_to_point(cp) do
  return cp;
end

p = Curry._2(point[0], 0, 3);

q = Curry._3(colored_point[0], 0, 4, "blue");

function lookup_obj(obj, _param) do
  while(true) do
    param = _param;
    if (param) then do
      obj$prime = param[0];
      if (Caml_obj.caml_equal(obj, obj$prime)) then do
        return obj$prime;
      end else do
        _param = param[1];
        continue ;
      end end 
    end else do
      throw Caml_builtin_exceptions.not_found;
    end end 
  end;
end

function c_init($$class) do
  m = CamlinternalOO.get_method_label($$class, "m");
  CamlinternalOO.set_method($$class, m, (function (self$3) do
          return 1;
        end));
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, $$class);
    end);
end

c = CamlinternalOO.make_class(shared$1, c_init);

function d_init($$class) do
  ids = CamlinternalOO.get_method_labels($$class, [
        "n",
        "as_c"
      ]);
  n = ids[0];
  as_c = ids[1];
  inh = CamlinternalOO.inherits($$class, 0, 0, shared$1, c, true);
  obj_init = inh[0];
  CamlinternalOO.set_methods($$class, [
        n,
        (function (self$4) do
            return 2;
          end),
        as_c,
        (function (self$4) do
            return self$4;
          end)
      ]);
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      Curry._1(obj_init, self$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

table = CamlinternalOO.create_table([
      "as_c",
      "m",
      "n"
    ]);

env_init = d_init(table);

CamlinternalOO.init_class(table);

d_000 = Curry._1(env_init, 0);

d = --[ class ]--[
  d_000,
  d_init,
  env_init,
  0
];

function c2$prime_001($$class) do
  CamlinternalOO.get_method_label($$class, "m");
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, $$class);
    end);
end

c2$prime = --[ class ]--[
  0,
  c2$prime_001,
  0,
  0
];

function functional_point_init($$class) do
  y = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$2, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$6) do
            return self$6[x];
          end),
        move,
        (function (self$6, d) do
            copy = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$6));
            copy[x] = self$6[x] + d | 0;
            return copy;
          end)
      ]);
  return (function (env, self, y$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[y] = y$1;
      self$1[x] = y$1;
      return self$1;
    end);
end

functional_point = CamlinternalOO.make_class(shared$2, functional_point_init);

p$1 = Curry._2(functional_point[0], 0, 7);

tmp = Caml_oo_curry.js2(-933174511, 2, p$1, 3);

eq("File \"class6_test.ml\", line 60, characters 5-12", --[ tuple ]--[
      7,
      10,
      7
    ], --[ tuple ]--[
      Caml_oo_curry.js1(291546447, 1, p$1),
      Caml_oo_curry.js1(291546447, 3, tmp),
      Caml_oo_curry.js1(291546447, 4, p$1)
    ]);

function bad_functional_point_init($$class) do
  y = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared$2, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$7) do
            return self$7[x];
          end),
        move,
        (function (self$7, d) do
            return Curry._2(bad_functional_point[0], 0, self$7[x] + d | 0);
          end)
      ]);
  return (function (env, self, y$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[y] = y$1;
      self$1[x] = y$1;
      return self$1;
    end);
end

table$1 = CamlinternalOO.create_table(shared$2);

env_init$1 = bad_functional_point_init(table$1);

CamlinternalOO.init_class(table$1);

bad_functional_point_000 = Curry._1(env_init$1, 0);

bad_functional_point = --[ class ]--[
  bad_functional_point_000,
  bad_functional_point_init,
  env_init$1,
  0
];

p$2 = Curry._2(bad_functional_point_000, 0, 7);

tmp$1 = Caml_oo_curry.js2(-933174511, 6, p$2, 3);

eq("File \"class6_test.ml\", line 74, characters 5-12", --[ tuple ]--[
      7,
      10,
      7
    ], --[ tuple ]--[
      Caml_oo_curry.js1(291546447, 5, p$2),
      Caml_oo_curry.js1(291546447, 7, tmp$1),
      Caml_oo_curry.js1(291546447, 8, p$2)
    ]);

Mt.from_pair_suites("Class6_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.point = point;
exports.colored_point = colored_point;
exports.colored_point_to_point = colored_point_to_point;
exports.p = p;
exports.q = q;
exports.lookup_obj = lookup_obj;
exports.c = c;
exports.d = d;
exports.c2$prime = c2$prime;
exports.functional_point = functional_point;
exports.bad_functional_point = bad_functional_point;
--[ point Not a pure module ]--
