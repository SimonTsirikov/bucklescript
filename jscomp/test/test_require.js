'use strict';


var match = typeof require == "undefined" ? undefined : require;

if (match ~= undefined) do
  console.log(match.resolve("./test_require.js"));
  var match$1 = typeof module == "undefined" ? undefined : module;
  var match$2 = match.main;
  if (match$1 ~= undefined) do
    if (match$2 ~= undefined and match$1 == match$2) do
      console.log("is main");
    end else do
      console.log("not main");
    end
  end else do
    console.log("not main");
  end
end

--[ match Not a pure module ]--
