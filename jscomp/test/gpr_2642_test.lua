__console = {log = print};


function isfree(id, _param) do
  while(true) do
    param = _param;
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Pident ]] then do
          return id == param[1]; end end 
       if ___conditional___ == 1--[[ Pdot ]] then do
          _param = param[1];
          ::continue:: ; end end 
       if ___conditional___ == 2--[[ Papply ]] then do
          if (isfree(id, param[1])) then do
            return true;
          end else do
            _param = param[2];
            ::continue:: ;
          end end  end end 
      
    end
  end;
end end

exports = {};
exports.isfree = isfree;
return exports;
--[[ No side effect ]]
