--[['use strict';]]

Mt = require "./mt.lua";
List = require "../../lib/js/list.lua";
Block = require "../../lib/js/block.lua";
Curry = require "../../lib/js/curry.lua";
Stream = require "../../lib/js/stream.lua";
Caml_bytes = require "../../lib/js/caml_bytes.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

function classify(chr) do
  if ((chr & 128) == 0) then do
    return --[[ Single ]]Block.__(0, [chr]);
  end else if ((chr & 64) == 0) then do
    return --[[ Cont ]]Block.__(1, [chr & 63]);
  end else if ((chr & 32) == 0) then do
    return --[[ Leading ]]Block.__(2, [
              1,
              chr & 31
            ]);
  end else if ((chr & 16) == 0) then do
    return --[[ Leading ]]Block.__(2, [
              2,
              chr & 15
            ]);
  end else if ((chr & 8) == 0) then do
    return --[[ Leading ]]Block.__(2, [
              3,
              chr & 7
            ]);
  end else if ((chr & 4) == 0) then do
    return --[[ Leading ]]Block.__(2, [
              4,
              chr & 3
            ]);
  end else if ((chr & 2) == 0) then do
    return --[[ Leading ]]Block.__(2, [
              5,
              chr & 1
            ]);
  end else do
    return --[[ Invalid ]]0;
  end end  end  end  end  end  end  end 
end end

function utf8_decode(strm) do
  return Stream.slazy((function (param) do
                match = Stream.peek(strm);
                if (match ~= undefined) then do
                  Stream.junk(strm);
                  match$1 = classify(match);
                  if (typeof match$1 == "number") then do
                    throw [
                          Stream.__Error,
                          "Invalid byte"
                        ];
                  end else do
                    local ___conditional___=(match$1.tag | 0);
                    do
                       if ___conditional___ = 0--[[ Single ]] then do
                          return Stream.icons(match$1[0], utf8_decode(strm));end end end 
                       if ___conditional___ = 1--[[ Cont ]] then do
                          throw [
                                Stream.__Error,
                                "Unexpected continuation byte"
                              ];end end end 
                       if ___conditional___ = 2--[[ Leading ]] then do
                          follow = function (strm, _n, _c) do
                            while(true) do
                              c = _c;
                              n = _n;
                              if (n == 0) then do
                                return c;
                              end else do
                                match = classify(Stream.next(strm));
                                if (typeof match == "number") then do
                                  throw [
                                        Stream.__Error,
                                        "Continuation byte expected"
                                      ];
                                end else if (match.tag == --[[ Cont ]]1) then do
                                  _c = (c << 6) | match[0] & 63;
                                  _n = n - 1 | 0;
                                  continue ;
                                end else do
                                  throw [
                                        Stream.__Error,
                                        "Continuation byte expected"
                                      ];
                                end end  end 
                              end end 
                            end;
                          end end;
                          return Stream.icons(follow(strm, match$1[0], match$1[1]), utf8_decode(strm));end end end 
                       do
                      
                    end
                  end end 
                end
                 end 
              end end));
end end

function to_list(xs) do
  v = do
    contents: --[[ [] ]]0
  end;
  Stream.iter((function (x) do
          v.contents = --[[ :: ]][
            x,
            v.contents
          ];
          return --[[ () ]]0;
        end end), xs);
  return List.rev(v.contents);
end end

function utf8_list(s) do
  return to_list(utf8_decode(Stream.of_string(s)));
end end

function decode(bytes, offset) do
  offset$1 = offset;
  match = classify(Caml_bytes.get(bytes, offset$1));
  if (typeof match == "number") then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "decode"
        ];
  end else do
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ = 0--[[ Single ]] then do
          return --[[ tuple ]][
                  match[0],
                  offset$1 + 1 | 0
                ];end end end 
       if ___conditional___ = 1--[[ Cont ]] then do
          throw [
                Caml_builtin_exceptions.invalid_argument,
                "decode"
              ];end end end 
       if ___conditional___ = 2--[[ Leading ]] then do
          _n = match[0];
          _c = match[1];
          _offset = offset$1 + 1 | 0;
          while(true) do
            offset$2 = _offset;
            c = _c;
            n = _n;
            if (n == 0) then do
              return --[[ tuple ]][
                      c,
                      offset$2
                    ];
            end else do
              match$1 = classify(Caml_bytes.get(bytes, offset$2));
              if (typeof match$1 == "number") then do
                throw [
                      Caml_builtin_exceptions.invalid_argument,
                      "decode"
                    ];
              end else if (match$1.tag == --[[ Cont ]]1) then do
                _offset = offset$2 + 1 | 0;
                _c = (c << 6) | match$1[0] & 63;
                _n = n - 1 | 0;
                continue ;
              end else do
                throw [
                      Caml_builtin_exceptions.invalid_argument,
                      "decode"
                    ];
              end end  end 
            end end 
          end;end end end 
       do
      
    end
  end end 
