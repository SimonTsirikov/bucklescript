'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Ffi_js_test = require("./ffi_js_test.js");

var x = "\x01\x02\x03";

var max = Math.max;

function $$test(x,y){
  return x + y;
}
;

var regression3 = Math.max;

var regression4 = Math.max;

function g(a) do
  var regression = (function(x,y){
   return ""
});
  var regression2 = Math.max;
  regression(a, Pervasives.failwith);
  Curry._2(regression2, 3, 2);
  regression3(3, 2);
  regression4(3, (function (x) do
          return x;
        end));
  return --[ () ]--0;
end

var max2 = Math.max;

function umax(a, b) do
  return max2(a, b);
end

function u(h) do
  return max2(3, h);
end

var max3 = Math.max;

function uu(h) do
  return max2(3, h);
end

var empty = Object.keys(3);

var v = $$test(1, 2);

Mt.from_pair_suites("Unsafe_ppx_test", --[ :: ]--[
      --[ tuple ]--[
        "unsafe_max",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      2,
                      max(1, 2)
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "unsafe_test",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        3,
                        v
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "unsafe_max2",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          2,
                          Math.max(1, 2)
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "ffi_keys",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            ["a"],
                            Ffi_js_test.keys(({a : 3}))
                          ]);
                end)
            ],
            --[ [] ]--0
          ]
        ]
      ]
    ]);

exports.x = x;
exports.max = max;
exports.regression3 = regression3;
exports.regression4 = regression4;
exports.g = g;
exports.max2 = max2;
exports.umax = umax;
exports.u = u;
exports.max3 = max3;
exports.uu = uu;
exports.empty = empty;
exports.v = v;
--[ max Not a pure module ]--
