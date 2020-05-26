'use strict';


function f9(param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ = 0--[ T60 ]--
       or ___conditional___ = 1--[ T61 ]--
       or ___conditional___ = 2--[ T62 ]-- then do
          return 1;end end end 
       do
      else do
        return 3;
        end end
        
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ T64 ]--
       or ___conditional___ = 1--[ T65 ]-- then do
          return 2;end end end 
       do
      else do
        return 3;
        end end
        
    end
  end end 
end

exports.f9 = f9;
--[ No side effect ]--
