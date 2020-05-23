'use strict';

var Bytes = require("../../lib/js/bytes.js");
var Caml_char = require("../../lib/js/caml_char.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");

function escaped(s) do
  var n = 0;
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    var c = s[i];
    var tmp;
    var exit = 0;
    if (c >= 14) do
      if (c ~= 34 and c ~= 92) do
        exit = 1;
      end else do
        tmp = 2;
      end
    end else if (c >= 11) do
      if (c >= 13) do
        tmp = 2;
      end else do
        exit = 1;
      end
    end else if (c >= 8) do
      tmp = 2;
    end else do
      exit = 1;
    end
    if (exit == 1) do
      tmp = Caml_char.caml_is_printable(c) ? 1 : 4;
    end
    n = n + tmp | 0;
  end
  if (n == #s) do
    return Bytes.copy(s);
  end else do
    var s$prime = Caml_bytes.caml_create_bytes(n);
    n = 0;
    for(var i$1 = 0 ,i_finish$1 = #s - 1 | 0; i$1 <= i_finish$1; ++i$1)do
      var c$1 = s[i$1];
      var exit$1 = 0;
      var switcher = c$1 - 34 | 0;
      if (switcher > 58 or switcher < 0) do
        if (switcher >= -20) do
          exit$1 = 1;
        end else do
          switch (switcher + 34 | 0) do
            case 8 :
                s$prime[n] = --[ "\\" ]--92;
                n = n + 1 | 0;
                s$prime[n] = --[ "b" ]--98;
                break;
            case 9 :
                s$prime[n] = --[ "\\" ]--92;
                n = n + 1 | 0;
                s$prime[n] = --[ "t" ]--116;
                break;
            case 10 :
                s$prime[n] = --[ "\\" ]--92;
                n = n + 1 | 0;
                s$prime[n] = --[ "n" ]--110;
                break;
            case 0 :
            case 1 :
            case 2 :
            case 3 :
            case 4 :
            case 5 :
            case 6 :
            case 7 :
            case 11 :
            case 12 :
                exit$1 = 1;
                break;
            case 13 :
                s$prime[n] = --[ "\\" ]--92;
                n = n + 1 | 0;
                s$prime[n] = --[ "r" ]--114;
                break;
            
          end
        end
      end else if (switcher > 57 or switcher < 1) do
        s$prime[n] = --[ "\\" ]--92;
        n = n + 1 | 0;
        s$prime[n] = c$1;
      end else do
        exit$1 = 1;
      end
      if (exit$1 == 1) do
        if (Caml_char.caml_is_printable(c$1)) do
          s$prime[n] = c$1;
        end else do
          s$prime[n] = --[ "\\" ]--92;
          n = n + 1 | 0;
          s$prime[n] = 48 + (c$1 / 100 | 0) | 0;
          n = n + 1 | 0;
          s$prime[n] = 48 + (c$1 / 10 | 0) % 10 | 0;
          n = n + 1 | 0;
          s$prime[n] = 48 + c$1 % 10 | 0;
        end
      end
      n = n + 1 | 0;
    end
    return s$prime;
  end
end

exports.escaped = escaped;
--[ No side effect ]--
