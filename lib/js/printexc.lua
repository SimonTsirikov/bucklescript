--[['use strict';]]

Obj = require "./obj";
Block = require "./block";
Curry = require "./curry";
__Buffer = require "./buffer";
Printf = require "./printf";
Caml_io = require "./caml_io";
Caml_array = require "./caml_array";
Pervasives = require "./pervasives";
Caml_js_exceptions = require "./caml_js_exceptions";
Caml_external_polyfill = require "./caml_external_polyfill";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

printers = do
  contents: --[[ [] ]]0
end;

locfmt = --[[ Format ]]{
  --[[ String_literal ]]Block.__(11, {
      "File \"",
      --[[ String ]]Block.__(2, {
          --[[ No_padding ]]0,
          --[[ String_literal ]]Block.__(11, {
              "\", line ",
              --[[ Int ]]Block.__(4, {
                  --[[ Int_d ]]0,
                  --[[ No_padding ]]0,
                  --[[ No_precision ]]0,
                  --[[ String_literal ]]Block.__(11, {
                      ", characters ",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ Char_literal ]]Block.__(12, {
                              --[[ "-" ]]45,
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ": ",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ End_of_format ]]0
                                        })
                                    })
                                })
                            })
                        })
                    })
                })
            })
        })
    }),
  "File \"%s\", line %d, characters %d-%d: %s"
};

function field(x, i) do
  f = x[i];
  if (typeof f == "number") then do
    return Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ Int ]]Block.__(4, {
                        --[[ Int_d ]]0,
                        --[[ No_padding ]]0,
                        --[[ No_precision ]]0,
                        --[[ End_of_format ]]0
                      }),
                    "%d"
                  }), f);
  end else if ((f.tag | 0) == Obj.string_tag) then do
    return Curry._1(Printf.sprintf(--[[ Format ]]{
                    --[[ Caml_string ]]Block.__(3, {
                        --[[ No_padding ]]0,
                        --[[ End_of_format ]]0
                      }),
                    "%S"
                  }), f);
  end else if ((f.tag | 0) == Obj.double_tag) then do
    return Pervasives.string_of_float(f);
  end else do
    return "_";
  end end  end  end 
end end

function other_fields(x, i) do
  if (i >= #x) then do
    return "";
  end else do
    return Curry._2(Printf.sprintf(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        ", ",
                        --[[ String ]]Block.__(2, {
                            --[[ No_padding ]]0,
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ End_of_format ]]0
                              })
                          })
                      }),
                    ", %s%s"
                  }), field(x, i), other_fields(x, i + 1 | 0));
  end end 
end end

function fields(x) do
  match = #x;
  local ___conditional___=(match);
  do
     if ___conditional___ = 0
     or ___conditional___ = 1 then do
        return "";end end end 
     if ___conditional___ = 2 then do
        return Curry._1(Printf.sprintf(--[[ Format ]]{
                        --[[ Char_literal ]]Block.__(12, {
                            --[[ "(" ]]40,
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ Char_literal ]]Block.__(12, {
                                    --[[ ")" ]]41,
                                    --[[ End_of_format ]]0
                                  })
                              })
                          }),
                        "(%s)"
                      }), field(x, 1));end end end 
     do
    else do
      return Curry._2(Printf.sprintf(--[[ Format ]]{
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "(" ]]40,
                          --[[ String ]]Block.__(2, {
                              --[[ No_padding ]]0,
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ ")" ]]41,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        }),
                      "(%s%s)"
                    }), field(x, 1), other_fields(x, 2));
      end end
      
  end
end end

function to_string(x) do
  _param = printers.contents;
  while(true) do
    param = _param;
    if (param) then do
      match;
      xpcall(function() do
        match = Curry._1(param[0], x);
      end end,function(exn) return do
        match = undefined;
      end end)
      if (match ~= undefined) then do
        return match;
      end else do
        _param = param[1];
        ::continue:: ;
      end end 
    end else if (x == Caml_builtin_exceptions.out_of_memory) then do
      return "Out of memory";
    end else if (x == Caml_builtin_exceptions.stack_overflow) then do
      return "Stack overflow";
    end else if (x[0] == Caml_builtin_exceptions.match_failure) then do
      match$1 = x[1];
      __char = match$1[2];
      return Curry._5(Printf.sprintf(locfmt), match$1[0], match$1[1], __char, __char + 5 | 0, "Pattern matching failed");
    end else if (x[0] == Caml_builtin_exceptions.assert_failure) then do
      match$2 = x[1];
      __char$1 = match$2[2];
      return Curry._5(Printf.sprintf(locfmt), match$2[0], match$2[1], __char$1, __char$1 + 6 | 0, "Assertion failed");
    end else if (x[0] == Caml_builtin_exceptions.undefined_recursive_module) then do
      match$3 = x[1];
      __char$2 = match$3[2];
      return Curry._5(Printf.sprintf(locfmt), match$3[0], match$3[1], __char$2, __char$2 + 6 | 0, "Undefined recursive module");
    end else if ((x.tag | 0) ~= 0) then do
      return x[0];
    end else do
      constructor = x[0][0];
      return constructor .. fields(x);
    end end  end  end  end  end  end  end 
  end;
