console = {log = print};

Mt = require "./mt";
Fs = require "";
Path = require "";
Block = require "../../lib/js/block";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. String(test_id.contents)),
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

match = typeof __filename == "undefined" and undefined or __filename;

current_file = match ~= undefined and match or "<Not Node JS>";

match_1 = typeof __dirname == "undefined" and undefined or __dirname;

current_dir_name = match_1 ~= undefined and match_1 or "<Not Node Js>";

Fs.readFileSync(current_file, "utf8");

Fs.readdirSync(current_dir_name);

pathobj = Path.parse(current_dir_name);

match_2 = typeof module == "undefined" and undefined or module;

if (match_2 ~= undefined) then do
  console.log(--[[ tuple ]]{
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

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[ match Not a pure module ]]