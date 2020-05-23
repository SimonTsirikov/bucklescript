

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
    if (typeof shape == "number") do
      switch (shape) do
        case --[ Function ]--0 :
        case --[ Lazy ]--1 :
            struct_[idx] = undef_module;
            return --[ () ]--0;
        case --[ Class ]--2 :
            struct_[idx] = --[ tuple ]--[
              undef_module,
              undef_module,
              undef_module,
              0
            ];
            return --[ () ]--0;
        
      end
    end else if (shape.tag) do
      struct_[idx] = shape[0];
      return --[ () ]--0;
    end else do
      var comps = shape[0];
      var v = { };
      struct_[idx] = v;
      var len = #comps;
      for(var i = 0 ,i_finish = len - 1 | 0; i <= i_finish; ++i)do
        var match = comps[i];
        loop(match[0], v, match[1]);
      end
      return --[ () ]--0;
    end
  end;
  var res = { };
  var dummy_name = "dummy";
  loop(shape, res, dummy_name);
  return res[dummy_name];
end

function update_mod(shape, o, n) do
  var aux = function (shape, o, n, parent, i) do
    if (typeof shape == "number") do
      switch (shape) do
        case --[ Function ]--0 :
            parent[i] = n;
            return --[ () ]--0;
        case --[ Lazy ]--1 :
        case --[ Class ]--2 :
            return Caml_obj.caml_update_dummy(o, n);
        
      end
    end else if (shape.tag) do
      return --[ () ]--0;
    end else do
      var comps = shape[0];
      for(var i$1 = 0 ,i_finish = #comps - 1 | 0; i$1 <= i_finish; ++i$1)do
        var match = comps[i$1];
        var name = match[1];
        aux(match[0], o[name], n[name], o, name);
      end
      return --[ () ]--0;
    end
  end;
  if (typeof shape == "number") do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "caml_module.ml",
            107,
            10
          ]
        ];
  end else if (shape.tag) do
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
    for(var i = 0 ,i_finish = #comps - 1 | 0; i <= i_finish; ++i)do
      var match = comps[i];
      var name = match[1];
      aux(match[0], o[name], n[name], o, name);
    end
    return --[ () ]--0;
  end
end

export do
  init_mod ,
  update_mod ,
  
end
--[ No side effect ]--
