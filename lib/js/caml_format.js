'use strict';

var Caml_int32 = require("./caml_int32.js");
var Caml_int64 = require("./caml_int64.js");
var Caml_utils = require("./caml_utils.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function parse_digit(c) do
  if (c >= 65) then do
    if (c >= 97) then do
      if (c >= 123) then do
        return -1;
      end else do
        return c - 87 | 0;
      end end 
    end else if (c >= 91) then do
      return -1;
    end else do
      return c - 55 | 0;
    end end  end 
  end else if (c > 57 or c < 48) then do
    return -1;
  end else do
    return c - --[ "0" ]--48 | 0;
  end end  end 
end

function int_of_string_base(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[ Oct ]-- then do
        return 8;end end end 
     if ___conditional___ = 1--[ Hex ]-- then do
        return 16;end end end 
     if ___conditional___ = 2--[ Dec ]-- then do
        return 10;end end end 
     if ___conditional___ = 3--[ Bin ]-- then do
        return 2;end end end 
     do
    
  end
end

function parse_sign_and_base(s) do
  var sign = 1;
  var base = --[ Dec ]--2;
  var i = 0;
  var match = s.charCodeAt(i);
  local ___conditional___=(match);
  do
     if ___conditional___ = 43 then do
        i = i + 1 | 0;end else 
     if ___conditional___ = 44
     or ___conditional___ = 45 then do
        sign = -1;
        i = i + 1 | 0;end else 
     do end end end
    else do
      end end
      
  end
  if (s[i] == "0") then do
    var match$1 = s.charCodeAt(i + 1 | 0);
    if (match$1 >= 89) then do
      if (match$1 >= 111) then do
        if (match$1 < 121) then do
          local ___conditional___=(match$1 - 111 | 0);
          do
             if ___conditional___ = 0 then do
                base = --[ Oct ]--0;
                i = i + 2 | 0;end else 
             if ___conditional___ = 6 then do
                i = i + 2 | 0;end else 
             if ___conditional___ = 1
             or ___conditional___ = 2
             or ___conditional___ = 3
             or ___conditional___ = 4
             or ___conditional___ = 5
             or ___conditional___ = 7
             or ___conditional___ = 8
             or ___conditional___ = 9 then do
                base = --[ Hex ]--1;
                i = i + 2 | 0;end else 
             do end end end end
            
          end
        end
         end 
      end else if (match$1 == 98) then do
        base = --[ Bin ]--3;
        i = i + 2 | 0;
      end
       end  end 
    end else if (match$1 ~= 66) then do
      if (match$1 >= 79) then do
        local ___conditional___=(match$1 - 79 | 0);
        do
           if ___conditional___ = 0 then do
              base = --[ Oct ]--0;
              i = i + 2 | 0;end else 
           if ___conditional___ = 6 then do
              i = i + 2 | 0;end else 
           if ___conditional___ = 1
           or ___conditional___ = 2
           or ___conditional___ = 3
           or ___conditional___ = 4
           or ___conditional___ = 5
           or ___conditional___ = 7
           or ___conditional___ = 8
           or ___conditional___ = 9 then do
              base = --[ Hex ]--1;
              i = i + 2 | 0;end else 
           do end end end end
          
        end
      end
       end 
    end else do
      base = --[ Bin ]--3;
      i = i + 2 | 0;
    end end  end 
  end
   end 
  return --[ tuple ]--[
          i,
          sign,
          base
        ];
end

function caml_int_of_string(s) do
  var match = parse_sign_and_base(s);
  var i = match[0];
  var base = int_of_string_base(match[2]);
  var threshold = 4294967295;
  var len = #s;
  var c = i < len and s.charCodeAt(i) or --[ "\000" ]--0;
  var d = parse_digit(c);
  if (d < 0 or d >= base) then do
    throw [
          Caml_builtin_exceptions.failure,
          "int_of_string"
        ];
  end
   end 
  var aux = function (_acc, _k) do
    while(true) do
      var k = _k;
      var acc = _acc;
      if (k == len) then do
        return acc;
      end else do
        var a = s.charCodeAt(k);
        if (a == --[ "_" ]--95) then do
          _k = k + 1 | 0;
          continue ;
        end else do
          var v = parse_digit(a);
          if (v < 0 or v >= base) then do
            throw [
                  Caml_builtin_exceptions.failure,
                  "int_of_string"
                ];
          end
           end 
          var acc$1 = base * acc + v;
          if (acc$1 > threshold) then do
            throw [
                  Caml_builtin_exceptions.failure,
                  "int_of_string"
                ];
          end
           end 
          _k = k + 1 | 0;
          _acc = acc$1;
          continue ;
        end end 
      end end 
    end;
  end;
  var res = match[1] * aux(d, i + 1 | 0);
  var or_res = res | 0;
  if (base == 10 and res ~= or_res) then do
    throw [
          Caml_builtin_exceptions.failure,
          "int_of_string"
        ];
  end
   end 
  return or_res;
end

function caml_int64_of_string(s) do
  var match = parse_sign_and_base(s);
  var hbase = match[2];
  var i = match[0];
  var base = Caml_int64.of_int32(int_of_string_base(hbase));
  var sign = Caml_int64.of_int32(match[1]);
  var threshold;
  local ___conditional___=(hbase);
  do
     if ___conditional___ = 0--[ Oct ]-- then do
        threshold = --[ int64 ]--[
          --[ hi ]--536870911,
          --[ lo ]--4294967295
        ];end else 
     if ___conditional___ = 1--[ Hex ]-- then do
        threshold = --[ int64 ]--[
          --[ hi ]--268435455,
          --[ lo ]--4294967295
        ];end else 
     if ___conditional___ = 2--[ Dec ]-- then do
        threshold = --[ int64 ]--[
          --[ hi ]--429496729,
          --[ lo ]--2576980377
        ];end else 
     if ___conditional___ = 3--[ Bin ]-- then do
        threshold = --[ int64 ]--[
          --[ hi ]--2147483647,
          --[ lo ]--4294967295
        ];end else 
     do end end end end end
    
  end
  var len = #s;
  var c = i < len and s.charCodeAt(i) or --[ "\000" ]--0;
  var d = Caml_int64.of_int32(parse_digit(c));
  if (Caml_int64.lt(d, --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--0
        ]) or Caml_int64.ge(d, base)) then do
    throw [
          Caml_builtin_exceptions.failure,
          "int64_of_string"
        ];
  end
   end 
  var aux = function (_acc, _k) do
    while(true) do
      var k = _k;
      var acc = _acc;
      if (k == len) then do
        return acc;
      end else do
        var a = s.charCodeAt(k);
        if (a == --[ "_" ]--95) then do
          _k = k + 1 | 0;
          continue ;
        end else do
          var v = Caml_int64.of_int32(parse_digit(a));
          if (Caml_int64.lt(v, --[ int64 ]--[
                  --[ hi ]--0,
                  --[ lo ]--0
                ]) or Caml_int64.ge(v, base) or Caml_int64.gt(acc, threshold)) then do
            throw [
                  Caml_builtin_exceptions.failure,
                  "int64_of_string"
                ];
          end
           end 
          var acc$1 = Caml_int64.add(Caml_int64.mul(base, acc), v);
          _k = k + 1 | 0;
          _acc = acc$1;
          continue ;
        end end 
      end end 
    end;
  end;
  var res = Caml_int64.mul(sign, aux(d, i + 1 | 0));
  var or_res = Caml_int64.or_(res, --[ int64 ]--[
        --[ hi ]--0,
        --[ lo ]--0
      ]);
  if (Caml_int64.eq(base, --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--10
        ]) and Caml_int64.neq(res, or_res)) then do
    throw [
          Caml_builtin_exceptions.failure,
          "int64_of_string"
        ];
  end
   end 
  return or_res;
