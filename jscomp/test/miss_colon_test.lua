__console = {log = print};

Block = require "......lib.js.block";
Caml_int32 = require "......lib.js.caml_int32";

function _plus_colon(_f, _g) do
  while(true) do
    g = _g;
    f = _f;
    if (not f.tag) then do
      n = f[1];
      if (g.tag) then do
        if (n == 0) then do
          return g;
        end
         end 
      end else do
        return --[[ Int ]]Block.__(0, {n + g[1] | 0});
      end end 
    end
     end 
    local ___conditional___=(g.tag | 0);
    do
       if ___conditional___ == 0--[[ Int ]] then do
          if (g[1] ~= 0) then do
            return --[[ Add ]]Block.__(2, {
                      f,
                      g
                    });
          end else do
            return f;
          end end  end end 
       if ___conditional___ == 2--[[ Add ]] then do
          _g = g[2];
          _f = _plus_colon(f, g[1]);
          ::continue:: ; end end 
       if ___conditional___ == 1--[[ Var ]]
       or ___conditional___ == 3--[[ Mul ]] then do
          return --[[ Add ]]Block.__(2, {
                    f,
                    g
                  }); end end 
      
    end
  end;
end end

function _star_colon(_f, _g) do
  while(true) do
    g = _g;
    f = _f;
    exit = 0;
    exit_1 = 0;
    if (f.tag) then do
      exit_1 = 3;
    end else do
      n = f[1];
      if (g.tag) then do
        if (n ~= 0) then do
          exit_1 = 3;
        end else do
          return --[[ Int ]]Block.__(0, {0});
        end end 
      end else do
        return --[[ Int ]]Block.__(0, {Caml_int32.imul(n, g[1])});
      end end 
    end end 
    if (exit_1 == 3) then do
      if (g.tag or g[1] ~= 0) then do
        exit = 2;
      end else do
        return --[[ Int ]]Block.__(0, {0});
      end end 
    end
     end 
    if (exit == 2 and not f.tag and f[1] == 1) then do
      return g;
    end
     end 
    local ___conditional___=(g.tag | 0);
    do
       if ___conditional___ == 0--[[ Int ]] then do
          if (g[1] ~= 1) then do
            return --[[ Mul ]]Block.__(3, {
                      f,
                      g
                    });
          end else do
            return f;
          end end  end end 
       if ___conditional___ == 1--[[ Var ]]
       or ___conditional___ == 2--[[ Add ]] then do
          return --[[ Mul ]]Block.__(3, {
                    f,
                    g
                  }); end end 
       if ___conditional___ == 3--[[ Mul ]] then do
          _g = g[2];
          _f = _star_colon(f, g[1]);
          ::continue:: ; end end 
      
    end
  end;
end end

function simplify(f) do
  local ___conditional___=(f.tag | 0);
  do
     if ___conditional___ == 0--[[ Int ]]
     or ___conditional___ == 1--[[ Var ]] then do
        return f; end end 
     if ___conditional___ == 2--[[ Add ]] then do
        return _plus_colon(simplify(f[1]), simplify(f[2])); end end 
     if ___conditional___ == 3--[[ Mul ]] then do
        return _star_colon(simplify(f[1]), simplify(f[2])); end end 
    
  end
end end

exports = {};
exports._plus_colon = _plus_colon;
exports._star_colon = _star_colon;
exports.simplify = simplify;
return exports;
--[[ No side effect ]]
