'use strict';

Arg = require("../../lib/js/arg.js");
Block = require("../../lib/js/block.js");

function anno_fun(arg) do
  return --[[ () ]]0;
end end

usage_msg = "Usage:\n";

compile = do
  contents: false
end;

test = do
  contents: true
end;

arg_spec_000 = --[[ tuple ]][
  "-c",
  --[[ Set ]]Block.__(2, [compile]),
  " Compile"
];

arg_spec_001 = --[[ :: ]][
  --[[ tuple ]][
    "-d",
    --[[ Clear ]]Block.__(3, [test]),
    " Test"
  ],
  --[[ [] ]]0
];

arg_spec = --[[ :: ]][
  arg_spec_000,
  arg_spec_001
];

Arg.parse(arg_spec, anno_fun, usage_msg);

exports.anno_fun = anno_fun;
exports.usage_msg = usage_msg;
exports.compile = compile;
exports.test = test;
exports.arg_spec = arg_spec;
--[[  Not a pure module ]]
