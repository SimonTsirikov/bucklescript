'use strict';

Arg = require("../../lib/js/arg.js");
Obj = require("../../lib/js/obj.js");
List = require("../../lib/js/list.js");
$$Array = require("../../lib/js/array.js");
Block = require("../../lib/js/block.js");
Curry = require("../../lib/js/curry.js");
Format = require("../../lib/js/format.js");
Printf = require("../../lib/js/printf.js");
$$String = require("../../lib/js/string.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Pervasives = require("../../lib/js/pervasives.js");
Caml_string = require("../../lib/js/caml_string.js");
Caml_exceptions = require("../../lib/js/caml_exceptions.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function $$finally(v, action, f) do
  e;
  try do
    e = Curry._1(f, v);
  end
  catch (e$1)do
    Curry._1(action, v);
    throw e$1;
  end
  Curry._1(action, v);
  return e;
end end

function with_file_as_chan(filename, f) do
  return $$finally(Pervasives.open_out_bin(filename), Pervasives.close_out, f);
end end

function with_file_as_pp(filename, f) do
  return $$finally(Pervasives.open_out_bin(filename), Pervasives.close_out, (function (chan) do
                fmt = Format.formatter_of_out_channel(chan);
                v = Curry._1(f, fmt);
                Format.pp_print_flush(fmt, --[[ () ]]0);
                return v;
              end end));
end end

function is_pos_pow(n) do
  E = Caml_exceptions.create("E");
  try do
    _c = 0;
    _n = n;
    while(true) do
      n$1 = _n;
      c = _c;
      if (n$1 <= 0) then do
        return -2;
      end else if (n$1 == 1) then do
        return c;
      end else if ((n$1 & 1) == 0) then do
        _n = (n$1 >> 1);
        _c = c + 1 | 0;
        continue ;
      end else do
        throw E;
      end end  end  end 
    end;
  end
  catch (exn)do
    if (exn == E) then do
      return -1;
    end else do
      throw exn;
    end end 
  end
end end

function failwithf(loc, fmt) do
  return Format.ksprintf((function (s) do
                s$1 = loc .. s;
                throw [
                      Caml_builtin_exceptions.failure,
                      s$1
                    ];
              end end), fmt);
end end

function invalid_argf(fmt) do
  return Format.ksprintf(Pervasives.invalid_arg, fmt);
end end

function bad_argf(fmt) do
  return Format.ksprintf((function (x) do
                throw [
                      Arg.Bad,
                      x
                    ];
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
          n$1 = n - 1 | 0;
          _n = n$1;
          _acc = --[[ :: ]][
            r[n$1],
            acc
          ];
          continue ;
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
            continue ;
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
        return --[[ :: ]][
                h,
                t
              ];
      end end 
    end end;
    s = #r;
    t = r.tag | 0;
    if (is_list(r)) then do
      fields = get_list(r);
      return "[" .. ($$String.concat("; ", List.map(dump, fields)) .. "]");
    end else if (t ~= 0) then do
      if (t == Obj.lazy_tag) then do
        return "<lazy>";
      end else if (t == Obj.closure_tag) then do
        return "<closure>";
      end else if (t == Obj.object_tag) then do
        fields$1 = get_fields(--[[ [] ]]0, s);
        match;
        if (fields$1) then do
          match$1 = fields$1[1];
          if (match$1) then do
            match = --[[ tuple ]][
              fields$1[0],
              match$1[0],
              match$1[1]
            ];
          end else do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]][
                    "ext_pervasives_test.ml",
                    118,
                    15
                  ]
                ];
          end end 
        end else do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]][
                  "ext_pervasives_test.ml",
                  118,
                  15
                ]
              ];
        end end 
        return "Object #" .. (dump(match[1]) .. (" (" .. ($$String.concat(", ", List.map(dump, match[2])) .. ")")));
      end else if (t == Obj.infix_tag) then do
        return "<infix>";
      end else if (t == Obj.forward_tag) then do
        return "<forward>";
      end else if (t < Obj.no_scan_tag) then do
        fields$2 = get_fields(--[[ [] ]]0, s);
        return "Tag" .. (String(t) .. (" (" .. ($$String.concat(", ", List.map(dump, fields$2)) .. ")")));
      end else if (t == Obj.string_tag) then do
        return "\"" .. ($$String.escaped(r) .. "\"");
      end else if (t == Obj.double_tag) then do
        return Pervasives.string_of_float(r);
      end else if (t == Obj.abstract_tag) then do
        return "<abstract>";
      end else if (t == Obj.custom_tag) then do
        return "<custom>";
      end else if (t == Obj.custom_tag) then do
        return "<final>";
      end else if (t == Obj.double_array_tag) then do
        return "[|" .. ($$String.concat(";", $$Array.to_list($$Array.map(Pervasives.string_of_float, r))) .. "|]");
      end else do
        name = Curry._2(Printf.sprintf(--[[ Format ]][
                  --[[ String_literal ]]Block.__(11, [
                      "unknown: tag ",
                      --[[ Int ]]Block.__(4, [
                          --[[ Int_d ]]0,
                          --[[ No_padding ]]0,
                          --[[ No_precision ]]0,
                          --[[ String_literal ]]Block.__(11, [
                              " size ",
                              --[[ Int ]]Block.__(4, [
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ End_of_format ]]0
                                ])
                            ])
                        ])
                    ]),
                  "unknown: tag %d size %d"
                ]), t, s);
        return "<" .. (name .. ">");
      end end  end  end  end  end  end  end  end  end  end  end  end 
    end else do
      fields$3 = get_fields(--[[ [] ]]0, s);
      return "(" .. ($$String.concat(", ", List.map(dump, fields$3)) .. ")");
    end end  end 
  end end 
end end

dump$1 = dump;

function pp_any(fmt, v) do
  return Curry._1(Format.fprintf(fmt, --[[ Format ]][
                  --[[ Formatting_gen ]]Block.__(18, [
                      --[[ Open_box ]]Block.__(1, [--[[ Format ]][
                            --[[ End_of_format ]]0,
                            ""
                          ]]),
                      --[[ String ]]Block.__(2, [
                          --[[ No_padding ]]0,
                          --[[ Formatting_lit ]]Block.__(17, [
                              --[[ Close_box ]]0,
                              --[[ End_of_format ]]0
                            ])
                        ])
                    ]),
                  "@[%s@]"
                ]), dump$1(v));
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

exports.$$finally = $$finally;
exports.with_file_as_chan = with_file_as_chan;
exports.with_file_as_pp = with_file_as_pp;
exports.is_pos_pow = is_pos_pow;
exports.failwithf = failwithf;
exports.invalid_argf = invalid_argf;
exports.bad_argf = bad_argf;
exports.dump = dump$1;
exports.pp_any = pp_any;
exports.hash_variant = hash_variant;
--[[ Format Not a pure module ]]
