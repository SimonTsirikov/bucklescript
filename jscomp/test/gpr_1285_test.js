'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");

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

class_tables$1 = --[[ Cons ]][
  0,
  0,
  0
];

function step1(param) do
  if (!class_tables[0]) then do
    $$class = CamlinternalOO.create_table(["step2"]);
    env = CamlinternalOO.new_variable($$class, "");
    step2 = CamlinternalOO.get_method_label($$class, "step2");
    CamlinternalOO.set_method($$class, step2, (function (self$1) do
            if (!class_tables$1[0]) then do
              $$class = CamlinternalOO.create_table(["step3"]);
              env = CamlinternalOO.new_variable($$class, "");
              step3 = CamlinternalOO.get_method_label($$class, "step3");
              CamlinternalOO.set_method($$class, step3, (function (self$2) do
                      return 33;
                    end end));
              env_init = function (env$1) do
                self = CamlinternalOO.create_object_opt(0, $$class);
                self[env] = env$1;
                return self;
              end end;
              CamlinternalOO.init_class($$class);
              class_tables$1[0] = env_init;
            end
             end 
            return Curry._1(class_tables$1[0], 0);
          end end));
    env_init = function (env$1) do
      self = CamlinternalOO.create_object_opt(0, $$class);
      self[env] = env$1;
      return self;
    end end;
    CamlinternalOO.init_class($$class);
    class_tables[0] = env_init;
  end
   end 
  return Curry._1(class_tables[0], 0);
end end

tmp = step1(--[[ () ]]0);

tmp$1 = Caml_oo_curry.js1(68057958, 1, tmp);

x = Caml_oo_curry.js1(68057959, 2, tmp$1);

eq("File \"gpr_1285_test.ml\", line 20, characters 5-12", x, 33);

Mt.from_pair_suites("Gpr_1285_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.step1 = step1;
exports.x = x;
--[[ x Not a pure module ]]