end end

function print(fct, arg) do
  xpcall(function() do
    return Curry._1(fct, arg);
  end end,function(raw_x) return do
    x = Caml_js_exceptions.internalToOCamlException(raw_x);
    Curry._1(Printf.eprintf(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "Uncaught exception: ",
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    })
                }),
              "Uncaught exception: %s\n"
            }), to_string(x));
    Caml_io.caml_ml_flush(Pervasives.stderr);
    error (x)
  end end)
end end

function __catch(fct, arg) do
  xpcall(function() do
    return Curry._1(fct, arg);
  end end,function(raw_x) return do
    x = Caml_js_exceptions.internalToOCamlException(raw_x);
    Caml_io.caml_ml_flush(Pervasives.stdout);
    Curry._1(Printf.eprintf(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "Uncaught exception: ",
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    })
                }),
              "Uncaught exception: %s\n"
            }), to_string(x));
    return Pervasives.exit(2);
  end end)
end end

function convert_raw_backtrace_slot(param) do
  error ({
    Caml_builtin_exceptions.failure,
    "convert_raw_backtrace_slot not implemented"
  })
end end

function convert_raw_backtrace(bt) do
  xpcall(function() do
    return --[[ () ]]0;
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Caml_builtin_exceptions.failure) then do
      return ;
    end else do
      error (exn)
    end end 
  end end)
end end

function format_backtrace_slot(pos, slot) do
  info = function (is_raise) do
    if (is_raise) then do
      if (pos == 0) then do
        return "Raised at";
      end else do
        return "Re-raised at";
      end end 
    end else if (pos == 0) then do
      return "Raised by primitive operation at";
    end else do
      return "Called from";
    end end  end 
  end end;
  if (slot.tag) then do
    if (slot[--[[ is_raise ]]0]) then do
      return ;
    end else do
      return Curry._1(Printf.sprintf(--[[ Format ]]{
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " unknown location",
                              --[[ End_of_format ]]0
                            })
                        }),
                      "%s unknown location"
                    }), info(false));
    end end 
  end else do
    return Curry._6(Printf.sprintf(--[[ Format ]]{
                    --[[ String ]]Block.__(2, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            " file \"",
                            --[[ String ]]Block.__(2, {
                                --[[ No_padding ]]0,
                                --[[ Char_literal ]]Block.__(12, {
                                    --[[ "\"" ]]34,
                                    --[[ String ]]Block.__(2, {
                                        --[[ No_padding ]]0,
                                        --[[ String_literal ]]Block.__(11, {
                                            ", line ",
                                            --[[ Int ]]Block.__(4, {
                                                --[[ Int_d ]]0,
                                                --[[ No_padding ]]0,
                                                --[[ No_precision ]]0,
                                                --[[ String_literal ]]Block.__(11, {
                                                    ", characters ",
                                                    --[[ Int ]]Block.__(4, {
                                                        --[[ Int_d ]]0,
                                                        --[[ No_padding ]]0,
                                                        --[[ No_precision ]]0,
                                                        --[[ Char_literal ]]Block.__(12, {
                                                            --[[ "-" ]]45,
                                                            --[[ Int ]]Block.__(4, {
                                                                --[[ Int_d ]]0,
                                                                --[[ No_padding ]]0,
                                                                --[[ No_precision ]]0,
                                                                --[[ End_of_format ]]0
                                                              })
                                                          })
                                                      })
                                                  })
                                              })
                                          })
                                      })
                                  })
                              })
                          })
                      }),
                    "%s file \"%s\"%s, line %d, characters %d-%d"
                  }), info(slot[--[[ is_raise ]]0]), slot[--[[ filename ]]1], slot[--[[ is_inline ]]5] and " (inlined)" or "", slot[--[[ line_number ]]2], slot[--[[ start_char ]]3], slot[--[[ end_char ]]4]);
  end end 
end end

function print_raw_backtrace(outchan, raw_backtrace) do
  outchan$1 = outchan;
  backtrace = convert_raw_backtrace(raw_backtrace);
  if (backtrace ~= undefined) then do
    a = backtrace;
    for i = 0 , #a - 1 | 0 , 1 do
      match = format_backtrace_slot(i, Caml_array.caml_array_get(a, i));
      if (match ~= undefined) then do
        Curry._1(Printf.fprintf(outchan$1, --[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    }),
                  "%s\n"
                }), match);
      end
       end 
    end
    return --[[ () ]]0;
  end else do
    return Printf.fprintf(outchan$1, --[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "(Program not linked with -g, cannot print stack backtrace)\n",
                    --[[ End_of_format ]]0
                  }),
                "(Program not linked with -g, cannot print stack backtrace)\n"
              });
  end end 
end end

function print_backtrace(outchan) do
  return print_raw_backtrace(outchan, --[[ () ]]0);
