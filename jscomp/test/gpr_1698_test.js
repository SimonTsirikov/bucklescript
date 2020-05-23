'use strict';

var Block = require("../../lib/js/block.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function is_number(_expr) do
  while(true) do
    var expr = _expr;
    switch (expr.tag | 0) do
      case --[ Val ]--0 :
          if (expr[0].tag) do
            return false;
          end else do
            return true;
          end
      case --[ Neg ]--1 :
          _expr = expr[0];
          continue ;
      case --[ Sum ]--2 :
      case --[ Pow ]--3 :
      case --[ Frac ]--4 :
      case --[ Gcd ]--5 :
          return false;
      
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
    switch (a.tag | 0) do
      case --[ Val ]--0 :
          switch (b.tag | 0) do
            case --[ Val ]--0 :
                return 111;
            case --[ Neg ]--1 :
                exit$3 = 5;
                break;
            case --[ Sum ]--2 :
                exit$2 = 4;
                break;
            case --[ Frac ]--4 :
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "gpr_1698_test.ml",
                        45,
                        10
                      ]
                    ];
            case --[ Pow ]--3 :
            case --[ Gcd ]--5 :
                exit = 1;
                break;
            
          end
          break;
      case --[ Neg ]--1 :
          _a = a[0];
          continue ;
      case --[ Sum ]--2 :
      case --[ Pow ]--3 :
          exit$3 = 5;
          break;
      case --[ Frac ]--4 :
          switch (b.tag | 0) do
            case --[ Val ]--0 :
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "gpr_1698_test.ml",
                        45,
                        10
                      ]
                    ];
            case --[ Neg ]--1 :
                exit$3 = 5;
                break;
            case --[ Sum ]--2 :
                exit$2 = 4;
                break;
            case --[ Frac ]--4 :
                na = a[0];
                da = a[1];
                nb = b[0];
                db = b[1];
                exit = 2;
                break;
            case --[ Pow ]--3 :
            case --[ Gcd ]--5 :
                exit = 1;
                break;
            
          end
          break;
      case --[ Gcd ]--5 :
          switch (b.tag | 0) do
            case --[ Neg ]--1 :
                exit$3 = 5;
                break;
            case --[ Sum ]--2 :
                exit$2 = 4;
                break;
            case --[ Gcd ]--5 :
                na = a[0];
                da = a[1];
                nb = b[0];
                db = b[1];
                exit = 2;
                break;
            default:
              exit$1 = 3;
          end
          break;
      
    end
    if (exit$3 == 5) do
      if (b.tag == --[ Neg ]--1) do
        _b = b[0];
        continue ;
      end else if (a.tag == --[ Sum ]--2 and is_number(b)) do
        return 1;
      end else do
        exit$2 = 4;
      end
    end
    if (exit$2 == 4) do
      if (b.tag == --[ Sum ]--2 and is_number(a)) do
        return -1;
      end else do
        exit$1 = 3;
      end
    end
    if (exit$1 == 3) do
      switch (a.tag | 0) do
        case --[ Sum ]--2 :
            exit = 1;
            break;
        case --[ Pow ]--3 :
            return -1;
        case --[ Val ]--0 :
        case --[ Frac ]--4 :
        case --[ Gcd ]--5 :
            return 1;
        
      end
    end
    switch (exit) do
      case 1 :
          switch (b.tag | 0) do
            case --[ Pow ]--3 :
                return 1;
            case --[ Gcd ]--5 :
                return -1;
            default:
              return -1;
          end
      case 2 :
          var denom = compare(context, state, da, db);
          if (denom == 0) do
            _b = nb;
            _a = na;
            continue ;
          end else do
            return denom;
          end
      
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
