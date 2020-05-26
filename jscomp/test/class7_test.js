'use strict';

Mt = require("./mt.js");
Oo = require("../../lib/js/oo.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_option = require("../../lib/js/caml_option.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");

shared = ["window"];

shared$1 = ["top_widget"];

shared$2 = ["x"];

shared$3 = ["copy"];

shared$4 = [
  "move",
  "get_x"
];

shared$5 = [
  "save",
  "restore"
];

shared$6 = [
  "get",
  "set"
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
  ids = CamlinternalOO.new_methods_variables($$class, shared$4, shared$2);
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

point = CamlinternalOO.make_class(shared$4, point_init);

p = Curry._2(point[0], 0, 55);

q = Oo.copy(p);

Caml_oo_curry.js2(-933174511, 1, q, 7);

eq("File \"class7_test.ml\", line 22, characters 5-12", --[ tuple ]--[
      55,
      62
    ], --[ tuple ]--[
      Caml_oo_curry.js1(291546447, 2, p),
      Caml_oo_curry.js1(291546447, 3, q)
    ]);

function ref_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, [
        "set",
        "get"
      ], shared$2);
  set = ids[0];
  get = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods($$class, [
        get,
        (function (self$2) do
            return self$2[x];
          end),
        set,
        (function (self$2, y) do
            self$2[x] = y;
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

ref = CamlinternalOO.make_class(shared$6, ref_init);

function backup_init($$class) do
  ids = CamlinternalOO.new_methods_variables($$class, shared$5, shared$3);
  save = ids[0];
  restore = ids[1];
  copy = ids[2];
  CamlinternalOO.set_methods($$class, [
        save,
        (function (self$3) do
            copy$1 = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$3));
            self$3[copy] = Caml_option.some((copy$1[copy] = undefined, copy$1));
            return --[ () ]--0;
          end),
        restore,
        (function (self$3) do
            match = self$3[copy];
            if (match ~= undefined) then do
              return Caml_option.valFromOption(match);
            end else do
              return self$3;
            end end 
          end)
      ]);
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[copy] = undefined;
      return self$1;
    end);
end

backup = CamlinternalOO.make_class(shared$5, backup_init);

function backup_ref_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  inh = CamlinternalOO.inherits($$class, shared$2, 0, shared$6, ref, true);
  obj_init = inh[0];
  inh$1 = CamlinternalOO.inherits($$class, shared$3, 0, [
        "restore",
        "save"
      ], backup, true);
  obj_init$1 = inh$1[0];
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      Curry._1(obj_init$1, self$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

backup_ref = CamlinternalOO.make_class([
      "save",
      "restore",
      "get",
      "set"
    ], backup_ref_init);

function get(_p, _n) do
  while(true) do
    n = _n;
    p = _p;
    if (n == 0) then do
      return Caml_oo_curry.js1(5144726, 6, p);
    end else do
      _n = n - 1 | 0;
      _p = Caml_oo_curry.js1(-357537970, 7, p);
      continue ;
    end end 
  end;
end

p$1 = Curry._2(backup_ref[0], 0, 0);

Caml_oo_curry.js1(-867333315, 8, p$1);

Caml_oo_curry.js2(5741474, 9, p$1, 1);

Caml_oo_curry.js1(-867333315, 10, p$1);

Caml_oo_curry.js2(5741474, 11, p$1, 2);

eq("File \"class7_test.ml\", line 47, characters 5-12", [
      2,
      1,
      1,
      1,
      1
    ], [
      get(p$1, 0),
      get(p$1, 1),
      get(p$1, 2),
      get(p$1, 3),
      get(p$1, 4)
    ]);

function backup2_init($$class) do
  ids = CamlinternalOO.new_methods_variables($$class, [
        "save",
        "restore",
        "clear"
      ], shared$3);
  save = ids[0];
  restore = ids[1];
  clear = ids[2];
  copy = ids[3];
  CamlinternalOO.set_methods($$class, [
        save,
        (function (self$5) do
            self$5[copy] = Caml_option.some(Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$5)));
            return --[ () ]--0;
          end),
        restore,
        (function (self$5) do
            match = self$5[copy];
            if (match ~= undefined) then do
              return Caml_option.valFromOption(match);
            end else do
              return self$5;
            end end 
          end),
        clear,
        (function (self$5) do
            self$5[copy] = undefined;
            return --[ () ]--0;
          end)
      ]);
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[copy] = undefined;
      return self$1;
    end);
end

backup2 = CamlinternalOO.make_class([
      "clear",
      "save",
      "restore"
    ], backup2_init);

function backup_ref2_init($$class) do
  x = CamlinternalOO.new_variable($$class, "");
  inh = CamlinternalOO.inherits($$class, shared$2, 0, shared$6, ref, true);
  obj_init = inh[0];
  inh$1 = CamlinternalOO.inherits($$class, shared$3, 0, [
        "clear",
        "restore",
        "save"
      ], backup2, true);
  obj_init$1 = inh$1[0];
  return (function (env, self, x$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x] = x$1;
      Curry._2(obj_init, self$1, x$1);
      Curry._1(obj_init$1, self$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end);
end

backup_ref2 = CamlinternalOO.make_class([
      "clear",
      "save",
      "restore",
      "get",
      "set"
    ], backup_ref2_init);

p$2 = Curry._2(backup_ref2[0], 0, 0);

Caml_oo_curry.js1(-867333315, 12, p$2);

Caml_oo_curry.js2(5741474, 13, p$2, 1);

Caml_oo_curry.js1(-867333315, 14, p$2);

Caml_oo_curry.js2(5741474, 15, p$2, 2);

eq("File \"class7_test.ml\", line 63, characters 5-12", [
      2,
      1,
      0,
      0,
      0
    ], [
      get(p$2, 0),
      get(p$2, 1),
      get(p$2, 2),
      get(p$2, 3),
      get(p$2, 4)
    ]);

function window_init($$class) do
  ids = CamlinternalOO.new_methods_variables($$class, shared$1, shared$1);
  top_widget = ids[0];
  top_widget$1 = ids[1];
  CamlinternalOO.set_method($$class, top_widget, (function (self$7) do
          return self$7[top_widget$1];
        end));
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[top_widget$1] = undefined;
      return self$1;
    end);
end

$$window = CamlinternalOO.make_class(shared$1, window_init);

function widget_init($$class) do
  w = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared, shared);
  $$window = ids[0];
  $$window$1 = ids[1];
  CamlinternalOO.set_method($$class, $$window, (function (self$8) do
          return self$8[$$window$1];
        end));
  return (function (env, self, w$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[w] = w$1;
      self$1[$$window$1] = w$1;
      return self$1;
    end);
end

widget = CamlinternalOO.make_class(shared, widget_init);

Mt.from_pair_suites("Class7_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.point = point;
exports.ref = ref;
exports.backup = backup;
exports.backup_ref = backup_ref;
exports.get = get;
exports.backup2 = backup2;
exports.backup_ref2 = backup_ref2;
exports.$$window = $$window;
exports.widget = widget;
--[ point Not a pure module ]--
