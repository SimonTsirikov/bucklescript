console.log = print;

Caml_format = require "./caml_format";
Caml_primitive = require "./caml_primitive";
Caml_js_exceptions = require "./caml_js_exceptions";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function succ(n) do
  return n + 1 | 0;
end end

function pred(n) do
  return n - 1 | 0;
end end

function abs(n) do
  if (n >= 0) then do
    return n;
  end else do
    return -n | 0;
  end end 
end end

function lognot(n) do
  return n ^ -1;
end end

function to_string(n) do
  return Caml_format.caml_int32_format("%d", n);
end end

function of_string_opt(s) do
  xpcall(function() do
    return Caml_format.caml_int32_of_string(s);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error(exn)
    end end 
  end end)
end end

compare = Caml_primitive.caml_int32_compare;

function equal(x, y) do
  return x == y;
end end

zero = 0;

one = 1;

minus_one = -1;

max_int = 2147483647;

min_int = -2147483648;

exports.zero = zero;
exports.one = one;
exports.minus_one = minus_one;
exports.succ = succ;
exports.pred = pred;
exports.abs = abs;
exports.max_int = max_int;
exports.min_int = min_int;
exports.lognot = lognot;
exports.of_string_opt = of_string_opt;
exports.to_string = to_string;
exports.compare = compare;
exports.equal = equal;
--[[ No side effect ]]
