'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Stack = require("../../lib/js/stack.js");

function to_list(v) do
  acc = --[ [] ]--0;
  while(v.c ~= --[ [] ]--0) do
    acc = --[ :: ]--[
      Stack.pop(v),
      acc
    ];
  end;
  return List.rev(acc);
end

function v(param) do
  v$1 = do
    c: --[ [] ]--0,
    len: 0
  end;
  Stack.push(3, v$1);
  Stack.push(4, v$1);
  Stack.push(1, v$1);
  return to_list(v$1);
end

suites_000 = --[ tuple ]--[
  "push_test",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                --[ :: ]--[
                  1,
                  --[ :: ]--[
                    4,
                    --[ :: ]--[
                      3,
                      --[ [] ]--0
                    ]
                  ]
                ],
                v(--[ () ]--0)
              ]);
    end)
];

suites = --[ :: ]--[
  suites_000,
  --[ [] ]--0
];

Mt.from_pair_suites("Stack_test", suites);

exports.to_list = to_list;
exports.v = v;
exports.suites = suites;
--[  Not a pure module ]--
