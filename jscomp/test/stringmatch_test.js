'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function tst01(s) do
  if (s == "") then do
    return 0;
  end else do
    return 1;
  end end 
end

if (tst01("") ~= 0) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          20,
          2
        ]
      ];
end
 end 

if (tst01("\0\0\0\x03") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          21,
          2
        ]
      ];
end
 end 

if (tst01("\0\0\0\0\0\0\0\x07") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          22,
          2
        ]
      ];
end
 end 

function tst02(s) do
  var len = #s;
  if (s == "") then do
    if (len < 0) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "stringmatch_test.ml",
              30,
              23
            ]
          ];
    end else do
      return 1;
    end end 
  end else do
    if (len == 0) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "stringmatch_test.ml",
              32,
              22
            ]
          ];
    end
     end 
    if (s == "A") then do
      return 2;
    end else do
      return 3;
    end end 
  end end 
end

if (tst02("") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          37,
          2
        ]
      ];
end
 end 

if (tst02("A") ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          38,
          2
        ]
      ];
end
 end 

if (tst02("B") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          39,
          2
        ]
      ];
end
 end 

if (tst02("\0\0\0\0\0\0\0\x07") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          40,
          2
        ]
      ];
end
 end 

if (tst02("\0\0\0\x03") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          41,
          2
        ]
      ];
end
 end 

function tst03(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ = "app_const" then do
        return 5;end end end 
     if ___conditional___ = "app_const_const" then do
        return 9;end end end 
     if ___conditional___ = "app_const_env" then do
        return 11;end end end 
     if ___conditional___ = "app_const_meth" then do
        return 12;end end end 
     if ___conditional___ = "app_const_var" then do
        return 10;end end end 
     if ___conditional___ = "app_env" then do
        return 7;end end end 
     if ___conditional___ = "app_env_const" then do
        return 14;end end end 
     if ___conditional___ = "app_meth" then do
        return 8;end end end 
     if ___conditional___ = "app_meth_const" then do
        return 15;end end end 
     if ___conditional___ = "app_var" then do
        return 6;end end end 
     if ___conditional___ = "app_var_const" then do
        return 13;end end end 
     if ___conditional___ = "get_const" then do
        return 0;end end end 
     if ___conditional___ = "get_env" then do
        return 2;end end end 
     if ___conditional___ = "get_meth" then do
        return 3;end end end 
     if ___conditional___ = "get_var" then do
        return 1;end end end 
     if ___conditional___ = "meth_app_const" then do
        return 16;end end end 
     if ___conditional___ = "meth_app_env" then do
        return 18;end end end 
     if ___conditional___ = "meth_app_meth" then do
        return 19;end end end 
     if ___conditional___ = "meth_app_var" then do
        return 17;end end end 
     if ___conditional___ = "send_const" then do
        return 20;end end end 
     if ___conditional___ = "send_env" then do
        return 22;end end end 
     if ___conditional___ = "send_meth" then do
        return 23;end end end 
     if ___conditional___ = "send_var" then do
        return 21;end end end 
     if ___conditional___ = "set_var" then do
        return 4;end end end 
     do
    else do
      return -1;
      end end
      
  end
end

if (tst03("get_const") ~= 0) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          123,
          2
        ]
      ];
end
 end 

if (tst03("set_congt") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          124,
          2
        ]
      ];
end
 end 

if (tst03("get_var") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          125,
          2
        ]
      ];
end
 end 

if (tst03("gat_ver") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          126,
          2
        ]
      ];
end
 end 

if (tst03("get_env") ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          127,
          2
        ]
      ];
end
 end 

if (tst03("get_env") ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          128,
          2
        ]
      ];
end
 end 

if (tst03("get_meth") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          129,
          2
        ]
      ];
end
 end 

if (tst03("met_geth") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          130,
          2
        ]
      ];
end
 end 

if (tst03("set_var") ~= 4) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          131,
          2
        ]
      ];
end
 end 

if (tst03("sev_tar") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          132,
          2
        ]
      ];
end
 end 

if (tst03("app_const") ~= 5) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          133,
          2
        ]
      ];
end
 end 

if (tst03("ppa_const") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          134,
          2
        ]
      ];
end
 end 

if (tst03("app_var") ~= 6) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          135,
          2
        ]
      ];
end
 end 

if (tst03("app_var") ~= 6) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          136,
          2
        ]
      ];
end
 end 

if (tst03("app_env") ~= 7) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          137,
          2
        ]
      ];
end
 end 

if (tst03("epp_anv") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          138,
          2
        ]
      ];
end
 end 

if (tst03("app_meth") ~= 8) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          139,
          2
        ]
      ];
end
 end 

if (tst03("atp_meph") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          140,
          2
        ]
      ];
end
 end 

if (tst03("app_const_const") ~= 9) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          141,
          2
        ]
      ];
end
 end 

if (tst03("app_const_const") ~= 9) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          142,
          2
        ]
      ];
end
 end 

if (tst03("app_const_var") ~= 10) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          143,
          2
        ]
      ];
end
 end 

if (tst03("atp_consp_var") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          144,
          2
        ]
      ];
end
 end 

if (tst03("app_const_env") ~= 11) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          145,
          2
        ]
      ];
end
 end 

if (tst03("app_constne_v") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          146,
          2
        ]
      ];
end
 end 

if (tst03("app_const_meth") ~= 12) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          147,
          2
        ]
      ];
end
 end 

if (tst03("spp_conat_meth") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          148,
          2
        ]
      ];
end
 end 

if (tst03("app_var_const") ~= 13) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          149,
          2
        ]
      ];
end
 end 

if (tst03("app_va_rconst") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          150,
          2
        ]
      ];
end
 end 

if (tst03("app_env_const") ~= 14) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          151,
          2
        ]
      ];
