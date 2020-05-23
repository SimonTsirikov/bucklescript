'use strict';


console.log("list");

console.log("list");

function f(param) do
  if (param ~= undefined) do
    return "Some";
  end else do
    return "None";
  end
end

console.log(--[ tuple ]--[
      f(3),
      "None",
      "Some"
    ]);

console.log(--[ tuple ]--[
      "A",
      "A"
    ]);

--[  Not a pure module ]--
