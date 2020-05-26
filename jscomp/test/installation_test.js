'use strict';

Mt = require("./mt.js");
Fs = require("fs");
Path = require("path");
Block = require("../../lib/js/block.js");
Child_process = require("child_process");
App_root_finder = require("./app_root_finder.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
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

match = typeof __dirname == "undefined" and undefined or __dirname;

if (match ~= undefined) then do
  root = App_root_finder.find_package_json(match);
  bsc_exe = Path.join(root, "bsc");
  exit = 0;
  output;
  try do
    output = Child_process.execSync(bsc_exe .. " -where ", do
          encoding: "utf8"
        end);
    exit = 1;
  end
  catch (e)do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "installation_test.ml",
            33,
            8
          ]
        ];
  end
  if (exit == 1) then do
    dir = output.trim();
    files = Fs.readdirSync(dir);
    exists = files.indexOf("pervasives.cmi");
    non_exists = files.indexOf("pervasive.cmi");
    v = exists >= 0 and non_exists < 0;
    console.log(v);
  end
   end 
end else do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "installation_test.ml",
          35,
          18
        ]
      ];
end end 

Mt.from_pair_suites("Installation_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[ match Not a pure module ]--