end end

function raw_backtrace_to_string(raw_backtrace) do
  backtrace = convert_raw_backtrace(raw_backtrace);
  if (backtrace ~= undefined) then do
    a = backtrace;
    b = __Buffer.create(1024);
    for i = 0 , #a - 1 | 0 , 1 do
      match = format_backtrace_slot(i, Caml_array.caml_array_get(a, i));
      if (match ~= undefined) then do
        Curry._1(Printf.bprintf(b, --[[ Format ]]{
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ Char_literal ]]Block.__(12, {
                          --[[ "\n" ]]10,
                          --[[ End_of_format ]]0
                        })
                    }),
                  "%s\n"
                }), match);
      end
       end 
    end
    return __Buffer.contents(b);
  end else do
    return "(Program not linked with -g, cannot print stack backtrace)\n";
  end end 
end end

function backtrace_slot_is_raise(param) do
  return param[--[[ is_raise ]]0];
end end

function backtrace_slot_is_inline(param) do
  if (param.tag) then do
    return false;
  end else do
    return param[--[[ is_inline ]]5];
  end end 
end end

function backtrace_slot_location(param) do
  if (param.tag) then do
    return ;
  end else do
    return do
            filename: param[--[[ filename ]]1],
            line_number: param[--[[ line_number ]]2],
            start_char: param[--[[ start_char ]]3],
            end_char: param[--[[ end_char ]]4]
          end;
  end end 
end end

function backtrace_slots(raw_backtrace) do
  match = convert_raw_backtrace(raw_backtrace);
  if (match ~= undefined) then do
    backtrace = match;
    usable_slot = function (param) do
      if (param.tag) then do
        return false;
      end else do
        return true;
      end end 
    end end;
    exists_usable = function (_i) do
      while(true) do
        i = _i;
        if (i ~= -1) then do
          if (usable_slot(Caml_array.caml_array_get(backtrace, i))) then do
            return true;
          end else do
            _i = i - 1 | 0;
            ::continue:: ;
          end end 
        end else do
          return false;
        end end 
      end;
    end end;
    if (exists_usable(#backtrace - 1 | 0)) then do
      return backtrace;
    end else do
      return ;
    end end 
  end
   end 
end end

function get_backtrace(param) do
  return raw_backtrace_to_string(--[[ () ]]0);
end end

function register_printer(fn) do
  printers.contents = --[[ :: ]]{
    fn,
    printers.contents
  };
  return --[[ () ]]0;
end end

function exn_slot(x) do
  if (x.tag) then do
    return x;
  end else do
    return x[0];
  end end 
end end

function exn_slot_id(x) do
  slot = exn_slot(x);
  return slot[1];
end end

function exn_slot_name(x) do
  slot = exn_slot(x);
  return slot[0];
end end

uncaught_exception_handler = do
  contents: undefined
end;

function set_uncaught_exception_handler(fn) do
  uncaught_exception_handler.contents = fn;
  return --[[ () ]]0;
end end

function record_backtrace(prim) do
  return --[[ () ]]0;
end end

function backtrace_status(prim) do
  return --[[ () ]]0;
end end

function get_raw_backtrace(prim) do
  return --[[ () ]]0;
end end

function get_callstack(prim) do
  return --[[ () ]]0;
end end

Slot = do
  is_raise: backtrace_slot_is_raise,
  is_inline: backtrace_slot_is_inline,
  __location: backtrace_slot_location,
  format: format_backtrace_slot
end;

function raw_backtrace_length(prim) do
  return Caml_external_polyfill.resolve("caml_raw_backtrace_length")(prim);
end end

function get_raw_backtrace_slot(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_raw_backtrace_slot")(prim, prim$1);
end end

function get_raw_backtrace_next_slot(prim) do
  return Caml_external_polyfill.resolve("caml_raw_backtrace_next_slot")(prim);
end end

exports.to_string = to_string;
exports.print = print;
exports.__catch = __catch;
exports.print_backtrace = print_backtrace;
exports.get_backtrace = get_backtrace;
exports.record_backtrace = record_backtrace;
exports.backtrace_status = backtrace_status;
exports.register_printer = register_printer;
exports.get_raw_backtrace = get_raw_backtrace;
exports.print_raw_backtrace = print_raw_backtrace;
exports.raw_backtrace_to_string = raw_backtrace_to_string;
exports.get_callstack = get_callstack;
exports.set_uncaught_exception_handler = set_uncaught_exception_handler;
exports.backtrace_slots = backtrace_slots;
exports.Slot = Slot;
exports.raw_backtrace_length = raw_backtrace_length;
exports.get_raw_backtrace_slot = get_raw_backtrace_slot;
exports.convert_raw_backtrace_slot = convert_raw_backtrace_slot;
exports.get_raw_backtrace_next_slot = get_raw_backtrace_next_slot;
exports.exn_slot_id = exn_slot_id;
exports.exn_slot_name = exn_slot_name;
--[[ No side effect ]]
