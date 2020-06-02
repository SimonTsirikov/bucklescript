console = {log = print};


match = typeof require == "undefined" and undefined or require;

if (match ~= undefined) then do
  console.log(match.resolve("./test_require.js"));
  match_1 = typeof module == "undefined" and undefined or module;
  match_2 = match.main;
  if (match_1 ~= undefined) then do
    if (match_2 ~= undefined and match_1 == match_2) then do
      console.log("is main");
    end else do
      console.log("not main");
    end end 
  end else do
    console.log("not main");
  end end 
end
 end 

exports = {}
--[[ match Not a pure module ]]
