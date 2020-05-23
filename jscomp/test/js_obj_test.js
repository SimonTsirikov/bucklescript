'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
var CamlinternalOO = require("../../lib/js/camlinternalOO.js");

function f(u) do
  return Caml_oo_curry.js2(5740587, 1, u, 32);
end

function f_js(u) do
  return u.say(32);
end

var class_tables = --[ Cons ]--[
  0,
  0,
  0
];

var suites_000 = --[ tuple ]--[
  "caml_obj",
  (function (param) do
      if (!class_tables[0]) then do
        var $$class = CamlinternalOO.create_table(["say"]);
        var env = CamlinternalOO.new_variable($$class, "");
        var say = CamlinternalOO.get_method_label($$class, "say");
        CamlinternalOO.set_method($$class, say, (function (self$1, x) do
                return 1 + x | 0;
              end));
        var env_init = function (env$1) do
          var self = CamlinternalOO.create_object_opt(0, $$class);
          self[env] = env$1;
          return self;
        end;
        CamlinternalOO.init_class($$class);
        class_tables[0] = env_init;
      end
       end 
      return --[ Eq ]--Block.__(0, [
                33,
                f(Curry._1(class_tables[0], 0))
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "js_obj",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  34,
                  (do
                        say: (function (x) do
                            return x + 2 | 0;
                          end)
                      end).say(32)
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "js_obj2",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    34,
                    (do
                          say: (function (x) do
                              return x + 2 | 0;
                            end)
                        end).say(32)
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "empty",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      0,
                      #Object.keys({ })
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "assign",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        do
                          a: 1
                        end,
                        Object.assign({ }, do
                              a: 1
                            end)
                      ]);
            end)
        ],
        --[ [] ]--0
      ]
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_obj_test", suites);

exports.f = f;
exports.f_js = f_js;
exports.suites = suites;
--[  Not a pure module ]--