end
 end 

if (tst03("app_env_const") ~= 14) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          152,
          2
        ]
      ];
end
 end 

if (tst03("app_meth_const") ~= 15) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          153,
          2
        ]
      ];
end
 end 

if (tst03("app_teth_consm") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          154,
          2
        ]
      ];
end
 end 

if (tst03("meth_app_const") ~= 16) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          155,
          2
        ]
      ];
end
 end 

if (tst03("math_epp_const") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          156,
          2
        ]
      ];
end
 end 

if (tst03("meth_app_var") ~= 17) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          157,
          2
        ]
      ];
end
 end 

if (tst03("meth_app_var") ~= 17) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          158,
          2
        ]
      ];
end
 end 

if (tst03("meth_app_env") ~= 18) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          159,
          2
        ]
      ];
end
 end 

if (tst03("eeth_app_mnv") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          160,
          2
        ]
      ];
end
 end 

if (tst03("meth_app_meth") ~= 19) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          161,
          2
        ]
      ];
end
 end 

if (tst03("meth_apt_meph") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          162,
          2
        ]
      ];
end
 end 

if (tst03("send_const") ~= 20) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          163,
          2
        ]
      ];
end
 end 

if (tst03("tend_conss") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          164,
          2
        ]
      ];
end
 end 

if (tst03("send_var") ~= 21) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          165,
          2
        ]
      ];
end
 end 

if (tst03("serd_van") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          166,
          2
        ]
      ];
end
 end 

if (tst03("send_env") ~= 22) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          167,
          2
        ]
      ];
end
 end 

if (tst03("sen_denv") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          168,
          2
        ]
      ];
end
 end 

if (tst03("send_meth") ~= 23) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          169,
          2
        ]
      ];
end
 end 

if (tst03("tend_mesh") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          170,
          2
        ]
      ];
end
 end 

function tst04(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ = "AAAAAAAA" then do
        return 0;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAA" then do
        return 1;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 2;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 3;end end end 
     if ___conditional___ = "BBBBBBBB" then do
        return 4;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBBB" then do
        return 5;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBBBBBBBBBBB" then do
        return 6;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" then do
        return 7;end end end 
     if ___conditional___ = "CCCCCCCC" then do
        return 8;end end end 
     if ___conditional___ = "CCCCCCCCCCCCCCCC" then do
        return 9;end end end 
     if ___conditional___ = "CCCCCCCCCCCCCCCCCCCCCCCC" then do
        return 10;end end end 
     if ___conditional___ = "CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC" then do
        return 11;end end end 
     do
    else do
      return -1;
      end end
      
  end
end

if (tst04("AAAAAAAA") ~= 0) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          204,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAAAAAAAAAAA") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          205,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAAAAAAAAAAAAAAAAAAA") ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          206,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          207,
          2
        ]
      ];
end
 end 

if (tst04("BBBBBBBB") ~= 4) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          208,
          2
        ]
      ];
end
 end 

if (tst04("BBBBBBBBBBBBBBBB") ~= 5) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          209,
          2
        ]
      ];
end
 end 

if (tst04("BBBBBBBBBBBBBBBBBBBBBBBB") ~= 6) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          210,
          2
        ]
      ];
end
 end 

if (tst04("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB") ~= 7) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          211,
          2
        ]
      ];
end
 end 

if (tst04("CCCCCCCC") ~= 8) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          212,
          2
        ]
      ];
end
 end 

if (tst04("CCCCCCCCCCCCCCCC") ~= 9) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          213,
          2
        ]
      ];
end
 end 

if (tst04("CCCCCCCCCCCCCCCCCCCCCCCC") ~= 10) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          214,
          2
        ]
      ];
end
 end 

if (tst04("CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC") ~= 11) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          215,
          2
        ]
      ];
end
 end 

if (tst04("") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          216,
          2
        ]
      ];
end
 end 

if (tst04("DDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          217,
          2
        ]
      ];
end
 end 

if (tst04("DDDDDDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          218,
          2
        ]
      ];
end
 end 

if (tst04("AAADDDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          219,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAADDDDDDDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          220,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAADDDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          221,
          2
        ]
      ];
end
 end 

if (tst04("AAAAAAAAAAAAAAADDDD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          222,
          2
        ]
      ];
end
 end 

function tst05(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ = "AAA" then do
        return 0;end end end 
     if ___conditional___ = "AAAA" then do
        return 1;end end end 
     if ___conditional___ = "AAAAA" then do
        return 2;end end end 
     if ___conditional___ = "AAAAAA" then do
        return 3;end end end 
     if ___conditional___ = "AAAAAAA" then do
        return 4;end end end 
     if ___conditional___ = "AAAAAAAAAAAA" then do
        return 5;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAA" then do
        return 6;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAA" then do
        return 7;end end end 
     if ___conditional___ = "BBB" then do
        return 8;end end end 
     if ___conditional___ = "BBBB" then do
        return 9;end end end 
     if ___conditional___ = "BBBBB" then do
        return 10;end end end 
     if ___conditional___ = "BBBBBB" then do
        return 11;end end end 
     if ___conditional___ = "BBBBBBB" then do
        return 12;end end end 
     do
    else do
      return -1;
      end end
      
  end
end

if (tst05("AAA") ~= 0) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          258,
          2
        ]
      ];
end
 end 

if (tst05("AAAA") ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          259,
          2
        ]
      ];
end
 end 

if (tst05("AAAAA") ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          260,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAA") ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          261,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAA") ~= 4) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          262,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAAAAAAA") ~= 5) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          263,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAAAAAAAAAAA") ~= 6) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          264,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAAAAAAAAAAAAAAA") ~= 7) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          265,
          2
        ]
      ];
