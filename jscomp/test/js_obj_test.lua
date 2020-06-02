--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Caml_oo_curry = require "../../lib/js/caml_oo_curry.lua";
CamlinternalOO = require "../../lib/js/camlinternalOO.lua";

function f(u) do
  return Caml_oo_curry.js2(5740587, 1, u, 32);
end end

function f_js(u) do
  return u.say(32);
end end

class_tables = --[[ Cons ]][
  0,
  0,
  0
];

suites_000 = --[[ tuple ]][
  "caml_obj",
  (function (param) do
      if (not class_tables[0]) then do
        __class = CamlinternalOO.create_table(["say"]);
        env = CamlinternalOO.new_variable(__class, "");
        say = CamlinternalOO.get_method_label(__class, "say");
        CamlinternalOO.set_method(__class, say, (function (self$1, x) do
                return 1 + x | 0;
              end end));
        env_init = function (env$1) do
          self = CamlinternalOO.create_object_opt(0, __class);
          self[env] = env$1;
          return self;
        end end;
        CamlinternalOO.init_class(__class);
        class_tables[0] = env_init;
      end
       end 
      return --[[ Eq ]]Block.__(0, [
                33,
                f(Curry._1(class_tables[0], 0))
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "js_obj",
    (function (param) do
        return --[[ Eq ]]Block.__(0, [
                  34,
                  (do
                        say: (function (x) do
                            return x + 2 | 0;
                          end end)
                      end).say(32)
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "js_obj2",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    34,
                    (do
                          say: (function (x) do
                              return x + 2 | 0;
                            end end)
                        end).say(32)
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "empty",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      0,
                      #Object.keys({ })
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "assign",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        do
                          a: 1
                        end,
                        Object.assign({ }, do
                              a: 1
                            end)
                      ]);
            end end)
        ],
        --[[ [] ]]0
      ]
    ]
  ]
];

suites = --[[ :: ]][
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_obj_test", suites);

exports.f = f;
exports.f_js = f_js;
exports.suites = suites;
--[[  Not a pure module ]]
