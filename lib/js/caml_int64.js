'use strict';

Caml_int32 = require("./caml_int32.js");
Caml_utils = require("./caml_utils.js");
Caml_primitive = require("./caml_primitive.js");
Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

min_int = --[ Int64 ]--[
  --[ hi ]---2147483648,
  --[ lo ]--0
];

max_int = --[ Int64 ]--[
  --[ hi ]--2147483647,
  --[ lo ]--1
];

one = --[ Int64 ]--[
  --[ hi ]--0,
  --[ lo ]--1
];

zero = --[ Int64 ]--[
  --[ hi ]--0,
  --[ lo ]--0
];

neg_one = --[ Int64 ]--[
  --[ hi ]---1,
  --[ lo ]--4294967295
];

function neg_signed(x) do
  return (x & 2147483648) ~= 0;
end end

function add(param, param$1) do
  other_low_ = param$1[--[ lo ]--1];
  this_low_ = param[--[ lo ]--1];
  lo = this_low_ + other_low_ & 4294967295;
  overflow = neg_signed(this_low_) and (neg_signed(other_low_) or !neg_signed(lo)) or neg_signed(other_low_) and !neg_signed(lo) and 1 or 0;
  hi = param[--[ hi ]--0] + param$1[--[ hi ]--0] + overflow & 4294967295;
  return --[ Int64 ]--[
          --[ hi ]--hi,
          --[ lo ]--(lo >>> 0)
        ];
end end

function not(param) do
  hi = param[--[ hi ]--0] ^ -1;
  lo = param[--[ lo ]--1] ^ -1;
  return --[ Int64 ]--[
          --[ hi ]--hi,
          --[ lo ]--(lo >>> 0)
        ];
end end

function eq(param, param$1) do
  if (param[--[ hi ]--0] == param$1[--[ hi ]--0]) then do
    return param[--[ lo ]--1] == param$1[--[ lo ]--1];
  end else do
    return false;
  end end 
end end

function equal_null(x, y) do
  if (y ~= null) then do
    return eq(x, y);
  end else do
    return false;
  end end 
end end

function equal_undefined(x, y) do
  if (y ~= undefined) then do
    return eq(x, y);
  end else do
    return false;
  end end 
end end

function equal_nullable(x, y) do
  if (y == null) then do
    return false;
  end else do
    return eq(x, y);
  end end 
end end

function neg(x) do
  if (eq(x, min_int)) then do
    return min_int;
  end else do
    return add(not(x), one);
  end end 
end end

function sub(x, y) do
  return add(x, neg(y));
end end

function lsl_(x, numBits) do
  if (numBits == 0) then do
    return x;
  end else do
    lo = x[--[ lo ]--1];
    if (numBits >= 32) then do
      return --[ Int64 ]--[
              --[ hi ]--(lo << (numBits - 32 | 0)),
              --[ lo ]--0
            ];
    end else do
      hi = (lo >>> (32 - numBits | 0)) | (x[--[ hi ]--0] << numBits);
      return --[ Int64 ]--[
              --[ hi ]--hi,
              --[ lo ]--((lo << numBits) >>> 0)
            ];
    end end 
  end end 
end end

function lsr_(x, numBits) do
  if (numBits == 0) then do
    return x;
  end else do
    hi = x[--[ hi ]--0];
    offset = numBits - 32 | 0;
    if (offset == 0) then do
      return --[ Int64 ]--[
              --[ hi ]--0,
              --[ lo ]--(hi >>> 0)
            ];
    end else if (offset > 0) then do
      lo = (hi >>> offset);
      return --[ Int64 ]--[
              --[ hi ]--0,
              --[ lo ]--(lo >>> 0)
            ];
    end else do
      hi$1 = (hi >>> numBits);
      lo$1 = (hi << (-offset | 0)) | (x[--[ lo ]--1] >>> numBits);
      return --[ Int64 ]--[
              --[ hi ]--hi$1,
              --[ lo ]--(lo$1 >>> 0)
            ];
    end end  end 
  end end 
end end

function asr_(x, numBits) do
  if (numBits == 0) then do
    return x;
  end else do
    hi = x[--[ hi ]--0];
    if (numBits < 32) then do
      hi$1 = (hi >> numBits);
      lo = (hi << (32 - numBits | 0)) | (x[--[ lo ]--1] >>> numBits);
      return --[ Int64 ]--[
              --[ hi ]--hi$1,
              --[ lo ]--(lo >>> 0)
            ];
    end else do
      lo$1 = (hi >> (numBits - 32 | 0));
      return --[ Int64 ]--[
              --[ hi ]--hi >= 0 and 0 or -1,
              --[ lo ]--(lo$1 >>> 0)
            ];
    end end 
  end end 
