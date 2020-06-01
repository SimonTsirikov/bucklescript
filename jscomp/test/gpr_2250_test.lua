'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Curry = require("../../lib/js/curry.lua");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.lua");
CamlinternalOO = require("../../lib/js/camlinternalOO.lua");

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

class_tables = --[[ Cons ]][
  0,
  0,
  0
];

function create(param) do
  if (not class_tables[0]) then do
    $$class = CamlinternalOO.create_table([
          "add",
          "get"
        ]);
    env = CamlinternalOO.new_variable($$class, "");
    ids = CamlinternalOO.new_methods_variables($$class, [
          "get",
          "add"
        ], ["data"]);
    get = ids[0];
    add = ids[1];
    data = ids[2];
    CamlinternalOO.set_methods($$class, [
          add,
          (function (self$1, param) do
              self$1[data] = self$1[data] + 1 | 0;
              return self$1;
            end end),
          get,
          (function (self$1, param) do
              return self$1[data];
            end end)
        ]);
    env_init = function (env$1) do
      self = CamlinternalOO.create_object_opt(0, $$class);
      self[data] = 0;
      self[env] = env$1;
      return self;
    end end;
    CamlinternalOO.init_class($$class);
    class_tables[0] = env_init;
  end
   end 
  return Curry._1(class_tables[0], 0);
end end

cxt1 = create(--[[ () ]]0);

tmp = Caml_oo_curry.js2(4846113, 1, cxt1, --[[ () ]]0);

result = Caml_oo_curry.js2(5144726, 2, tmp, --[[ () ]]0);

eq("File \"gpr_2250_test.ml\", line 26, characters 5-12", result, 1);

cxt2 = create(--[[ () ]]0);

tmp$1 = Caml_oo_curry.js2(4846113, 3, cxt2, --[[ () ]]0);

tmp$2 = Caml_oo_curry.js2(4846113, 4, tmp$1, --[[ () ]]0);

result2 = Caml_oo_curry.js2(5144726, 5, tmp$2, --[[ () ]]0);

eq("File \"gpr_2250_test.ml\", line 37, characters 5-12", result2, 2);

Mt.from_pair_suites("Gpr_2250_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.create = create;
exports.cxt1 = cxt1;
exports.result = result;
exports.cxt2 = cxt2;
exports.result2 = result2;
--[[ cxt1 Not a pure module ]]
