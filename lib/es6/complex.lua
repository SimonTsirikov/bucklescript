


one = {
  re = 1.0,
  im = 0.0
};

function add(x, y) do
  return {
          re = x.re + y.re,
          im = x.im + y.im
        };
end end

function sub(x, y) do
  return {
          re = x.re - y.re,
          im = x.im - y.im
        };
end end

function neg(x) do
  return {
          re = -x.re,
          im = -x.im
        };
end end

function conj(x) do
  return {
          re = x.re,
          im = -x.im
        };
end end

function mul(x, y) do
  return {
          re = x.re * y.re - x.im * y.im,
          im = x.re * y.im + x.im * y.re
        };
end end

function div(x, y) do
  if (__Math.abs(y.re) >= __Math.abs(y.im)) then do
    r = y.im / y.re;
    d = y.re + r * y.im;
    return {
            re = (x.re + r * x.im) / d,
            im = (x.im - r * x.re) / d
          };
  end else do
    r_1 = y.re / y.im;
    d_1 = y.im + r_1 * y.re;
    return {
            re = (r_1 * x.re + x.im) / d_1,
            im = (r_1 * x.im - x.re) / d_1
          };
  end end 
end end

function inv(x) do
  return div(one, x);
end end

function norm2(x) do
  return x.re * x.re + x.im * x.im;
end end

function norm(x) do
  r = __Math.abs(x.re);
  i = __Math.abs(x.im);
  if (r == 0.0) then do
    return i;
  end else if (i == 0.0) then do
    return r;
  end else if (r >= i) then do
    q = i / r;
    return r * __Math.sqrt(1.0 + q * q);
  end else do
    q_1 = r / i;
    return i * __Math.sqrt(1.0 + q_1 * q_1);
  end end  end  end 
end end

function arg(x) do
  return __Math.atan2(x.im, x.re);
end end

function polar(n, a) do
  return {
          re = __Math.cos(a) * n,
          im = __Math.sin(a) * n
        };
end end

function sqrt(x) do
  if (x.re == 0.0 and x.im == 0.0) then do
    return {
            re = 0.0,
            im = 0.0
          };
  end else do
    r = __Math.abs(x.re);
    i = __Math.abs(x.im);
    w;
    if (r >= i) then do
      q = i / r;
      w = __Math.sqrt(r) * __Math.sqrt(0.5 * (1.0 + __Math.sqrt(1.0 + q * q)));
    end else do
      q_1 = r / i;
      w = __Math.sqrt(i) * __Math.sqrt(0.5 * (q_1 + __Math.sqrt(1.0 + q_1 * q_1)));
    end end 
    if (x.re >= 0.0) then do
      return {
              re = w,
              im = 0.5 * x.im / w
            };
    end else do
      return {
              re = 0.5 * i / w,
              im = x.im >= 0.0 and w or -w
            };
    end end 
  end end 
end end

function exp(x) do
  e = __Math.exp(x.re);
  return {
          re = e * __Math.cos(x.im),
          im = e * __Math.sin(x.im)
        };
end end

function log(x) do
  return {
          re = __Math.log(norm(x)),
          im = __Math.atan2(x.im, x.re)
        };
end end

function pow(x, y) do
  return exp(mul(y, log(x)));
end end

zero = {
  re = 0.0,
  im = 0.0
};

i = {
  re = 0.0,
  im = 1.0
};

export do
  zero ,
  one ,
  i ,
  neg ,
  conj ,
  add ,
  sub ,
  mul ,
  inv ,
  div ,
  sqrt ,
  norm2 ,
  norm ,
  arg ,
  polar ,
  exp ,
  log ,
  pow ,
  
end
--[[ No side effect ]]
