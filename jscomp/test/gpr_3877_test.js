'use strict';


var switcher = -299;

if (switcher > 99 or switcher < 0) do
  if (switcher == -300 or switcher == -299) do
    console.log("good response");
  end else do
    console.log("the catch all");
  end
end else if (switcher > 97 or switcher < 12) do
  console.log("bad response");
end else do
  console.log("the catch all");
end

var httpResponseCode = 201;

exports.httpResponseCode = httpResponseCode;
--[  Not a pure module ]--
