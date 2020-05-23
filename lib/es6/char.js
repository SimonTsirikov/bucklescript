

import * as Caml_bytes from "./caml_bytes.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function chr(n) do
  if (n < 0 or n > 255) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Char.chr"
        ];
  end
  return n;
end

function escaped(c) do
  var exit = 0;
  if (c >= 40) do
    if (c ~= 92) do
      exit = c >= 127 ? 1 : 2;
    end else do
      return "\\\\";
    end
  end else if (c >= 32) do
    if (c >= 39) do
      return "\\'";
    end else do
      exit = 2;
    end
  end else if (c >= 14) do
    exit = 1;
  end else do
    switch (c) do
      case 8 :
          return "\\b";
      case 9 :
          return "\\t";
      case 10 :
          return "\\n";
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
          exit = 1;
          break;
      case 13 :
          return "\\r";
      
    end
  end
  switch (exit) do
    case 1 :
        var s = [
          0,
          0,
          0,
          0
        ];
        s[0] = --[ "\\" ]--92;
        s[1] = 48 + (c / 100 | 0) | 0;
        s[2] = 48 + (c / 10 | 0) % 10 | 0;
        s[3] = 48 + c % 10 | 0;
        return Caml_bytes.bytes_to_string(s);
    case 2 :
        var s$1 = [0];
        s$1[0] = c;
        return Caml_bytes.bytes_to_string(s$1);
    
  end
end

function lowercase(c) do
  if (c >= --[ "A" ]--65 and c <= --[ "Z" ]--90 or c >= --[ "\192" ]--192 and c <= --[ "\214" ]--214 or c >= --[ "\216" ]--216 and c <= --[ "\222" ]--222) do
    return c + 32 | 0;
  end else do
    return c;
  end
end

function uppercase(c) do
  if (c >= --[ "a" ]--97 and c <= --[ "z" ]--122 or c >= --[ "\224" ]--224 and c <= --[ "\246" ]--246 or c >= --[ "\248" ]--248 and c <= --[ "\254" ]--254) do
    return c - 32 | 0;
  end else do
    return c;
  end
end

function lowercase_ascii(c) do
  if (c >= --[ "A" ]--65 and c <= --[ "Z" ]--90) do
    return c + 32 | 0;
  end else do
    return c;
  end
end

function uppercase_ascii(c) do
  if (c >= --[ "a" ]--97 and c <= --[ "z" ]--122) do
    return c - 32 | 0;
  end else do
    return c;
  end
end

function compare(c1, c2) do
  return c1 - c2 | 0;
end

function equal(c1, c2) do
  return (c1 - c2 | 0) == 0;
end

export do
  chr ,
  escaped ,
  lowercase ,
  uppercase ,
  lowercase_ascii ,
  uppercase_ascii ,
  compare ,
  equal ,
  
end
--[ No side effect ]--