end
 end 

if (tst05("BBB") ~= 8) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          266,
          2
        ]
      ];
end
 end 

if (tst05("BBBB") ~= 9) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          267,
          2
        ]
      ];
end
 end 

if (tst05("BBBBB") ~= 10) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          268,
          2
        ]
      ];
end
 end 

if (tst05("BBBBBB") ~= 11) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          269,
          2
        ]
      ];
end
 end 

if (tst05("BBBBBBB") ~= 12) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          270,
          2
        ]
      ];
end
 end 

if (tst05("") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          271,
          2
        ]
      ];
end
 end 

if (tst05("AAD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          272,
          2
        ]
      ];
end
 end 

if (tst05("AAAD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          273,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          274,
          2
        ]
      ];
end
 end 

if (tst05("AAAAAAAD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          275,
          2
        ]
      ];
end
 end 

if (tst05("BBD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          276,
          2
        ]
      ];
end
 end 

if (tst05("BBBD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          277,
          2
        ]
      ];
end
 end 

if (tst05("BBBBBBD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          278,
          2
        ]
      ];
end
 end 

if (tst05("BBBBBBBD") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          279,
          2
        ]
      ];
end
 end 

var s00 = "and";

var t00 = "nad";

var s01 = "as";

var t01 = "sa";

var s02 = "assert";

var t02 = "asesrt";

var s03 = "begin";

var t03 = "negib";

var s04 = "class";

var t04 = "lcass";

var s05 = "constraint";

var t05 = "constiarnt";

var s06 = "do";

var t06 = "od";

var s07 = "done";

var t07 = "eond";

var s08 = "downto";

var t08 = "dowtno";

var s09 = "else";

var t09 = "lese";

var s10 = "end";

var t10 = "edn";

var s11 = "exception";

var t11 = "exception";

var s12 = "external";

var t12 = "external";

var s13 = "false";

var t13 = "fslae";

var s14 = "for";

var t14 = "ofr";

var s15 = "fun";

var t15 = "fnu";

var s16 = "function";

var t16 = "function";

var s17 = "functor";

var t17 = "ounctfr";

var s18 = "if";

var t18 = "fi";

var s19 = "in";

var t19 = "in";

var s20 = "include";

var t20 = "inculde";

var s21 = "inherit";

var t21 = "iehnrit";

var s22 = "initializer";

var t22 = "enitializir";

var s23 = "lazy";

var t23 = "zaly";

var s24 = "let";

var t24 = "elt";

var s25 = "match";

var t25 = "match";

var s26 = "method";

var t26 = "methdo";

var s27 = "module";

var t27 = "modelu";

var s28 = "mutable";

var t28 = "butamle";

var s29 = "new";

var t29 = "wen";

var s30 = "object";

var t30 = "objcet";

var s31 = "of";

var t31 = "of";

var s32 = "open";

var t32 = "epon";

var s33 = "or";

var t33 = "ro";

var s34 = "private";

var t34 = "privaet";

var s35 = "rec";

var t35 = "rec";

var s36 = "sig";

var t36 = "gis";

var s37 = "struct";

var t37 = "scrutt";

var s38 = "then";

var t38 = "hten";

var s39 = "to";

var t39 = "to";

var s40 = "true";

var t40 = "teur";

var s41 = "try";

var t41 = "try";

var s42 = "type";

var t42 = "pyte";

var s43 = "val";

var t43 = "val";

var s44 = "virtual";

var t44 = "vritual";

var s45 = "when";

var t45 = "whne";

var s46 = "while";

var t46 = "wlihe";

var s47 = "with";

var t47 = "iwth";

var s48 = "mod";

var t48 = "mod";

var s49 = "land";

var t49 = "alnd";

var s50 = "lor";

var t50 = "rol";

var s51 = "lxor";

var t51 = "lxor";

var s52 = "lsl";

var t52 = "lsl";

var s53 = "lsr";

var t53 = "lsr";

var s54 = "asr";

var t54 = "sar";

var s55 = "A";

var t55 = "A";

var s56 = "AA";

var t56 = "AA";

var s57 = "AAA";

var t57 = "AAA";

var s58 = "AAAA";

var t58 = "AAAA";

var s59 = "AAAAA";

var t59 = "AAAAA";

var s60 = "AAAAAA";

var t60 = "AAAAAA";

var s61 = "AAAAAAA";

var t61 = "AAAAAAA";

var s62 = "AAAAAAAA";

var t62 = "AAAAAAAA";

var s63 = "AAAAAAAAA";

var t63 = "AAAAAAAAA";

var s64 = "AAAAAAAAAA";

var t64 = "AAAAAAAAAA";

var s65 = "AAAAAAAAAAA";

var t65 = "AAAAAAAAAAA";

var s66 = "AAAAAAAAAAAA";

var t66 = "AAAAAAAAAAAA";

var s67 = "AAAAAAAAAAAAA";

var t67 = "AAAAAAAAAAAAA";

var s68 = "AAAAAAAAAAAAAA";

var t68 = "AAAAAAAAAAAAAA";

var s69 = "AAAAAAAAAAAAAAA";

var t69 = "AAAAAAAAAAAAAAA";

var s70 = "AAAAAAAAAAAAAAAA";

var t70 = "AAAAAAAAAAAAAAAA";

var s71 = "AAAAAAAAAAAAAAAAA";

var t71 = "AAAAAAAAAAAAAAAAA";

var s72 = "AAAAAAAAAAAAAAAAAA";

var t72 = "AAAAAAAAAAAAAAAAAA";

var s73 = "AAAAAAAAAAAAAAAAAAA";

var t73 = "AAAAAAAAAAAAAAAAAAA";

var s74 = "AAAAAAAAAAAAAAAAAAAA";

