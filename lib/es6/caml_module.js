

import * as Caml_obj from "./caml_obj.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function init_mod(loc, shape) do
  var undef_module = function (param) do
    throw [
          Caml_builtin_exceptions.undefined_recursive_module,
          loc
        ];
  end;
  var loop = function (shape, struct_, idx) do
    if (typeof shape == "number") then do
      local ___conditional___=(shape);
      do
         if ___conditional___ = 0--[ Function ]--
         or ___conditional___ = 1--[ Lazy ]-- then do
            struct_[idx] = undef_module;
            return --[ () ]--0;end end end 
         if ___conditional___ = 2--[ Class ]-- then do
            struct_[idx] = --[ tuple ]--[
              undef_module,
              undef_module,
              undef_module,
              0
            ];
            return --[ () ]--0;end end end 
         do
        
      end
    end else if (shape.tag) then do
      struct_[idx] = shape[0];
      return --[ () ]--0;
    end else do
      var comps = shape[0];
      var v = { };
      struct_[idx] = v;
      var len = #comps;
      for var i = 0 , len - 1 | 0 , 1 do
        var match = comps[i];
        loop(match[0], v, match[1]);
      end
      return --[ () ]--0;
    end end  end 
  end;
  var res = { };
  var dummy_name = "dummy";
  loop(shape, res, dummy_name);
  return res[dummy_name];
end

function update_mod(shape, o, n) do
  var aux = function (shape, o, n, parent, i) do
    if (typeof shape == "number") then do
      local ___conditional___=(shape);
      do
         if ___conditional___ = 0--[ Function ]-- then do
            parent[i] = n;
            return --[ () ]--0;end end end 
         if ___conditional___ = 1--[ Lazy ]--
         or ___conditional___ = 2--[ Class ]-- then do
            return Caml_obj.caml_update_dummy(o, n);end end end 
         do
        
      end
    end else if (shape.tag) then do
      return --[ () ]--0;
    end else do
      var comps = shape[0];
      for var i$1 = 0 , #comps - 1 | 0 , 1 do
        var match = comps[i$1];
        var name = match[1];
        aux(match[0], o[name], n[name], o, name);
      end
      return --[ () ]--0;
    end end  end 
  end;
  if (typeof shape == "number") then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "caml_module.ml",
            107,
            10
          ]
        ];
  end else if (shape.tag) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "caml_module.ml",
            107,
            10
          ]
        ];
  end else do
    var comps = shape[0];
    for var i = 0 , #comps - 1 | 0 , 1 do
      var match = comps[i];
      var name = match[1];
      aux(match[0], o[name], n[name], o, name);
    end
    return --[ () ]--0;
  end end  end 
end

export do
  init_mod ,
  update_mod ,
  
end
--[ No side effect ]--