end

function int_of_base(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[ Oct ]-- then do
        return 8;end end end 
     if ___conditional___ = 1--[ Hex ]-- then do
        return 16;end end end 
     if ___conditional___ = 2--[ Dec ]-- then do
        return 10;end end end 
     do
    
  end
end

function lowercase(c) do
  if (c >= --[ "A" ]--65 and c <= --[ "Z" ]--90 or c >= --[ "\192" ]--192 and c <= --[ "\214" ]--214 or c >= --[ "\216" ]--216 and c <= --[ "\222" ]--222) then do
    return c + 32 | 0;
  end else do
    return c;
  end end 
end

function parse_format(fmt) do
  var len = #fmt;
  if (len > 31) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "format_int: format too long"
        ];
  end
   end 
  var f = do
    justify: "+",
    signstyle: "-",
    filter: " ",
    alternate: false,
    base: --[ Dec ]--2,
    signedconv: false,
    width: 0,
    uppercase: false,
    sign: 1,
    prec: -1,
    conv: "f"
  end;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i >= len) then do
      return f;
    end else do
      var c = fmt.charCodeAt(i);
      var exit = 0;
      if (c >= 69) then do
        if (c >= 88) then do
          if (c >= 121) then do
            exit = 1;
          end else do
            local ___conditional___=(c - 88 | 0);
            do
               if ___conditional___ = 0 then do
                  f.base = --[ Hex ]--1;
                  f.uppercase = true;
                  _i = i + 1 | 0;
                  continue ;end end end 
               if ___conditional___ = 13
               or ___conditional___ = 14
               or ___conditional___ = 15 then do
                  exit = 5;end else 
               if ___conditional___ = 12
               or ___conditional___ = 17 then do
                  exit = 4;end else 
               if ___conditional___ = 23 then do
                  f.base = --[ Oct ]--0;
                  _i = i + 1 | 0;
                  continue ;end end end 
               if ___conditional___ = 29 then do
                  f.base = --[ Dec ]--2;
                  _i = i + 1 | 0;
                  continue ;end end end 
               if ___conditional___ = 1
               or ___conditional___ = 2
               or ___conditional___ = 3
               or ___conditional___ = 4
               or ___conditional___ = 5
               or ___conditional___ = 6
               or ___conditional___ = 7
               or ___conditional___ = 8
               or ___conditional___ = 9
               or ___conditional___ = 10
               or ___conditional___ = 11
               or ___conditional___ = 16
               or ___conditional___ = 18
               or ___conditional___ = 19
               or ___conditional___ = 20
               or ___conditional___ = 21
               or ___conditional___ = 22
               or ___conditional___ = 24
               or ___conditional___ = 25
               or ___conditional___ = 26
               or ___conditional___ = 27
               or ___conditional___ = 28
               or ___conditional___ = 30
               or ___conditional___ = 31 then do
                  exit = 1;end else 
               if ___conditional___ = 32 then do
                  f.base = --[ Hex ]--1;
                  _i = i + 1 | 0;
                  continue ;end end end 
               do
              
            end
          end end 
        end else if (c >= 72) then do
          exit = 1;
        end else do
          f.signedconv = true;
          f.uppercase = true;
          f.conv = String.fromCharCode(lowercase(c));
          _i = i + 1 | 0;
          continue ;
        end end  end 
      end else do
        local ___conditional___=(c);
        do
           if ___conditional___ = 35 then do
              f.alternate = true;
              _i = i + 1 | 0;
              continue ;end end end 
           if ___conditional___ = 32
           or ___conditional___ = 43 then do
              exit = 2;end else 
           if ___conditional___ = 45 then do
              f.justify = "-";
              _i = i + 1 | 0;
              continue ;end end end 
           if ___conditional___ = 46 then do
              f.prec = 0;
              var j = i + 1 | 0;
              while((function(j)do
                  return function () do
                    var w = fmt.charCodeAt(j) - --[ "0" ]--48 | 0;
                    return w >= 0 and w <= 9;
                  end
                  end(j))()) do
                f.prec = (Caml_int32.imul(f.prec, 10) + fmt.charCodeAt(j) | 0) - --[ "0" ]--48 | 0;
                j = j + 1 | 0;
              end;
              _i = j;
              continue ;end end end 
           if ___conditional___ = 33
           or ___conditional___ = 34
           or ___conditional___ = 36
           or ___conditional___ = 37
           or ___conditional___ = 38
           or ___conditional___ = 39
           or ___conditional___ = 40
           or ___conditional___ = 41
           or ___conditional___ = 42
           or ___conditional___ = 44
           or ___conditional___ = 47 then do
              exit = 1;end else 
           if ___conditional___ = 48 then do
              f.filter = "0";
              _i = i + 1 | 0;
              continue ;end end end 
           if ___conditional___ = 49
           or ___conditional___ = 50
           or ___conditional___ = 51
           or ___conditional___ = 52
           or ___conditional___ = 53
           or ___conditional___ = 54
           or ___conditional___ = 55
           or ___conditional___ = 56
           or ___conditional___ = 57 then do
              exit = 3;end else 
           do
          else do
            exit = 1;
            end end
            
        end
      end end 
      local ___conditional___=(exit);
      do
         if ___conditional___ = 1 then do
            _i = i + 1 | 0;
            continue ;end end end 
         if ___conditional___ = 2 then do
            f.signstyle = String.fromCharCode(c);
            _i = i + 1 | 0;
            continue ;end end end 
         if ___conditional___ = 3 then do
            f.width = 0;
            var j$1 = i;
            while((function(j$1)do
                return function () do
                  var w = fmt.charCodeAt(j$1) - --[ "0" ]--48 | 0;
                  return w >= 0 and w <= 9;
                end
                end(j$1))()) do
              f.width = (Caml_int32.imul(f.width, 10) + fmt.charCodeAt(j$1) | 0) - --[ "0" ]--48 | 0;
              j$1 = j$1 + 1 | 0;
            end;
            _i = j$1;
            continue ;end end end 
         if ___conditional___ = 4 then do
            f.signedconv = true;
            f.base = --[ Dec ]--2;
            _i = i + 1 | 0;
            continue ;end end end 
         if ___conditional___ = 5 then do
            f.signedconv = true;
            f.conv = String.fromCharCode(c);
            _i = i + 1 | 0;
            continue ;end end end 
         do
        
      end
    end end 
  end;