var t74 = "AAAAAAAAAAAAAAAAAAAA";

var s75 = "AAAAAAAAAAAAAAAAAAAAA";

var t75 = "AAAAAAAAAAAAAAAAAAAAA";

var s76 = "AAAAAAAAAAAAAAAAAAAAAA";

var t76 = "AAAAAAAAAAAAAAAAAAAAAA";

var s77 = "AAAAAAAAAAAAAAAAAAAAAAA";

var t77 = "AAAAAAAAAAAAAAAAAAAAAAA";

var s78 = "AAAAAAAAAAAAAAAAAAAAAAAA";

var t78 = "AAAAAAAAAAAAAAAAAAAAAAAA";

var s79 = "AAAAAAAAAAAAAAAAAAAAAAAAA";

var t79 = "AAAAAAAAAAAAAAAAAAAAAAAAA";

var s80 = "AAAAAAAAAAAAAAAAAAAAAAAAAA";

var t80 = "AAAAAAAAAAAAAAAAAAAAAAAAAA";

var s81 = "AAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t81 = "AAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s82 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t82 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s83 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t83 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s84 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t84 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s85 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t85 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s86 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t86 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s87 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t87 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s88 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var t88 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";

var s89 = "BBBBBBBBBBBBBBB";

var t89 = "BBBBBBBBBBBBBBB";

var s90 = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";

var t90 = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";

var s91 = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";

var t91 = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB";

function tst06(s) do
  local ___conditional___=(s);
  do
     if ___conditional___ = "A" then do
        return 55;end end end 
     if ___conditional___ = "AA" then do
        return 56;end end end 
     if ___conditional___ = "AAA" then do
        return 57;end end end 
     if ___conditional___ = "AAAA" then do
        return 58;end end end 
     if ___conditional___ = "AAAAA" then do
        return 59;end end end 
     if ___conditional___ = "AAAAAA" then do
        return 60;end end end 
     if ___conditional___ = "AAAAAAA" then do
        return 61;end end end 
     if ___conditional___ = "AAAAAAAA" then do
        return 62;end end end 
     if ___conditional___ = "AAAAAAAAA" then do
        return 63;end end end 
     if ___conditional___ = "AAAAAAAAAA" then do
        return 64;end end end 
     if ___conditional___ = "AAAAAAAAAAA" then do
        return 65;end end end 
     if ___conditional___ = "AAAAAAAAAAAA" then do
        return 66;end end end 
     if ___conditional___ = "AAAAAAAAAAAAA" then do
        return 67;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAA" then do
        return 68;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAA" then do
        return 69;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAA" then do
        return 70;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAA" then do
        return 71;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAA" then do
        return 72;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAA" then do
        return 73;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAA" then do
        return 74;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAA" then do
        return 75;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAA" then do
        return 76;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAA" then do
        return 77;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 78;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 79;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 80;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 81;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 82;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 83;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 84;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 85;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 86;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 87;end end end 
     if ___conditional___ = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" then do
        return 88;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBB" then do
        return 89;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" then do
        return 90;end end end 
     if ___conditional___ = "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" then do
        return 91;end end end 
     if ___conditional___ = "and" then do
        return 0;end end end 
     if ___conditional___ = "as" then do
        return 1;end end end 
     if ___conditional___ = "asr" then do
        return 54;end end end 
     if ___conditional___ = "assert" then do
        return 2;end end end 
     if ___conditional___ = "begin" then do
        return 3;end end end 
     if ___conditional___ = "class" then do
        return 4;end end end 
     if ___conditional___ = "constraint" then do
        return 5;end end end 
     if ___conditional___ = "do" then do
        return 6;end end end 
     if ___conditional___ = "done" then do
        return 7;end end end 
     if ___conditional___ = "downto" then do
        return 8;end end end 
     if ___conditional___ = "else" then do
        return 9;end end end 
     if ___conditional___ = "end" then do
        return 10;end end end 
     if ___conditional___ = "exception" then do
        return 11;end end end 
     if ___conditional___ = "external" then do
        return 12;end end end 
     if ___conditional___ = "false" then do
        return 13;end end end 
     if ___conditional___ = "for" then do
        return 14;end end end 
     if ___conditional___ = "fun" then do
        return 15;end end end 
     if ___conditional___ = "function" then do
        return 16;end end end 
     if ___conditional___ = "functor" then do
        return 17;end end end 
     if ___conditional___ = "if" then do
        return 18;end end end 
     if ___conditional___ = "in" then do
        return 19;end end end 
     if ___conditional___ = "include" then do
        return 20;end end end 
     if ___conditional___ = "inherit" then do
        return 21;end end end 
     if ___conditional___ = "initializer" then do
        return 22;end end end 
     if ___conditional___ = "land" then do
        return 49;end end end 
     if ___conditional___ = "lazy" then do
        return 23;end end end 
     if ___conditional___ = "let" then do
        return 24;end end end 
     if ___conditional___ = "lor" then do
        return 50;end end end 
     if ___conditional___ = "lsl" then do
        return 52;end end end 
     if ___conditional___ = "lsr" then do
        return 53;end end end 
     if ___conditional___ = "lxor" then do
        return 51;end end end 
     if ___conditional___ = "match" then do
        return 25;end end end 
     if ___conditional___ = "method" then do
        return 26;end end end 
     if ___conditional___ = "mod" then do
        return 48;end end end 
     if ___conditional___ = "module" then do
        return 27;end end end 
     if ___conditional___ = "mutable" then do
        return 28;end end end 
     if ___conditional___ = "new" then do
        return 29;end end end 
     if ___conditional___ = "object" then do
        return 30;end end end 
     if ___conditional___ = "of" then do
        return 31;end end end 
     if ___conditional___ = "open" then do
        return 32;end end end 
     if ___conditional___ = "or" then do
        return 33;end end end 
     if ___conditional___ = "private" then do
        return 34;end end end 
     if ___conditional___ = "rec" then do
        return 35;end end end 
     if ___conditional___ = "sig" then do
        return 36;end end end 
     if ___conditional___ = "struct" then do
        return 37;end end end 
     if ___conditional___ = "then" then do
        return 38;end end end 
     if ___conditional___ = "to" then do
        return 39;end end end 
     if ___conditional___ = "true" then do
        return 40;end end end 
     if ___conditional___ = "try" then do
        return 41;end end end 
     if ___conditional___ = "type" then do
        return 42;end end end 
     if ___conditional___ = "val" then do
        return 43;end end end 
     if ___conditional___ = "virtual" then do
        return 44;end end end 
     if ___conditional___ = "when" then do
        return 45;end end end 
     if ___conditional___ = "while" then do
        return 46;end end end 
     if ___conditional___ = "with" then do
        return 47;end end end 
     do
    else do
      return -1;
      end end
      
  end
