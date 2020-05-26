'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");

function fib(n) do
  if (n ~= 1 and n ~= 23) then do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end else do
    return 11111123;
  end end 
end

function escaped(s) do
  var n = 0;
  for var i = 0 , #s - 1 | 0 , 1 do
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
    for var i$1 = 0 , #s - 1 | 0 , 1 do
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

function string_escaped(s) do
  return Bytes.to_string(escaped(Bytes.of_string(s)));
end

var suites_000 = --[ tuple ]--[
  "complete_escape",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                Bytes.to_string(escaped(Bytes.of_string("\0\x01\x02\x03\x04\x05\x06\x07\b\t\n\x0b\f\r\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\x7f\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"))),
                "\\000\\001\\002\\003\\004\\005\\006\\007\\b\\t\\n\\011\\012\\r\\014\\015\\016\\017\\018\\019\\020\\021\\022\\023\\024\\025\\026\\027\\028\\029\\030\\031 !\\\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\\127\\128\\129\\130\\131\\132\\133\\134\\135\\136\\137\\138\\139\\140\\141\\142\\143\\144\\145\\146\\147\\148\\149\\150\\151\\152\\153\\154\\155\\156\\157\\158\\159\\160\\161\\162\\163\\164\\165\\166\\167\\168\\169\\170\\171\\172\\173\\174\\175\\176\\177\\178\\179\\180\\181\\182\\183\\184\\185\\186\\187\\188\\189\\190\\191\\192\\193\\194\\195\\196\\197\\198\\199\\200\\201\\202\\203\\204\\205\\206\\207\\208\\209\\210\\211\\212\\213\\214\\215\\216\\217\\218\\219\\220\\221\\222\\223\\224\\225\\226\\227\\228\\229\\230\\231\\232\\233\\234\\235\\236\\237\\238\\239\\240\\241\\242\\243\\244\\245\\246\\247\\248\\249\\250\\251\\252\\253\\254\\255"
              ]);
    end)
];

var suites = --[ :: ]--[
  suites_000,
  --[ [] ]--0
];

Mt.from_pair_suites("Complex_if_test", suites);

exports.fib = fib;
exports.escaped = escaped;
exports.string_escaped = string_escaped;
exports.suites = suites;
--[  Not a pure module ]--