end

function finish_formatting(config, rawbuffer) do
  var justify = config.justify;
  var signstyle = config.signstyle;
  var filter = config.filter;
  var alternate = config.alternate;
  var base = config.base;
  var signedconv = config.signedconv;
  var width = config.width;
  var uppercase = config.uppercase;
  var sign = config.sign;
  var len = #rawbuffer;
  if (signedconv and (sign < 0 or signstyle ~= "-")) then do
    len = len + 1 | 0;
  end
   end 
  if (alternate) then do
    if (base == --[ Oct ]--0) then do
      len = len + 1 | 0;
    end else if (base == --[ Hex ]--1) then do
      len = len + 2 | 0;
    end
     end  end 
  end
   end 
  var buffer = "";
  if (justify == "+" and filter == " ") then do
    for var _for = len , width - 1 | 0 , 1 do
      buffer = buffer .. filter;
    end
  end
   end 
  if (signedconv) then do
    if (sign < 0) then do
      buffer = buffer .. "-";
    end else if (signstyle ~= "-") then do
      buffer = buffer .. signstyle;
    end
     end  end 
  end
   end 
  if (alternate and base == --[ Oct ]--0) then do
    buffer = buffer .. "0";
  end
   end 
  if (alternate and base == --[ Hex ]--1) then do
    buffer = buffer .. "0x";
  end
   end 
  if (justify == "+" and filter == "0") then do
    for var _for$1 = len , width - 1 | 0 , 1 do
      buffer = buffer .. filter;
    end
  end
   end 
  buffer = uppercase and buffer .. rawbuffer.toUpperCase() or buffer .. rawbuffer;
  if (justify == "-") then do
    for var _for$2 = len , width - 1 | 0 , 1 do
      buffer = buffer .. " ";
    end
  end
   end 
  return buffer;
