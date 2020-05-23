'use strict';


function isfree(id, _param) do
  while(true) do
    var param = _param;
    switch (param.tag | 0) do
      case --[ Pident ]--0 :
          return id == param[0];
      case --[ Pdot ]--1 :
          _param = param[0];
          continue ;
      case --[ Papply ]--2 :
          if (isfree(id, param[0])) do
            return true;
          end else do
            _param = param[1];
            continue ;
          end
      
    end
  end;
end

exports.isfree = isfree;
--[ No side effect ]--