end

if (tst06(s00) ~= 0) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          565,
          2
        ]
      ];
end
 end 

if (tst06(t00) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          566,
          2
        ]
      ];
end
 end 

if (tst06(s01) ~= 1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          567,
          2
        ]
      ];
end
 end 

if (tst06(t01) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          568,
          2
        ]
      ];
end
 end 

if (tst06(s02) ~= 2) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          569,
          2
        ]
      ];
end
 end 

if (tst06(t02) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          570,
          2
        ]
      ];
end
 end 

if (tst06(s03) ~= 3) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          571,
          2
        ]
      ];
end
 end 

if (tst06(t03) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          572,
          2
        ]
      ];
end
 end 

if (tst06(s04) ~= 4) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          573,
          2
        ]
      ];
end
 end 

if (tst06(t04) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          574,
          2
        ]
      ];
end
 end 

if (tst06(s05) ~= 5) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          575,
          2
        ]
      ];
end
 end 

if (tst06(t05) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          576,
          2
        ]
      ];
end
 end 

if (tst06(s06) ~= 6) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          577,
          2
        ]
      ];
end
 end 

if (tst06(t06) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          578,
          2
        ]
      ];
end
 end 

if (tst06(s07) ~= 7) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          579,
          2
        ]
      ];
end
 end 

if (tst06(t07) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          580,
          2
        ]
      ];
end
 end 

if (tst06(s08) ~= 8) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          581,
          2
        ]
      ];
end
 end 

if (tst06(t08) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          582,
          2
        ]
      ];
end
 end 

if (tst06(s09) ~= 9) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          583,
          2
        ]
      ];
end
 end 

if (tst06(t09) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          584,
          2
        ]
      ];
end
 end 

if (tst06(s10) ~= 10) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          585,
          2
        ]
      ];
end
 end 

if (tst06(t10) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          586,
          2
        ]
      ];
end
 end 

if (tst06(s11) ~= 11) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          587,
          2
        ]
      ];
end
 end 

if (tst06(t11) ~= 11) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          588,
          2
        ]
      ];
end
 end 

if (tst06(s12) ~= 12) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          589,
          2
        ]
      ];
end
 end 

if (tst06(t12) ~= 12) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          590,
          2
        ]
      ];
end
 end 

if (tst06(s13) ~= 13) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          591,
          2
        ]
      ];
end
 end 

if (tst06(t13) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          592,
          2
        ]
      ];
end
 end 

if (tst06(s14) ~= 14) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          593,
          2
        ]
      ];
end
 end 

if (tst06(t14) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          594,
          2
        ]
      ];
end
 end 

if (tst06(s15) ~= 15) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          595,
          2
        ]
      ];
end
 end 

if (tst06(t15) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          596,
          2
        ]
      ];
end
 end 

if (tst06(s16) ~= 16) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          597,
          2
        ]
      ];
end
 end 

if (tst06(t16) ~= 16) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          598,
          2
        ]
      ];
end
 end 

if (tst06(s17) ~= 17) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          599,
          2
        ]
      ];
end
 end 

if (tst06(t17) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          600,
          2
        ]
      ];
end
 end 

if (tst06(s18) ~= 18) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          601,
          2
        ]
      ];
end
 end 

if (tst06(t18) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          602,
          2
        ]
      ];
end
 end 

if (tst06(s19) ~= 19) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          603,
          2
        ]
      ];
end
 end 

if (tst06(t19) ~= 19) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          604,
          2
        ]
      ];
end
 end 

if (tst06(s20) ~= 20) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          605,
          2
        ]
      ];
end
 end 

if (tst06(t20) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          606,
          2
        ]
      ];
end
 end 

if (tst06(s21) ~= 21) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          607,
          2
        ]
      ];
end
 end 

if (tst06(t21) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          608,
          2
        ]
      ];
end
 end 

if (tst06(s22) ~= 22) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          609,
          2
        ]
      ];
end
 end 

if (tst06(t22) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          610,
          2
        ]
      ];
end
 end 

if (tst06(s23) ~= 23) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          611,
          2
        ]
      ];
end
 end 

if (tst06(t23) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          612,
          2
        ]
      ];
end
 end 

if (tst06(s24) ~= 24) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          613,
          2
        ]
      ];
end
 end 

if (tst06(t24) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          614,
          2
        ]
      ];
end
 end 

if (tst06(s25) ~= 25) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          615,
          2
        ]
      ];
end
 end 

if (tst06(t25) ~= 25) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          616,
          2
        ]
      ];
end
 end 

if (tst06(s26) ~= 26) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          617,
          2
        ]
      ];
end
 end 

if (tst06(t26) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          618,
          2
        ]
      ];
end
 end 

