console = {log = print};

Mt = require "./mt";
Oo = require "../../lib/js/oo";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Caml_option = require "../../lib/js/caml_option";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";
Caml_exceptions = require "../../lib/js/caml_exceptions";

shared = {"window"};

shared_1 = {"top_widget"};

shared_2 = {"x"};

shared_3 = {"copy"};

shared_4 = {
  "move",
  "get_x"
};

shared_5 = {
  "save",
  "restore"
};

shared_6 = {
  "get",
  "set"
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

function point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_4, shared_2);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function(self$1) do
            return self$1[x];
          end end),
        move,
        (function(self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

point = CamlinternalOO.make_class(shared_4, point_init);

p = Curry._2(point[0], 0, 55);

q = Oo.copy(p);

Caml_oo_curry.js2(-933174511, 1, q, 7);

eq("File \"class7_test.ml\", line 22, characters 5-12", --[[ tuple ]]{
      55,
      62
    }, --[[ tuple ]]{
      Caml_oo_curry.js1(291546447, 2, p),
      Caml_oo_curry.js1(291546447, 3, q)
    });

function ref_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "set",
        "get"
      }, shared_2);
  set = ids[0];
  get = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get,
        (function(self$2) do
            return self$2[x];
          end end),
        set,
        (function(self$2, y) do
            self$2[x] = y;
            return --[[ () ]]0;
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

ref = CamlinternalOO.make_class(shared_6, ref_init);

function backup_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared_5, shared_3);
  save = ids[0];
  restore = ids[1];
  copy = ids[2];
  CamlinternalOO.set_methods(__class, {
        save,
        (function(self$3) do
            copy_1 = Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$3));
            self$3[copy] = Caml_option.some((copy_1[copy] = undefined, copy_1));
            return --[[ () ]]0;
          end end),
        restore,
        (function(self$3) do
            match = self$3[copy];
            if (match ~= undefined) then do
              return Caml_option.valFromOption(match);
            end else do
              return self$3;
            end end 
          end end)
      });
  return (function(env, self) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[copy] = undefined;
      return self_1;
    end end);
end end

backup = CamlinternalOO.make_class(shared_5, backup_init);

function backup_ref_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  inh = CamlinternalOO.inherits(__class, shared_2, 0, shared_6, ref, true);
  obj_init = inh[0];
  inh_1 = CamlinternalOO.inherits(__class, shared_3, 0, {
        "restore",
        "save"
      }, backup, true);
  obj_init_1 = inh_1[0];
  return (function(env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      Curry._1(obj_init_1, self_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

backup_ref = CamlinternalOO.make_class({
      "save",
      "restore",
      "get",
      "set"
    }, backup_ref_init);

function get(_p, _n) do
  while(true) do
    n = _n;
    p = _p;
    if (n == 0) then do
      return Caml_oo_curry.js1(5144726, 6, p);
    end else do
      _n = n - 1 | 0;
      _p = Caml_oo_curry.js1(-357537970, 7, p);
      ::continue:: ;
    end end 
  end;
end end

p_1 = Curry._2(backup_ref[0], 0, 0);

Caml_oo_curry.js1(-867333315, 8, p_1);

Caml_oo_curry.js2(5741474, 9, p_1, 1);

Caml_oo_curry.js1(-867333315, 10, p_1);

Caml_oo_curry.js2(5741474, 11, p_1, 2);

eq("File \"class7_test.ml\", line 47, characters 5-12", {
      2,
      1,
      1,
      1,
      1
    }, {
      get(p_1, 0),
      get(p_1, 1),
      get(p_1, 2),
      get(p_1, 3),
      get(p_1, 4)
    });

function backup2_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, {
        "save",
        "restore",
        "clear"
      }, shared_3);
  save = ids[0];
  restore = ids[1];
  clear = ids[2];
  copy = ids[3];
  CamlinternalOO.set_methods(__class, {
        save,
        (function(self$5) do
            self$5[copy] = Caml_option.some(Caml_exceptions.caml_set_oo_id(Caml_obj.caml_obj_dup(self$5)));
            return --[[ () ]]0;
          end end),
        restore,
        (function(self$5) do
            match = self$5[copy];
            if (match ~= undefined) then do
              return Caml_option.valFromOption(match);
            end else do
              return self$5;
            end end 
          end end),
        clear,
        (function(self$5) do
            self$5[copy] = undefined;
            return --[[ () ]]0;
          end end)
      });
  return (function(env, self) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[copy] = undefined;
      return self_1;
    end end);
end end

backup2 = CamlinternalOO.make_class({
      "clear",
      "save",
      "restore"
    }, backup2_init);

function backup_ref2_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  inh = CamlinternalOO.inherits(__class, shared_2, 0, shared_6, ref, true);
  obj_init = inh[0];
  inh_1 = CamlinternalOO.inherits(__class, shared_3, 0, {
        "clear",
        "restore",
        "save"
      }, backup2, true);
  obj_init_1 = inh_1[0];
  return (function(env, self, x_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_1;
      Curry._2(obj_init, self_1, x_1);
      Curry._1(obj_init_1, self_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

backup_ref2 = CamlinternalOO.make_class({
      "clear",
      "save",
      "restore",
      "get",
      "set"
    }, backup_ref2_init);

p_2 = Curry._2(backup_ref2[0], 0, 0);

Caml_oo_curry.js1(-867333315, 12, p_2);

Caml_oo_curry.js2(5741474, 13, p_2, 1);

Caml_oo_curry.js1(-867333315, 14, p_2);

Caml_oo_curry.js2(5741474, 15, p_2, 2);

eq("File \"class7_test.ml\", line 63, characters 5-12", {
      2,
      1,
      0,
      0,
      0
    }, {
      get(p_2, 0),
      get(p_2, 1),
      get(p_2, 2),
      get(p_2, 3),
      get(p_2, 4)
    });

function window_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared_1, shared_1);
  top_widget = ids[0];
  top_widget_1 = ids[1];
  CamlinternalOO.set_method(__class, top_widget, (function(self$7) do
          return self$7[top_widget_1];
        end end));
  return (function(env, self) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[top_widget_1] = undefined;
      return self_1;
    end end);
end end

__window = CamlinternalOO.make_class(shared_1, window_init);

function widget_init(__class) do
  w = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared, shared);
  __window = ids[0];
  __window_1 = ids[1];
  CamlinternalOO.set_method(__class, __window, (function(self$8) do
          return self$8[__window_1];
        end end));
  return (function(env, self, w_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[w] = w_1;
      self_1[__window_1] = w_1;
      return self_1;
    end end);
end end

widget = CamlinternalOO.make_class(shared, widget_init);

Mt.from_pair_suites("Class7_test", suites.contents);

exports = {}
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
exports.__window = __window;
exports.widget = widget;
--[[ point Not a pure module ]]