end

function caml_format_int(fmt, i) do
  if (fmt == "%d") then do
    return String(i);
  end else do
    var f = parse_format(fmt);
    var f$1 = f;
    var i$1 = i;
    var i$2 = i$1 < 0 and (
        f$1.signedconv and (f$1.sign = -1, -i$1) or (i$1 >>> 0)
      ) or i$1;
    var s = i$2.toString(int_of_base(f$1.base));
    if (f$1.prec >= 0) then do
      f$1.filter = " ";
      var n = f$1.prec - #s | 0;
      if (n > 0) then do
        s = Caml_utils.repeat(n, "0") .. s;
      end
       end 
    end
     end 
    return finish_formatting(f$1, s);
  end end 
end

function caml_int64_format(fmt, x) do
  var f = parse_format(fmt);
  var x$1 = f.signedconv and Caml_int64.lt(x, --[ int64 ]--[
        --[ hi ]--0,
        --[ lo ]--0
      ]) and (f.sign = -1, Caml_int64.neg(x)) or x;
  var s = "";
  var match = f.base;
  local ___conditional___=(match);
  do
     if ___conditional___ = 0--[ Oct ]-- then do
        var wbase = --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--8
        ];
        var cvtbl = "01234567";
        if (Caml_int64.lt(x$1, --[ int64 ]--[
                --[ hi ]--0,
                --[ lo ]--0
              ])) then do
          var y = Caml_int64.discard_sign(x$1);
          var match$1 = Caml_int64.div_mod(y, wbase);
          var quotient = Caml_int64.add(--[ int64 ]--[
                --[ hi ]--268435456,
                --[ lo ]--0
              ], match$1[0]);
          var modulus = match$1[1];
          s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus))) .. s;
          while(Caml_int64.neq(quotient, --[ int64 ]--[
                  --[ hi ]--0,
                  --[ lo ]--0
                ])) do
            var match$2 = Caml_int64.div_mod(quotient, wbase);
            quotient = match$2[0];
            modulus = match$2[1];
            s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus))) .. s;
          end;
        end else do
          var match$3 = Caml_int64.div_mod(x$1, wbase);
          var quotient$1 = match$3[0];
          var modulus$1 = match$3[1];
          s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus$1))) .. s;
          while(Caml_int64.neq(quotient$1, --[ int64 ]--[
                  --[ hi ]--0,
                  --[ lo ]--0
                ])) do
            var match$4 = Caml_int64.div_mod(quotient$1, wbase);
            quotient$1 = match$4[0];
            modulus$1 = match$4[1];
            s = String.fromCharCode(cvtbl.charCodeAt(Caml_int64.to_int32(modulus$1))) .. s;
          end;
        end end end else 
     if ___conditional___ = 1--[ Hex ]-- then do
        s = Caml_int64.to_hex(x$1) .. s;end else 
     if ___conditional___ = 2--[ Dec ]-- then do
        var wbase$1 = --[ int64 ]--[
          --[ hi ]--0,
          --[ lo ]--10
        ];
        var cvtbl$1 = "0123456789";
        if (Caml_int64.lt(x$1, --[ int64 ]--[
                --[ hi ]--0,
                --[ lo ]--0
              ])) then do
          var y$1 = Caml_int64.discard_sign(x$1);
          var match$5 = Caml_int64.div_mod(y$1, wbase$1);
          var match$6 = Caml_int64.div_mod(Caml_int64.add(--[ int64 ]--[
                    --[ hi ]--0,
                    --[ lo ]--8
                  ], match$5[1]), wbase$1);
          var quotient$2 = Caml_int64.add(Caml_int64.add(--[ int64 ]--[
                    --[ hi ]--214748364,
                    --[ lo ]--3435973836
                  ], match$5[0]), match$6[0]);
          var modulus$2 = match$6[1];
          s = String.fromCharCode(cvtbl$1.charCodeAt(Caml_int64.to_int32(modulus$2))) .. s;
          while(Caml_int64.neq(quotient$2, --[ int64 ]--[
                  --[ hi ]--0,
                  --[ lo ]--0
                ])) do
            var match$7 = Caml_int64.div_mod(quotient$2, wbase$1);
            quotient$2 = match$7[0];
            modulus$2 = match$7[1];
            s = String.fromCharCode(cvtbl$1.charCodeAt(Caml_int64.to_int32(modulus$2))) .. s;
          end;
        end else do
          var match$8 = Caml_int64.div_mod(x$1, wbase$1);
          var quotient$3 = match$8[0];
          var modulus$3 = match$8[1];
          s = String.fromCharCode(cvtbl$1.charCodeAt(Caml_int64.to_int32(modulus$3))) .. s;
          while(Caml_int64.neq(quotient$3, --[ int64 ]--[
                  --[ hi ]--0,
                  --[ lo ]--0
                ])) do
            var match$9 = Caml_int64.div_mod(quotient$3, wbase$1);
            quotient$3 = match$9[0];
            modulus$3 = match$9[1];
            s = String.fromCharCode(cvtbl$1.charCodeAt(Caml_int64.to_int32(modulus$3))) .. s;
          end;
        end end end else 
     do end end end end
    
  end
  if (f.prec >= 0) then do
    f.filter = " ";
    var n = f.prec - #s | 0;
    if (n > 0) then do
      s = Caml_utils.repeat(n, "0") .. s;
    end
     end 
  end
   end 
  return finish_formatting(f, s);
