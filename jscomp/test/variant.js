'use strict';

var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function foo(param) do
  if (typeof param == "number") then do
    if (param == --[ A1 ]--0) then do
      return 1;
    end else do
      return 2;
    end end 
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[ B ]-- then do
          return param[0];end end end 
       if ___conditional___ = 1--[ C ]-- then do
          return param[0] + param[1] | 0;end end end 
       if ___conditional___ = 2--[ D ]-- then do
          var match = param[0];
          return match[0] + match[1] | 0;end end end 
       do
      
    end
  end end 
end

function fooA1(param) do
  if (typeof param == "number" and param == 0) then do
    return 1;
  end else do
    return 42;
  end end 
end

function fooC(param) do
  if (typeof param == "number" or param.tag ~= --[ C ]--1) then do
    return 42;
  end else do
    return param[0] + param[1] | 0;
  end end 
end

function switchNum(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0 then do
        return "0";end end end 
     if ___conditional___ = 1 then do
        return "1";end end end 
     if ___conditional___ = 2 then do
        return "2";end end end 
     do
    else do
      return "_";
      end end
      
  end
end

var same = Caml_obj.caml_equal;

var compare = Caml_obj.caml_compare;

var Path = do
  same: same,
  compare: compare
end;

function Make(M) do
  var find = function (x) do
    return --[ () ]--0;
  end;
  return do
          find: find
        end;
end

function find(x) do
  return --[ () ]--0;
end

var M = do
  find: find
end;

function rollback_path(subst, p) do
  try do
    return "try";
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      local ___conditional___=(p.tag | 0);
      do
         if ___conditional___ = 1--[ Pdot ]-- then do
            return "Pdot";end end end 
         if ___conditional___ = 0--[ Pident ]--
         or ___conditional___ = 2--[ Papply ]-- then do
            return "Pident | Papply";end end end 
         do
        
      end
    end else do
      throw exn;
    end end 
  end
end

var EA1 = Caml_exceptions.create("Variant.EA1");

var EA2 = Caml_exceptions.create("Variant.EA2");

var EB = Caml_exceptions.create("Variant.EB");

var EC = Caml_exceptions.create("Variant.EC");

var ED = Caml_exceptions.create("Variant.ED");

function fooExn(f) do
  try do
    return Curry._1(f, --[ () ]--0);
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn == EA1) then do
      return 1;
    end else if (exn == EA2) then do
      return 2;
    end else if (exn[0] == EB) then do
      return exn[1];
    end else if (exn[0] == EC) then do
      return exn[1] + exn[2] | 0;
    end else if (exn[0] == ED) then do
      var match = exn[1];
      return match[0] + match[1] | 0;
    end else do
      throw exn;
    end end  end  end  end  end 
  end
end

var a1 = --[ A1 ]--0;

var a2 = --[ A2 ]--1;

var b = --[ B ]--Block.__(0, [34]);

var c = --[ C ]--Block.__(1, [
    4,
    2
  ]);

var d = --[ D ]--Block.__(2, [--[ tuple ]--[
      4,
      2
    ]]);

exports.a1 = a1;
exports.a2 = a2;
exports.b = b;
exports.c = c;
exports.d = d;
exports.foo = foo;
exports.fooA1 = fooA1;
exports.fooC = fooC;
exports.switchNum = switchNum;
exports.Path = Path;
exports.Make = Make;
exports.M = M;
exports.rollback_path = rollback_path;
exports.EA1 = EA1;
exports.EA2 = EA2;
exports.EB = EB;
exports.EC = EC;
exports.ED = ED;
exports.fooExn = fooExn;
--[ No side effect ]--
