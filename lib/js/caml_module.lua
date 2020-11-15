__console = {log = print};

Caml_obj = require "..caml_obj";
Caml_builtin_exceptions = require "..caml_builtin_exceptions";

function init_mod(loc, shape) do
  undef_module = function(param) do
    error({
      Caml_builtin_exceptions.undefined_recursive_module,
      loc
    })
  end end;
  loop = function(shape, struct_, idx) do
    if (type(shape) == "number") then do
      local ___conditional___=(shape);
      do
         if ___conditional___ == 0--[[ Function ]]
         or ___conditional___ == 1--[[ Lazy ]] then do
            struct_[idx] = undef_module;
            return --[[ () ]]0; end end 
         if ___conditional___ == 2--[[ Class ]] then do
            struct_[idx] = --[[ tuple ]]{
              undef_module,
              undef_module,
              undef_module,
              0
            };
            return --[[ () ]]0; end end 
        
      end
    end else if (shape.tag) then do
      struct_[idx] = shape[1];
      return --[[ () ]]0;
    end else do
      comps = shape[1];
      v = { };
      struct_[idx] = v;
      len = #comps;
      for i = 0 , len - 1 | 0 , 1 do
        match = comps[i];
        loop(match[1], v, match[2]);
      end
      return --[[ () ]]0;
    end end  end 
  end end;
  res = { };
  dummy_name = "dummy";
  loop(shape, res, dummy_name);
  return res[dummy_name];
end end

function update_mod(shape, o, n) do
  aux = function(shape, o, n, parent, i) do
    if (type(shape) == "number") then do
      local ___conditional___=(shape);
      do
         if ___conditional___ == 0--[[ Function ]] then do
            parent[i] = n;
            return --[[ () ]]0; end end 
         if ___conditional___ == 1--[[ Lazy ]]
         or ___conditional___ == 2--[[ Class ]] then do
            return Caml_obj.caml_update_dummy(o, n); end end 
        
      end
    end else if (shape.tag) then do
      return --[[ () ]]0;
    end else do
      comps = shape[1];
      for i_1 = 0 , #comps - 1 | 0 , 1 do
        match = comps[i_1];
        name = match[2];
        aux(match[1], o[name], n[name], o, name);
      end
      return --[[ () ]]0;
    end end  end 
  end end;
  if (type(shape) == "number") then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "caml_module.ml",
        107,
        10
      }
    })
  end else if (shape.tag) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "caml_module.ml",
        107,
        10
      }
    })
  end else do
    comps = shape[1];
    for i = 0 , #comps - 1 | 0 , 1 do
      match = comps[i];
      name = match[2];
      aux(match[1], o[name], n[name], o, name);
    end
    return --[[ () ]]0;
  end end  end 
end end

exports = {};
exports.init_mod = init_mod;
exports.update_mod = update_mod;
return exports;
--[[ No side effect ]]