if (tst06(s27) ~= 27) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          619,
          2
        ]
      ];
end
 end 

if (tst06(t27) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          620,
          2
        ]
      ];
end
 end 

if (tst06(s28) ~= 28) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          621,
          2
        ]
      ];
end
 end 

if (tst06(t28) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          622,
          2
        ]
      ];
end
 end 

if (tst06(s29) ~= 29) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          623,
          2
        ]
      ];
end
 end 

if (tst06(t29) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          624,
          2
        ]
      ];
end
 end 

if (tst06(s30) ~= 30) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          625,
          2
        ]
      ];
end
 end 

if (tst06(t30) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          626,
          2
        ]
      ];
end
 end 

if (tst06(s31) ~= 31) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          627,
          2
        ]
      ];
end
 end 

if (tst06(t31) ~= 31) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          628,
          2
        ]
      ];
end
 end 

if (tst06(s32) ~= 32) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          629,
          2
        ]
      ];
end
 end 

if (tst06(t32) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          630,
          2
        ]
      ];
end
 end 

if (tst06(s33) ~= 33) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          631,
          2
        ]
      ];
end
 end 

if (tst06(t33) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          632,
          2
        ]
      ];
end
 end 

if (tst06(s34) ~= 34) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          633,
          2
        ]
      ];
end
 end 

if (tst06(t34) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          634,
          2
        ]
      ];
end
 end 

if (tst06(s35) ~= 35) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          635,
          2
        ]
      ];
end
 end 

if (tst06(t35) ~= 35) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          636,
          2
        ]
      ];
end
 end 

if (tst06(s36) ~= 36) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          637,
          2
        ]
      ];
end
 end 

if (tst06(t36) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          638,
          2
        ]
      ];
end
 end 

if (tst06(s37) ~= 37) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          639,
          2
        ]
      ];
end
 end 

if (tst06(t37) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          640,
          2
        ]
      ];
end
 end 

if (tst06(s38) ~= 38) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          641,
          2
        ]
      ];
end
 end 

if (tst06(t38) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          642,
          2
        ]
      ];
end
 end 

if (tst06(s39) ~= 39) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          643,
          2
        ]
      ];
end
 end 

if (tst06(t39) ~= 39) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          644,
          2
        ]
      ];
end
 end 

if (tst06(s40) ~= 40) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          645,
          2
        ]
      ];
end
 end 

if (tst06(t40) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          646,
          2
        ]
      ];
end
 end 

if (tst06(s41) ~= 41) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          647,
          2
        ]
      ];
end
 end 

if (tst06(t41) ~= 41) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          648,
          2
        ]
      ];
end
 end 

if (tst06(s42) ~= 42) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          649,
          2
        ]
      ];
end
 end 

if (tst06(t42) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          650,
          2
        ]
      ];
end
 end 

if (tst06(s43) ~= 43) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          651,
          2
        ]
      ];
end
 end 

if (tst06(t43) ~= 43) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          652,
          2
        ]
      ];
end
 end 

if (tst06(s44) ~= 44) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          653,
          2
        ]
      ];
end
 end 

if (tst06(t44) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          654,
          2
        ]
      ];
end
 end 

if (tst06(s45) ~= 45) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          655,
          2
        ]
      ];
end
 end 

if (tst06(t45) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          656,
          2
        ]
      ];
end
 end 

if (tst06(s46) ~= 46) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          657,
          2
        ]
      ];
end
 end 

if (tst06(t46) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          658,
          2
        ]
      ];
end
 end 

if (tst06(s47) ~= 47) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          659,
          2
        ]
      ];
end
 end 

if (tst06(t47) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          660,
          2
        ]
      ];
end
 end 

if (tst06(s48) ~= 48) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          661,
          2
        ]
      ];
end
 end 

if (tst06(t48) ~= 48) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          662,
          2
        ]
      ];
end
 end 

if (tst06(s49) ~= 49) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          663,
          2
        ]
      ];
end
 end 

if (tst06(t49) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          664,
          2
        ]
      ];
end
 end 

if (tst06(s50) ~= 50) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          665,
          2
        ]
      ];
end
 end 

if (tst06(t50) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          666,
          2
        ]
      ];
end
 end 

if (tst06(s51) ~= 51) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          667,
          2
        ]
      ];
end
 end 

if (tst06(t51) ~= 51) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          668,
          2
        ]
      ];
end
 end 

if (tst06(s52) ~= 52) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          669,
          2
        ]
      ];
end
 end 

if (tst06(t52) ~= 52) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          670,
          2
        ]
      ];
end
 end 

if (tst06(s53) ~= 53) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          671,
          2
        ]
      ];
end
 end 

if (tst06(t53) ~= 53) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          672,
          2
        ]
      ];
end
 end 

if (tst06(s54) ~= 54) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          673,
          2
        ]
      ];
end
 end 

if (tst06(t54) ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          674,
          2
        ]
      ];
end
 end 

if (tst06(s55) ~= 55) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          675,
          2
        ]
      ];
end
 end 

if (tst06(t55) ~= 55) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          676,
          2
        ]
      ];
end
 end 

if (tst06(s56) ~= 56) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          677,
          2
        ]
      ];
end
 end 

if (tst06(t56) ~= 56) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          678,
          2
        ]
      ];
end
 end 

if (tst06(s57) ~= 57) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          679,
          2
        ]
      ];
end
 end 

if (tst06(t57) ~= 57) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          680,
          2
        ]
      ];
end
 end 

if (tst06(s58) ~= 58) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          681,
          2
        ]
      ];
end
 end 

if (tst06(t58) ~= 58) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          682,
          2
        ]
      ];
end
 end 

if (tst06(s59) ~= 59) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          683,
          2
        ]
      ];
end
 end 

