'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Bytes = require("../../lib/js/bytes.js");
Caml_bytes = require("../../lib/js/caml_bytes.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
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

b = [
  0,
  0,
  0
];

b[0] = --[ "a" ]--97;

b[1] = --[ "b" ]--98;

b[2] = --[ "c" ]--99;

Bytes.blit(b, 0, b, 1, 2);

res = Caml_bytes.bytes_to_string(b);

console.log(res);

eq("File \"bytes_split_gpr_743_test.ml\", line 17, characters 5-12", --[ tuple ]--[
      "aab",
      res
    ]);

b$1 = [
  0,
  0,
  0
];

b$1[0] = --[ "a" ]--97;

b$1[1] = --[ "b" ]--98;

b$1[2] = --[ "c" ]--99;

Bytes.blit(b$1, 1, b$1, 0, 2);

res2 = Caml_bytes.bytes_to_string(b$1);

console.log(res2);

eq("File \"bytes_split_gpr_743_test.ml\", line 32, characters 5-12", --[ tuple ]--[
      "bcc",
      res2
    ]);

Mt.from_pair_suites("Bytes_split_gpr_743_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[  Not a pure module ]--
