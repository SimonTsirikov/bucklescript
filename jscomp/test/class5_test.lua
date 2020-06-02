console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Pervasives = require "../../lib/js/pervasives";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";

shared = {
  "fold",
  "empty"
};

shared_1 = {"x"};

shared_2 = {
  "move",
  "get_x"
};

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

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

function printable_point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "print",
        "move",
        "get_x"
      }, shared_1);
  print = ids[0];
  move = ids[1];
  get_x = ids[2];
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
        print,
        (function(self$1) do
            return String(Curry._1(self$1[0][get_x], self$1));
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

printable_point = CamlinternalOO.make_class({
      "move",
      "print",
      "get_x"
    }, printable_point_init);

function printable_colored_point_init(__class) do
  y = CamlinternalOO.new_variable(__class, "");
  c = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "print",
        "color"
      }, {"c"});
  print = ids[0];
  color = ids[1];
  c_1 = ids[2];
  CamlinternalOO.set_method(__class, color, (function(self$2) do
          return self$2[c_1];
        end end));
  inh = CamlinternalOO.inherits(__class, shared_1, 0, {
        "get_x",
        "move",
        "print"
      }, printable_point, true);
  obj_init = inh[0];
  print_1 = inh[4];
  CamlinternalOO.set_method(__class, print, (function(self$2) do
          return "(" .. (Curry._1(print_1, self$2) .. (", " .. (Curry._1(self$2[0][color], self$2) .. ")")));
        end end));
  return (function(env, self, y_1, c_2) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[c] = c_2;
      self_1[y] = y_1;
      self_1[c_1] = c_2;
      Curry._2(obj_init, self_1, y_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

printable_colored_point = CamlinternalOO.make_class({
      "move",
      "print",
      "color",
      "get_x"
    }, printable_colored_point_init);

p = Curry._3(printable_colored_point[0], 0, 17, "red");

eq("File \"class5_test.ml\", line 32, characters 12-19", Caml_oo_curry.js1(-930392019, 1, p), "(17, red)");

function ref_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, {
        "set",
        "get"
      }, shared_1);
  set = ids[0];
  get = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get,
        (function(self$3) do
            return self$3[x];
          end end),
        set,
        (function(self$3, y) do
            self$3[x] = y;
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

ref = CamlinternalOO.make_class({
      "get",
      "set"
    }, ref_init);

r = Curry._2(ref[0], 0, 1);

Caml_oo_curry.js2(5741474, 2, r, 2);

v = Caml_oo_curry.js1(5144726, 3, r);

eq("File \"class5_test.ml\", line 43, characters 12-19", v, 2);

function intlist_init(__class) do
  l = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.get_method_labels(__class, shared);
  fold = ids[0];
  empty = ids[1];
  CamlinternalOO.set_methods(__class, {
        empty,
        (function(self$4) do
            return self$4[l] == --[[ [] ]]0;
          end end),
        fold,
        (function(self$4, f, accu) do
            return List.fold_left(f, accu, self$4[l]);
          end end)
      });
  return (function(env, self, l_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[l] = l_1;
      return self_1;
    end end);
end end

intlist = CamlinternalOO.make_class(shared, intlist_init);

l = Curry._2(intlist[0], 0, --[[ :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ :: ]]{
          3,
          --[[ [] ]]0
        }
      }
    });

eq("File \"class5_test.ml\", line 54, characters 5-12", 6, Caml_oo_curry.js3(-1010803711, 4, l, (function(x, y) do
            return x + y | 0;
          end end), 0));

function intlist2_init(__class) do
  l = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.get_method_labels(__class, shared);
  fold = ids[0];
  empty = ids[1];
  CamlinternalOO.set_methods(__class, {
        empty,
        (function(self$5) do
            return self$5[l] == --[[ [] ]]0;
          end end),
        fold,
        (function(self$5, f, accu) do
            return List.fold_left(f, accu, self$5[l]);
          end end)
      });
  return (function(env, self, l_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[l] = l_1;
      return self_1;
    end end);
end end

intlist2 = CamlinternalOO.make_class(shared, intlist2_init);

l_1 = Curry._2(intlist2[0], 0, --[[ :: ]]{
      1,
      --[[ :: ]]{
        2,
        --[[ :: ]]{
          3,
          --[[ [] ]]0
        }
      }
    });

eq("File \"class5_test.ml\", line 67, characters 5-12", --[[ tuple ]]{
      6,
      "1 2 3 "
    }, --[[ tuple ]]{
      Caml_oo_curry.js3(-1010803711, 5, l_1, (function(x, y) do
              return x + y | 0;
            end end), 0),
      Caml_oo_curry.js3(-1010803711, 6, l_1, (function(s, x) do
              return s .. (String(x) .. " ");
            end end), "")
    });

function point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared_2, shared_1);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
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
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

point = CamlinternalOO.make_class(shared_2, point_init);

function distance_point_init(__class) do
  x = CamlinternalOO.new_variable(__class, "");
  distance = CamlinternalOO.get_method_label(__class, "distance");
  inh = CamlinternalOO.inherits(__class, shared_1, 0, {
        "get_x",
        "move"
      }, point, true);
  obj_init = inh[0];
  x_1 = inh[1];
  CamlinternalOO.set_method(__class, distance, (function(self$7, other) do
          return Pervasives.abs(Caml_oo_curry.js1(291546447, 7, other) - self$7[x_1] | 0);
        end end));
  return (function(env, self, x_2) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x] = x_2;
      Curry._2(obj_init, self_1, x_2);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

distance_point = CamlinternalOO.make_class({
      "move",
      "distance",
      "get_x"
    }, distance_point_init);

p_1 = Curry._2(distance_point[0], 0, 3);

a = Caml_oo_curry.js2(-335965387, 8, p_1, Curry._2(point[0], 0, 8));

b = Caml_oo_curry.js2(-335965387, 9, p_1, Curry._3(printable_colored_point[0], 0, 1, "blue"));

eq("File \"class5_test.ml\", line 94, characters 5-12", --[[ tuple ]]{
      5,
      2
    }, --[[ tuple ]]{
      a,
      b
    });

Mt.from_pair_suites("Class5_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.printable_point = printable_point;
exports.printable_colored_point = printable_colored_point;
exports.p = p;
exports.ref = ref;
exports.v = v;
exports.intlist = intlist;
exports.intlist2 = intlist2;
exports.l = l_1;
exports.point = point;
exports.distance_point = distance_point;
exports.a = a;
exports.b = b;
--[[ printable_point Not a pure module ]]