'use strict';

var Block = require("../../lib/js/block.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function is_number(_expr) do
  while(true) do
    var expr = _expr;
    local ___conditional___=(expr.tag | 0);
    do
       if ___conditional___ = 0--[ Val ]-- then do
          if (expr[0].tag) then do
            return false;
          end else do
            return true;
          end end end end end 
       if ___conditional___ = 1--[ Neg ]-- then do
          _expr = expr[0];
          continue ;end end end 
       if ___conditional___ = 2--[ Sum ]--
       or ___conditional___ = 3--[ Pow ]--
       or ___conditional___ = 4--[ Frac ]--
       or ___conditional___ = 5--[ Gcd ]-- then do
          return false;end end end 
       do
      
    end
  end;
end

function compare(context, state, _a, _b) do
  while(true) do
    var b = _b;
    var a = _a;
    var exit = 0;
    var na;
    var da;
    var nb;
    var db;
    var exit$1 = 0;
    var exit$2 = 0;
    var exit$3 = 0;
    local ___conditional___=(a.tag | 0);
    do
       if ___conditional___ = 0--[ Val ]-- then do
          local ___conditional___=(b.tag | 0);
          do
             if ___conditional___ = 0--[ Val ]-- then do
                return 111;end end end 
             if ___conditional___ = 1--[ Neg ]-- then do
                exit$3 = 5;end else 
             if ___conditional___ = 2--[ Sum ]-- then do
                exit$2 = 4;end else 
             if ___conditional___ = 4--[ Frac ]-- then do
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "gpr_1698_test.ml",
                        45,
                        10
                      ]
                    ];end end end 
             if ___conditional___ = 3--[ Pow ]--
             or ___conditional___ = 5--[ Gcd ]-- then do
                exit = 1;end else 
             do end end
            
          endend else 
       if ___conditional___ = 1--[ Neg ]-- then do
          _a = a[0];
          continue ;end end end 
       if ___conditional___ = 2--[ Sum ]--
       or ___conditional___ = 3--[ Pow ]-- then do
          exit$3 = 5;end else 
       if ___conditional___ = 4--[ Frac ]-- then do
          local ___conditional___=(b.tag | 0);
          do
             if ___conditional___ = 0--[ Val ]-- then do
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "gpr_1698_test.ml",
                        45,
                        10
                      ]
                    ];end end end 
             if ___conditional___ = 1--[ Neg ]-- then do
                exit$3 = 5;end else 
             if ___conditional___ = 2--[ Sum ]-- then do
                exit$2 = 4;end else 
             if ___conditional___ = 4--[ Frac ]-- then do
                na = a[0];
                da = a[1];
                nb = b[0];
                db = b[1];
                exit = 2;end else 
             if ___conditional___ = 3--[ Pow ]--
             or ___conditional___ = 5--[ Gcd ]-- then do
                exit = 1;end else 
             do end end end end
            
          endend else 
       if ___conditional___ = 5--[ Gcd ]-- then do
          local ___conditional___=(b.tag | 0);
          do
             if ___conditional___ = 1--[ Neg ]-- then do
                exit$3 = 5;end else 
             if ___conditional___ = 2--[ Sum ]-- then do
                exit$2 = 4;end else 
             if ___conditional___ = 5--[ Gcd ]-- then do
                na = a[0];
                da = a[1];
                nb = b[0];
                db = b[1];
                exit = 2;end else 
             do end end end end
            else do
              exit$1 = 3;
              end end
              
          endend else 
       do end end end end
      
    end
    if (exit$3 == 5) then do
      if (b.tag == --[ Neg ]--1) then do
        _b = b[0];
        continue ;
      end else if (a.tag == --[ Sum ]--2 and is_number(b)) then do
        return 1;
      end else do
        exit$2 = 4;
      end end  end 
    end
     end 
    if (exit$2 == 4) then do
      if (b.tag == --[ Sum ]--2 and is_number(a)) then do
        return -1;
      end else do
        exit$1 = 3;
      end end 
    end
     end 
    if (exit$1 == 3) then do
      local ___conditional___=(a.tag | 0);
      do
         if ___conditional___ = 2--[ Sum ]-- then do
            exit = 1;end else 
         if ___conditional___ = 3--[ Pow ]-- then do
            return -1;end end end 
         if ___conditional___ = 0--[ Val ]--
         or ___conditional___ = 4--[ Frac ]--
         or ___conditional___ = 5--[ Gcd ]-- then do
            return 1;end end end 
         do
        
      end
    end
     end 
    local ___conditional___=(exit);
    do
       if ___conditional___ = 1 then do
          local ___conditional___=(b.tag | 0);
          do
             if ___conditional___ = 3--[ Pow ]-- then do
                return 1;end end end 
             if ___conditional___ = 5--[ Gcd ]-- then do
                return -1;end end end 
             do
            else do
              return -1;
              end end
              
          endend end end 
       if ___conditional___ = 2 then do
          var denom = compare(context, state, da, db);
          if (denom == 0) then do
            _b = nb;
            _a = na;
            continue ;
          end else do
            return denom;
          end end end end end 
       do
      
    end
  end;
end

var a = --[ Sum ]--Block.__(2, [--[ :: ]--[
      --[ Val ]--Block.__(0, [--[ Symbol ]--Block.__(1, ["a"])]),
      --[ :: ]--[
        --[ Val ]--Block.__(0, [--[ Natural ]--Block.__(0, [2])]),
        --[ [] ]--0
      ]
    ]]);

var b = --[ Val ]--Block.__(0, [--[ Symbol ]--Block.__(1, ["x"])]);

console.log(compare(--[ InSum ]--0, do
          complex: true
        end, a, b));

--[  Not a pure module ]--
