--[['use strict';]]

Pervasives = require "../../lib/js/pervasives";

function str(e) do
  local ___conditional___=(e.tag | 0);
  do
     if ___conditional___ = 0--[[ Numeral ]] then do
        return Pervasives.string_of_float(e[0]);end end end 
     if ___conditional___ = 1--[[ Plus ]] then do
        return str(e[0]) .. ("+" .. str(e[1]));end end end 
     if ___conditional___ = 2--[[ Minus ]] then do
        return str(e[0]) .. ("-" .. str(e[1]));end end end 
     if ___conditional___ = 3--[[ Times ]] then do
        return str(e[0]) .. ("*" .. str(e[1]));end end end 
     if ___conditional___ = 4--[[ Divide ]] then do
        return str(e[0]) .. ("/" .. str(e[1]));end end end 
     if ___conditional___ = 5--[[ Negate ]] then do
        return "-" .. str(e[0]);end end end 
     if ___conditional___ = 6--[[ Variable ]] then do
        return e[0];end end end 
     do
    
  end
end end

exports.str = str;
--[[ No side effect ]]
