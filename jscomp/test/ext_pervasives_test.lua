--[['use strict';]]

Arg = require "../../lib/js/arg";
Obj = require "../../lib/js/obj";
List = require "../../lib/js/list";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Format = require "../../lib/js/format";
Printf = require "../../lib/js/printf";
__String = require "../../lib/js/string";
Caml_obj = require "../../lib/js/caml_obj";
Caml_int32 = require "../../lib/js/caml_int32";
Pervasives = require "../../lib/js/pervasives";
Caml_string = require "../../lib/js/caml_string";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function __finally(v, action, f) do
  e;
  xpcall(function() do
    e = Curry._1(f, v);
  end end,function(e_1) do
    Curry._1(action, v);
    error(e_1)
  end end)
  Curry._1(action, v);
  return e;
end end

function with_file_as_chan(filename, f) do
  return __finally(Pervasives.open_out_bin(filename), Pervasives.close_out, f);
end end

function with_file_as_pp(filename, f) do
  return __finally(Pervasives.open_out_bin(filename), Pervasives.close_out, (function (chan) do
                fmt = Format.formatter_of_out_channel(chan);
                v = Curry._1(f, fmt);
                Format.pp_print_flush(fmt, --[[ () ]]0);
                return v;
              end end));
end end

function is_pos_pow(n) do
  E = Caml_exceptions.create("E");
  xpcall(function() do
    _c = 0;
    _n = n;
    while(true) do
      n_1 = _n;
      c = _c;
      if (n_1 <= 0) then do
        return -2;
      end else if (n_1 == 1) then do
        return c;
      end else if ((n_1 & 1) == 0) then do
        _n = (n_1 >> 1);
        _c = c + 1 | 0;
        ::continue:: ;
      end else do
        error(E)
      end end  end  end 
    end;
  end end,function(exn) do
    if (exn == E) then do
      return -1;
    end else do
      error(exn)
    end end 
  end end)
end end

function failwithf(loc, fmt) do
  return Format.ksprintf((function (s) do
                s_1 = loc .. s;
                error({
                  Caml_builtin_exceptions.failure,
                  s_1
                })
              end end), fmt);
end end

function invalid_argf(fmt) do
  return Format.ksprintf(Pervasives.invalid_arg, fmt);
end end

function bad_argf(fmt) do
  return Format.ksprintf((function (x) do
                error({
                  Arg.Bad,
                  x
                })
              end end), fmt);
end end

function dump(r) do
  if (typeof r == "number") then do
    return String(r);
  end else do
    get_fields = function (_acc, _n) do
      while(true) do
        n = _n;
        acc = _acc;
        if (n ~= 0) then do
          n_1 = n - 1 | 0;
          _n = n_1;
          _acc = --[[ :: ]]{
            r[n_1],
            acc
          };
          ::continue:: ;
        end else do
          return acc;
        end end 
      end;
    end end;
    is_list = function (_r) do
      while(true) do
        r = _r;
        if (typeof r == "number") then do
          return Caml_obj.caml_equal(r, 0);
        end else do
          s = #r;
          t = r.tag | 0;
          if (t == 0 and s == 2) then do
            _r = r[1];
            ::continue:: ;
          end else do
            return false;
          end end 
        end end 
      end;
    end end;
    get_list = function (r) do
      if (typeof r == "number") then do
        return --[[ [] ]]0;
      end else do
        h = r[0];
        t = get_list(r[1]);
        return --[[ :: ]]{
                h,
                t
              };
      end end 
    end end;
    s = #r;
    t = r.tag | 0;
    if (is_list(r)) then do
      fields = get_list(r);
      return "[" .. (__String.concat("; ", List.map(dump, fields)) .. "]");
    end else if (t ~= 0) then do
      if (t == Obj.lazy_tag) then do
        return "<lazy>";
      end else if (t == Obj.closure_tag) then do
        return "<closure>";
      end else if (t == Obj.object_tag) then do
        fields_1 = get_fields(--[[ [] ]]0, s);
        match;
        if (fields_1) then do
          match_1 = fields_1[1];
          if (match_1) then do
            match = --[[ tuple ]]{
              fields_1[0],
              match_1[0],
              match_1[1]
            };
          end else do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "ext_pervasives_test.ml",
                118,
                15
              }
            })
          end end 
        end else do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "ext_pervasives_test.ml",
              118,
              15
            }
          })
        end end 
        return "Object #" .. (dump(match[1]) .. (" (" .. (__String.concat(", ", List.map(dump, match[2])) .. ")")));
      end else if (t == Obj.infix_tag) then do
        return "<infix>";
      end else if (t == Obj.forward_tag) then do
        return "<forward>";
      end else if (t < Obj.no_scan_tag) then do
        fields_2 = get_fields(--[[ [] ]]0, s);
        return "Tag" .. (String(t) .. (" (" .. (__String.concat(", ", List.map(dump, fields_2)) .. ")")));
      end else if (t == Obj.string_tag) then do
        return "\"" .. (__String.escaped(r) .. "\"");
      end else if (t == Obj.double_tag) then do
        return Pervasives.string_of_float(r);
      end else if (t == Obj.abstract_tag) then do
        return "<abstract>";
      end else if (t == Obj.custom_tag) then do
        return "<custom>";
      end else if (t == Obj.custom_tag) then do
        return "<final>";
      end else if (t == Obj.double_array_tag) then do
        return "[|" .. (__String.concat(";", __Array.to_list(__Array.map(Pervasives.string_of_float, r))) .. "|]");
      end else do
        name = Curry._2(Printf.sprintf(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "unknown: tag ",
                      --[[ Int ]]Block.__(4, {
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              " size ",
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ End_of_format ]]0
                                })
                            })
                        })
                    }),
                  "unknown: tag %d size %d"
                }), t, s);
        return "<" .. (name .. ">");
      end end  end  end  end  end  end  end  end  end  end  end  end 
    end else do
      fields_3 = get_fields(--[[ [] ]]0, s);
      return "(" .. (__String.concat(", ", List.map(dump, fields_3)) .. ")");
    end end  end 
  end end 
end end

dump_1 = dump;

function pp_any(fmt, v) do
  return Curry._1(Format.fprintf(fmt, --[[ Format ]]{
                  --[[ Formatting_gen ]]Block.__(18, {
                      --[[ Open_box ]]Block.__(1, {--[[ Format ]]{
                            --[[ End_of_format ]]0,
                            ""
                          }}),
                      --[[ String ]]Block.__(2, {
                          --[[ No_padding ]]0,
                          --[[ Formatting_lit ]]Block.__(17, {
                              --[[ Close_box ]]0,
                              --[[ End_of_format ]]0
                            })
                        })
                    }),
                  "@[%s@]"
                }), dump_1(v));
end end

function hash_variant(s) do
  accu = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    accu = Caml_int32.imul(223, accu) + Caml_string.get(s, i) | 0;
  end
  accu = accu & 2147483647;
  if (accu > 1073741823) then do
    return accu - -2147483648 | 0;
  end else do
    return accu;
  end end 
end end

exports.__finally = __finally;
exports.with_file_as_chan = with_file_as_chan;
exports.with_file_as_pp = with_file_as_pp;
exports.is_pos_pow = is_pos_pow;
exports.failwithf = failwithf;
exports.invalid_argf = invalid_argf;
exports.bad_argf = bad_argf;
exports.dump = dump_1;
exports.pp_any = pp_any;
exports.hash_variant = hash_variant;
--[[ Format Not a pure module ]]