if (tst06(t59) ~= 59) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          684,
          2
        ]
      ];
end
 end 

if (tst06(s60) ~= 60) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          685,
          2
        ]
      ];
end
 end 

if (tst06(t60) ~= 60) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          686,
          2
        ]
      ];
end
 end 

if (tst06(s61) ~= 61) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          687,
          2
        ]
      ];
end
 end 

if (tst06(t61) ~= 61) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          688,
          2
        ]
      ];
end
 end 

if (tst06(s62) ~= 62) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          689,
          2
        ]
      ];
end
 end 

if (tst06(t62) ~= 62) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          690,
          2
        ]
      ];
end
 end 

if (tst06(s63) ~= 63) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          691,
          2
        ]
      ];
end
 end 

if (tst06(t63) ~= 63) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          692,
          2
        ]
      ];
end
 end 

if (tst06(s64) ~= 64) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          693,
          2
        ]
      ];
end
 end 

if (tst06(t64) ~= 64) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          694,
          2
        ]
      ];
end
 end 

if (tst06(s65) ~= 65) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          695,
          2
        ]
      ];
end
 end 

if (tst06(t65) ~= 65) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          696,
          2
        ]
      ];
end
 end 

if (tst06(s66) ~= 66) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          697,
          2
        ]
      ];
end
 end 

if (tst06(t66) ~= 66) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          698,
          2
        ]
      ];
end
 end 

if (tst06(s67) ~= 67) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          699,
          2
        ]
      ];
end
 end 

if (tst06(t67) ~= 67) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          700,
          2
        ]
      ];
end
 end 

if (tst06(s68) ~= 68) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          701,
          2
        ]
      ];
end
 end 

if (tst06(t68) ~= 68) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          702,
          2
        ]
      ];
end
 end 

if (tst06(s69) ~= 69) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          703,
          2
        ]
      ];
end
 end 

if (tst06(t69) ~= 69) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          704,
          2
        ]
      ];
end
 end 

if (tst06(s70) ~= 70) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          705,
          2
        ]
      ];
end
 end 

if (tst06(t70) ~= 70) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          706,
          2
        ]
      ];
end
 end 

if (tst06(s71) ~= 71) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          707,
          2
        ]
      ];
end
 end 

if (tst06(t71) ~= 71) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          708,
          2
        ]
      ];
end
 end 

if (tst06(s72) ~= 72) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          709,
          2
        ]
      ];
end
 end 

if (tst06(t72) ~= 72) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          710,
          2
        ]
      ];
end
 end 

if (tst06(s73) ~= 73) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          711,
          2
        ]
      ];
end
 end 

if (tst06(t73) ~= 73) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          712,
          2
        ]
      ];
end
 end 

if (tst06(s74) ~= 74) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          713,
          2
        ]
      ];
end
 end 

if (tst06(t74) ~= 74) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          714,
          2
        ]
      ];
end
 end 

if (tst06(s75) ~= 75) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          715,
          2
        ]
      ];
end
 end 

if (tst06(t75) ~= 75) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          716,
          2
        ]
      ];
end
 end 

if (tst06(s76) ~= 76) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          717,
          2
        ]
      ];
end
 end 

if (tst06(t76) ~= 76) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          718,
          2
        ]
      ];
end
 end 

if (tst06(s77) ~= 77) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          719,
          2
        ]
      ];
end
 end 

if (tst06(t77) ~= 77) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          720,
          2
        ]
      ];
end
 end 

if (tst06(s78) ~= 78) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          721,
          2
        ]
      ];
end
 end 

if (tst06(t78) ~= 78) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          722,
          2
        ]
      ];
end
 end 

if (tst06(s79) ~= 79) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          723,
          2
        ]
      ];
end
 end 

if (tst06(t79) ~= 79) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          724,
          2
        ]
      ];
end
 end 

if (tst06(s80) ~= 80) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          725,
          2
        ]
      ];
end
 end 

if (tst06(t80) ~= 80) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          726,
          2
        ]
      ];
end
 end 

if (tst06(s81) ~= 81) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          727,
          2
        ]
      ];
end
 end 

if (tst06(t81) ~= 81) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          728,
          2
        ]
      ];
end
 end 

if (tst06(s82) ~= 82) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          729,
          2
        ]
      ];
end
 end 

if (tst06(t82) ~= 82) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          730,
          2
        ]
      ];
end
 end 

if (tst06(s83) ~= 83) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          731,
          2
        ]
      ];
end
 end 

if (tst06(t83) ~= 83) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          732,
          2
        ]
      ];
end
 end 

if (tst06(s84) ~= 84) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          733,
          2
        ]
      ];
end
 end 

if (tst06(t84) ~= 84) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          734,
          2
        ]
      ];
end
 end 

if (tst06(s85) ~= 85) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          735,
          2
        ]
      ];
end
 end 

if (tst06(t85) ~= 85) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          736,
          2
        ]
      ];
end
 end 

if (tst06(s86) ~= 86) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          737,
          2
        ]
      ];
end
 end 

if (tst06(t86) ~= 86) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          738,
          2
        ]
      ];
end
 end 

if (tst06(s87) ~= 87) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          739,
          2
        ]
      ];
end
 end 

if (tst06(t87) ~= 87) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          740,
          2
        ]
      ];
end
 end 

if (tst06(s88) ~= 88) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          741,
          2
        ]
      ];
end
 end 

if (tst06(t88) ~= 88) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          742,
          2
        ]
      ];
end
 end 

if (tst06(s89) ~= 89) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          743,
          2
        ]
      ];
end
 end 

if (tst06(t89) ~= 89) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          744,
          2
        ]
      ];
end
 end 

if (tst06(s90) ~= 90) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          745,
          2
        ]
      ];
