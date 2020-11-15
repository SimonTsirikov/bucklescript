__console = {log = print};


match = type(require) == "undefined" and nil or require;

if (match ~= nil) then do
  __console.log(match.resolve("./test_require.js"));
  match_1 = type(module) == "undefined" and nil or module;
  match_2 = match.main;
  if (match_1 ~= nil) then do
    if (match_2 ~= nil and match_1 == match_2) then do
      __console.log("is main");
    end else do
      __console.log("not main");
    end end 
  end else do
    __console.log("not main");
  end end 
end
 end 

exports = {};
return exports;
--[[ match Not a pure module ]]