end end

function is_zero(param) do
  if (param[--[ hi ]--0] ~= 0 or param[--[ lo ]--1] ~= 0) then do
    return false;
  end else do
    return true;
  end end 
end end

function mul(_this, _other) do
  while(true) do
    other = _other;
    $$this = _this;
    lo;
    exit = 0;
    exit$1 = 0;
    if ($$this[--[ hi ]--0] ~= 0 or $$this[--[ lo ]--1] ~= 0) then do
      exit$1 = 3;
    end else do
      return zero;
    end end 
    if (exit$1 == 3) then do
      if (other[--[ hi ]--0] ~= 0 or other[--[ lo ]--1] ~= 0) then do
        exit = 2;
      end else do
        return zero;
      end end 
    end
     end 
    if (exit == 2) then do
      this_hi = $$this[--[ hi ]--0];
      exit$2 = 0;
      if (this_hi ~= -2147483648 or $$this[--[ lo ]--1] ~= 0) then do
        exit$2 = 3;
      end else do
        lo = other[--[ lo ]--1];
      end end 
      if (exit$2 == 3) then do
        other_hi = other[--[ hi ]--0];
        lo$1 = $$this[--[ lo ]--1];
        exit$3 = 0;
        if (other_hi ~= -2147483648 or other[--[ lo ]--1] ~= 0) then do
          exit$3 = 4;
        end else do
          lo = lo$1;
        end end 
        if (exit$3 == 4) then do
          other_lo = other[--[ lo ]--1];
          if (this_hi < 0) then do
            if (other_hi < 0) then do
              _other = neg(other);
              _this = neg($$this);
              continue ;
            end else do
              return neg(mul(neg($$this), other));
            end end 
          end else if (other_hi < 0) then do
            return neg(mul($$this, neg(other)));
          end else do
            a48 = (this_hi >>> 16);
            a32 = this_hi & 65535;
            a16 = (lo$1 >>> 16);
            a00 = lo$1 & 65535;
            b48 = (other_hi >>> 16);
            b32 = other_hi & 65535;
            b16 = (other_lo >>> 16);
            b00 = other_lo & 65535;
            c48 = 0;
            c32 = 0;
            c16 = 0;
            c00 = a00 * b00;
            c16 = (c00 >>> 16) + a16 * b00;
            c32 = (c16 >>> 16);
            c16 = (c16 & 65535) + a00 * b16;
            c32 = c32 + (c16 >>> 16) + a32 * b00;
            c48 = (c32 >>> 16);
            c32 = (c32 & 65535) + a16 * b16;
            c48 = c48 + (c32 >>> 16);
            c32 = (c32 & 65535) + a00 * b32;
            c48 = c48 + (c32 >>> 16);
            c32 = c32 & 65535;
            c48 = c48 + (a48 * b00 + a32 * b16 + a16 * b32 + a00 * b48) & 65535;
            hi = c32 | (c48 << 16);
            lo$2 = c00 & 65535 | ((c16 & 65535) << 16);
            return --[ Int64 ]--[
                    --[ hi ]--hi,
                    --[ lo ]--(lo$2 >>> 0)
                  ];
          end end  end 
        end
         end 
      end
       end 
    end
     end 
    if ((lo & 1) == 0) then do
      return zero;
    end else do
      return min_int;
    end end 
  end;
end end

function swap(param) do
  hi = Caml_int32.caml_int32_bswap(param[--[ lo ]--1]);
  lo = Caml_int32.caml_int32_bswap(param[--[ hi ]--0]);
  return --[ Int64 ]--[
          --[ hi ]--hi,
          --[ lo ]--(lo >>> 0)
        ];
end end

function xor(param, param$1) do
  return --[ Int64 ]--[
          --[ hi ]--param[--[ hi ]--0] ^ param$1[--[ hi ]--0],
          --[ lo ]--((param[--[ lo ]--1] ^ param$1[--[ lo ]--1]) >>> 0)
        ];
end end

function or_(param, param$1) do
  return --[ Int64 ]--[
          --[ hi ]--param[--[ hi ]--0] | param$1[--[ hi ]--0],
          --[ lo ]--((param[--[ lo ]--1] | param$1[--[ lo ]--1]) >>> 0)
        ];
end end

