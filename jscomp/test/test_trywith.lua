--[['use strict';]]

Curry = require "../../lib/js/curry";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function ff(g, x) do
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn) return do
    if (exn ~= Caml_builtin_exceptions.not_found) then do
      error (exn)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn$1) return do
    if (exn$1 ~= Caml_builtin_exceptions.out_of_memory) then do
      error (exn$1)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn) return do
    exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn$2[0] ~= Caml_builtin_exceptions.sys_error) then do
      error (exn$2)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn$1) return do
    exn$3 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
    if (exn$3[0] ~= Caml_builtin_exceptions.invalid_argument) then do
      error (exn$3)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn$4) return do
    if (exn$4 ~= Caml_builtin_exceptions.end_of_file) then do
      error (exn$4)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn$2) return do
    exn$5 = Caml_js_exceptions.internalToOCamlException(raw_exn$2);
    if (exn$5[0] ~= Caml_builtin_exceptions.match_failure) then do
      error (exn$5)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn$6) return do
    if (exn$6 ~= Caml_builtin_exceptions.stack_overflow) then do
      error (exn$6)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(exn$7) return do
    if (exn$7 ~= Caml_builtin_exceptions.sys_blocked_io) then do
      error (exn$7)
    end
     end 
  end end)
  xpcall(function() do
    Curry._1(g, x);
  end end,function(raw_exn$3) return do
    exn$8 = Caml_js_exceptions.internalToOCamlException(raw_exn$3);
    if (exn$8[0] ~= Caml_builtin_exceptions.assert_failure) then do
      error (exn$8)
    end
     end 
  end end)
  xpcall(function() do
    return Curry._1(g, x);
  end end,function(raw_exn$4) return do
    exn$9 = Caml_js_exceptions.internalToOCamlException(raw_exn$4);
    if (exn$9[0] == Caml_builtin_exceptions.undefined_recursive_module) then do
      return --[[ () ]]0;
    end else do
      error (exn$9)
    end end 
  end end)
end end

function u(param) do
  error (Caml_builtin_exceptions.not_found)
end end

function f(x) do
  if (typeof x == "number") then do
    return 2;
  end else if (x.tag) then do
    error ({
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
