--[['use strict';]]


function isfree(id, _param) do
  while(true) do
    param = _param;
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[[ Pident ]] then do
          return id == param[0];end end end 
       if ___conditional___ = 1--[[ Pdot ]] then do
          _param = param[0];
          ::continue:: ;end end end 
       if ___conditional___ = 2--[[ Papply ]] then do
          if (isfree(id, param[0])) then do
            return true;
          end else do
            _param = param[1];
            ::continue:: ;
          end end end end end 
       do
      
    end
  end;
end end

exports.isfree = isfree;
--[[ No side effect ]]
