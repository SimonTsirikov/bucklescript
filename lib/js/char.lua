console = {log = print};

Caml_bytes = require "./caml_bytes";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function chr(n) do
  if (n < 0 or n > 255) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "Char.chr"
    })
  end
   end 
  return n;
end end

function escaped(c) do
  exit = 0;
  if (c >= 40) then do
    if (c ~= 92) then do
      exit = c >= 127 and 1 or 2;
    end else do
      return "\\\\";
    end end 
  end else if (c >= 32) then do
    if (c >= 39) then do
      return "\\'";
    end else do
      exit = 2;
    end end 
  end else if (c >= 14) then do
    exit = 1;
  end else do
    local ___conditional___=(c);
    do
       if ___conditional___ == 8 then do
          return "\\b"; end end 
       if ___conditional___ == 9 then do
          return "\\t"; end end 
       if ___conditional___ == 10 then do
          return "\\n"; end end 
       if ___conditional___ == 0
       or ___conditional___ == 1
       or ___conditional___ == 2
       or ___conditional___ == 3
       or ___conditional___ == 4
       or ___conditional___ == 5
       or ___conditional___ == 6
       or ___conditional___ == 7
       or ___conditional___ == 11
       or ___conditional___ == 12 then do
          exit = 1; end else 
       if ___conditional___ == 13 then do
          return "\\r"; end end end end 
      
    end
  end end  end  end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        s = {
          0,
          0,
          0,
          0
        };
        s[0] = --[[ "\\" ]]92;
        s[1] = 48 + (c / 100 | 0) | 0;
        s[2] = 48 + (c / 10 | 0) % 10 | 0;
        s[3] = 48 + c % 10 | 0;
        return Caml_bytes.bytes_to_string(s); end end 
     if ___conditional___ == 2 then do
        s_1 = {0};
        s_1[0] = c;
        return Caml_bytes.bytes_to_string(s_1); end end 
    
  end
end end

function lowercase(c) do
  if (c >= --[[ "A" ]]65 and c <= --[[ "Z" ]]90 or c >= --[[ "\192" ]]192 and c <= --[[ "\214" ]]214 or c >= --[[ "\216" ]]216 and c <= --[[ "\222" ]]222) then do
    return c + 32 | 0;
  end else do
    return c;
  end end 
end end

function uppercase(c) do
  if (c >= --[[ "a" ]]97 and c <= --[[ "z" ]]122 or c >= --[[ "\224" ]]224 and c <= --[[ "\246" ]]246 or c >= --[[ "\248" ]]248 and c <= --[[ "\254" ]]254) then do
    return c - 32 | 0;
  end else do
    return c;
  end end 
end end

function lowercase_ascii(c) do
  if (c >= --[[ "A" ]]65 and c <= --[[ "Z" ]]90) then do
    return c + 32 | 0;
  end else do
    return c;
  end end 
end end

function uppercase_ascii(c) do
  if (c >= --[[ "a" ]]97 and c <= --[[ "z" ]]122) then do
    return c - 32 | 0;
  end else do
    return c;
  end end 
end end

function compare(c1, c2) do
  return c1 - c2 | 0;
end end

function equal(c1, c2) do
  return (c1 - c2 | 0) == 0;
end end

exports = {}
exports.chr = chr;
exports.escaped = escaped;
exports.lowercase = lowercase;
exports.uppercase = uppercase;
exports.lowercase_ascii = lowercase_ascii;
exports.uppercase_ascii = uppercase_ascii;
exports.compare = compare;
exports.equal = equal;
--[[ No side effect ]]
