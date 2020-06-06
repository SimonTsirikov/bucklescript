console = {log = print};


match = typeof require == "undefined" and nil or require;

if (match ~= nil) then do
  console.log(match.resolve("./test_require.js"));
  match_1 = typeof module == "undefined" and nil or module;
  match_2 = match.main;
  if (match_1 ~= nil) then do
    if (match_2 ~= nil and match_1 == match_2) then do
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
