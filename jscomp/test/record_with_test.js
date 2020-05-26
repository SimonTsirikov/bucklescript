'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");

v = do
  syntax: undefined,
  imports: 0,
  file_options: 0,
  package: 0,
  messages: 0,
  enums: 0,
  extends: 0
end;

u_v = do
  syntax: undefined,
  imports: 0,
  file_options: 0,
  package: 0,
  messages: 0,
  enums: 0,
  extends: 0
end;

function f(g, h) do
  init = Curry._1(g, h);
  return do
          syntax: init.syntax,
          imports: 0,
          file_options: init.file_options,
          package: init.package,
          messages: init.messages,
          enums: init.enums,
          extends: init.extends
        end;
end

suites_000 = --[ tuple ]--[
  "eq_with",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                v,
                u_v
              ]);
    end)
];

suites = --[ :: ]--[
  suites_000,
  --[ [] ]--0
];

Mt.from_pair_suites("Record_with_test", suites);

uv = do
  syntax: undefined,
  imports: 1,
  file_options: 0,
  package: 0,
  messages: 0,
  enums: 0,
  extends: 0
end;

exports.v = v;
exports.uv = uv;
exports.u_v = u_v;
exports.f = f;
exports.suites = suites;
--[  Not a pure module ]--