end end

function eq_list(cmp, _xs, _ys) do
  while(true) do
    ys = _ys;
    xs = _xs;
    if (xs) then do
      if (ys and Curry._2(cmp, xs[0], ys[0])) then do
        _ys = ys[1];
        _xs = xs[1];
        continue ;
      end else do
        return false;
      end end 
    end else if (ys) then do
      return false;
    end else do
      return true;
    end end  end 
  end;
end end

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, param) do
  y = param[1];
  x = param[0];
  test_id.contents = test_id.contents + 1 | 0;
  console.log(--[[ tuple ]][
        x,
        y
      ]);
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

List.iter((function (param) do
        return eq("File \"utf8_decode_test.ml\", line 107, characters 7-14", --[[ tuple ]][
                    true,
                    eq_list((function (prim, prim$1) do
                            return prim == prim$1;
                          end end), to_list(utf8_decode(Stream.of_string(param[0]))), param[1])
                  ]);
      end end), --[[ :: ]][
      --[[ tuple ]][
        "\xe4\xbd\xa0\xe5\xa5\xbdBuckleScript,\xe6\x9c\x80\xe5\xa5\xbd\xe7\x9a\x84JS\xe8\xaf\xad\xe8\xa8\x80",
        --[[ :: ]][
          20320,
          --[[ :: ]][
            22909,
            --[[ :: ]][
              66,
              --[[ :: ]][
                117,
                --[[ :: ]][
                  99,
                  --[[ :: ]][
                    107,
                    --[[ :: ]][
                      108,
                      --[[ :: ]][
                        101,
                        --[[ :: ]][
                          83,
                          --[[ :: ]][
                            99,
                            --[[ :: ]][
                              114,
                              --[[ :: ]][
                                105,
                                --[[ :: ]][
                                  112,
                                  --[[ :: ]][
                                    116,
                                    --[[ :: ]][
                                      44,
                                      --[[ :: ]][
                                        26368,
                                        --[[ :: ]][
                                          22909,
                                          --[[ :: ]][
                                            30340,
                                            --[[ :: ]][
                                              74,
                                              --[[ :: ]][
                                                83,
                                                --[[ :: ]][
                                                  35821,
                                                  --[[ :: ]][
                                                    35328,
                                                    --[[ [] ]]0
                                                  ]
                                                ]
                                              ]
                                            ]
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "hello \xe4\xbd\xa0\xe5\xa5\xbd\xef\xbc\x8c\xe4\xb8\xad\xe5\x8d\x8e\xe6\xb0\x91\xe6\x97\x8f hei",
          --[[ :: ]][
            104,
            --[[ :: ]][
              101,
              --[[ :: ]][
                108,
                --[[ :: ]][
                  108,
                  --[[ :: ]][
                    111,
                    --[[ :: ]][
                      32,
                      --[[ :: ]][
                        20320,
                        --[[ :: ]][
                          22909,
                          --[[ :: ]][
                            65292,
                            --[[ :: ]][
                              20013,
                              --[[ :: ]][
                                21326,
                                --[[ :: ]][
                                  27665,
                                  --[[ :: ]][
                                    26063,
                                    --[[ :: ]][
                                      32,
                                      --[[ :: ]][
                                        104,
                                        --[[ :: ]][
                                          101,
                                          --[[ :: ]][
                                            105,
                                            --[[ [] ]]0
                                          ]
                                        ]
                                      ]
                                    ]
                                  ]
                                ]
                              ]
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ],
        --[[ [] ]]0
      ]
    ]);

Mt.from_pair_suites("Utf8_decode_test", suites.contents);

exports.classify = classify;
exports.utf8_decode = utf8_decode;
exports.to_list = to_list;
exports.utf8_list = utf8_list;
exports.decode = decode;
exports.eq_list = eq_list;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[  Not a pure module ]]
