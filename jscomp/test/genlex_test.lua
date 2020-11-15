__console = {log = print};

Mt = require "..mt";
List = require "......lib.js.list";
Block = require "......lib.js.block";
Genlex = require "......lib.js.genlex";
Stream = require "......lib.js.stream";

lexer = Genlex.make_lexer(--[[ :: ]]{
      "+",
      --[[ :: ]]{
        "-",
        --[[ :: ]]{
          "*",
          --[[ :: ]]{
            "/",
            --[[ :: ]]{
              "let",
              --[[ :: ]]{
                "=",
                --[[ :: ]]{
                  "(",
                  --[[ :: ]]{
                    ")",
                    --[[ [] ]]0
                  }
                }
              }
            }
          }
        }
      }
    });

function to_list(s) do
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    v;
    xpcall(function() do
      v = Stream.next(s);
    end end,function(exn) do
      if (exn == Stream.Failure) then do
        return List.rev(acc);
      end else do
        error(exn)
      end end 
    end end)
    _acc = --[[ :: ]]{
      v,
      acc
    };
    ::continue:: ;
  end;
end end

suites_000 = --[[ tuple ]]{
  "lexer_stream_genlex",
  (function(param) do
      return --[[ Eq ]]Block.__(0, {
                --[[ :: ]]{
                  --[[ Int ]]Block.__(2, {3}),
                  --[[ :: ]]{
                    --[[ Kwd ]]Block.__(0, {"("}),
                    --[[ :: ]]{
                      --[[ Int ]]Block.__(2, {3}),
                      --[[ :: ]]{
                        --[[ Kwd ]]Block.__(0, {"+"}),
                        --[[ :: ]]{
                          --[[ Int ]]Block.__(2, {2}),
                          --[[ :: ]]{
                            --[[ Int ]]Block.__(2, {-1}),
                            --[[ :: ]]{
                              --[[ Kwd ]]Block.__(0, {")"}),
                              --[[ [] ]]0
                            }
                          }
                        }
                      }
                    }
                  }
                },
                to_list(lexer(Stream.of_string("3(3 + 2 -1)")))
              });
    end end)
};

suites = --[[ :: ]]{
  suites_000,
  --[[ [] ]]0
};

Mt.from_pair_suites("Genlex_test", suites);

exports = {};
exports.lexer = lexer;
exports.to_list = to_list;
exports.suites = suites;
return exports;
--[[ lexer Not a pure module ]]
