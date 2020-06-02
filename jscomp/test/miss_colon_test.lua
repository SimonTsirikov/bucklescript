console = {log = print};

Block = require "../../lib/js/block";
Caml_int32 = require "../../lib/js/caml_int32";

function $plus$colon(_f, _g) do
  while(true) do
    g = _g;
    f = _f;
    if (not f.tag) then do
      n = f[0];
      if (g.tag) then do
        if (n == 0) then do
          return g;
        end
         end 
      end else do
        return --[[ Int ]]Block.__(0, {n + g[0] | 0});
      end end 
    end
     end 
    local ___conditional___=(g.tag | 0);
    do
       if ___conditional___ == 0--[[ Int ]] then do
          if (g[0] ~= 0) then do
            return --[[ Add ]]Block.__(2, {
                      f,
                      g
                    });
          end else do
            return f;
          end end  end end 
       if ___conditional___ == 2--[[ Add ]] then do
          _g = g[1];
          _f = $plus$colon(f, g[0]);
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

function $star$colon(_f, _g) do
  while(true) do
    g = _g;
    f = _f;
    exit = 0;
    exit_1 = 0;
    if (f.tag) then do
      exit_1 = 3;
    end else do
      n = f[0];
      if (g.tag) then do
        if (n ~= 0) then do
          exit_1 = 3;
        end else do
          return --[[ Int ]]Block.__(0, {0});
        end end 
      end else do
        return --[[ Int ]]Block.__(0, {Caml_int32.imul(n, g[0])});
      end end 
    end end 
    if (exit_1 == 3) then do
      if (g.tag or g[0] ~= 0) then do
        exit = 2;
      end else do
        return --[[ Int ]]Block.__(0, {0});
      end end 
    end
     end 
    if (exit == 2 and not f.tag and f[0] == 1) then do
      return g;
    end
     end 
    local ___conditional___=(g.tag | 0);
    do
       if ___conditional___ == 0--[[ Int ]] then do
          if (g[0] ~= 1) then do
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
          _g = g[1];
          _f = $star$colon(f, g[0]);
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
        return $plus$colon(simplify(f[0]), simplify(f[1])); end end 
     if ___conditional___ == 3--[[ Mul ]] then do
        return $star$colon(simplify(f[0]), simplify(f[1])); end end 
    
  end
end end

exports = {}
exports.$plus$colon = $plus$colon;
exports.$star$colon = $star$colon;
exports.simplify = simplify;
--[[ No side effect ]]
