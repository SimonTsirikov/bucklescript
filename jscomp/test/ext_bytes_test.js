'use strict';

var Mt = require("./mt.js");
var Char = require("../../lib/js/char.js");
var Bytes = require("../../lib/js/bytes.js");
var Curry = require("../../lib/js/curry.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function escaped(s) do
  var n = 0;
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    var match = s[i];
    var tmp;
    if (match >= 32) then do
      var switcher = match - 34 | 0;
      tmp = switcher > 58 or switcher < 0 and (
          switcher >= 93 and 4 or 1
        ) or (
          switcher > 57 or switcher < 1 and 2 or 1
        );
    end else do
      tmp = match >= 11 and (
          match ~= 13 and 4 or 2
        ) or (
          match >= 8 and 2 or 4
        );
    end end 
    n = n + tmp | 0;
  end
  if (n == #s) then do
    return Bytes.copy(s);
  end else do
    var s$prime = Caml_bytes.caml_create_bytes(n);
    n = 0;
    for(var i$1 = 0 ,i_finish$1 = #s - 1 | 0; i$1 <= i_finish$1; ++i$1)do
      var c = s[i$1];
      var exit = 0;
      if (c >= 35) then do
        if (c ~= 92) then do
          if (c >= 127) then do
            exit = 1;
          end else do
            s$prime[n] = c;
          end end 
        end else do
          exit = 2;
        end end 
      end else if (c >= 32) then do
        if (c >= 34) then do
          exit = 2;
        end else do
          s$prime[n] = c;
        end end 
      end else if (c >= 14) then do
        exit = 1;
      end else do
        local ___conditional___=(c);
        do
           if ___conditional___ = 8 then do
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "b" ]--98;end else 
           if ___conditional___ = 9 then do
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "t" ]--116;end else 
           if ___conditional___ = 10 then do
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "n" ]--110;end else 
           if ___conditional___ = 0
           or ___conditional___ = 1
           or ___conditional___ = 2
           or ___conditional___ = 3
           or ___conditional___ = 4
           or ___conditional___ = 5
           or ___conditional___ = 6
           or ___conditional___ = 7
           or ___conditional___ = 11
           or ___conditional___ = 12 then do
              exit = 1;end else 
           if ___conditional___ = 13 then do
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "r" ]--114;end else 
           do end end end end end end
          
        end
      end end  end  end 
      local ___conditional___=(exit);
      do
         if ___conditional___ = 1 then do
            s$prime[n] = --[ "\\" ]--92;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 100 | 0) | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 10 | 0) % 10 | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + c % 10 | 0;end else 
         if ___conditional___ = 2 then do
            s$prime[n] = --[ "\\" ]--92;
            n = n + 1 | 0;
            s$prime[n] = c;end else 
         do end end end
        
      end
      n = n + 1 | 0;
    end
    return s$prime;
  end end 
end

function starts_with(xs, prefix, p) do
  var H = Caml_exceptions.create("H");
  var len1 = #xs;
  var len2 = #prefix;
  if (len2 > len1) then do
    return false;
  end else do
    try do
      for(var i = 0 ,i_finish = len2 - 1 | 0; i <= i_finish; ++i)do
        if (!Curry._2(p, Caml_bytes.get(xs, i), Caml_bytes.get(prefix, i))) then do
          throw H;
        end
         end 
      end
      return true;
    end
    catch (exn)do
      if (exn == H) then do
        return false;
      end else do
        throw exn;
      end end 
    end
  end end 
end

var a = Bytes.init(100, Char.chr);

Bytes.blit(a, 5, a, 10, 10);

eq("File \"ext_bytes_test.ml\", line 96, characters 7-14", a, Bytes.of_string("\0\x01\x02\x03\x04\x05\x06\x07\b\t\x05\x06\x07\b\t\n\x0b\f\r\x0e\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abc"));

var a$1 = Bytes.init(100, Char.chr);

Bytes.blit(a$1, 10, a$1, 5, 10);

eq("File \"ext_bytes_test.ml\", line 102, characters 7-14", a$1, Bytes.of_string("\0\x01\x02\x03\x04\n\x0b\f\r\x0e\x0f\x10\x11\x12\x13\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abc"));

var f = Char.chr;

var a$2 = Caml_bytes.bytes_to_string(Bytes.init(100, f));

var b = Bytes.init(100, (function (i) do
        return --[ "\000" ]--0;
      end));

Bytes.blit_string(a$2, 10, b, 5, 10);

eq("File \"ext_bytes_test.ml\", line 109, characters 7-14", b, Bytes.of_string("\0\0\0\0\0\n\x0b\f\r\x0e\x0f\x10\x11\x12\x13\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"));

Mt.from_pair_suites("Ext_bytes_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.escaped = escaped;
exports.starts_with = starts_with;
--[ a Not a pure module ]--
