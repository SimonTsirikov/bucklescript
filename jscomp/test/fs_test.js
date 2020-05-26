'use strict';

var Mt = require("./mt.js");
var Fs = require("fs");
var Path = require("path");
var Block = require("../../lib/js/block.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, param) do
  var y = param[1];
  var x = param[0];
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

var match = typeof __filename == "undefined" and undefined or __filename;

var current_file = match ~= undefined and match or "<Not Node JS>";

var match$1 = typeof __dirname == "undefined" and undefined or __dirname;

var current_dir_name = match$1 ~= undefined and match$1 or "<Not Node Js>";

Fs.readFileSync(current_file, "utf8");

Fs.readdirSync(current_dir_name);

var pathobj = Path.parse(current_dir_name);

var match$2 = typeof module == "undefined" and undefined or module;

if (match$2 ~= undefined) then do
  console.log(--[ tuple ]--[
        match$2.id,
        match$2.paths
      ]);
  eq("File \"fs_test.ml\", line 45, characters 7-14", --[ tuple ]--[
        pathobj.name,
        "test"
      ]);
end
 end 

Mt.from_pair_suites("Fs_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[ match Not a pure module ]--
