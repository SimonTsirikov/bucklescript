'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    x,
                    y
                  ]);
        end)
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function f(h) do
  return h.x.y.z;
end

function f2(h) do
  return h.x.y.z;
end

function f3(h, x, y) do
  return h.paint(x, y).draw(x, y);
end

function f4(h, x, y) do
  h.paint = --[ tuple ]--[
    x,
    y
  ];
  h.paint.draw = --[ tuple ]--[
    x,
    y
  ];
  return --[ () ]--0;
end

eq("File \"chain_code_test.ml\", line 28, characters 5-12", 32, (do
        x: do
          y: do
            z: 32
          end
        end
      end).x.y.z);

Mt.from_pair_suites("Chain_code_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
--[  Not a pure module ]--
