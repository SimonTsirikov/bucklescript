'use strict';

var Block = require("../../lib/js/block.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");

function $plus$colon(_f, _g) do
  while(true) do
    var g = _g;
    var f = _f;
    if (!f.tag) then do
      var n = f[0];
      if (g.tag) then do
        if (n == 0) then do
          return g;
        end
         end 
      end else do
        return --[ Int ]--Block.__(0, [n + g[0] | 0]);
      end end 
    end
     end 
    switch (g.tag | 0) do
      case --[ Int ]--0 :
          if (g[0] ~= 0) then do
            return --[ Add ]--Block.__(2, [
                      f,
                      g
                    ]);
          end else do
            return f;
          end end 
      case --[ Add ]--2 :
          _g = g[1];
          _f = $plus$colon(f, g[0]);
          continue ;
      case --[ Var ]--1 :
      case --[ Mul ]--3 :
          return --[ Add ]--Block.__(2, [
                    f,
                    g
                  ]);
      
    end
  end;
end

function $star$colon(_f, _g) do
  while(true) do
    var g = _g;
    var f = _f;
    var exit = 0;
    var exit$1 = 0;
    if (f.tag) then do
      exit$1 = 3;
    end else do
      var n = f[0];
      if (g.tag) then do
        if (n ~= 0) then do
          exit$1 = 3;
        end else do
          return --[ Int ]--Block.__(0, [0]);
        end end 
      end else do
        return --[ Int ]--Block.__(0, [Caml_int32.imul(n, g[0])]);
      end end 
    end end 
    if (exit$1 == 3) then do
      if (g.tag or g[0] ~= 0) then do
        exit = 2;
      end else do
        return --[ Int ]--Block.__(0, [0]);
      end end 
    end
     end 
    if (exit == 2 and !f.tag and f[0] == 1) then do
      return g;
    end
     end 
    switch (g.tag | 0) do
      case --[ Int ]--0 :
          if (g[0] ~= 1) then do
            return --[ Mul ]--Block.__(3, [
                      f,
                      g
                    ]);
          end else do
            return f;
          end end 
      case --[ Var ]--1 :
      case --[ Add ]--2 :
          return --[ Mul ]--Block.__(3, [
                    f,
                    g
                  ]);
      case --[ Mul ]--3 :
          _g = g[1];
          _f = $star$colon(f, g[0]);
          continue ;
      
    end
  end;
end

function simplify(f) do
  switch (f.tag | 0) do
    case --[ Int ]--0 :
    case --[ Var ]--1 :
        return f;
    case --[ Add ]--2 :
        return $plus$colon(simplify(f[0]), simplify(f[1]));
    case --[ Mul ]--3 :
        return $star$colon(simplify(f[0]), simplify(f[1]));
    
  end
end

exports.$plus$colon = $plus$colon;
exports.$star$colon = $star$colon;
exports.simplify = simplify;
--[ No side effect ]--