end
 end 

if (tst06(t90) ~= 90) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          746,
          2
        ]
      ];
end
 end 

if (tst06(s91) ~= 91) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          747,
          2
        ]
      ];
end
 end 

if (tst06(t91) ~= 91) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          748,
          2
        ]
      ];
end
 end 

if (tst06("") ~= -1) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[ tuple ]--[
          "stringmatch_test.ml",
          749,
          2
        ]
      ];
end
 end 

exports.tst01 = tst01;
exports.tst02 = tst02;
exports.tst03 = tst03;
exports.tst04 = tst04;
exports.tst05 = tst05;
exports.s00 = s00;
exports.t00 = t00;
exports.s01 = s01;
exports.t01 = t01;
exports.s02 = s02;
exports.t02 = t02;
exports.s03 = s03;
exports.t03 = t03;
exports.s04 = s04;
exports.t04 = t04;
exports.s05 = s05;
exports.t05 = t05;
exports.s06 = s06;
exports.t06 = t06;
exports.s07 = s07;
exports.t07 = t07;
exports.s08 = s08;
exports.t08 = t08;
exports.s09 = s09;
exports.t09 = t09;
exports.s10 = s10;
exports.t10 = t10;
exports.s11 = s11;
exports.t11 = t11;
exports.s12 = s12;
exports.t12 = t12;
exports.s13 = s13;
exports.t13 = t13;
exports.s14 = s14;
exports.t14 = t14;
exports.s15 = s15;
exports.t15 = t15;
exports.s16 = s16;
exports.t16 = t16;
exports.s17 = s17;
exports.t17 = t17;
exports.s18 = s18;
exports.t18 = t18;
exports.s19 = s19;
exports.t19 = t19;
exports.s20 = s20;
exports.t20 = t20;
exports.s21 = s21;
exports.t21 = t21;
exports.s22 = s22;
exports.t22 = t22;
exports.s23 = s23;
exports.t23 = t23;
exports.s24 = s24;
exports.t24 = t24;
exports.s25 = s25;
exports.t25 = t25;
exports.s26 = s26;
exports.t26 = t26;
exports.s27 = s27;
exports.t27 = t27;
exports.s28 = s28;
exports.t28 = t28;
exports.s29 = s29;
exports.t29 = t29;
exports.s30 = s30;
exports.t30 = t30;
exports.s31 = s31;
exports.t31 = t31;
exports.s32 = s32;
exports.t32 = t32;
exports.s33 = s33;
exports.t33 = t33;
exports.s34 = s34;
exports.t34 = t34;
exports.s35 = s35;
exports.t35 = t35;
exports.s36 = s36;
exports.t36 = t36;
exports.s37 = s37;
exports.t37 = t37;
exports.s38 = s38;
exports.t38 = t38;
exports.s39 = s39;
exports.t39 = t39;
exports.s40 = s40;
exports.t40 = t40;
exports.s41 = s41;
exports.t41 = t41;
exports.s42 = s42;
exports.t42 = t42;
exports.s43 = s43;
exports.t43 = t43;
exports.s44 = s44;
exports.t44 = t44;
exports.s45 = s45;
exports.t45 = t45;
exports.s46 = s46;
exports.t46 = t46;
exports.s47 = s47;
exports.t47 = t47;
exports.s48 = s48;
exports.t48 = t48;
exports.s49 = s49;
exports.t49 = t49;
exports.s50 = s50;
exports.t50 = t50;
exports.s51 = s51;
exports.t51 = t51;
exports.s52 = s52;
exports.t52 = t52;
exports.s53 = s53;
exports.t53 = t53;
exports.s54 = s54;
exports.t54 = t54;
exports.s55 = s55;
exports.t55 = t55;
exports.s56 = s56;
exports.t56 = t56;
exports.s57 = s57;
exports.t57 = t57;
exports.s58 = s58;
exports.t58 = t58;
exports.s59 = s59;
exports.t59 = t59;
exports.s60 = s60;
exports.t60 = t60;
exports.s61 = s61;
exports.t61 = t61;
exports.s62 = s62;
exports.t62 = t62;
exports.s63 = s63;
exports.t63 = t63;
exports.s64 = s64;
exports.t64 = t64;
exports.s65 = s65;
exports.t65 = t65;
exports.s66 = s66;
exports.t66 = t66;
exports.s67 = s67;
exports.t67 = t67;
exports.s68 = s68;
exports.t68 = t68;
exports.s69 = s69;
exports.t69 = t69;
exports.s70 = s70;
exports.t70 = t70;
exports.s71 = s71;
exports.t71 = t71;
exports.s72 = s72;
exports.t72 = t72;
exports.s73 = s73;
exports.t73 = t73;
exports.s74 = s74;
exports.t74 = t74;
exports.s75 = s75;
exports.t75 = t75;
exports.s76 = s76;
exports.t76 = t76;
exports.s77 = s77;
exports.t77 = t77;
exports.s78 = s78;
exports.t78 = t78;
exports.s79 = s79;
exports.t79 = t79;
exports.s80 = s80;
exports.t80 = t80;
exports.s81 = s81;
exports.t81 = t81;
exports.s82 = s82;
exports.t82 = t82;
exports.s83 = s83;
exports.t83 = t83;
exports.s84 = s84;
exports.t84 = t84;
exports.s85 = s85;
exports.t85 = t85;
exports.s86 = s86;
exports.t86 = t86;
exports.s87 = s87;
exports.t87 = t87;
exports.s88 = s88;
exports.t88 = t88;
exports.s89 = s89;
exports.t89 = t89;
exports.s90 = s90;
exports.t90 = t90;
exports.s91 = s91;
exports.t91 = t91;
exports.tst06 = tst06;
--[  Not a pure module ]--
