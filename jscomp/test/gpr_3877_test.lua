__console = {log = print};


switcher = -299;

if (switcher > 99 or switcher < 0) then do
  if (switcher == -300 or switcher == -299) then do
    __console.log("good response");
  end else do
    __console.log("the catch all");
  end end 
end else if (switcher > 97 or switcher < 12) then do
  __console.log("bad response");
end else do
  __console.log("the catch all");
end end  end 

httpResponseCode = 201;

exports = {};
exports.httpResponseCode = httpResponseCode;
return exports;
--[[  Not a pure module ]]
