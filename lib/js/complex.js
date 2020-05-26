'use strict';


var one = do
  re: 1.0,
  im: 0.0
end;

function add(x, y) do
  return do
          re: x.re + y.re,
          im: x.im + y.im
        end;
end

function sub(x, y) do
  return do
          re: x.re - y.re,
          im: x.im - y.im
        end;
end

function neg(x) do
  return do
          re: -x.re,
          im: -x.im
        end;
end

function conj(x) do
  return do
          re: x.re,
          im: -x.im
        end;
end

function mul(x, y) do
  return do
          re: x.re * y.re - x.im * y.im,
          im: x.re * y.im + x.im * y.re
        end;
end

function div(x, y) do
  if (Math.abs(y.re) >= Math.abs(y.im)) then do
    var r = y.im / y.re;
    var d = y.re + r * y.im;
    return do
            re: (x.re + r * x.im) / d,
            im: (x.im - r * x.re) / d
          end;
  end else do
    var r$1 = y.re / y.im;
    var d$1 = y.im + r$1 * y.re;
    return do
            re: (r$1 * x.re + x.im) / d$1,
            im: (r$1 * x.im - x.re) / d$1
          end;
  end end 
end

function inv(x) do
  return div(one, x);
end

function norm2(x) do
  return x.re * x.re + x.im * x.im;
end

function norm(x) do
  var r = Math.abs(x.re);
  var i = Math.abs(x.im);
  if (r == 0.0) then do
    return i;
  end else if (i == 0.0) then do
    return r;
  end else if (r >= i) then do
    var q = i / r;
    return r * Math.sqrt(1.0 + q * q);
  end else do
    var q$1 = r / i;
    return i * Math.sqrt(1.0 + q$1 * q$1);
  end end  end  end 
end

function arg(x) do
  return Math.atan2(x.im, x.re);
end

function polar(n, a) do
  return do
          re: Math.cos(a) * n,
          im: Math.sin(a) * n
        end;
end

function sqrt(x) do
  if (x.re == 0.0 and x.im == 0.0) then do
    return do
            re: 0.0,
            im: 0.0
          end;
  end else do
    var r = Math.abs(x.re);
    var i = Math.abs(x.im);
    var w;
    if (r >= i) then do
      var q = i / r;
      w = Math.sqrt(r) * Math.sqrt(0.5 * (1.0 + Math.sqrt(1.0 + q * q)));
    end else do
      var q$1 = r / i;
      w = Math.sqrt(i) * Math.sqrt(0.5 * (q$1 + Math.sqrt(1.0 + q$1 * q$1)));
    end end 
    if (x.re >= 0.0) then do
      return do
              re: w,
              im: 0.5 * x.im / w
            end;
    end else do
      return do
              re: 0.5 * i / w,
              im: x.im >= 0.0 and w or -w
            end;
    end end 
  end end 
end

function exp(x) do
  var e = Math.exp(x.re);
  return do
          re: e * Math.cos(x.im),
          im: e * Math.sin(x.im)
        end;
end

function log(x) do
  return do
          re: Math.log(norm(x)),
          im: Math.atan2(x.im, x.re)
        end;
end

function pow(x, y) do
  return exp(mul(y, log(x)));
end

var zero = do
  re: 0.0,
  im: 0.0
end;

var i = do
  re: 0.0,
  im: 1.0
end;

exports.zero = zero;
exports.one = one;
exports.i = i;
exports.neg = neg;
exports.conj = conj;
exports.add = add;
exports.sub = sub;
exports.mul = mul;
exports.inv = inv;
exports.div = div;
exports.sqrt = sqrt;
exports.norm2 = norm2;
exports.norm = norm;
exports.arg = arg;
exports.polar = polar;
exports.exp = exp;
exports.log = log;
exports.pow = pow;
--[ No side effect ]--
