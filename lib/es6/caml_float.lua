


caml_int32_float_of_bits = (function(x){
    return new Float32Array(new Int32Array([x]).buffer)[0] 
    });

caml_int32_bits_of_float = (function(x){
  return new Int32Array(new Float32Array([x]).buffer)[0] 
});

function caml_modf_float(x) do
  if (__isFinite(x)) then do
    neg = 1 / x < 0;
    x_1 = __Math.abs(x);
    i = __Math.floor(x_1);
    f = x_1 - i;
    if (neg) then do
      return --[[ tuple ]]{
              -f,
              -i
            };
    end else do
      return --[[ tuple ]]{
              f,
              i
            };
    end end 
  end else if (__isNaN(x)) then do
    return --[[ tuple ]]{
            __NaN,
            __NaN
          };
  end else do
    return --[[ tuple ]]{
            1 / x,
            x
          };
  end end  end 
end end

function caml_ldexp_float(x, exp) do
  x_prime = x;
  exp_prime = exp;
  if (exp_prime > 1023) then do
    exp_prime = exp_prime - 1023;
    x_prime = x_prime * __Math.pow(2, 1023);
    if (exp_prime > 1023) then do
      exp_prime = exp_prime - 1023;
      x_prime = x_prime * __Math.pow(2, 1023);
    end
     end 
  end else if (exp_prime < -1023) then do
    exp_prime = exp_prime + 1023;
    x_prime = x_prime * __Math.pow(2, -1023);
  end
   end  end 
  return x_prime * __Math.pow(2, exp_prime);
end end

function caml_frexp_float(x) do
  if (x == 0 or not __isFinite(x)) then do
    return --[[ tuple ]]{
            x,
            0
          };
  end else do
    neg = x < 0;
    x_prime = __Math.abs(x);
    exp = __Math.floor(__Math.LOG2E * __Math.log(x_prime)) + 1;
    x_prime = x_prime * __Math.pow(2, -exp);
    if (x_prime < 0.5) then do
      x_prime = x_prime * 2;
      exp = exp - 1;
    end
     end 
    if (neg) then do
      x_prime = -x_prime;
    end
     end 
    return --[[ tuple ]]{
            x_prime,
            exp | 0
          };
  end end 
end end

function caml_copysign_float(x, y) do
  x_1 = __Math.abs(x);
  y_1 = y == 0 and 1 / y or y;
  if (y_1 < 0) then do
    return -x_1;
  end else do
    return x_1;
  end end 
end end

function caml_expm1_float(x) do
  y = __Math.exp(x);
  z = y - 1;
  if (__Math.abs(x) > 1) then do
    return z;
  end else if (z == 0) then do
    return x;
  end else do
    return x * z / __Math.log(y);
  end end  end 
end end

function caml_hypot_float(x, y) do
  x0 = __Math.abs(x);
  y0 = __Math.abs(y);
  a = x0 > y0 and x0 or y0;
  b = (
    x0 < y0 and x0 or y0
  ) / (
    a ~= 0 and a or 1
  );
  return a * __Math.sqrt(1 + b * b);
end end

function caml_log10_float(x) do
  return __Math.LOG10E * __Math.log(x);
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
