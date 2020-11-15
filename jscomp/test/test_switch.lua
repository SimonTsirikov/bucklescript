__console = {log = print};

Block = require "......lib.js.block";
Curry = require "......lib.js.curry";

function f(param) do
  if (type(param) == "number") then do
    if (param == --[[ G ]]0) then do
      return 4;
    end else do
      return 5;
    end end 
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ A ]] then do
          return 0; end end 
       if ___conditional___ == 1--[[ B ]] then do
          return 1; end end 
       if ___conditional___ == 2--[[ C ]] then do
          return 2; end end 
       if ___conditional___ == 3--[[ F ]] then do
          return 3; end end 
      
    end
  end end 
end end

function bind(x, f) do
  if (x.tag) then do
    return x;
  end else do
    return --[[ Left ]]Block.__(0, {Curry._1(f, x[1])});
  end end 
end end

exports = {};
exports.f = f;
exports.bind = bind;
return exports;
--[[ No side effect ]]
