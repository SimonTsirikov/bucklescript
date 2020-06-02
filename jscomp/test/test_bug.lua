console = {log = print};

Bytes = require "../../lib/js/bytes";
Caml_char = require "../../lib/js/caml_char";
Caml_bytes = require "../../lib/js/caml_bytes";

function escaped(s) do
  n = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    c = s[i];
    tmp;
    exit = 0;
    if (c >= 14) then do
      if (c ~= 34 and c ~= 92) then do
        exit = 1;
      end else do
        tmp = 2;
      end end 
    end else if (c >= 11) then do
      if (c >= 13) then do
        tmp = 2;
      end else do
        exit = 1;
      end end 
    end else if (c >= 8) then do
      tmp = 2;
    end else do
      exit = 1;
    end end  end  end 
    if (exit == 1) then do
      tmp = Caml_char.caml_is_printable(c) and 1 or 4;
    end
     end 
    n = n + tmp | 0;
  end
  if (n == #s) then do
    return Bytes.copy(s);
  end else do
    s$prime = Caml_bytes.caml_create_bytes(n);
    n = 0;
    for i_1 = 0 , #s - 1 | 0 , 1 do
      c_1 = s[i_1];
      exit_1 = 0;
      switcher = c_1 - 34 | 0;
      if (switcher > 58 or switcher < 0) then do
        if (switcher >= -20) then do
          exit_1 = 1;
        end else do
          local ___conditional___=(switcher + 34 | 0);
          do
             if ___conditional___ == 8 then do
                s$prime[n] = --[[ "\\" ]]92;
                n = n + 1 | 0;
                s$prime[n] = --[[ "b" ]]98; end else 
             if ___conditional___ == 9 then do
                s$prime[n] = --[[ "\\" ]]92;
                n = n + 1 | 0;
                s$prime[n] = --[[ "t" ]]116; end else 
             if ___conditional___ == 10 then do
                s$prime[n] = --[[ "\\" ]]92;
                n = n + 1 | 0;
                s$prime[n] = --[[ "n" ]]110; end else 
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
                exit_1 = 1; end else 
             if ___conditional___ == 13 then do
                s$prime[n] = --[[ "\\" ]]92;
                n = n + 1 | 0;
                s$prime[n] = --[[ "r" ]]114; end else 
             end end end end end end end end end end
            
          end
        end end 
      end else if (switcher > 57 or switcher < 1) then do
        s$prime[n] = --[[ "\\" ]]92;
        n = n + 1 | 0;
        s$prime[n] = c_1;
      end else do
        exit_1 = 1;
      end end  end 
      if (exit_1 == 1) then do
        if (Caml_char.caml_is_printable(c_1)) then do
          s$prime[n] = c_1;
        end else do
          s$prime[n] = --[[ "\\" ]]92;
          n = n + 1 | 0;
          s$prime[n] = 48 + (c_1 / 100 | 0) | 0;
          n = n + 1 | 0;
          s$prime[n] = 48 + (c_1 / 10 | 0) % 10 | 0;
          n = n + 1 | 0;
          s$prime[n] = 48 + c_1 % 10 | 0;
        end end 
      end
       end 
      n = n + 1 | 0;
    end
    return s$prime;
  end end 
end end

exports = {}
exports.escaped = escaped;
--[[ No side effect ]]