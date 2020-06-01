


caml_int32_float_of_bits = (function(x){
    return new Float32Array(new Int32Array([x]).buffer)[0] 
    });

caml_int32_bits_of_float = (function(x){
  return new Int32Array(new Float32Array([x]).buffer)[0] 
});

function caml_modf_float(x) do
  if (isFinite(x)) then do
    neg = 1 / x < 0;
    x$1 = Math.abs(x);
    i = Math.floor(x$1);
    f = x$1 - i;
    if (neg) then do
      return --[[ tuple ]][
              -f,
              -i
            ];
    end else do
      return --[[ tuple ]][
              f,
              i
            ];
    end end 
  end else if (isNaN(x)) then do
    return --[[ tuple ]][
            NaN,
            NaN
          ];
  end else do
    return --[[ tuple ]][
            1 / x,
            x
          ];
  end end  end 
end end

function caml_ldexp_float(x, exp) do
  x$prime = x;
  exp$prime = exp;
  if (exp$prime > 1023) then do
    exp$prime = exp$prime - 1023;
    x$prime = x$prime * Math.pow(2, 1023);
    if (exp$prime > 1023) then do
      exp$prime = exp$prime - 1023;
      x$prime = x$prime * Math.pow(2, 1023);
    end
     end 
  end else if (exp$prime < -1023) then do
    exp$prime = exp$prime + 1023;
    x$prime = x$prime * Math.pow(2, -1023);
  end
   end  end 
  return x$prime * Math.pow(2, exp$prime);
end end

function caml_frexp_float(x) do
  if (x == 0 or not isFinite(x)) then do
    return --[[ tuple ]][
            x,
            0
          ];
  end else do
    neg = x < 0;
    x$prime = Math.abs(x);
    exp = Math.floor(Math.LOG2E * Math.log(x$prime)) + 1;
    x$prime = x$prime * Math.pow(2, -exp);
    if (x$prime < 0.5) then do
      x$prime = x$prime * 2;
      exp = exp - 1;
    end
     end 
    if (neg) then do
      x$prime = -x$prime;
    end
     end 
    return --[[ tuple ]][
            x$prime,
            exp | 0
          ];
  end end 
end end

function caml_copysign_float(x, y) do
  x$1 = Math.abs(x);
  y$1 = y == 0 and 1 / y or y;
  if (y$1 < 0) then do
    return -x$1;
  end else do
    return x$1;
  end end 
end end

function caml_expm1_float(x) do
  y = Math.exp(x);
  z = y - 1;
  if (Math.abs(x) > 1) then do
    return z;
  end else if (z == 0) then do
    return x;
  end else do
    return x * z / Math.log(y);
  end end  end 
end end

function caml_hypot_float(x, y) do
  x0 = Math.abs(x);
  y0 = Math.abs(y);
  a = x0 > y0 and x0 or y0;
  b = (
    x0 < y0 and x0 or y0
  ) / (
    a ~= 0 and a or 1
  );
  return a * Math.sqrt(1 + b * b);
end end

function caml_log10_float(x) do
  return Math.LOG10E * Math.log(x);
end end

export do
  caml_int32_float_of_bits ,
  caml_int32_bits_of_float ,
  caml_modf_float ,
  caml_ldexp_float ,
  caml_frexp_float ,
  caml_copysign_float ,
  caml_expm1_float ,
  caml_hypot_float ,
  caml_log10_float ,
  
end
--[[ No side effect ]]
