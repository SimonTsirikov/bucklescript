console.log = print;

Js_exn = require "../../lib/js/js_exn";
Caml_option = require "../../lib/js/caml_option";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";

function test_js_error(param) do
  e;
  xpcall(function() do
    e = JSON.parse(" {\"x\" : }");
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      console.log(exn[1].stack);
      return ;
    end else do
      error(exn)
    end end 
  end end)
  return Caml_option.some(e);
end end

function test_js_error2(param) do
  xpcall(function() do
    return JSON.parse(" {\"x\" : }");
  end end,function(raw_e) do
    e = Caml_js_exceptions.internalToOCamlException(raw_e);
    if (e[0] == Js_exn.__Error) then do
      console.log(e[1].stack);
      error(e)
    end else do
      error(e)
    end end 
  end end)
end end

function example1(param) do
  v;
  xpcall(function() do
    v = JSON.parse(" {\"x\"  }");
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      console.log(exn[1].stack);
      return ;
    end else do
      error(exn)
    end end 
  end end)
  return Caml_option.some(v);
end end

function example2(param) do
  xpcall(function() do
    return Caml_option.some(JSON.parse(" {\"x\"}"));
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Js_exn.__Error) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

exports.test_js_error = test_js_error;
exports.test_js_error2 = test_js_error2;
exports.example1 = example1;
exports.example2 = example2;
--[[ No side effect ]]
