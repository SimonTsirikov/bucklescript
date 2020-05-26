'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Hashtbl = require("../../lib/js/hashtbl.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

shared = ["calc"];

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

function fib_init($$class) do
  calc = CamlinternalOO.get_method_label($$class, "calc");
  CamlinternalOO.set_method($$class, calc, (function (self$1, x) do
          if (x == 0 or x == 1) then do
            return 1;
          end else do
            return Curry._2(self$1[0][calc], self$1, x - 1 | 0) + Curry._2(self$1[0][calc], self$1, x - 2 | 0) | 0;
          end end 
        end end));
  return (function (env, self) do
      return CamlinternalOO.create_object_opt(self, $$class);
    end end);
end end

fib = CamlinternalOO.make_class(shared, fib_init);

function memo_fib_init($$class) do
  ids = CamlinternalOO.new_methods_variables($$class, shared, ["cache"]);
  calc = ids[0];
  cache = ids[1];
  inh = CamlinternalOO.inherits($$class, 0, 0, shared, fib, true);
  obj_init = inh[0];
  calc$1 = inh[1];
  CamlinternalOO.set_method($$class, calc, (function (self$2, x) do
          try do
            return Hashtbl.find(self$2[cache], x);
          end
          catch (exn)do
            if (exn == Caml_builtin_exceptions.not_found) then do
              v = Curry._2(calc$1, self$2, x);
              Hashtbl.add(self$2[cache], x, v);
              return v;
            end else do
              throw exn;
            end end 
          end
        end end));
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[cache] = Hashtbl.create(undefined, 31);
      Curry._1(obj_init, self$1);
      return CamlinternalOO.run_initializers_opt(self, self$1, $$class);
    end end);
end end

memo_fib = CamlinternalOO.make_class(shared, memo_fib_init);

tmp = Curry._1(memo_fib[0], 0);

eq("File \"class_fib_open_recursion_test.ml\", line 33, characters 5-12", Caml_oo_curry.js2(-1044768619, 1, tmp, 40), 165580141);

Mt.from_pair_suites("Class_fib_open_recursion_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fib = fib;
exports.memo_fib = memo_fib;
--[[ fib Not a pure module ]]
