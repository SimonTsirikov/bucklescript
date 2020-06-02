--[['use strict';]]

Mt = require "./mt.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Caml_oo_curry = require "../../lib/js/caml_oo_curry.lua";
CamlinternalOO = require "../../lib/js/camlinternalOO.lua";

shared = ["x"];

shared$1 = [
  "move",
  "get_x"
];

function point_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared$1, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, [
        get_x,
        (function (self$1) do
            return self$1[x];
          end end),
        move,
        (function (self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end)
      ]);
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, __class);
      self$1[x] = 0;
      return self$1;
    end end);
end end

point = CamlinternalOO.make_class(shared$1, point_init);

p = Curry._1(point[0], 0);

zero = Caml_oo_curry.js1(291546447, 1, p);

Caml_oo_curry.js2(-933174511, 2, p, 3);

three = Caml_oo_curry.js1(291546447, 3, p);

x0 = do
  contents: 0
end;

function point2_init(__class) do
  ids = CamlinternalOO.new_methods_variables(__class, shared$1, shared);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, [
        get_x,
        (function (self$2) do
            return self$2[x];
          end end),
        move,
        (function (self$2, d) do
            self$2[x] = self$2[x] + d | 0;
            return --[[ () ]]0;
          end end)
      ]);
  return (function (env, self) do
      self$1 = CamlinternalOO.create_object_opt(self, __class);
      x0.contents = x0.contents + 1 | 0;
      self$1[x] = x0.contents;
      return self$1;
    end end);
end end

point2 = CamlinternalOO.make_class(shared$1, point2_init);

tmp = Curry._1(point2[0], 0);

one = Caml_oo_curry.js1(291546447, 4, tmp);

tmp$1 = Curry._1(point2[0], 0);

two = Caml_oo_curry.js1(291546447, 5, tmp$1);

u = do
  x: 3,
  getX: (function () do
      self = this ;
      return self.x; end
    end)
end;

Mt.from_pair_suites("Class_test", --[[ :: ]][
      --[[ tuple ]][
        "File \"class_test.ml\", line 38, characters 4-11",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      zero,
                      0
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "File \"class_test.ml\", line 39, characters 4-11",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        three,
                        3
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "File \"class_test.ml\", line 40, characters 4-11",
            (function (param) do
                return --[[ Eq ]]Block.__(0, [
                          one,
                          1
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "File \"class_test.ml\", line 41, characters 4-11",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, [
                            two,
                            2
                          ]);
                end end)
            ],
            --[[ [] ]]0
          ]
        ]
      ]
    ]);

exports.point = point;
exports.p = p;
exports.zero = zero;
exports.three = three;
exports.x0 = x0;
exports.point2 = point2;
exports.one = one;
exports.two = two;
exports.u = u;
--[[ point Not a pure module ]]