function and_(param, param$1) do
  return --[ Int64 ]--[
          --[ hi ]--param[--[ hi ]--0] & param$1[--[ hi ]--0],
          --[ lo ]--((param[--[ lo ]--1] & param$1[--[ lo ]--1]) >>> 0)
        ];
end end

function ge(param, param$1) do
  other_hi = param$1[--[ hi ]--0];
  hi = param[--[ hi ]--0];
  if (hi > other_hi) then do
    return true;
  end else if (hi < other_hi) then do
    return false;
  end else do
    return param[--[ lo ]--1] >= param$1[--[ lo ]--1];
  end end  end 
end end

function neq(x, y) do
  return !eq(x, y);
end end

function lt(x, y) do
  return !ge(x, y);
end end

function gt(param, param$1) do
  if (param[--[ hi ]--0] > param$1[--[ hi ]--0]) then do
    return true;
  end else if (param[--[ hi ]--0] < param$1[--[ hi ]--0]) then do
    return false;
  end else do
    return param[--[ lo ]--1] > param$1[--[ lo ]--1];
  end end  end 
end end

function le(x, y) do
  return !gt(x, y);
end end

function min(x, y) do
  if (ge(x, y)) then do
    return y;
  end else do
    return x;
  end end 
end end

function max(x, y) do
  if (gt(x, y)) then do
    return x;
  end else do
    return y;
  end end 
end end

function to_float(param) do
  return param[--[ hi ]--0] * 0x100000000 + param[--[ lo ]--1];
end end

function of_float(x) do
  if (isNaN(x) or !isFinite(x)) then do
    return zero;
  end else if (x <= -9.22337203685477581e+18) then do
    return min_int;
  end else if (x + 1 >= 9.22337203685477581e+18) then do
    return max_int;
  end else if (x < 0) then do
    return neg(of_float(-x));
  end else do
    hi = x / 4294967296 | 0;
    lo = x % 4294967296 | 0;
    return --[ Int64 ]--[
            --[ hi ]--hi,
            --[ lo ]--(lo >>> 0)
          ];
  end end  end  end  end 
end end

function div(_self, _other) do
  while(true) do
    other = _other;
    self = _self;
    exit = 0;
    exit$1 = 0;
    if (other[--[ hi ]--0] ~= 0 or other[--[ lo ]--1] ~= 0) then do
      exit$1 = 3;
    end else do
      throw Caml_builtin_exceptions.division_by_zero;
    end end 
    if (exit$1 == 3) then do
      match = self[--[ hi ]--0];
      if (match ~= -2147483648) then do
        if (match ~= 0 or self[--[ lo ]--1] ~= 0) then do
          exit = 2;
        end else do
          return zero;
        end end 
      end else if (self[--[ lo ]--1] ~= 0) then do
        exit = 2;
      end else if (eq(other, one) or eq(other, neg_one)) then do
        return self;
      end else if (eq(other, min_int)) then do
        return one;
      end else do
        half_this = asr_(self, 1);
        approx = lsl_(div(half_this, other), 1);
        exit$2 = 0;
        if (approx[--[ hi ]--0] ~= 0 or approx[--[ lo ]--1] ~= 0) then do
          exit$2 = 4;
        end else if (other[--[ hi ]--0] < 0) then do
          return one;
        end else do
          return neg(one);
        end end  end 
        if (exit$2 == 4) then do
          y = mul(other, approx);
          rem = add(self, neg(y));
          return add(approx, div(rem, other));
        end
         end 
      end end  end  end  end 
    end
     end 
    if (exit == 2 and other[--[ hi ]--0] == -2147483648 and other[--[ lo ]--1] == 0) then do
      return zero;
    end
     end 
    other_hi = other[--[ hi ]--0];
    if (self[--[ hi ]--0] < 0) then do
      if (other_hi < 0) then do
        _other = neg(other);
        _self = neg(self);
        continue ;
      end else do
        return neg(div(neg(self), other));
      end end 
    end else if (other_hi < 0) then do
      return neg(div(self, neg(other)));
    end else do
      res = zero;
      rem$1 = self;
      while(ge(rem$1, other)) do
        approx$1 = Caml_primitive.caml_float_max(1, Math.floor(to_float(rem$1) / to_float(other)));
        log2 = Math.ceil(Math.log(approx$1) / Math.LN2);
        delta = log2 <= 48 and 1 or Math.pow(2, log2 - 48);
        approxRes = of_float(approx$1);
        approxRem = mul(approxRes, other);
        while(approxRem[--[ hi ]--0] < 0 or gt(approxRem, rem$1)) do
          approx$1 = approx$1 - delta;
          approxRes = of_float(approx$1);
          approxRem = mul(approxRes, other);
        end;
        if (is_zero(approxRes)) then do
          approxRes = one;
        end
         end 
        res = add(res, approxRes);
        rem$1 = add(rem$1, neg(approxRem));
      end;
      return res;
    end end  end 
  end;