end

function caml_format_float(fmt, x) do
  var f = parse_format(fmt);
  var prec = f.prec < 0 and 6 or f.prec;
  var x$1 = x < 0 and (f.sign = -1, -x) or x;
  var s = "";
  if (isNaN(x$1)) then do
    s = "nan";
    f.filter = " ";
  end else if (isFinite(x$1)) then do
    var match = f.conv;
    local ___conditional___=(match);
    do
       if ___conditional___ = "e" then do
          s = x$1.toExponential(prec);
          var i = #s;
          if (s[i - 3 | 0] == "e") then do
            s = s.slice(0, i - 1 | 0) .. ("0" .. s.slice(i - 1 | 0));
          end
           end end else 
       if ___conditional___ = "f" then do
          s = x$1.toFixed(prec);end else 
       if ___conditional___ = "g" then do
          var prec$1 = prec ~= 0 and prec or 1;
          s = x$1.toExponential(prec$1 - 1 | 0);
          var j = s.indexOf("e");
          var exp = Number(s.slice(j + 1 | 0)) | 0;
          if (exp < -4 or x$1 >= 1e21 or #x$1.toFixed() > prec$1) then do
            var i$1 = j - 1 | 0;
            while(s[i$1] == "0") do
              i$1 = i$1 - 1 | 0;
            end;
            if (s[i$1] == ".") then do
              i$1 = i$1 - 1 | 0;
            end
             end 
            s = s.slice(0, i$1 + 1 | 0) .. s.slice(j);
            var i$2 = #s;
            if (s[i$2 - 3 | 0] == "e") then do
              s = s.slice(0, i$2 - 1 | 0) .. ("0" .. s.slice(i$2 - 1 | 0));
            end
             end 
          end else do
            var p = prec$1;
            if (exp < 0) then do
              p = p - (exp + 1 | 0) | 0;
              s = x$1.toFixed(p);
            end else do
              while((function () do
                      s = x$1.toFixed(p);
                      return #s > (prec$1 + 1 | 0);
                    end)()) do
                p = p - 1 | 0;
              end;
            end end 
            if (p ~= 0) then do
              var k = #s - 1 | 0;
              while(s[k] == "0") do
                k = k - 1 | 0;
              end;
              if (s[k] == ".") then do
                k = k - 1 | 0;
              end
               end 
              s = s.slice(0, k + 1 | 0);
            end
             end 
          end end end else 
       do end end end end
      else do
        end end
        
    end
  end else do
    s = "inf";
    f.filter = " ";
  end end  end 
  return finish_formatting(f, s);
end

var caml_hexstring_of_float = (function(x,prec,style){
  if (!isFinite(x)) {
    if (isNaN(x)) return "nan";
    return x > 0 ? "infinity":"-infinity";
  }
  var sign = (x==0 && 1/x == -Infinity)?1:(x>=0)?0:1;
  if(sign) x = -x;
  var exp = 0;
  if (x == 0) { }
  else if (x < 1) {
    while (x < 1 && exp > -1022)  { x *= 2; exp-- }
  } else {
    while (x >= 2) { x /= 2; exp++ }
  }
  var exp_sign = exp < 0 ? '' : '+';
  var sign_str = '';
  if (sign) sign_str = '-'
  else {
    switch(style){
    case 43 /* '+' */: sign_str = '+'; break;
    case 32 /* ' ' */: sign_str = ' '; break;
    default: break;
    }
  }
  if (prec >= 0 && prec < 13) {
    /* If a precision is given, and is small, round mantissa accordingly */
      var cst = Math.pow(2,prec * 4);
      x = Math.round(x * cst) / cst;
  }
  var x_str = x.toString(16);
  if(prec >= 0){
      var idx = x_str.indexOf('.');
    if(idx<0) {
      x_str += '.' +  '0'.repeat(prec);
    }
    else {
      var size = idx+1+prec;
      if(x_str.length < size)
        x_str += '0'.repeat(size - x_str.length);
      else
        x_str = x_str.substr(0,size);
    }
  }
  return  (sign_str + '0x' + x_str + 'p' + exp_sign + exp.toString(10));
});

var float_of_string = (function(s,exn){

    var res = +s;
    if ((s.length > 0) && (res === res))
        return res;
    s = s.replace(/_/g, "");
    res = +s;
    if (((s.length > 0) && (res === res)) || /^[+-]?nan$/i.test(s)) {
        return res;
    };
    var m = /^ *([+-]?)0x([0-9a-f]+)\.?([0-9a-f]*)p([+-]?[0-9]+)/i.exec(s);
    //            1        2             3           4
    if(m){
        var m3 = m[3].replace(/0+$/,'');
        var mantissa = parseInt(m[1] + m[2] + m3, 16);
        var exponent = (m[4]|0) - 4*m3.length;
        res = mantissa * Math.pow(2, exponent);
        return res;
    }
    if (/^\+?inf(inity)?$/i.test(s))
        return Infinity;
    if (/^-inf(inity)?$/i.test(s))
        return -Infinity;
    throw exn;
});

function caml_float_of_string(s) do
  return float_of_string(s, [
              Caml_builtin_exceptions.failure,
              "float_of_string"
            ]);
end

var caml_nativeint_format = caml_format_int;

var caml_int32_format = caml_format_int;

var caml_int32_of_string = caml_int_of_string;

var caml_nativeint_of_string = caml_int_of_string;

exports.caml_format_float = caml_format_float;
exports.caml_hexstring_of_float = caml_hexstring_of_float;
exports.caml_format_int = caml_format_int;
exports.caml_nativeint_format = caml_nativeint_format;
exports.caml_int32_format = caml_int32_format;
exports.caml_float_of_string = caml_float_of_string;
exports.caml_int64_format = caml_int64_format;
exports.caml_int_of_string = caml_int_of_string;
exports.caml_int32_of_string = caml_int32_of_string;
exports.caml_int64_of_string = caml_int64_of_string;
exports.caml_nativeint_of_string = caml_nativeint_of_string;
--[ No side effect ]--
