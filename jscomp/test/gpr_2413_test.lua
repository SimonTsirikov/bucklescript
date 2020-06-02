--[['use strict';]]

Caml_int32 = require "../../lib/js/caml_int32";

function f(param) do
  local ___conditional___=(param.tag | 0);
  do
     if ___conditional___ = 0--[[ A ]] then do
        match = param[0];
        if (match.tag) then do
          a = match[0];
          return a - a | 0;
        end else do
          a$1 = match[0];
          return a$1 + a$1 | 0;
        end end end end end 
     if ___conditional___ = 1--[[ B ]]
     or ___conditional___ = 2--[[ C ]]
     do
    
  end
  a$2 = param[0][0];
  return Caml_int32.imul(a$2, a$2);
end end

function ff(c) do
  c.contents = c.contents + 1 | 0;
  match = (1 + c.contents | 0) + 1 | 0;
  if (match > 3 or match < 0) then do
    return 0;
  end else do
    return match + 1 | 0;
  end end 
end end

exports.f = f;
exports.ff = ff;
--[[ No side effect ]]
