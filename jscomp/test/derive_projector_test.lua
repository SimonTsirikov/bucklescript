'use strict';

Block = require("../../lib/js/block.lua");

function u_x(param) do
  return param.u_x;
end end

function b_x(param) do
  return param.b_x;
end end

function c_x(param) do
  return param.c_x;
end end

function d_int(param_0) do
  return --[[ D_int ]]Block.__(0, [param_0]);
end end

function d_tuple(param_0, param_1) do
  return --[[ D_tuple ]]Block.__(1, [
            param_0,
            param_1
          ]);
end end

function newContent(param_0) do
  return --[[ NewContent ]]Block.__(2, [param_0]);
end end

function d_tweak(param_0) do
  return --[[ D_tweak ]]Block.__(3, [param_0]);
end end

function u_X(param) do
  return param.u_X;
end end

function d(param) do
  return param.d;
end end

v = --[[ D_int ]]Block.__(0, [3]);

h_001 = --[[ :: ]][
  --[[ D_int ]]Block.__(0, [3]),
  --[[ :: ]][
    --[[ D_tuple ]]Block.__(1, [
        3,
        "hgo"
      ]),
    --[[ :: ]][
      --[[ D_tweak ]]Block.__(3, [--[[ tuple ]][
            3,
            "hgo"
          ]]),
      --[[ :: ]][
        --[[ NewContent ]]Block.__(2, ["3"]),
        --[[ [] ]]0
      ]
    ]
  ]
];

h = --[[ :: ]][
  --[[ D_empty ]]0,
  h_001
];

function xx(param_0) do
  return --[[ Xx ]][param_0];
end end

function a(param_0) do
  return --[[ A ]][param_0];
end end

d_empty = --[[ D_empty ]]0;

hei = --[[ Hei ]]0;

exports.u_x = u_x;
exports.b_x = b_x;
exports.c_x = c_x;
exports.d_empty = d_empty;
exports.d_int = d_int;
exports.d_tuple = d_tuple;
exports.newContent = newContent;
exports.d_tweak = d_tweak;
exports.hei = hei;
exports.u_X = u_X;
exports.d = d;
exports.v = v;
exports.h = h;
exports.xx = xx;
exports.a = a;
--[[ No side effect ]]
