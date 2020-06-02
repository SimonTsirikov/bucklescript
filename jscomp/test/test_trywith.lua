--[['use strict';]]

Curry = require "../../lib/js/curry";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function ff(g, x) do
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn) do
    if (exn ~= Caml_builtin_exceptions.not_found) then do
      error(exn)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn_1) do
    if (exn_1 ~= Caml_builtin_exceptions.out_of_memory) then do
      error(exn_1)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn) do
    exn_2 = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn_2[0] ~= Caml_builtin_exceptions.sys_error) then do
      error(exn_2)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn_1) do
    exn_3 = Caml_js_exceptions.internalToOCamlException(raw_exn_1);
    if (exn_3[0] ~= Caml_builtin_exceptions.invalid_argument) then do
      error(exn_3)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn_4) do
    if (exn_4 ~= Caml_builtin_exceptions.end_of_file) then do
      error(exn_4)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn_2) do
    exn_5 = Caml_js_exceptions.internalToOCamlException(raw_exn_2);
    if (exn_5[0] ~= Caml_builtin_exceptions.match_failure) then do
      error(exn_5)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn_6) do
    if (exn_6 ~= Caml_builtin_exceptions.stack_overflow) then do
      error(exn_6)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn_7) do
    if (exn_7 ~= Caml_builtin_exceptions.sys_blocked_io) then do
      error(exn_7)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn_3) do
    exn_8 = Caml_js_exceptions.internalToOCamlException(raw_exn_3);
    if (exn_8[0] ~= Caml_builtin_exceptions.assert_failure) then do
      error(exn_8)
    end
     end 
  end end)
  xpcall(function() do
    return Curry._1(g, x);
  end end,function(raw_exn_4) do
    exn_9 = Caml_js_exceptions.internalToOCamlException(raw_exn_4);
    if (exn_9[0] == Caml_builtin_exceptions.undefined_recursive_module) then do
      return --[[ () ]]0;
    end else do
      error(exn_9)
    end end 
  end end)
end end

function u(param) do
  error(Caml_builtin_exceptions.not_found)
end end

function f(x) do
  if (typeof x == "number") then do
    return 2;
  end else if (x.tag) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "test_trywith.ml",
        51,
        9
      }
    })
  end else do
    return 1;
  end end  end 
end end

u1 = "bad character decimal encoding \\";

v = "bad character decimal encoding \\%c%c%c";

exports.ff = ff;
exports.u = u;
exports.u1 = u1;
exports.v = v;
exports.f = f;
--[[ No side effect ]]
