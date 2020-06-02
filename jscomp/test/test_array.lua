--[['use strict';]]

$$Array = require "../../lib/js/array.lua";
Caml_array = require "../../lib/js/caml_array.lua";

v = Caml_array.caml_make_vect(6, 5);

Caml_array.caml_make_float_vect(30);

h = $$Array.sub(v, 0, 2);

hhh = $$Array.append([
      1,
      2,
      3,
      4
    ], [
      1,
      2,
      3,
      5
    ]);

u = Caml_array.caml_array_concat(--[[ :: ]][
      [
        1,
        2
      ],
      --[[ :: ]][
        [
          2,
          3
        ],
        --[[ :: ]][
          [
            3,
            4
          ],
          --[[ [] ]]0
        ]
      ]
    ]);

hh = $$Array.blit;

exports.v = v;
exports.h = h;
exports.hh = hh;
exports.hhh = hhh;
exports.u = u;
--[[  Not a pure module ]]
