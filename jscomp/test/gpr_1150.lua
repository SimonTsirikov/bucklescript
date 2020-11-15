__console = {log = print};

Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

function f(children) do
  if (children) then do
    children_1 = children[2];
    a0 = children[1];
    if (children_1) then do
      children_2 = children_1[2];
      a1 = children_1[1];
      if (children_2) then do
        children_3 = children_2[2];
        a2 = children_2[1];
        if (children_3) then do
          children_4 = children_3[2];
          a3 = children_3[1];
          if (children_4) then do
            children_5 = children_4[2];
            a4 = children_4[1];
            if (children_5) then do
              children_6 = children_5[2];
              a5 = children_5[1];
              if (children_6) then do
                children_7 = children_6[2];
                a6 = children_6[1];
                if (children_7) then do
                  children_8 = children_7[2];
                  a7 = children_7[1];
                  if (children_8) then do
                    children_9 = children_8[2];
                    a8 = children_8[1];
                    if (children_9) then do
                      children_10 = children_9[2];
                      a9 = children_9[1];
                      if (children_10) then do
                        children_11 = children_10[2];
                        a10 = children_10[1];
                        if (children_11) then do
                          children_12 = children_11[2];
                          a11 = children_11[1];
                          if (children_12) then do
                            children_13 = children_12[2];
                            a12 = children_12[1];
                            if (children_13) then do
                              children_14 = children_13[2];
                              a13 = children_13[1];
                              if (children_14) then do
                                children_15 = children_14[2];
                                a14 = children_14[1];
                                if (children_15) then do
                                  if (children_15[2]) then do
                                    error({
                                      Caml_builtin_exceptions.assert_failure,
                                      --[[ tuple ]]{
                                        "gpr_1150.ml",
                                        56,
                                        34
                                      }
                                    })
                                  end
                                   end 
                                  return {
                                          a0,
                                          a1,
                                          a2,
                                          a3,
                                          a4,
                                          a5,
                                          a6,
                                          a7,
                                          a8,
                                          a9,
                                          a10,
                                          a11,
                                          a12,
                                          a13,
                                          a14,
                                          children_15[1]
                                        };
                                end else do
                                  return {
                                          a0,
                                          a1,
                                          a2,
                                          a3,
                                          a4,
                                          a5,
                                          a6,
                                          a7,
                                          a8,
                                          a9,
                                          a10,
                                          a11,
                                          a12,
                                          a13,
                                          a14
                                        };
                                end end 
                              end else do
                                return {
                                        a0,
                                        a1,
                                        a2,
                                        a3,
                                        a4,
                                        a5,
                                        a6,
                                        a7,
                                        a8,
                                        a9,
                                        a10,
                                        a11,
                                        a12,
                                        a13
                                      };
                              end end 
                            end else do
                              return {
                                      a0,
                                      a1,
                                      a2,
                                      a3,
                                      a4,
                                      a5,
                                      a6,
                                      a7,
                                      a8,
                                      a9,
                                      a10,
                                      a11,
                                      a12
                                    };
                            end end 
                          end else do
                            return {
                                    a0,
                                    a1,
                                    a2,
                                    a3,
                                    a4,
                                    a5,
                                    a6,
                                    a7,
                                    a8,
                                    a9,
                                    a10,
                                    a11
                                  };
                          end end 
                        end else do
                          return {
                                  a0,
                                  a1,
                                  a2,
                                  a3,
                                  a4,
                                  a5,
                                  a6,
                                  a7,
                                  a8,
                                  a9,
                                  a10
                                };
                        end end 
                      end else do
                        return {
                                a0,
                                a1,
                                a2,
                                a3,
                                a4,
                                a5,
                                a6,
                                a7,
                                a8,
                                a9
                              };
                      end end 
                    end else do
                      return {
                              a0,
                              a1,
                              a2,
                              a3,
                              a4,
                              a5,
                              a6,
                              a7,
                              a8
                            };
                    end end 
                  end else do
                    return {
                            a0,
                            a1,
                            a2,
                            a3,
                            a4,
                            a5,
                            a6,
                            a7
                          };
                  end end 
                end else do
                  return {
                          a0,
                          a1,
                          a2,
                          a3,
                          a4,
                          a5,
                          a6
                        };
                end end 
              end else do
                return {
                        a0,
                        a1,
                        a2,
                        a3,
                        a4,
                        a5
                      };
              end end 
            end else do
              return {
                      a0,
                      a1,
                      a2,
                      a3,
                      a4
                    };
            end end 
          end else do
            return {
                    a0,
                    a1,
                    a2,
                    a3
                  };
          end end 
        end else do
          return {
                  a0,
                  a1,
                  a2
                };
        end end 
      end else do
        return {
                a0,
                a1
              };
      end end 
    end else do
      return {a0};
    end end 
  end else do
    return {};
  end end 
end end

exports = {};
exports.f = f;
return exports;
--[[ No side effect ]]