end end

function mod_(self, other) do
  y = mul(div(self, other), other);
  return add(self, neg(y));
end end

function div_mod(self, other) do
  quotient = div(self, other);
  y = mul(quotient, other);
  return --[ tuple ]--[
          quotient,
          add(self, neg(y))
        ];
end end

function compare(param, param$1) do
  v = Caml_primitive.caml_nativeint_compare(param[--[ hi ]--0], param$1[--[ hi ]--0]);
  if (v == 0) then do
    return Caml_primitive.caml_nativeint_compare(param[--[ lo ]--1], param$1[--[ lo ]--1]);
  end else do
    return v;
  end end 
end end

function of_int32(lo) do
  return --[ Int64 ]--[
          --[ hi ]--lo < 0 and -1 or 0,
          --[ lo ]--(lo >>> 0)
        ];
end end

function to_int32(param) do
  return param[--[ lo ]--1] | 0;
end end

function to_hex(x) do
  x_lo = x[--[ lo ]--1];
  x_hi = x[--[ hi ]--0];
  aux = function (v) do
    return (v >>> 0).toString(16);
  end end;
  if (x_hi == 0 and x_lo == 0) then do
    return "0";
  end
   end 
  if (x_lo ~= 0) then do
    if (x_hi ~= 0) then do
      lo = aux(x_lo);
      pad = 8 - #lo | 0;
      if (pad <= 0) then do
        return aux(x_hi) .. lo;
      end else do
        return aux(x_hi) .. (Caml_utils.repeat(pad, "0") .. lo);
      end end 
    end else do
      return aux(x_lo);
    end end 
  end else do
    return aux(x_hi) .. "00000000";
  end end 
end end

function discard_sign(x) do
  return --[ Int64 ]--[
          --[ hi ]--2147483647 & x[--[ hi ]--0],
          --[ lo ]--x[--[ lo ]--1]
        ];
end end

function float_of_bits(param) do
  return (function(lo,hi){ return (new Float64Array(new Int32Array([lo,hi]).buffer))[0]})(param[--[ lo ]--1], param[--[ hi ]--0]);
end end

function bits_of_float(x) do
  buf = (function(x){return new Int32Array(new Float64Array([x]).buffer)})(x);
  return --[ Int64 ]--[
          --[ hi ]--buf[1],
          --[ lo ]--(buf[0] >>> 0)
        ];
end end

function get64(s, i) do
  hi = (s.charCodeAt(i + 4 | 0) << 32) | (s.charCodeAt(i + 5 | 0) << 40) | (s.charCodeAt(i + 6 | 0) << 48) | (s.charCodeAt(i + 7 | 0) << 56);
  lo = s.charCodeAt(i) | (s.charCodeAt(i + 1 | 0) << 8) | (s.charCodeAt(i + 2 | 0) << 16) | (s.charCodeAt(i + 3 | 0) << 24);
  return --[ Int64 ]--[
          --[ hi ]--hi,
          --[ lo ]--(lo >>> 0)
        ];
end end

exports.min_int = min_int;
exports.max_int = max_int;
exports.one = one;
exports.zero = zero;
exports.not = not;
exports.of_int32 = of_int32;
exports.to_int32 = to_int32;
exports.add = add;
exports.neg = neg;
exports.sub = sub;
exports.lsl_ = lsl_;
exports.lsr_ = lsr_;
exports.asr_ = asr_;
exports.is_zero = is_zero;
exports.mul = mul;
exports.xor = xor;
exports.or_ = or_;
exports.and_ = and_;
exports.swap = swap;
exports.ge = ge;
exports.eq = eq;
exports.neq = neq;
exports.lt = lt;
exports.gt = gt;
exports.le = le;
exports.equal_null = equal_null;
exports.equal_undefined = equal_undefined;
exports.equal_nullable = equal_nullable;
exports.min = min;
exports.max = max;
exports.to_float = to_float;
exports.of_float = of_float;
exports.div = div;
exports.mod_ = mod_;
exports.compare = compare;
exports.float_of_bits = float_of_bits;
exports.bits_of_float = bits_of_float;
exports.get64 = get64;
exports.div_mod = div_mod;
exports.to_hex = to_hex;
exports.discard_sign = discard_sign;
--[ Caml_int32 Not a pure module ]--
