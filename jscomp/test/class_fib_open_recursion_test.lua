__console = {log = print};

Mt = require "..mt";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Hashtbl = require "......lib.js.hashtbl";
Caml_oo_curry = require "......lib.js.caml_oo_curry";
CamlinternalOO = require "......lib.js.camlinternalOO";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

shared = {"calc"};

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
      loc .. (" id " .. __String(test_id.contents)),
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

function fib_init(__class) do
  calc = CamlinternalOO.get_method_label(__class, "calc");
  CamlinternalOO.set_method(__class, calc, (function(self_1, x) do
          if (x == 0 or x == 1) then do
            return 1;
          end else do
            return Curry._2(self_1[1][calc], self_1, x - 1 | 0) + Curry._2(self_1[1][calc], self_1, x - 2 | 0) | 0;
          end end 
        end end));
  return (function(env, self) do
      return CamlinternalOO.create_object_opt(self, __class);
    end end);
end end

fib = CamlinternalOO.make_class(shared, fib_init);

function memo_fib_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared, {"cache"});
  calc = ids[1];
  cache = ids[2];
  inh = CamlinternalOO.inherits(__class, 0, 0, shared, fib, true);
  obj_init = inh[1];
  calc_1 = inh[2];
  CamlinternalOO.set_method(__class, calc, (function(self_2, x) do
          xpcall(function() do
            return Hashtbl.find(self_2[cache], x);
          end end,function(exn) do
            if (exn == Caml_builtin_exceptions.not_found) then do
              v = Curry._2(calc_1, self_2, x);
              Hashtbl.add(self_2[cache], x, v);
              return v;
            end else do
              error(exn)
            end end 
          end end)
        end end));
  return (function(env, self) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[cache] = Hashtbl.create(nil, 31);
      Curry._1(obj_init, self_1);
      return CamlinternalOO.run_initializers_opt(self, self_1, __class);
    end end);
end end

memo_fib = CamlinternalOO.make_class(shared, memo_fib_init);

tmp = Curry._1(memo_fib[1], 0);

eq("File \"class_fib_open_recursion_test.ml\", line 33, characters 5-12", Caml_oo_curry.js2(-1044768619, 1, tmp, 40), 165580141);

Mt.from_pair_suites("Class_fib_open_recursion_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fib = fib;
exports.memo_fib = memo_fib;
return exports;
--[[ fib Not a pure module ]]
