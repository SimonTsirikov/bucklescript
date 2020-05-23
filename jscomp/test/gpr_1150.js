'use strict';

var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function f(children) do
  if (children) then do
    var children$1 = children[1];
    var a0 = children[0];
    if (children$1) then do
      var children$2 = children$1[1];
      var a1 = children$1[0];
      if (children$2) then do
        var children$3 = children$2[1];
        var a2 = children$2[0];
        if (children$3) then do
          var children$4 = children$3[1];
          var a3 = children$3[0];
          if (children$4) then do
            var children$5 = children$4[1];
            var a4 = children$4[0];
            if (children$5) then do
              var children$6 = children$5[1];
              var a5 = children$5[0];
              if (children$6) then do
                var children$7 = children$6[1];
                var a6 = children$6[0];
                if (children$7) then do
                  var children$8 = children$7[1];
                  var a7 = children$7[0];
                  if (children$8) then do
                    var children$9 = children$8[1];
                    var a8 = children$8[0];
                    if (children$9) then do
                      var children$10 = children$9[1];
                      var a9 = children$9[0];
                      if (children$10) then do
                        var children$11 = children$10[1];
                        var a10 = children$10[0];
                        if (children$11) then do
                          var children$12 = children$11[1];
                          var a11 = children$11[0];
                          if (children$12) then do
                            var children$13 = children$12[1];
                            var a12 = children$12[0];
                            if (children$13) then do
                              var children$14 = children$13[1];
                              var a13 = children$13[0];
                              if (children$14) then do
                                var children$15 = children$14[1];
                                var a14 = children$14[0];
                                if (children$15) then do
                                  if (children$15[1]) then do
                                    throw [
                                          Caml_builtin_exceptions.assert_failure,
                                          --[ tuple ]--[
                                            "gpr_1150.ml",
                                            56,
                                            34
                                          ]
                                        ];
                                  end
                                   end 
                                  return [
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
                                          children$15[0]
                                        ];
                                end else do
                                  return [
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
                                        ];
                                end end 
                              end else do
                                return [
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
                                      ];
                              end end 
                            end else do
                              return [
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
                                    ];
                            end end 
                          end else do
                            return [
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
                                  ];
                          end end 
                        end else do
                          return [
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
                                ];
                        end end 
                      end else do
                        return [
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
                              ];
                      end end 
                    end else do
                      return [
                              a0,
                              a1,
                              a2,
                              a3,
                              a4,
                              a5,
                              a6,
                              a7,
                              a8
                            ];
                    end end 
                  end else do
                    return [
                            a0,
                            a1,
                            a2,
                            a3,
                            a4,
                            a5,
                            a6,
                            a7
                          ];
                  end end 
                end else do
                  return [
                          a0,
                          a1,
                          a2,
                          a3,
                          a4,
                          a5,
                          a6
                        ];
                end end 
              end else do
                return [
                        a0,
                        a1,
                        a2,
                        a3,
                        a4,
                        a5
                      ];
              end end 
            end else do
              return [
                      a0,
                      a1,
                      a2,
                      a3,
                      a4
                    ];
            end end 
          end else do
            return [
                    a0,
                    a1,
                    a2,
                    a3
                  ];
          end end 
        end else do
          return [
                  a0,
                  a1,
                  a2
                ];
        end end 
      end else do
        return [
                a0,
                a1
              ];
      end end 
    end else do
      return [a0];
    end end 
  end else do
    return [];
  end end 
end

exports.f = f;
--[ No side effect ]--
