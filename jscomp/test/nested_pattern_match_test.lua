console = {log = print};


function f_list(x) do
  if (x) then do
    match = x[1];
    if (match) then do
      match_1 = match[1];
      if (match_1) then do
        match_2 = match_1[1];
        if (match_2) then do
          match_3 = match_2[1];
          if (match_3) then do
            match_4 = match_3[1];
            if (match_4) then do
              return ((((x[0] + match[0] | 0) + match_1[0] | 0) + match_2[0] | 0) + match_3[0] | 0) + match_4[0] | 0;
            end else do
              return 0;
            end end 
          end else do
            return 0;
          end end 
        end else do
          return 0;
        end end 
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end else do
    return 0;
  end end 
end end

function f_arr(x) do
  if (#x ~= 6) then do
    return 0;
  end else do
    a0 = x[0];
    a1 = x[1];
    a2 = x[2];
    a3 = x[3];
    a4 = x[4];
    a5 = x[5];
    return ((((a0 + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0) + a5 | 0;
  end end 
end end

function f_opion(x) do
  match = x.hi;
  if (match ~= 2) then do
    if (match ~= 3) then do
      return 0;
    end else do
      match_1 = x.lo;
      if (match_1 and match_1[0] == nil) then do
        match_2 = match_1[1];
        if (match_2 and match_2[0] == nil) then do
          match_3 = match_2[1];
          if (match_3) then do
            match_4 = match_3[0];
            if (match_4 == 2) then do
              match_5 = match_3[1];
              if (match_5) then do
                match_6 = match_5[0];
                if (match_6 == 1) then do
                  match_7 = match_5[1];
                  if (match_7 and match_7[0] ~= nil) then do
                    return 2;
                  end else do
                    return 0;
                  end end 
                end else do
                  return 0;
                end end 
              end else do
                return 0;
              end end 
            end else do
              return 0;
            end end 
          end else do
            return 0;
          end end 
        end else do
          return 0;
        end end 
      end else do
        return 0;
      end end 
    end end 
  end else do
    match_8 = x.lo;
    if (match_8 and match_8[0] == nil) then do
      match_9 = match_8[1];
      if (match_9 and match_9[0] == nil) then do
        match_10 = match_9[1];
        if (match_10) then do
          match_11 = match_10[0];
          if (match_11 == 2) then do
            match_12 = match_10[1];
            if (match_12) then do
              match_13 = match_12[0];
              if (match_13 == 1) then do
                match_14 = match_12[1];
                if (match_14 and match_14[0] ~= nil) then do
                  return 3;
                end else do
                  return 0;
                end end 
              end else do
                return 0;
              end end 
            end else do
              return 0;
            end end 
          end else do
            return 0;
          end end 
        end else do
          return 0;
        end end 
      end else do
        return 0;
      end end 
    end else do
      return 0;
    end end 
  end end 
end end

exports = {}
exports.f_list = f_list;
exports.f_arr = f_arr;
exports.f_opion = f_opion;
--[[ No side effect ]]
