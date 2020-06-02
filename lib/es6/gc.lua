

import * as Block from "./block.lua";
import * as Curry from "./curry.lua";
import * as Printf from "./printf.lua";
import * as Caml_gc from "./caml_gc.lua";

dummy_stat = do
  minor_words: 0,
  promoted_words: 0,
  major_words: 0,
  minor_collections: 0,
  major_collections: 0,
  heap_words: 0,
  heap_chunks: 0,
  live_words: 0,
  live_blocks: 0,
  free_words: 0,
  free_blocks: 0,
  largest_free: 0,
  fragments: 0,
  compactions: 0,
  top_heap_words: 0,
  stack_size: 0
end;

function stat(param) do
  return dummy_stat;
end end

function quick_stat(param) do
  return dummy_stat;
end end

function get(param) do
  return do
          minor_heap_size: 0,
          major_heap_increment: 0,
          space_overhead: 0,
          verbose: 0,
          max_overhead: 0,
          stack_limit: 0,
          allocation_policy: 0,
          window_size: 0
        end;
end end

function print_stat(c) do
  st = stat(--[[ () ]]0);
  Curry._1(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "minor_collections: ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "minor_collections: %d\n"
          }), st.minor_collections);
  Curry._1(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "major_collections: ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "major_collections: %d\n"
          }), st.major_collections);
  Curry._1(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "compactions:       ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "compactions:       %d\n"
          }), st.compactions);
  Printf.fprintf(c, --[[ Format ]]{
        --[[ Char_literal ]]Block.__(12, {
            --[[ "\n" ]]10,
            --[[ End_of_format ]]0
          }),
        "\n"
      });
  l1 = #Curry._1(Printf.sprintf(--[[ Format ]]{
            --[[ Float ]]Block.__(8, {
                --[[ Float_f ]]0,
                --[[ No_padding ]]0,
                --[[ Lit_precision ]]{0},
                --[[ End_of_format ]]0
              }),
            "%.0f"
          }), st.minor_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "minor_words:    ",
                --[[ Float ]]Block.__(8, {
                    --[[ Float_f ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ Lit_precision ]]{0},
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "minor_words:    %*.0f\n"
          }), l1, st.minor_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "promoted_words: ",
                --[[ Float ]]Block.__(8, {
                    --[[ Float_f ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ Lit_precision ]]{0},
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "promoted_words: %*.0f\n"
          }), l1, st.promoted_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "major_words:    ",
                --[[ Float ]]Block.__(8, {
                    --[[ Float_f ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ Lit_precision ]]{0},
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "major_words:    %*.0f\n"
          }), l1, st.major_words);
  Printf.fprintf(c, --[[ Format ]]{
        --[[ Char_literal ]]Block.__(12, {
            --[[ "\n" ]]10,
            --[[ End_of_format ]]0
          }),
        "\n"
      });
  l2 = #Curry._1(Printf.sprintf(--[[ Format ]]{
            --[[ Int ]]Block.__(4, {
                --[[ Int_d ]]0,
                --[[ No_padding ]]0,
                --[[ No_precision ]]0,
                --[[ End_of_format ]]0
              }),
            "%d"
          }), st.top_heap_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "top_heap_words: ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "top_heap_words: %*d\n"
          }), l2, st.top_heap_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "heap_words:     ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "heap_words:     %*d\n"
          }), l2, st.heap_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "live_words:     ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "live_words:     %*d\n"
          }), l2, st.live_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "free_words:     ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "free_words:     %*d\n"
          }), l2, st.free_words);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "largest_free:   ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "largest_free:   %*d\n"
          }), l2, st.largest_free);
  Curry._2(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "fragments:      ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}),
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "fragments:      %*d\n"
          }), l2, st.fragments);
  Printf.fprintf(c, --[[ Format ]]{
        --[[ Char_literal ]]Block.__(12, {
            --[[ "\n" ]]10,
            --[[ End_of_format ]]0
          }),
        "\n"
      });
  Curry._1(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "live_blocks: ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "live_blocks: %d\n"
          }), st.live_blocks);
  Curry._1(Printf.fprintf(c, --[[ Format ]]{
            --[[ String_literal ]]Block.__(11, {
                "free_blocks: ",
                --[[ Int ]]Block.__(4, {
                    --[[ Int_d ]]0,
                    --[[ No_padding ]]0,
                    --[[ No_precision ]]0,
                    --[[ Char_literal ]]Block.__(12, {
                        --[[ "\n" ]]10,
                        --[[ End_of_format ]]0
                      })
                  })
              }),
            "free_blocks: %d\n"
          }), st.free_blocks);
  return Curry._1(Printf.fprintf(c, --[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "heap_chunks: ",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ "\n" ]]10,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "heap_chunks: %d\n"
                }), st.heap_chunks);
end end

function allocated_bytes(param) do
  match = Caml_gc.caml_gc_counters(--[[ () ]]0);
  return (match[0] + match[2] - match[1]) * 4;
end end

function finalise_last(param, param_1) do
  return --[[ () ]]0;
end end

function call_alarm(arec) do
  if (arec.active.contents) then do
    Caml_gc.caml_final_register(call_alarm, arec);
    return Curry._1(arec.f, --[[ () ]]0);
  end else do
    return 0;
  end end 
end end

function create_alarm(f) do
  arec_active = do
    contents: true
  end;
  arec = do
    active: arec_active,
    f: f
  end;
  Caml_gc.caml_final_register(call_alarm, arec);
  return arec_active;
end end

function delete_alarm(a) do
  a.contents = false;
  return --[[ () ]]0;
end end

finalise = Caml_gc.caml_final_register;

finalise_release = Caml_gc.caml_final_release;

export do
  stat ,
  quick_stat ,
  get ,
  print_stat ,
  allocated_bytes ,
  finalise ,
  finalise_last ,
  finalise_release ,
  create_alarm ,
  delete_alarm ,
  
end
--[[ No side effect ]]