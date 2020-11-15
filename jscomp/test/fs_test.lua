__console = {log = print};

Mt = require "..mt";
Fs = require "fs";
Path = require "path";
Block = require "......lib.js.block";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, param) do
  y = param[2];
  x = param[1];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

match = type(__filename) == "undefined" and nil or __filename;

current_file = match ~= nil and match or "<Not Node JS>";

match_1 = type(__dirname) == "undefined" and nil or __dirname;

current_dir_name = match_1 ~= nil and match_1 or "<Not Node Js>";

Fs.readFileSync(current_file, "utf8");

Fs.readdirSync(current_dir_name);

pathobj = Path.parse(current_dir_name);

match_2 = type(module) == "undefined" and nil or module;

if (match_2 ~= nil) then do
  __console.log(--[[ tuple ]]{
        match_2.id,
        match_2.paths
      });
  eq("File \"fs_test.ml\", line 45, characters 7-14", --[[ tuple ]]{
        pathobj.name,
        "test"
      });
end
 end 

Mt.from_pair_suites("Fs_test", suites.contents);

exports = {};
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
return exports;
--[[ match Not a pure module ]]
