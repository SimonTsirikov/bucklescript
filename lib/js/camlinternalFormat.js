'use strict';

var Char = require("./char.js");
var Block = require("./block.js");
var Bytes = require("./bytes.js");
var Curry = require("./curry.js");
var $$Buffer = require("./buffer.js");
var $$String = require("./string.js");
var Caml_io = require("./caml_io.js");
var Caml_obj = require("./caml_obj.js");
var Caml_bytes = require("./caml_bytes.js");
var Caml_int32 = require("./caml_int32.js");
var Pervasives = require("./pervasives.js");
var Caml_format = require("./caml_format.js");
var Caml_string = require("./caml_string.js");
var Caml_primitive = require("./caml_primitive.js");
var Caml_exceptions = require("./caml_exceptions.js");
var Caml_js_exceptions = require("./caml_js_exceptions.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");
var CamlinternalFormatBasics = require("./camlinternalFormatBasics.js");

function create_char_set(param) do
  return Bytes.make(32, --[ "\000" ]--0);
end

function add_in_char_set(char_set, c) do
  var str_ind = (c >>> 3);
  var mask = (1 << (c & 7));
  char_set[str_ind] = Pervasives.char_of_int(Caml_bytes.get(char_set, str_ind) | mask);
  return --[ () ]--0;
end

var freeze_char_set = Bytes.to_string;

function rev_char_set(char_set) do
  var char_set$prime = Bytes.make(32, --[ "\000" ]--0);
  for(var i = 0; i <= 31; ++i)do
    char_set$prime[i] = Pervasives.char_of_int(Caml_string.get(char_set, i) ^ 255);
  end
  return Caml_bytes.bytes_to_string(char_set$prime);
end

function is_in_char_set(char_set, c) do
  var str_ind = (c >>> 3);
  var mask = (1 << (c & 7));
  return (Caml_string.get(char_set, str_ind) & mask) ~= 0;
end

function pad_of_pad_opt(pad_opt) do
  if (pad_opt ~= undefined) then do
    return --[ Lit_padding ]--Block.__(0, [
              --[ Right ]--1,
              pad_opt
            ]);
  end else do
    return --[ No_padding ]--0;
  end end 
end

function prec_of_prec_opt(prec_opt) do
  if (prec_opt ~= undefined) then do
    return --[ Lit_precision ]--[prec_opt];
  end else do
    return --[ No_precision ]--0;
  end end 
end

function param_format_of_ignored_format(ign, fmt) do
  if (typeof ign == "number") then do
    switch (ign) do
      case --[ Ignored_char ]--0 :
          return --[ Param_format_EBB ]--[--[ Char ]--Block.__(0, [fmt])];
      case --[ Ignored_caml_char ]--1 :
          return --[ Param_format_EBB ]--[--[ Caml_char ]--Block.__(1, [fmt])];
      case --[ Ignored_reader ]--2 :
          return --[ Param_format_EBB ]--[--[ Reader ]--Block.__(19, [fmt])];
      case --[ Ignored_scan_next_char ]--3 :
          return --[ Param_format_EBB ]--[--[ Scan_next_char ]--Block.__(22, [fmt])];
      
    end
  end else do
    switch (ign.tag | 0) do
      case --[ Ignored_string ]--0 :
          return --[ Param_format_EBB ]--[--[ String ]--Block.__(2, [
                      pad_of_pad_opt(ign[0]),
                      fmt
                    ])];
      case --[ Ignored_caml_string ]--1 :
          return --[ Param_format_EBB ]--[--[ Caml_string ]--Block.__(3, [
                      pad_of_pad_opt(ign[0]),
                      fmt
                    ])];
      case --[ Ignored_int ]--2 :
          return --[ Param_format_EBB ]--[--[ Int ]--Block.__(4, [
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[ No_precision ]--0,
                      fmt
                    ])];
      case --[ Ignored_int32 ]--3 :
          return --[ Param_format_EBB ]--[--[ Int32 ]--Block.__(5, [
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[ No_precision ]--0,
                      fmt
                    ])];
      case --[ Ignored_nativeint ]--4 :
          return --[ Param_format_EBB ]--[--[ Nativeint ]--Block.__(6, [
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[ No_precision ]--0,
                      fmt
                    ])];
      case --[ Ignored_int64 ]--5 :
          return --[ Param_format_EBB ]--[--[ Int64 ]--Block.__(7, [
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[ No_precision ]--0,
                      fmt
                    ])];
      case --[ Ignored_float ]--6 :
          return --[ Param_format_EBB ]--[--[ Float ]--Block.__(8, [
                      --[ Float_f ]--0,
                      pad_of_pad_opt(ign[0]),
                      prec_of_prec_opt(ign[1]),
                      fmt
                    ])];
      case --[ Ignored_bool ]--7 :
          return --[ Param_format_EBB ]--[--[ Bool ]--Block.__(9, [
                      pad_of_pad_opt(ign[0]),
                      fmt
                    ])];
      case --[ Ignored_format_arg ]--8 :
          return --[ Param_format_EBB ]--[--[ Format_arg ]--Block.__(13, [
                      ign[0],
                      ign[1],
                      fmt
                    ])];
      case --[ Ignored_format_subst ]--9 :
          return --[ Param_format_EBB ]--[--[ Format_subst ]--Block.__(14, [
                      ign[0],
                      ign[1],
                      fmt
                    ])];
      case --[ Ignored_scan_char_set ]--10 :
          return --[ Param_format_EBB ]--[--[ Scan_char_set ]--Block.__(20, [
                      ign[0],
                      ign[1],
                      fmt
                    ])];
      case --[ Ignored_scan_get_counter ]--11 :
          return --[ Param_format_EBB ]--[--[ Scan_get_counter ]--Block.__(21, [
                      ign[0],
                      fmt
                    ])];
      
    end
  end end 
end

function buffer_check_size(buf, overhead) do
  var len = #buf.bytes;
  var min_len = buf.ind + overhead | 0;
  if (min_len > len) then do
    var new_len = Caml_primitive.caml_int_max((len << 1), min_len);
    var new_str = Caml_bytes.caml_create_bytes(new_len);
    Bytes.blit(buf.bytes, 0, new_str, 0, len);
    buf.bytes = new_str;
    return --[ () ]--0;
  end else do
    return 0;
  end end 
end

function buffer_add_char(buf, c) do
  buffer_check_size(buf, 1);
  buf.bytes[buf.ind] = c;
  buf.ind = buf.ind + 1 | 0;
  return --[ () ]--0;
end

function buffer_add_string(buf, s) do
  var str_len = #s;
  buffer_check_size(buf, str_len);
  $$String.blit(s, 0, buf.bytes, buf.ind, str_len);
  buf.ind = buf.ind + str_len | 0;
  return --[ () ]--0;
end

function buffer_contents(buf) do
  return Bytes.sub_string(buf.bytes, 0, buf.ind);
end

function char_of_iconv(iconv) do
  switch (iconv) do
    case --[ Int_d ]--0 :
    case --[ Int_pd ]--1 :
    case --[ Int_sd ]--2 :
        return --[ "d" ]--100;
    case --[ Int_i ]--3 :
    case --[ Int_pi ]--4 :
    case --[ Int_si ]--5 :
        return --[ "i" ]--105;
    case --[ Int_x ]--6 :
    case --[ Int_Cx ]--7 :
        return --[ "x" ]--120;
    case --[ Int_X ]--8 :
    case --[ Int_CX ]--9 :
        return --[ "X" ]--88;
    case --[ Int_o ]--10 :
    case --[ Int_Co ]--11 :
        return --[ "o" ]--111;
    case --[ Int_u ]--12 :
        return --[ "u" ]--117;
    
  end
end

function char_of_fconv(fconv) do
  switch (fconv) do
    case --[ Float_f ]--0 :
    case --[ Float_pf ]--1 :
    case --[ Float_sf ]--2 :
        return --[ "f" ]--102;
    case --[ Float_e ]--3 :
    case --[ Float_pe ]--4 :
    case --[ Float_se ]--5 :
        return --[ "e" ]--101;
    case --[ Float_E ]--6 :
    case --[ Float_pE ]--7 :
    case --[ Float_sE ]--8 :
        return --[ "E" ]--69;
    case --[ Float_g ]--9 :
    case --[ Float_pg ]--10 :
    case --[ Float_sg ]--11 :
        return --[ "g" ]--103;
    case --[ Float_G ]--12 :
    case --[ Float_pG ]--13 :
    case --[ Float_sG ]--14 :
        return --[ "G" ]--71;
    case --[ Float_F ]--15 :
        return --[ "F" ]--70;
    case --[ Float_h ]--16 :
    case --[ Float_ph ]--17 :
    case --[ Float_sh ]--18 :
        return --[ "h" ]--104;
    case --[ Float_H ]--19 :
    case --[ Float_pH ]--20 :
    case --[ Float_sH ]--21 :
        return --[ "H" ]--72;
    
  end
end

function char_of_counter(counter) do
  switch (counter) do
    case --[ Line_counter ]--0 :
        return --[ "l" ]--108;
    case --[ Char_counter ]--1 :
        return --[ "n" ]--110;
    case --[ Token_counter ]--2 :
        return --[ "N" ]--78;
    
  end
end

function bprint_char_set(buf, char_set) do
  var print_char = function (buf, i) do
    var c = Pervasives.char_of_int(i);
    if (c ~= 37) then do
      if (c ~= 64) then do
        return buffer_add_char(buf, c);
      end else do
        buffer_add_char(buf, --[ "%" ]--37);
        return buffer_add_char(buf, --[ "@" ]--64);
      end end 
    end else do
      buffer_add_char(buf, --[ "%" ]--37);
      return buffer_add_char(buf, --[ "%" ]--37);
    end end 
  end;
  var print_out = function (set, _i) do
    while(true) do
      var i = _i;
      if (i < 256) then do
        if (is_in_char_set(set, Pervasives.char_of_int(i))) then do
          var set$1 = set;
          var i$1 = i;
          var match = Pervasives.char_of_int(i$1);
          var switcher = match - 45 | 0;
          if (switcher > 48 or switcher < 0) then do
            if (switcher >= 210) then do
              return print_char(buf, 255);
            end else do
              return print_second(set$1, i$1 + 1 | 0);
            end end 
          end else if (switcher > 47 or switcher < 1) then do
            return print_out(set$1, i$1 + 1 | 0);
          end else do
            return print_second(set$1, i$1 + 1 | 0);
          end end  end 
        end else do
          _i = i + 1 | 0;
          continue ;
        end end 
      end else do
        return 0;
      end end 
    end;
  end;
  var print_second = function (set, i) do
    if (is_in_char_set(set, Pervasives.char_of_int(i))) then do
      var match = Pervasives.char_of_int(i);
      var switcher = match - 45 | 0;
      if (switcher > 48 or switcher < 0) then do
        if (switcher >= 210) then do
          print_char(buf, 254);
          return print_char(buf, 255);
        end
         end 
      end else if ((switcher > 47 or switcher < 1) and !is_in_char_set(set, Pervasives.char_of_int(i + 1 | 0))) then do
        print_char(buf, i - 1 | 0);
        return print_out(set, i + 1 | 0);
      end
       end  end 
      if (is_in_char_set(set, Pervasives.char_of_int(i + 1 | 0))) then do
        var set$1 = set;
        var i$1 = i - 1 | 0;
        var _j = i + 2 | 0;
        while(true) do
          var j = _j;
          if (j == 256 or !is_in_char_set(set$1, Pervasives.char_of_int(j))) then do
            print_char(buf, i$1);
            print_char(buf, --[ "-" ]--45);
            print_char(buf, j - 1 | 0);
            if (j < 256) then do
              return print_out(set$1, j + 1 | 0);
            end else do
              return 0;
            end end 
          end else do
            _j = j + 1 | 0;
            continue ;
          end end 
        end;
      end else do
        print_char(buf, i - 1 | 0);
        print_char(buf, i);
        return print_out(set, i + 2 | 0);
      end end 
    end else do
      print_char(buf, i - 1 | 0);
      return print_out(set, i + 1 | 0);
    end end 
  end;
  var print_start = function (set) do
    var is_alone = function (c) do
      var before = Char.chr(c - 1 | 0);
      var after = Char.chr(c + 1 | 0);
      if (is_in_char_set(set, c)) then do
        return !(is_in_char_set(set, before) and is_in_char_set(set, after));
      end else do
        return false;
      end end 
    end;
    if (is_alone(--[ "]" ]--93)) then do
      buffer_add_char(buf, --[ "]" ]--93);
    end
     end 
    print_out(set, 1);
    if (is_alone(--[ "-" ]--45)) then do
      return buffer_add_char(buf, --[ "-" ]--45);
    end else do
      return 0;
    end end 
  end;
  buffer_add_char(buf, --[ "[" ]--91);
  print_start(is_in_char_set(char_set, --[ "\000" ]--0) ? (buffer_add_char(buf, --[ "^" ]--94), rev_char_set(char_set)) : char_set);
  return buffer_add_char(buf, --[ "]" ]--93);
end

function bprint_padty(buf, padty) do
  switch (padty) do
    case --[ Left ]--0 :
        return buffer_add_char(buf, --[ "-" ]--45);
    case --[ Right ]--1 :
        return --[ () ]--0;
    case --[ Zeros ]--2 :
        return buffer_add_char(buf, --[ "0" ]--48);
    
  end
end

function bprint_ignored_flag(buf, ign_flag) do
  if (ign_flag) then do
    return buffer_add_char(buf, --[ "_" ]--95);
  end else do
    return 0;
  end end 
end

function bprint_pad_opt(buf, pad_opt) do
  if (pad_opt ~= undefined) then do
    return buffer_add_string(buf, String(pad_opt));
  end else do
    return --[ () ]--0;
  end end 
end

function bprint_padding(buf, pad) do
  if (typeof pad == "number") then do
    return --[ () ]--0;
  end else do
    bprint_padty(buf, pad[0]);
    if (pad.tag) then do
      return buffer_add_char(buf, --[ "*" ]--42);
    end else do
      return buffer_add_string(buf, String(pad[1]));
    end end 
  end end 
end

function bprint_precision(buf, prec) do
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      return buffer_add_string(buf, ".*");
    end else do
      return --[ () ]--0;
    end end 
  end else do
    buffer_add_char(buf, --[ "." ]--46);
    return buffer_add_string(buf, String(prec[0]));
  end end 
end

function bprint_iconv_flag(buf, iconv) do
  switch (iconv) do
    case --[ Int_pd ]--1 :
    case --[ Int_pi ]--4 :
        return buffer_add_char(buf, --[ "+" ]--43);
    case --[ Int_sd ]--2 :
    case --[ Int_si ]--5 :
        return buffer_add_char(buf, --[ " " ]--32);
    case --[ Int_Cx ]--7 :
    case --[ Int_CX ]--9 :
    case --[ Int_Co ]--11 :
        return buffer_add_char(buf, --[ "#" ]--35);
    case --[ Int_d ]--0 :
    case --[ Int_i ]--3 :
    case --[ Int_x ]--6 :
    case --[ Int_X ]--8 :
    case --[ Int_o ]--10 :
    case --[ Int_u ]--12 :
        return --[ () ]--0;
    
  end
end

function bprint_int_fmt(buf, ign_flag, iconv, pad, prec) do
  buffer_add_char(buf, --[ "%" ]--37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_iconv_flag(buf, iconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  return buffer_add_char(buf, char_of_iconv(iconv));
end

function bprint_altint_fmt(buf, ign_flag, iconv, pad, prec, c) do
  buffer_add_char(buf, --[ "%" ]--37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_iconv_flag(buf, iconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  buffer_add_char(buf, c);
  return buffer_add_char(buf, char_of_iconv(iconv));
end

function bprint_fconv_flag(buf, fconv) do
  switch (fconv) do
    case --[ Float_f ]--0 :
    case --[ Float_e ]--3 :
    case --[ Float_E ]--6 :
    case --[ Float_g ]--9 :
    case --[ Float_G ]--12 :
    case --[ Float_F ]--15 :
    case --[ Float_h ]--16 :
    case --[ Float_H ]--19 :
        return --[ () ]--0;
    case --[ Float_pf ]--1 :
    case --[ Float_pe ]--4 :
    case --[ Float_pE ]--7 :
    case --[ Float_pg ]--10 :
    case --[ Float_pG ]--13 :
    case --[ Float_ph ]--17 :
    case --[ Float_pH ]--20 :
        return buffer_add_char(buf, --[ "+" ]--43);
    case --[ Float_sf ]--2 :
    case --[ Float_se ]--5 :
    case --[ Float_sE ]--8 :
    case --[ Float_sg ]--11 :
    case --[ Float_sG ]--14 :
    case --[ Float_sh ]--18 :
    case --[ Float_sH ]--21 :
        return buffer_add_char(buf, --[ " " ]--32);
    
  end
end

function bprint_float_fmt(buf, ign_flag, fconv, pad, prec) do
  buffer_add_char(buf, --[ "%" ]--37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_fconv_flag(buf, fconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  return buffer_add_char(buf, char_of_fconv(fconv));
end

function string_of_formatting_lit(formatting_lit) do
  if (typeof formatting_lit == "number") then do
    switch (formatting_lit) do
      case --[ Close_box ]--0 :
          return "@]";
      case --[ Close_tag ]--1 :
          return "@}";
      case --[ FFlush ]--2 :
          return "@?";
      case --[ Force_newline ]--3 :
          return "@\n";
      case --[ Flush_newline ]--4 :
          return "@.";
      case --[ Escaped_at ]--5 :
          return "@@";
      case --[ Escaped_percent ]--6 :
          return "@%";
      
    end
  end else do
    switch (formatting_lit.tag | 0) do
      case --[ Break ]--0 :
      case --[ Magic_size ]--1 :
          return formatting_lit[0];
      case --[ Scan_indic ]--2 :
          return "@" .. Caml_bytes.bytes_to_string(Bytes.make(1, formatting_lit[0]));
      
    end
  end end 
end

function string_of_formatting_gen(formatting_gen) do
  return formatting_gen[0][1];
end

function bprint_char_literal(buf, chr) do
  if (chr ~= 37) then do
    return buffer_add_char(buf, chr);
  end else do
    return buffer_add_string(buf, "%%");
  end end 
end

function bprint_string_literal(buf, str) do
  for(var i = 0 ,i_finish = #str - 1 | 0; i <= i_finish; ++i)do
    bprint_char_literal(buf, Caml_string.get(str, i));
  end
  return --[ () ]--0;
end

function bprint_fmtty(buf, _fmtty) do
  while(true) do
    var fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return --[ () ]--0;
    end else do
      switch (fmtty.tag | 0) do
        case --[ Char_ty ]--0 :
            buffer_add_string(buf, "%c");
            _fmtty = fmtty[0];
            continue ;
        case --[ String_ty ]--1 :
            buffer_add_string(buf, "%s");
            _fmtty = fmtty[0];
            continue ;
        case --[ Int_ty ]--2 :
            buffer_add_string(buf, "%i");
            _fmtty = fmtty[0];
            continue ;
        case --[ Int32_ty ]--3 :
            buffer_add_string(buf, "%li");
            _fmtty = fmtty[0];
            continue ;
        case --[ Nativeint_ty ]--4 :
            buffer_add_string(buf, "%ni");
            _fmtty = fmtty[0];
            continue ;
        case --[ Int64_ty ]--5 :
            buffer_add_string(buf, "%Li");
            _fmtty = fmtty[0];
            continue ;
        case --[ Float_ty ]--6 :
            buffer_add_string(buf, "%f");
            _fmtty = fmtty[0];
            continue ;
        case --[ Bool_ty ]--7 :
            buffer_add_string(buf, "%B");
            _fmtty = fmtty[0];
            continue ;
        case --[ Format_arg_ty ]--8 :
            buffer_add_string(buf, "%{");
            bprint_fmtty(buf, fmtty[0]);
            buffer_add_string(buf, "%}");
            _fmtty = fmtty[1];
            continue ;
        case --[ Format_subst_ty ]--9 :
            buffer_add_string(buf, "%(");
            bprint_fmtty(buf, fmtty[0]);
            buffer_add_string(buf, "%)");
            _fmtty = fmtty[2];
            continue ;
        case --[ Alpha_ty ]--10 :
            buffer_add_string(buf, "%a");
            _fmtty = fmtty[0];
            continue ;
        case --[ Theta_ty ]--11 :
            buffer_add_string(buf, "%t");
            _fmtty = fmtty[0];
            continue ;
        case --[ Any_ty ]--12 :
            buffer_add_string(buf, "%?");
            _fmtty = fmtty[0];
            continue ;
        case --[ Reader_ty ]--13 :
            buffer_add_string(buf, "%r");
            _fmtty = fmtty[0];
            continue ;
        case --[ Ignored_reader_ty ]--14 :
            buffer_add_string(buf, "%_r");
            _fmtty = fmtty[0];
            continue ;
        
      end
    end end 
  end;
end

function int_of_custom_arity(param) do
  if (param) then do
    return 1 + int_of_custom_arity(param[0]) | 0;
  end else do
    return 0;
  end end 
end

function bprint_fmt(buf, fmt) do
  var _fmt = fmt;
  var _ign_flag = false;
  while(true) do
    var ign_flag = _ign_flag;
    var fmt$1 = _fmt;
    if (typeof fmt$1 == "number") then do
      return --[ () ]--0;
    end else do
      switch (fmt$1.tag | 0) do
        case --[ Char ]--0 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[ "c" ]--99);
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ Caml_char ]--1 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[ "C" ]--67);
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ String ]--2 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[ "s" ]--115);
            _ign_flag = false;
            _fmt = fmt$1[1];
            continue ;
        case --[ Caml_string ]--3 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[ "S" ]--83);
            _ign_flag = false;
            _fmt = fmt$1[1];
            continue ;
        case --[ Int ]--4 :
            bprint_int_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2]);
            _ign_flag = false;
            _fmt = fmt$1[3];
            continue ;
        case --[ Int32 ]--5 :
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[ "l" ]--108);
            _ign_flag = false;
            _fmt = fmt$1[3];
            continue ;
        case --[ Nativeint ]--6 :
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[ "n" ]--110);
            _ign_flag = false;
            _fmt = fmt$1[3];
            continue ;
        case --[ Int64 ]--7 :
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[ "L" ]--76);
            _ign_flag = false;
            _fmt = fmt$1[3];
            continue ;
        case --[ Float ]--8 :
            bprint_float_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2]);
            _ign_flag = false;
            _fmt = fmt$1[3];
            continue ;
        case --[ Bool ]--9 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[ "B" ]--66);
            _ign_flag = false;
            _fmt = fmt$1[1];
            continue ;
        case --[ Flush ]--10 :
            buffer_add_string(buf, "%!");
            _fmt = fmt$1[0];
            continue ;
        case --[ String_literal ]--11 :
            bprint_string_literal(buf, fmt$1[0]);
            _fmt = fmt$1[1];
            continue ;
        case --[ Char_literal ]--12 :
            bprint_char_literal(buf, fmt$1[0]);
            _fmt = fmt$1[1];
            continue ;
        case --[ Format_arg ]--13 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            buffer_add_char(buf, --[ "{" ]--123);
            bprint_fmtty(buf, fmt$1[1]);
            buffer_add_char(buf, --[ "%" ]--37);
            buffer_add_char(buf, --[ "}" ]--125);
            _ign_flag = false;
            _fmt = fmt$1[2];
            continue ;
        case --[ Format_subst ]--14 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            buffer_add_char(buf, --[ "(" ]--40);
            bprint_fmtty(buf, fmt$1[1]);
            buffer_add_char(buf, --[ "%" ]--37);
            buffer_add_char(buf, --[ ")" ]--41);
            _ign_flag = false;
            _fmt = fmt$1[2];
            continue ;
        case --[ Alpha ]--15 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[ "a" ]--97);
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ Theta ]--16 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[ "t" ]--116);
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ Formatting_lit ]--17 :
            bprint_string_literal(buf, string_of_formatting_lit(fmt$1[0]));
            _fmt = fmt$1[1];
            continue ;
        case --[ Formatting_gen ]--18 :
            bprint_string_literal(buf, "@{");
            bprint_string_literal(buf, string_of_formatting_gen(fmt$1[0]));
            _fmt = fmt$1[1];
            continue ;
        case --[ Reader ]--19 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[ "r" ]--114);
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ Scan_char_set ]--20 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            bprint_char_set(buf, fmt$1[1]);
            _ign_flag = false;
            _fmt = fmt$1[2];
            continue ;
        case --[ Scan_get_counter ]--21 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, char_of_counter(fmt$1[0]));
            _ign_flag = false;
            _fmt = fmt$1[1];
            continue ;
        case --[ Scan_next_char ]--22 :
            buffer_add_char(buf, --[ "%" ]--37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_string_literal(buf, "0c");
            _ign_flag = false;
            _fmt = fmt$1[0];
            continue ;
        case --[ Ignored_param ]--23 :
            var match = param_format_of_ignored_format(fmt$1[0], fmt$1[1]);
            _ign_flag = true;
            _fmt = match[0];
            continue ;
        case --[ Custom ]--24 :
            for(var _i = 1 ,_i_finish = int_of_custom_arity(fmt$1[0]); _i <= _i_finish; ++_i)do
              buffer_add_char(buf, --[ "%" ]--37);
              bprint_ignored_flag(buf, ign_flag);
              buffer_add_char(buf, --[ "?" ]--63);
            end
            _ign_flag = false;
            _fmt = fmt$1[2];
            continue ;
        
      end
    end end 
  end;
end

function string_of_fmt(fmt) do
  var buf = do
    ind: 0,
    bytes: Caml_bytes.caml_create_bytes(16)
  end;
  bprint_fmt(buf, fmt);
  return buffer_contents(buf);
end

function symm(param) do
  if (typeof param == "number") then do
    return --[ End_of_fmtty ]--0;
  end else do
    switch (param.tag | 0) do
      case --[ Char_ty ]--0 :
          return --[ Char_ty ]--Block.__(0, [symm(param[0])]);
      case --[ String_ty ]--1 :
          return --[ String_ty ]--Block.__(1, [symm(param[0])]);
      case --[ Int_ty ]--2 :
          return --[ Int_ty ]--Block.__(2, [symm(param[0])]);
      case --[ Int32_ty ]--3 :
          return --[ Int32_ty ]--Block.__(3, [symm(param[0])]);
      case --[ Nativeint_ty ]--4 :
          return --[ Nativeint_ty ]--Block.__(4, [symm(param[0])]);
      case --[ Int64_ty ]--5 :
          return --[ Int64_ty ]--Block.__(5, [symm(param[0])]);
      case --[ Float_ty ]--6 :
          return --[ Float_ty ]--Block.__(6, [symm(param[0])]);
      case --[ Bool_ty ]--7 :
          return --[ Bool_ty ]--Block.__(7, [symm(param[0])]);
      case --[ Format_arg_ty ]--8 :
          return --[ Format_arg_ty ]--Block.__(8, [
                    param[0],
                    symm(param[1])
                  ]);
      case --[ Format_subst_ty ]--9 :
          return --[ Format_subst_ty ]--Block.__(9, [
                    param[1],
                    param[0],
                    symm(param[2])
                  ]);
      case --[ Alpha_ty ]--10 :
          return --[ Alpha_ty ]--Block.__(10, [symm(param[0])]);
      case --[ Theta_ty ]--11 :
          return --[ Theta_ty ]--Block.__(11, [symm(param[0])]);
      case --[ Any_ty ]--12 :
          return --[ Any_ty ]--Block.__(12, [symm(param[0])]);
      case --[ Reader_ty ]--13 :
          return --[ Reader_ty ]--Block.__(13, [symm(param[0])]);
      case --[ Ignored_reader_ty ]--14 :
          return --[ Ignored_reader_ty ]--Block.__(14, [symm(param[0])]);
      
    end
  end end 
end

function fmtty_rel_det(param) do
  if (typeof param == "number") then do
    return --[ tuple ]--[
            (function (param) do
                return --[ Refl ]--0;
              end),
            (function (param) do
                return --[ Refl ]--0;
              end),
            (function (param) do
                return --[ Refl ]--0;
              end),
            (function (param) do
                return --[ Refl ]--0;
              end)
          ];
  end else do
    switch (param.tag | 0) do
      case --[ Char_ty ]--0 :
          var match = fmtty_rel_det(param[0]);
          var af = match[1];
          var fa = match[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match[2],
                  match[3]
                ];
      case --[ String_ty ]--1 :
          var match$1 = fmtty_rel_det(param[0]);
          var af$1 = match$1[1];
          var fa$1 = match$1[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$1, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$1, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$1[2],
                  match$1[3]
                ];
      case --[ Int_ty ]--2 :
          var match$2 = fmtty_rel_det(param[0]);
          var af$2 = match$2[1];
          var fa$2 = match$2[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$2, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$2, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$2[2],
                  match$2[3]
                ];
      case --[ Int32_ty ]--3 :
          var match$3 = fmtty_rel_det(param[0]);
          var af$3 = match$3[1];
          var fa$3 = match$3[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$3, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$3, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$3[2],
                  match$3[3]
                ];
      case --[ Nativeint_ty ]--4 :
          var match$4 = fmtty_rel_det(param[0]);
          var af$4 = match$4[1];
          var fa$4 = match$4[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$4, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$4, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$4[2],
                  match$4[3]
                ];
      case --[ Int64_ty ]--5 :
          var match$5 = fmtty_rel_det(param[0]);
          var af$5 = match$5[1];
          var fa$5 = match$5[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$5, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$5, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$5[2],
                  match$5[3]
                ];
      case --[ Float_ty ]--6 :
          var match$6 = fmtty_rel_det(param[0]);
          var af$6 = match$6[1];
          var fa$6 = match$6[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$6, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$6, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$6[2],
                  match$6[3]
                ];
      case --[ Bool_ty ]--7 :
          var match$7 = fmtty_rel_det(param[0]);
          var af$7 = match$7[1];
          var fa$7 = match$7[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$7, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$7, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$7[2],
                  match$7[3]
                ];
      case --[ Format_arg_ty ]--8 :
          var match$8 = fmtty_rel_det(param[1]);
          var af$8 = match$8[1];
          var fa$8 = match$8[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$8, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$8, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$8[2],
                  match$8[3]
                ];
      case --[ Format_subst_ty ]--9 :
          var match$9 = fmtty_rel_det(param[2]);
          var de = match$9[3];
          var ed = match$9[2];
          var af$9 = match$9[1];
          var fa$9 = match$9[0];
          var ty = trans(symm(param[0]), param[1]);
          var match$10 = fmtty_rel_det(ty);
          var jd = match$10[3];
          var dj = match$10[2];
          var ga = match$10[1];
          var ag = match$10[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$9, --[ Refl ]--0);
                      Curry._1(ag, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(ga, --[ Refl ]--0);
                      Curry._1(af$9, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(ed, --[ Refl ]--0);
                      Curry._1(dj, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(jd, --[ Refl ]--0);
                      Curry._1(de, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end)
                ];
      case --[ Alpha_ty ]--10 :
          var match$11 = fmtty_rel_det(param[0]);
          var af$10 = match$11[1];
          var fa$10 = match$11[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$10, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$10, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$11[2],
                  match$11[3]
                ];
      case --[ Theta_ty ]--11 :
          var match$12 = fmtty_rel_det(param[0]);
          var af$11 = match$12[1];
          var fa$11 = match$12[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$11, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$11, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$12[2],
                  match$12[3]
                ];
      case --[ Any_ty ]--12 :
          var match$13 = fmtty_rel_det(param[0]);
          var af$12 = match$13[1];
          var fa$12 = match$13[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$12, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$12, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  match$13[2],
                  match$13[3]
                ];
      case --[ Reader_ty ]--13 :
          var match$14 = fmtty_rel_det(param[0]);
          var de$1 = match$14[3];
          var ed$1 = match$14[2];
          var af$13 = match$14[1];
          var fa$13 = match$14[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$13, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$13, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(ed$1, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(de$1, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end)
                ];
      case --[ Ignored_reader_ty ]--14 :
          var match$15 = fmtty_rel_det(param[0]);
          var de$2 = match$15[3];
          var ed$2 = match$15[2];
          var af$14 = match$15[1];
          var fa$14 = match$15[0];
          return --[ tuple ]--[
                  (function (param) do
                      Curry._1(fa$14, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(af$14, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(ed$2, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end),
                  (function (param) do
                      Curry._1(de$2, --[ Refl ]--0);
                      return --[ Refl ]--0;
                    end)
                ];
      
    end
  end end 
end

function trans(ty1, ty2) do
  var exit = 0;
  if (typeof ty1 == "number") then do
    if (typeof ty2 == "number") then do
      return --[ End_of_fmtty ]--0;
    end else do
      switch (ty2.tag | 0) do
        case --[ Format_arg_ty ]--8 :
            exit = 6;
            break;
        case --[ Format_subst_ty ]--9 :
            exit = 7;
            break;
        case --[ Alpha_ty ]--10 :
            exit = 1;
            break;
        case --[ Theta_ty ]--11 :
            exit = 2;
            break;
        case --[ Any_ty ]--12 :
            exit = 3;
            break;
        case --[ Reader_ty ]--13 :
            exit = 4;
            break;
        case --[ Ignored_reader_ty ]--14 :
            exit = 5;
            break;
        default:
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "camlinternalFormat.ml",
                  846,
                  23
                ]
              ];
      end
    end end 
  end else do
    switch (ty1.tag | 0) do
      case --[ Char_ty ]--0 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Char_ty ]--0 :
                  return --[ Char_ty ]--Block.__(0, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ String_ty ]--1 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ String_ty ]--1 :
                  return --[ String_ty ]--Block.__(1, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Int_ty ]--2 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Int_ty ]--2 :
                  return --[ Int_ty ]--Block.__(2, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Int32_ty ]--3 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Int32_ty ]--3 :
                  return --[ Int32_ty ]--Block.__(3, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Nativeint_ty ]--4 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Nativeint_ty ]--4 :
                  return --[ Nativeint_ty ]--Block.__(4, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Int64_ty ]--5 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Int64_ty ]--5 :
                  return --[ Int64_ty ]--Block.__(5, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Float_ty ]--6 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Float_ty ]--6 :
                  return --[ Float_ty ]--Block.__(6, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Bool_ty ]--7 :
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            switch (ty2.tag | 0) do
              case --[ Bool_ty ]--7 :
                  return --[ Bool_ty ]--Block.__(7, [trans(ty1[0], ty2[0])]);
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  exit = 7;
                  break;
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              
            end
          end end 
          break;
      case --[ Format_arg_ty ]--8 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    832,
                    26
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Format_arg_ty ]--8 :
                  return --[ Format_arg_ty ]--Block.__(8, [
                            trans(ty1[0], ty2[0]),
                            trans(ty1[1], ty2[1])
                          ]);
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        832,
                        26
                      ]
                    ];
            end
          end end 
          break;
      case --[ Format_subst_ty ]--9 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    842,
                    28
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Format_arg_ty ]--8 :
                  exit = 6;
                  break;
              case --[ Format_subst_ty ]--9 :
                  var ty = trans(symm(ty1[1]), ty2[0]);
                  var match = fmtty_rel_det(ty);
                  Curry._1(match[1], --[ Refl ]--0);
                  Curry._1(match[3], --[ Refl ]--0);
                  return --[ Format_subst_ty ]--Block.__(9, [
                            ty1[0],
                            ty2[1],
                            trans(ty1[2], ty2[2])
                          ]);
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  exit = 5;
                  break;
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        842,
                        28
                      ]
                    ];
            end
          end end 
          break;
      case --[ Alpha_ty ]--10 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    810,
                    21
                  ]
                ];
          end else if (ty2.tag == --[ Alpha_ty ]--10) then do
            return --[ Alpha_ty ]--Block.__(10, [trans(ty1[0], ty2[0])]);
          end else do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    810,
                    21
                  ]
                ];
          end end  end 
      case --[ Theta_ty ]--11 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    814,
                    21
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  return --[ Theta_ty ]--Block.__(11, [trans(ty1[0], ty2[0])]);
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        814,
                        21
                      ]
                    ];
            end
          end end 
          break;
      case --[ Any_ty ]--12 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    818,
                    19
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  return --[ Any_ty ]--Block.__(12, [trans(ty1[0], ty2[0])]);
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        818,
                        19
                      ]
                    ];
            end
          end end 
          break;
      case --[ Reader_ty ]--13 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    822,
                    22
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  return --[ Reader_ty ]--Block.__(13, [trans(ty1[0], ty2[0])]);
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        822,
                        22
                      ]
                    ];
            end
          end end 
          break;
      case --[ Ignored_reader_ty ]--14 :
          if (typeof ty2 == "number") then do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    827,
                    30
                  ]
                ];
          end else do
            switch (ty2.tag | 0) do
              case --[ Alpha_ty ]--10 :
                  exit = 1;
                  break;
              case --[ Theta_ty ]--11 :
                  exit = 2;
                  break;
              case --[ Any_ty ]--12 :
                  exit = 3;
                  break;
              case --[ Reader_ty ]--13 :
                  exit = 4;
                  break;
              case --[ Ignored_reader_ty ]--14 :
                  return --[ Ignored_reader_ty ]--Block.__(14, [trans(ty1[0], ty2[0])]);
              default:
                throw [
                      Caml_builtin_exceptions.assert_failure,
                      --[ tuple ]--[
                        "camlinternalFormat.ml",
                        827,
                        30
                      ]
                    ];
            end
          end end 
          break;
      
    end
  end end 
  switch (exit) do
    case 1 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                811,
                21
              ]
            ];
    case 2 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                815,
                21
              ]
            ];
    case 3 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                819,
                19
              ]
            ];
    case 4 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                823,
                22
              ]
            ];
    case 5 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                828,
                30
              ]
            ];
    case 6 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                833,
                26
              ]
            ];
    case 7 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                843,
                28
              ]
            ];
    case 8 :
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                847,
                23
              ]
            ];
    
  end
end

function fmtty_of_formatting_gen(formatting_gen) do
  return fmtty_of_fmt(formatting_gen[0][0]);
end

function fmtty_of_fmt(_fmtty) do
  while(true) do
    var fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return --[ End_of_fmtty ]--0;
    end else do
      switch (fmtty.tag | 0) do
        case --[ String ]--2 :
        case --[ Caml_string ]--3 :
            break;
        case --[ Int ]--4 :
            var ty_rest = fmtty_of_fmt(fmtty[3]);
            var prec_ty = fmtty_of_precision_fmtty(fmtty[2], --[ Int_ty ]--Block.__(2, [ty_rest]));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty);
        case --[ Int32 ]--5 :
            var ty_rest$1 = fmtty_of_fmt(fmtty[3]);
            var prec_ty$1 = fmtty_of_precision_fmtty(fmtty[2], --[ Int32_ty ]--Block.__(3, [ty_rest$1]));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$1);
        case --[ Nativeint ]--6 :
            var ty_rest$2 = fmtty_of_fmt(fmtty[3]);
            var prec_ty$2 = fmtty_of_precision_fmtty(fmtty[2], --[ Nativeint_ty ]--Block.__(4, [ty_rest$2]));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$2);
        case --[ Int64 ]--7 :
            var ty_rest$3 = fmtty_of_fmt(fmtty[3]);
            var prec_ty$3 = fmtty_of_precision_fmtty(fmtty[2], --[ Int64_ty ]--Block.__(5, [ty_rest$3]));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$3);
        case --[ Float ]--8 :
            var ty_rest$4 = fmtty_of_fmt(fmtty[3]);
            var prec_ty$4 = fmtty_of_precision_fmtty(fmtty[2], --[ Float_ty ]--Block.__(6, [ty_rest$4]));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$4);
        case --[ Bool ]--9 :
            return fmtty_of_padding_fmtty(fmtty[0], --[ Bool_ty ]--Block.__(7, [fmtty_of_fmt(fmtty[1])]));
        case --[ Flush ]--10 :
            _fmtty = fmtty[0];
            continue ;
        case --[ Format_arg ]--13 :
            return --[ Format_arg_ty ]--Block.__(8, [
                      fmtty[1],
                      fmtty_of_fmt(fmtty[2])
                    ]);
        case --[ Format_subst ]--14 :
            var ty = fmtty[1];
            return --[ Format_subst_ty ]--Block.__(9, [
                      ty,
                      ty,
                      fmtty_of_fmt(fmtty[2])
                    ]);
        case --[ Alpha ]--15 :
            return --[ Alpha_ty ]--Block.__(10, [fmtty_of_fmt(fmtty[0])]);
        case --[ Theta ]--16 :
            return --[ Theta_ty ]--Block.__(11, [fmtty_of_fmt(fmtty[0])]);
        case --[ String_literal ]--11 :
        case --[ Char_literal ]--12 :
        case --[ Formatting_lit ]--17 :
            _fmtty = fmtty[1];
            continue ;
        case --[ Formatting_gen ]--18 :
            return CamlinternalFormatBasics.concat_fmtty(fmtty_of_formatting_gen(fmtty[0]), fmtty_of_fmt(fmtty[1]));
        case --[ Reader ]--19 :
            return --[ Reader_ty ]--Block.__(13, [fmtty_of_fmt(fmtty[0])]);
        case --[ Scan_char_set ]--20 :
            return --[ String_ty ]--Block.__(1, [fmtty_of_fmt(fmtty[2])]);
        case --[ Scan_get_counter ]--21 :
            return --[ Int_ty ]--Block.__(2, [fmtty_of_fmt(fmtty[1])]);
        case --[ Ignored_param ]--23 :
            var ign = fmtty[0];
            var fmt = fmtty[1];
            if (typeof ign == "number") then do
              if (ign == --[ Ignored_reader ]--2) then do
                return --[ Ignored_reader_ty ]--Block.__(14, [fmtty_of_fmt(fmt)]);
              end else do
                return fmtty_of_fmt(fmt);
              end end 
            end else if (ign.tag == --[ Ignored_format_subst ]--9) then do
              return CamlinternalFormatBasics.concat_fmtty(ign[1], fmtty_of_fmt(fmt));
            end else do
              return fmtty_of_fmt(fmt);
            end end  end 
        case --[ Custom ]--24 :
            return fmtty_of_custom(fmtty[0], fmtty_of_fmt(fmtty[2]));
        default:
          return --[ Char_ty ]--Block.__(0, [fmtty_of_fmt(fmtty[0])]);
      end
    end end 
    return fmtty_of_padding_fmtty(fmtty[0], --[ String_ty ]--Block.__(1, [fmtty_of_fmt(fmtty[1])]));
  end;
end

function fmtty_of_custom(arity, fmtty) do
  if (arity) then do
    return --[ Any_ty ]--Block.__(12, [fmtty_of_custom(arity[0], fmtty)]);
  end else do
    return fmtty;
  end end 
end

function fmtty_of_padding_fmtty(pad, fmtty) do
  if (typeof pad == "number" or !pad.tag) then do
    return fmtty;
  end else do
    return --[ Int_ty ]--Block.__(2, [fmtty]);
  end end 
end

function fmtty_of_precision_fmtty(prec, fmtty) do
  if (typeof prec == "number" and prec ~= 0) then do
    return --[ Int_ty ]--Block.__(2, [fmtty]);
  end else do
    return fmtty;
  end end 
end

var Type_mismatch = Caml_exceptions.create("CamlinternalFormat.Type_mismatch");

function type_padding(pad, fmtty) do
  if (typeof pad == "number") then do
    return --[ Padding_fmtty_EBB ]--[
            --[ No_padding ]--0,
            fmtty
          ];
  end else if (pad.tag) then do
    if (typeof fmtty == "number") then do
      throw Type_mismatch;
    end else if (fmtty.tag == --[ Int_ty ]--2) then do
      return --[ Padding_fmtty_EBB ]--[
              --[ Arg_padding ]--Block.__(1, [pad[0]]),
              fmtty[0]
            ];
    end else do
      throw Type_mismatch;
    end end  end 
  end else do
    return --[ Padding_fmtty_EBB ]--[
            --[ Lit_padding ]--Block.__(0, [
                pad[0],
                pad[1]
              ]),
            fmtty
          ];
  end end  end 
end

function type_padprec(pad, prec, fmtty) do
  var match = type_padding(pad, fmtty);
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      var match$1 = match[1];
      if (typeof match$1 == "number") then do
        throw Type_mismatch;
      end else if (match$1.tag == --[ Int_ty ]--2) then do
        return --[ Padprec_fmtty_EBB ]--[
                match[0],
                --[ Arg_precision ]--1,
                match$1[0]
              ];
      end else do
        throw Type_mismatch;
      end end  end 
    end else do
      return --[ Padprec_fmtty_EBB ]--[
              match[0],
              --[ No_precision ]--0,
              match[1]
            ];
    end end 
  end else do
    return --[ Padprec_fmtty_EBB ]--[
            match[0],
            --[ Lit_precision ]--[prec[0]],
            match[1]
          ];
  end end 
end

function type_ignored_format_substitution(sub_fmtty, fmt, fmtty) do
  if (typeof sub_fmtty == "number") then do
    return --[ Fmtty_fmt_EBB ]--[
            --[ End_of_fmtty ]--0,
            type_format_gen(fmt, fmtty)
          ];
  end else do
    switch (sub_fmtty.tag | 0) do
      case --[ Char_ty ]--0 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag) then do
            throw Type_mismatch;
          end else do
            var match = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Char_ty ]--Block.__(0, [match[0]]),
                    match[1]
                  ];
          end end  end 
      case --[ String_ty ]--1 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ String_ty ]--1) then do
            var match$1 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ String_ty ]--Block.__(1, [match$1[0]]),
                    match$1[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int_ty ]--2 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Int_ty ]--2) then do
            var match$2 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Int_ty ]--Block.__(2, [match$2[0]]),
                    match$2[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int32_ty ]--3 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Int32_ty ]--3) then do
            var match$3 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Int32_ty ]--Block.__(3, [match$3[0]]),
                    match$3[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Nativeint_ty ]--4 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Nativeint_ty ]--4) then do
            var match$4 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Nativeint_ty ]--Block.__(4, [match$4[0]]),
                    match$4[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int64_ty ]--5 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Int64_ty ]--5) then do
            var match$5 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Int64_ty ]--Block.__(5, [match$5[0]]),
                    match$5[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Float_ty ]--6 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Float_ty ]--6) then do
            var match$6 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Float_ty ]--Block.__(6, [match$6[0]]),
                    match$6[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Bool_ty ]--7 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Bool_ty ]--7) then do
            var match$7 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Bool_ty ]--Block.__(7, [match$7[0]]),
                    match$7[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Format_arg_ty ]--8 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Format_arg_ty ]--8) then do
            var sub2_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[ Fmtty_EBB ]--[sub_fmtty[0]], --[ Fmtty_EBB ]--[sub2_fmtty$prime])) then do
              throw Type_mismatch;
            end
             end 
            var match$8 = type_ignored_format_substitution(sub_fmtty[1], fmt, fmtty[1]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Format_arg_ty ]--Block.__(8, [
                        sub2_fmtty$prime,
                        match$8[0]
                      ]),
                    match$8[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Format_subst_ty ]--9 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Format_subst_ty ]--9) then do
            var sub2_fmtty$prime$1 = fmtty[1];
            var sub1_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(sub_fmtty[0])], --[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(sub1_fmtty$prime)])) then do
              throw Type_mismatch;
            end
             end 
            if (Caml_obj.caml_notequal(--[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(sub_fmtty[1])], --[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(sub2_fmtty$prime$1)])) then do
              throw Type_mismatch;
            end
             end 
            var sub_fmtty$prime = trans(symm(sub1_fmtty$prime), sub2_fmtty$prime$1);
            var match$9 = fmtty_rel_det(sub_fmtty$prime);
            Curry._1(match$9[1], --[ Refl ]--0);
            Curry._1(match$9[3], --[ Refl ]--0);
            var match$10 = type_ignored_format_substitution(CamlinternalFormatBasics.erase_rel(sub_fmtty[2]), fmt, fmtty[2]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Format_subst_ty ]--Block.__(9, [
                        sub1_fmtty$prime,
                        sub2_fmtty$prime$1,
                        symm(match$10[0])
                      ]),
                    match$10[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Alpha_ty ]--10 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Alpha_ty ]--10) then do
            var match$11 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Alpha_ty ]--Block.__(10, [match$11[0]]),
                    match$11[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Theta_ty ]--11 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Theta_ty ]--11) then do
            var match$12 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Theta_ty ]--Block.__(11, [match$12[0]]),
                    match$12[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Any_ty ]--12 :
          throw Type_mismatch;
      case --[ Reader_ty ]--13 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Reader_ty ]--13) then do
            var match$13 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Reader_ty ]--Block.__(13, [match$13[0]]),
                    match$13[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Ignored_reader_ty ]--14 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Ignored_reader_ty ]--14) then do
            var match$14 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[ Fmtty_fmt_EBB ]--[
                    --[ Ignored_reader_ty ]--Block.__(14, [match$14[0]]),
                    match$14[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      
    end
  end end 
end

function type_format_gen(fmt, fmtty) do
  if (typeof fmt == "number") then do
    return --[ Fmt_fmtty_EBB ]--[
            --[ End_of_format ]--0,
            fmtty
          ];
  end else do
    switch (fmt.tag | 0) do
      case --[ Char ]--0 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag) then do
            throw Type_mismatch;
          end else do
            var match = type_format_gen(fmt[0], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Char ]--Block.__(0, [match[0]]),
                    match[1]
                  ];
          end end  end 
      case --[ Caml_char ]--1 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag) then do
            throw Type_mismatch;
          end else do
            var match$1 = type_format_gen(fmt[0], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Caml_char ]--Block.__(1, [match$1[0]]),
                    match$1[1]
                  ];
          end end  end 
      case --[ String ]--2 :
          var match$2 = type_padding(fmt[0], fmtty);
          var match$3 = match$2[1];
          if (typeof match$3 == "number") then do
            throw Type_mismatch;
          end else if (match$3.tag == --[ String_ty ]--1) then do
            var match$4 = type_format_gen(fmt[1], match$3[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ String ]--Block.__(2, [
                        match$2[0],
                        match$4[0]
                      ]),
                    match$4[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Caml_string ]--3 :
          var match$5 = type_padding(fmt[0], fmtty);
          var match$6 = match$5[1];
          if (typeof match$6 == "number") then do
            throw Type_mismatch;
          end else if (match$6.tag == --[ String_ty ]--1) then do
            var match$7 = type_format_gen(fmt[1], match$6[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Caml_string ]--Block.__(3, [
                        match$5[0],
                        match$7[0]
                      ]),
                    match$7[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int ]--4 :
          var match$8 = type_padprec(fmt[1], fmt[2], fmtty);
          var match$9 = match$8[2];
          if (typeof match$9 == "number") then do
            throw Type_mismatch;
          end else if (match$9.tag == --[ Int_ty ]--2) then do
            var match$10 = type_format_gen(fmt[3], match$9[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Int ]--Block.__(4, [
                        fmt[0],
                        match$8[0],
                        match$8[1],
                        match$10[0]
                      ]),
                    match$10[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int32 ]--5 :
          var match$11 = type_padprec(fmt[1], fmt[2], fmtty);
          var match$12 = match$11[2];
          if (typeof match$12 == "number") then do
            throw Type_mismatch;
          end else if (match$12.tag == --[ Int32_ty ]--3) then do
            var match$13 = type_format_gen(fmt[3], match$12[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Int32 ]--Block.__(5, [
                        fmt[0],
                        match$11[0],
                        match$11[1],
                        match$13[0]
                      ]),
                    match$13[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Nativeint ]--6 :
          var match$14 = type_padprec(fmt[1], fmt[2], fmtty);
          var match$15 = match$14[2];
          if (typeof match$15 == "number") then do
            throw Type_mismatch;
          end else if (match$15.tag == --[ Nativeint_ty ]--4) then do
            var match$16 = type_format_gen(fmt[3], match$15[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Nativeint ]--Block.__(6, [
                        fmt[0],
                        match$14[0],
                        match$14[1],
                        match$16[0]
                      ]),
                    match$16[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Int64 ]--7 :
          var match$17 = type_padprec(fmt[1], fmt[2], fmtty);
          var match$18 = match$17[2];
          if (typeof match$18 == "number") then do
            throw Type_mismatch;
          end else if (match$18.tag == --[ Int64_ty ]--5) then do
            var match$19 = type_format_gen(fmt[3], match$18[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Int64 ]--Block.__(7, [
                        fmt[0],
                        match$17[0],
                        match$17[1],
                        match$19[0]
                      ]),
                    match$19[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Float ]--8 :
          var match$20 = type_padprec(fmt[1], fmt[2], fmtty);
          var match$21 = match$20[2];
          if (typeof match$21 == "number") then do
            throw Type_mismatch;
          end else if (match$21.tag == --[ Float_ty ]--6) then do
            var match$22 = type_format_gen(fmt[3], match$21[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Float ]--Block.__(8, [
                        fmt[0],
                        match$20[0],
                        match$20[1],
                        match$22[0]
                      ]),
                    match$22[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Bool ]--9 :
          var match$23 = type_padding(fmt[0], fmtty);
          var match$24 = match$23[1];
          if (typeof match$24 == "number") then do
            throw Type_mismatch;
          end else if (match$24.tag == --[ Bool_ty ]--7) then do
            var match$25 = type_format_gen(fmt[1], match$24[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Bool ]--Block.__(9, [
                        match$23[0],
                        match$25[0]
                      ]),
                    match$25[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Flush ]--10 :
          var match$26 = type_format_gen(fmt[0], fmtty);
          return --[ Fmt_fmtty_EBB ]--[
                  --[ Flush ]--Block.__(10, [match$26[0]]),
                  match$26[1]
                ];
      case --[ String_literal ]--11 :
          var match$27 = type_format_gen(fmt[1], fmtty);
          return --[ Fmt_fmtty_EBB ]--[
                  --[ String_literal ]--Block.__(11, [
                      fmt[0],
                      match$27[0]
                    ]),
                  match$27[1]
                ];
      case --[ Char_literal ]--12 :
          var match$28 = type_format_gen(fmt[1], fmtty);
          return --[ Fmt_fmtty_EBB ]--[
                  --[ Char_literal ]--Block.__(12, [
                      fmt[0],
                      match$28[0]
                    ]),
                  match$28[1]
                ];
      case --[ Format_arg ]--13 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Format_arg_ty ]--8) then do
            var sub_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[ Fmtty_EBB ]--[fmt[1]], --[ Fmtty_EBB ]--[sub_fmtty$prime])) then do
              throw Type_mismatch;
            end
             end 
            var match$29 = type_format_gen(fmt[2], fmtty[1]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Format_arg ]--Block.__(13, [
                        fmt[0],
                        sub_fmtty$prime,
                        match$29[0]
                      ]),
                    match$29[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Format_subst ]--14 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Format_subst_ty ]--9) then do
            var sub_fmtty1 = fmtty[0];
            if (Caml_obj.caml_notequal(--[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(fmt[1])], --[ Fmtty_EBB ]--[CamlinternalFormatBasics.erase_rel(sub_fmtty1)])) then do
              throw Type_mismatch;
            end
             end 
            var match$30 = type_format_gen(fmt[2], CamlinternalFormatBasics.erase_rel(fmtty[2]));
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Format_subst ]--Block.__(14, [
                        fmt[0],
                        sub_fmtty1,
                        match$30[0]
                      ]),
                    match$30[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Alpha ]--15 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Alpha_ty ]--10) then do
            var match$31 = type_format_gen(fmt[0], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Alpha ]--Block.__(15, [match$31[0]]),
                    match$31[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Theta ]--16 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Theta_ty ]--11) then do
            var match$32 = type_format_gen(fmt[0], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Theta ]--Block.__(16, [match$32[0]]),
                    match$32[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Formatting_lit ]--17 :
          var match$33 = type_format_gen(fmt[1], fmtty);
          return --[ Fmt_fmtty_EBB ]--[
                  --[ Formatting_lit ]--Block.__(17, [
                      fmt[0],
                      match$33[0]
                    ]),
                  match$33[1]
                ];
      case --[ Formatting_gen ]--18 :
          var formatting_gen = fmt[0];
          var fmt0 = fmt[1];
          var fmtty0 = fmtty;
          if (formatting_gen.tag) then do
            var match$34 = formatting_gen[0];
            var match$35 = type_format_gen(match$34[0], fmtty0);
            var match$36 = type_format_gen(fmt0, match$35[1]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Formatting_gen ]--Block.__(18, [
                        --[ Open_box ]--Block.__(1, [--[ Format ]--[
                              match$35[0],
                              match$34[1]
                            ]]),
                        match$36[0]
                      ]),
                    match$36[1]
                  ];
          end else do
            var match$37 = formatting_gen[0];
            var match$38 = type_format_gen(match$37[0], fmtty0);
            var match$39 = type_format_gen(fmt0, match$38[1]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Formatting_gen ]--Block.__(18, [
                        --[ Open_tag ]--Block.__(0, [--[ Format ]--[
                              match$38[0],
                              match$37[1]
                            ]]),
                        match$39[0]
                      ]),
                    match$39[1]
                  ];
          end end 
      case --[ Reader ]--19 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Reader_ty ]--13) then do
            var match$40 = type_format_gen(fmt[0], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Reader ]--Block.__(19, [match$40[0]]),
                    match$40[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Scan_char_set ]--20 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ String_ty ]--1) then do
            var match$41 = type_format_gen(fmt[2], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Scan_char_set ]--Block.__(20, [
                        fmt[0],
                        fmt[1],
                        match$41[0]
                      ]),
                    match$41[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Scan_get_counter ]--21 :
          if (typeof fmtty == "number") then do
            throw Type_mismatch;
          end else if (fmtty.tag == --[ Int_ty ]--2) then do
            var match$42 = type_format_gen(fmt[1], fmtty[0]);
            return --[ Fmt_fmtty_EBB ]--[
                    --[ Scan_get_counter ]--Block.__(21, [
                        fmt[0],
                        match$42[0]
                      ]),
                    match$42[1]
                  ];
          end else do
            throw Type_mismatch;
          end end  end 
      case --[ Ignored_param ]--23 :
          var ign = fmt[0];
          var fmt$1 = fmt[1];
          var fmtty$1 = fmtty;
          if (typeof ign == "number") then do
            if (ign == --[ Ignored_reader ]--2) then do
              if (typeof fmtty$1 == "number") then do
                throw Type_mismatch;
              end else if (fmtty$1.tag == --[ Ignored_reader_ty ]--14) then do
                var match$43 = type_format_gen(fmt$1, fmtty$1[0]);
                return --[ Fmt_fmtty_EBB ]--[
                        --[ Ignored_param ]--Block.__(23, [
                            --[ Ignored_reader ]--2,
                            match$43[0]
                          ]),
                        match$43[1]
                      ];
              end else do
                throw Type_mismatch;
              end end  end 
            end else do
              return type_ignored_param_one(ign, fmt$1, fmtty$1);
            end end 
          end else do
            switch (ign.tag | 0) do
              case --[ Ignored_format_arg ]--8 :
                  return type_ignored_param_one(--[ Ignored_format_arg ]--Block.__(8, [
                                ign[0],
                                ign[1]
                              ]), fmt$1, fmtty$1);
              case --[ Ignored_format_subst ]--9 :
                  var match$44 = type_ignored_format_substitution(ign[1], fmt$1, fmtty$1);
                  var match$45 = match$44[1];
                  return --[ Fmt_fmtty_EBB ]--[
                          --[ Ignored_param ]--Block.__(23, [
                              --[ Ignored_format_subst ]--Block.__(9, [
                                  ign[0],
                                  match$44[0]
                                ]),
                              match$45[0]
                            ]),
                          match$45[1]
                        ];
              default:
                return type_ignored_param_one(ign, fmt$1, fmtty$1);
            end
          end end 
      case --[ Scan_next_char ]--22 :
      case --[ Custom ]--24 :
          throw Type_mismatch;
      
    end
  end end 
end

function type_ignored_param_one(ign, fmt, fmtty) do
  var match = type_format_gen(fmt, fmtty);
  return --[ Fmt_fmtty_EBB ]--[
          --[ Ignored_param ]--Block.__(23, [
              ign,
              match[0]
            ]),
          match[1]
        ];
end

function type_format(fmt, fmtty) do
  var match = type_format_gen(fmt, fmtty);
  if (typeof match[1] == "number") then do
    return match[0];
  end else do
    throw Type_mismatch;
  end end 
end

function recast(fmt, fmtty) do
  return type_format(fmt, CamlinternalFormatBasics.erase_rel(symm(fmtty)));
end

function fix_padding(padty, width, str) do
  var len = #str;
  var width$1 = Pervasives.abs(width);
  var padty$1 = width < 0 ? --[ Left ]--0 : padty;
  if (width$1 <= len) then do
    return str;
  end else do
    var res = Bytes.make(width$1, padty$1 == --[ Zeros ]--2 ? --[ "0" ]--48 : --[ " " ]--32);
    switch (padty$1) do
      case --[ Left ]--0 :
          $$String.blit(str, 0, res, 0, len);
          break;
      case --[ Right ]--1 :
          $$String.blit(str, 0, res, width$1 - len | 0, len);
          break;
      case --[ Zeros ]--2 :
          if (len > 0 and (Caml_string.get(str, 0) == --[ "+" ]--43 or Caml_string.get(str, 0) == --[ "-" ]--45 or Caml_string.get(str, 0) == --[ " " ]--32)) then do
            res[0] = Caml_string.get(str, 0);
            $$String.blit(str, 1, res, (width$1 - len | 0) + 1 | 0, len - 1 | 0);
          end else if (len > 1 and Caml_string.get(str, 0) == --[ "0" ]--48 and (Caml_string.get(str, 1) == --[ "x" ]--120 or Caml_string.get(str, 1) == --[ "X" ]--88)) then do
            res[1] = Caml_string.get(str, 1);
            $$String.blit(str, 2, res, (width$1 - len | 0) + 2 | 0, len - 2 | 0);
          end else do
            $$String.blit(str, 0, res, width$1 - len | 0, len);
          end end  end 
          break;
      
    end
    return Caml_bytes.bytes_to_string(res);
  end end 
end

function fix_int_precision(prec, str) do
  var prec$1 = Pervasives.abs(prec);
  var len = #str;
  var c = Caml_string.get(str, 0);
  var exit = 0;
  if (c >= 58) then do
    if (c >= 71) then do
      if (c > 102 or c < 97) then do
        return str;
      end else do
        exit = 2;
      end end 
    end else if (c >= 65) then do
      exit = 2;
    end else do
      return str;
    end end  end 
  end else if (c ~= 32) then do
    if (c >= 43) then do
      switch (c - 43 | 0) do
        case 0 :
        case 2 :
            exit = 1;
            break;
        case 1 :
        case 3 :
        case 4 :
            return str;
        case 5 :
            if ((prec$1 + 2 | 0) > len and len > 1 and (Caml_string.get(str, 1) == --[ "x" ]--120 or Caml_string.get(str, 1) == --[ "X" ]--88)) then do
              var res = Bytes.make(prec$1 + 2 | 0, --[ "0" ]--48);
              res[1] = Caml_string.get(str, 1);
              $$String.blit(str, 2, res, (prec$1 - len | 0) + 4 | 0, len - 2 | 0);
              return Caml_bytes.bytes_to_string(res);
            end else do
              exit = 2;
            end end 
            break;
        case 6 :
        case 7 :
        case 8 :
        case 9 :
        case 10 :
        case 11 :
        case 12 :
        case 13 :
        case 14 :
            exit = 2;
            break;
        
      end
    end else do
      return str;
    end end 
  end else do
    exit = 1;
  end end  end 
  switch (exit) do
    case 1 :
        if ((prec$1 + 1 | 0) > len) then do
          var res$1 = Bytes.make(prec$1 + 1 | 0, --[ "0" ]--48);
          res$1[0] = c;
          $$String.blit(str, 1, res$1, (prec$1 - len | 0) + 2 | 0, len - 1 | 0);
          return Caml_bytes.bytes_to_string(res$1);
        end else do
          return str;
        end end 
    case 2 :
        if (prec$1 > len) then do
          var res$2 = Bytes.make(prec$1, --[ "0" ]--48);
          $$String.blit(str, 0, res$2, prec$1 - len | 0, len);
          return Caml_bytes.bytes_to_string(res$2);
        end else do
          return str;
        end end 
    
  end
end

function string_to_caml_string(str) do
  var str$1 = $$String.escaped(str);
  var l = #str$1;
  var res = Bytes.make(l + 2 | 0, --[ "\"" ]--34);
  Caml_bytes.caml_blit_string(str$1, 0, res, 1, l);
  return Caml_bytes.bytes_to_string(res);
end

function format_of_iconv(param) do
  switch (param) do
    case --[ Int_d ]--0 :
        return "%d";
    case --[ Int_pd ]--1 :
        return "%+d";
    case --[ Int_sd ]--2 :
        return "% d";
    case --[ Int_i ]--3 :
        return "%i";
    case --[ Int_pi ]--4 :
        return "%+i";
    case --[ Int_si ]--5 :
        return "% i";
    case --[ Int_x ]--6 :
        return "%x";
    case --[ Int_Cx ]--7 :
        return "%#x";
    case --[ Int_X ]--8 :
        return "%X";
    case --[ Int_CX ]--9 :
        return "%#X";
    case --[ Int_o ]--10 :
        return "%o";
    case --[ Int_Co ]--11 :
        return "%#o";
    case --[ Int_u ]--12 :
        return "%u";
    
  end
end

function format_of_iconvL(param) do
  switch (param) do
    case --[ Int_d ]--0 :
        return "%Ld";
    case --[ Int_pd ]--1 :
        return "%+Ld";
    case --[ Int_sd ]--2 :
        return "% Ld";
    case --[ Int_i ]--3 :
        return "%Li";
    case --[ Int_pi ]--4 :
        return "%+Li";
    case --[ Int_si ]--5 :
        return "% Li";
    case --[ Int_x ]--6 :
        return "%Lx";
    case --[ Int_Cx ]--7 :
        return "%#Lx";
    case --[ Int_X ]--8 :
        return "%LX";
    case --[ Int_CX ]--9 :
        return "%#LX";
    case --[ Int_o ]--10 :
        return "%Lo";
    case --[ Int_Co ]--11 :
        return "%#Lo";
    case --[ Int_u ]--12 :
        return "%Lu";
    
  end
end

function format_of_iconvl(param) do
  switch (param) do
    case --[ Int_d ]--0 :
        return "%ld";
    case --[ Int_pd ]--1 :
        return "%+ld";
    case --[ Int_sd ]--2 :
        return "% ld";
    case --[ Int_i ]--3 :
        return "%li";
    case --[ Int_pi ]--4 :
        return "%+li";
    case --[ Int_si ]--5 :
        return "% li";
    case --[ Int_x ]--6 :
        return "%lx";
    case --[ Int_Cx ]--7 :
        return "%#lx";
    case --[ Int_X ]--8 :
        return "%lX";
    case --[ Int_CX ]--9 :
        return "%#lX";
    case --[ Int_o ]--10 :
        return "%lo";
    case --[ Int_Co ]--11 :
        return "%#lo";
    case --[ Int_u ]--12 :
        return "%lu";
    
  end
end

function format_of_iconvn(param) do
  switch (param) do
    case --[ Int_d ]--0 :
        return "%nd";
    case --[ Int_pd ]--1 :
        return "%+nd";
    case --[ Int_sd ]--2 :
        return "% nd";
    case --[ Int_i ]--3 :
        return "%ni";
    case --[ Int_pi ]--4 :
        return "%+ni";
    case --[ Int_si ]--5 :
        return "% ni";
    case --[ Int_x ]--6 :
        return "%nx";
    case --[ Int_Cx ]--7 :
        return "%#nx";
    case --[ Int_X ]--8 :
        return "%nX";
    case --[ Int_CX ]--9 :
        return "%#nX";
    case --[ Int_o ]--10 :
        return "%no";
    case --[ Int_Co ]--11 :
        return "%#no";
    case --[ Int_u ]--12 :
        return "%nu";
    
  end
end

function format_of_fconv(fconv, prec) do
  if (fconv == --[ Float_F ]--15) then do
    return "%.12g";
  end else do
    var prec$1 = Pervasives.abs(prec);
    var symb = char_of_fconv(fconv);
    var buf = do
      ind: 0,
      bytes: Caml_bytes.caml_create_bytes(16)
    end;
    buffer_add_char(buf, --[ "%" ]--37);
    bprint_fconv_flag(buf, fconv);
    buffer_add_char(buf, --[ "." ]--46);
    buffer_add_string(buf, String(prec$1));
    buffer_add_char(buf, symb);
    return buffer_contents(buf);
  end end 
end

function convert_int(iconv, n) do
  return Caml_format.caml_format_int(format_of_iconv(iconv), n);
end

function convert_int32(iconv, n) do
  return Caml_format.caml_int32_format(format_of_iconvl(iconv), n);
end

function convert_nativeint(iconv, n) do
  return Caml_format.caml_nativeint_format(format_of_iconvn(iconv), n);
end

function convert_int64(iconv, n) do
  return Caml_format.caml_int64_format(format_of_iconvL(iconv), n);
end

function convert_float(fconv, prec, x) do
  if (fconv >= 16) then do
    var sign;
    if (fconv >= 17) then do
      switch (fconv - 17 | 0) do
        case --[ Float_sf ]--2 :
            sign = --[ "-" ]--45;
            break;
        case --[ Float_f ]--0 :
        case --[ Float_e ]--3 :
            sign = --[ "+" ]--43;
            break;
        case --[ Float_pf ]--1 :
        case --[ Float_pe ]--4 :
            sign = --[ " " ]--32;
            break;
        
      end
    end else do
      sign = --[ "-" ]--45;
    end end 
    var str = Caml_format.caml_hexstring_of_float(x, prec, sign);
    if (fconv >= 19) then do
      return Caml_bytes.bytes_to_string(Bytes.uppercase_ascii(Caml_bytes.bytes_of_string(str)));
    end else do
      return str;
    end end 
  end else do
    var str$1 = Caml_format.caml_format_float(format_of_fconv(fconv, prec), x);
    if (fconv ~= --[ Float_F ]--15) then do
      return str$1;
    end else do
      var len = #str$1;
      var is_valid = function (_i) do
        while(true) do
          var i = _i;
          if (i == len) then do
            return false;
          end else do
            var match = Caml_string.get(str$1, i);
            var switcher = match - 46 | 0;
            if (switcher > 23 or switcher < 0) then do
              if (switcher ~= 55) then do
                _i = i + 1 | 0;
                continue ;
              end else do
                return true;
              end end 
            end else if (switcher > 22 or switcher < 1) then do
              return true;
            end else do
              _i = i + 1 | 0;
              continue ;
            end end  end 
          end end 
        end;
      end;
      var match = Pervasives.classify_float(x);
      if (match ~= 3) then do
        if (match >= 4) then do
          return "nan";
        end else if (is_valid(0)) then do
          return str$1;
        end else do
          return str$1 .. ".";
        end end  end 
      end else if (x < 0.0) then do
        return "neg_infinity";
      end else do
        return "infinity";
      end end  end 
    end end 
  end end 
end

function format_caml_char(c) do
  var str = Char.escaped(c);
  var l = #str;
  var res = Bytes.make(l + 2 | 0, --[ "'" ]--39);
  Caml_bytes.caml_blit_string(str, 0, res, 1, l);
  return Caml_bytes.bytes_to_string(res);
end

function string_of_fmtty(fmtty) do
  var buf = do
    ind: 0,
    bytes: Caml_bytes.caml_create_bytes(16)
  end;
  bprint_fmtty(buf, fmtty);
  return buffer_contents(buf);
end

function make_printf(_k, o, _acc, _fmt) do
  while(true) do
    var fmt = _fmt;
    var acc = _acc;
    var k = _k;
    if (typeof fmt == "number") then do
      return Curry._2(k, o, acc);
    end else do
      switch (fmt.tag | 0) do
        case --[ Char ]--0 :
            var rest = fmt[0];
            return (function(k,acc,rest)do
            return function (c) do
              var new_acc = --[ Acc_data_char ]--Block.__(5, [
                  acc,
                  c
                ]);
              return make_printf(k, o, new_acc, rest);
            end
            end(k,acc,rest));
        case --[ Caml_char ]--1 :
            var rest$1 = fmt[0];
            return (function(k,acc,rest$1)do
            return function (c) do
              var new_acc_001 = format_caml_char(c);
              var new_acc = --[ Acc_data_string ]--Block.__(4, [
                  acc,
                  new_acc_001
                ]);
              return make_printf(k, o, new_acc, rest$1);
            end
            end(k,acc,rest$1));
        case --[ String ]--2 :
            return make_padding(k, o, acc, fmt[1], fmt[0], (function (str) do
                          return str;
                        end));
        case --[ Caml_string ]--3 :
            return make_padding(k, o, acc, fmt[1], fmt[0], string_to_caml_string);
        case --[ Int ]--4 :
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int, fmt[0]);
        case --[ Int32 ]--5 :
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int32, fmt[0]);
        case --[ Nativeint ]--6 :
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_nativeint, fmt[0]);
        case --[ Int64 ]--7 :
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int64, fmt[0]);
        case --[ Float ]--8 :
            var k$1 = k;
            var o$1 = o;
            var acc$1 = acc;
            var fmt$1 = fmt[3];
            var pad = fmt[1];
            var prec = fmt[2];
            var fconv = fmt[0];
            if (typeof pad == "number") then do
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv)do
                  return function (p, x) do
                    var str = convert_float(fconv, p, x);
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv)do
                  return function (x) do
                    var str = convert_float(fconv, -6, x);
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv));
                end end 
              end else do
                var p = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,p)do
                return function (x) do
                  var str = convert_float(fconv, p, x);
                  return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                acc$1,
                                str
                              ]), fmt$1);
                end
                end(k$1,o$1,acc$1,fmt$1,fconv,p));
              end end 
            end else if (pad.tag) then do
              var padty = pad[0];
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty)do
                  return function (w, p, x) do
                    var str = fix_padding(padty, w, convert_float(fconv, p, x));
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty)do
                  return function (w, x) do
                    var str = convert_float(fconv, -6, x);
                    var str$prime = fix_padding(padty, w, str);
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str$prime
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty));
                end end 
              end else do
                var p$1 = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,padty,p$1)do
                return function (w, x) do
                  var str = fix_padding(padty, w, convert_float(fconv, p$1, x));
                  return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                acc$1,
                                str
                              ]), fmt$1);
                end
                end(k$1,o$1,acc$1,fmt$1,fconv,padty,p$1));
              end end 
            end else do
              var w = pad[1];
              var padty$1 = pad[0];
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w)do
                  return function (p, x) do
                    var str = fix_padding(padty$1, w, convert_float(fconv, p, x));
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w)do
                  return function (x) do
                    var str = convert_float(fconv, -6, x);
                    var str$prime = fix_padding(padty$1, w, str);
                    return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                  acc$1,
                                  str$prime
                                ]), fmt$1);
                  end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w));
                end end 
              end else do
                var p$2 = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w,p$2)do
                return function (x) do
                  var str = fix_padding(padty$1, w, convert_float(fconv, p$2, x));
                  return make_printf(k$1, o$1, --[ Acc_data_string ]--Block.__(4, [
                                acc$1,
                                str
                              ]), fmt$1);
                end
                end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w,p$2));
              end end 
            end end  end 
        case --[ Bool ]--9 :
            return make_padding(k, o, acc, fmt[1], fmt[0], Pervasives.string_of_bool);
        case --[ Flush ]--10 :
            _fmt = fmt[0];
            _acc = --[ Acc_flush ]--Block.__(7, [acc]);
            continue ;
        case --[ String_literal ]--11 :
            _fmt = fmt[1];
            _acc = --[ Acc_string_literal ]--Block.__(2, [
                acc,
                fmt[0]
              ]);
            continue ;
        case --[ Char_literal ]--12 :
            _fmt = fmt[1];
            _acc = --[ Acc_char_literal ]--Block.__(3, [
                acc,
                fmt[0]
              ]);
            continue ;
        case --[ Format_arg ]--13 :
            var rest$2 = fmt[2];
            var ty = string_of_fmtty(fmt[1]);
            return (function(k,acc,rest$2,ty)do
            return function (str) do
              return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                            acc,
                            ty
                          ]), rest$2);
            end
            end(k,acc,rest$2,ty));
        case --[ Format_subst ]--14 :
            var rest$3 = fmt[2];
            var fmtty = fmt[1];
            return (function(k,acc,fmtty,rest$3)do
            return function (param) do
              return make_printf(k, o, acc, CamlinternalFormatBasics.concat_fmt(recast(param[0], fmtty), rest$3));
            end
            end(k,acc,fmtty,rest$3));
        case --[ Alpha ]--15 :
            var rest$4 = fmt[0];
            return (function(k,acc,rest$4)do
            return function (f, x) do
              return make_printf(k, o, --[ Acc_delay ]--Block.__(6, [
                            acc,
                            (function (o) do
                                return Curry._2(f, o, x);
                              end)
                          ]), rest$4);
            end
            end(k,acc,rest$4));
        case --[ Theta ]--16 :
            var rest$5 = fmt[0];
            return (function(k,acc,rest$5)do
            return function (f) do
              return make_printf(k, o, --[ Acc_delay ]--Block.__(6, [
                            acc,
                            f
                          ]), rest$5);
            end
            end(k,acc,rest$5));
        case --[ Formatting_lit ]--17 :
            _fmt = fmt[1];
            _acc = --[ Acc_formatting_lit ]--Block.__(0, [
                acc,
                fmt[0]
              ]);
            continue ;
        case --[ Formatting_gen ]--18 :
            var match = fmt[0];
            if (match.tag) then do
              var rest$6 = fmt[1];
              var k$prime = (function(k,acc,rest$6)do
              return function k$prime(koc, kacc) do
                return make_printf(k, koc, --[ Acc_formatting_gen ]--Block.__(1, [
                              acc,
                              --[ Acc_open_box ]--Block.__(1, [kacc])
                            ]), rest$6);
              end
              end(k,acc,rest$6));
              _fmt = match[0][0];
              _acc = --[ End_of_acc ]--0;
              _k = k$prime;
              continue ;
            end else do
              var rest$7 = fmt[1];
              var k$prime$1 = (function(k,acc,rest$7)do
              return function k$prime$1(koc, kacc) do
                return make_printf(k, koc, --[ Acc_formatting_gen ]--Block.__(1, [
                              acc,
                              --[ Acc_open_tag ]--Block.__(0, [kacc])
                            ]), rest$7);
              end
              end(k,acc,rest$7));
              _fmt = match[0][0];
              _acc = --[ End_of_acc ]--0;
              _k = k$prime$1;
              continue ;
            end end 
        case --[ Reader ]--19 :
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    1525,
                    4
                  ]
                ];
        case --[ Scan_char_set ]--20 :
            var rest$8 = fmt[2];
            var new_acc = --[ Acc_invalid_arg ]--Block.__(8, [
                acc,
                "Printf: bad conversion %["
              ]);
            return (function(k,rest$8,new_acc)do
            return function (param) do
              return make_printf(k, o, new_acc, rest$8);
            end
            end(k,rest$8,new_acc));
        case --[ Scan_get_counter ]--21 :
            var rest$9 = fmt[1];
            return (function(k,acc,rest$9)do
            return function (n) do
              var new_acc_001 = Caml_format.caml_format_int("%u", n);
              var new_acc = --[ Acc_data_string ]--Block.__(4, [
                  acc,
                  new_acc_001
                ]);
              return make_printf(k, o, new_acc, rest$9);
            end
            end(k,acc,rest$9));
        case --[ Scan_next_char ]--22 :
            var rest$10 = fmt[0];
            return (function(k,acc,rest$10)do
            return function (c) do
              var new_acc = --[ Acc_data_char ]--Block.__(5, [
                  acc,
                  c
                ]);
              return make_printf(k, o, new_acc, rest$10);
            end
            end(k,acc,rest$10));
        case --[ Ignored_param ]--23 :
            return make_ignored_param(k, o, acc, fmt[0], fmt[1]);
        case --[ Custom ]--24 :
            return make_custom(k, o, acc, fmt[2], fmt[0], Curry._1(fmt[1], --[ () ]--0));
        
      end
    end end 
  end;
end

function make_ignored_param(k, o, acc, ign, fmt) do
  if (typeof ign == "number") then do
    if (ign == --[ Ignored_reader ]--2) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "camlinternalFormat.ml",
              1593,
              39
            ]
          ];
    end else do
      return make_invalid_arg(k, o, acc, fmt);
    end end 
  end else if (ign.tag == --[ Ignored_format_subst ]--9) then do
    return make_from_fmtty(k, o, acc, ign[1], fmt);
  end else do
    return make_invalid_arg(k, o, acc, fmt);
  end end  end 
end

function make_from_fmtty(k, o, acc, fmtty, fmt) do
  if (typeof fmtty == "number") then do
    return make_invalid_arg(k, o, acc, fmt);
  end else do
    switch (fmtty.tag | 0) do
      case --[ Char_ty ]--0 :
          var rest = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest, fmt);
            end);
      case --[ String_ty ]--1 :
          var rest$1 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$1, fmt);
            end);
      case --[ Int_ty ]--2 :
          var rest$2 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$2, fmt);
            end);
      case --[ Int32_ty ]--3 :
          var rest$3 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$3, fmt);
            end);
      case --[ Nativeint_ty ]--4 :
          var rest$4 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$4, fmt);
            end);
      case --[ Int64_ty ]--5 :
          var rest$5 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$5, fmt);
            end);
      case --[ Float_ty ]--6 :
          var rest$6 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$6, fmt);
            end);
      case --[ Bool_ty ]--7 :
          var rest$7 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$7, fmt);
            end);
      case --[ Format_arg_ty ]--8 :
          var rest$8 = fmtty[1];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$8, fmt);
            end);
      case --[ Format_subst_ty ]--9 :
          var rest$9 = fmtty[2];
          var ty = trans(symm(fmtty[0]), fmtty[1]);
          return (function (param) do
              return make_from_fmtty(k, o, acc, CamlinternalFormatBasics.concat_fmtty(ty, rest$9), fmt);
            end);
      case --[ Alpha_ty ]--10 :
          var rest$10 = fmtty[0];
          return (function (param, param$1) do
              return make_from_fmtty(k, o, acc, rest$10, fmt);
            end);
      case --[ Theta_ty ]--11 :
          var rest$11 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$11, fmt);
            end);
      case --[ Any_ty ]--12 :
          var rest$12 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$12, fmt);
            end);
      case --[ Reader_ty ]--13 :
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "camlinternalFormat.ml",
                  1616,
                  31
                ]
              ];
      case --[ Ignored_reader_ty ]--14 :
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "camlinternalFormat.ml",
                  1617,
                  31
                ]
              ];
      
    end
  end end 
end

function make_invalid_arg(k, o, acc, fmt) do
  return make_printf(k, o, --[ Acc_invalid_arg ]--Block.__(8, [
                acc,
                "Printf: bad conversion %_"
              ]), fmt);
end

function make_padding(k, o, acc, fmt, pad, trans) do
  if (typeof pad == "number") then do
    return (function (x) do
        var new_acc_001 = Curry._1(trans, x);
        var new_acc = --[ Acc_data_string ]--Block.__(4, [
            acc,
            new_acc_001
          ]);
        return make_printf(k, o, new_acc, fmt);
      end);
  end else if (pad.tag) then do
    var padty = pad[0];
    return (function (w, x) do
        var new_acc_001 = fix_padding(padty, w, Curry._1(trans, x));
        var new_acc = --[ Acc_data_string ]--Block.__(4, [
            acc,
            new_acc_001
          ]);
        return make_printf(k, o, new_acc, fmt);
      end);
  end else do
    var width = pad[1];
    var padty$1 = pad[0];
    return (function (x) do
        var new_acc_001 = fix_padding(padty$1, width, Curry._1(trans, x));
        var new_acc = --[ Acc_data_string ]--Block.__(4, [
            acc,
            new_acc_001
          ]);
        return make_printf(k, o, new_acc, fmt);
      end);
  end end  end 
end

function make_int_padding_precision(k, o, acc, fmt, pad, prec, trans, iconv) do
  if (typeof pad == "number") then do
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (p, x) do
            var str = fix_int_precision(p, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end else do
        return (function (x) do
            var str = Curry._2(trans, iconv, x);
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end end 
    end else do
      var p = prec[0];
      return (function (x) do
          var str = fix_int_precision(p, Curry._2(trans, iconv, x));
          return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                        acc,
                        str
                      ]), fmt);
        end);
    end end 
  end else if (pad.tag) then do
    var padty = pad[0];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (w, p, x) do
            var str = fix_padding(padty, w, fix_int_precision(p, Curry._2(trans, iconv, x)));
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end else do
        return (function (w, x) do
            var str = fix_padding(padty, w, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end end 
    end else do
      var p$1 = prec[0];
      return (function (w, x) do
          var str = fix_padding(padty, w, fix_int_precision(p$1, Curry._2(trans, iconv, x)));
          return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                        acc,
                        str
                      ]), fmt);
        end);
    end end 
  end else do
    var w = pad[1];
    var padty$1 = pad[0];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (p, x) do
            var str = fix_padding(padty$1, w, fix_int_precision(p, Curry._2(trans, iconv, x)));
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end else do
        return (function (x) do
            var str = fix_padding(padty$1, w, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                          acc,
                          str
                        ]), fmt);
          end);
      end end 
    end else do
      var p$2 = prec[0];
      return (function (x) do
          var str = fix_padding(padty$1, w, fix_int_precision(p$2, Curry._2(trans, iconv, x)));
          return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                        acc,
                        str
                      ]), fmt);
        end);
    end end 
  end end  end 
end

function make_custom(k, o, acc, rest, arity, f) do
  if (arity) then do
    var arity$1 = arity[0];
    return (function (x) do
        return make_custom(k, o, acc, rest, arity$1, Curry._1(f, x));
      end);
  end else do
    return make_printf(k, o, --[ Acc_data_string ]--Block.__(4, [
                  acc,
                  f
                ]), rest);
  end end 
end

function make_iprintf(_k, o, _fmt) do
  while(true) do
    var fmt = _fmt;
    var k = _k;
    var exit = 0;
    if (typeof fmt == "number") then do
      return Curry._1(k, o);
    end else do
      switch (fmt.tag | 0) do
        case --[ String ]--2 :
            var tmp = fmt[0];
            if (typeof tmp ~= "number" and tmp.tag) then do
              var partial_arg = make_iprintf(k, o, fmt[1]);
              var partial_arg$1 = (function(partial_arg)do
              return function partial_arg$1(param) do
                return partial_arg;
              end
              end(partial_arg));
              return (function (param) do
                  return partial_arg$1;
                end);
            end
             end 
            var partial_arg$2 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$2)do
            return function (param) do
              return partial_arg$2;
            end
            end(partial_arg$2));
        case --[ Caml_string ]--3 :
            var tmp$1 = fmt[0];
            if (typeof tmp$1 ~= "number" and tmp$1.tag) then do
              var partial_arg$3 = make_iprintf(k, o, fmt[1]);
              var partial_arg$4 = (function(partial_arg$3)do
              return function partial_arg$4(param) do
                return partial_arg$3;
              end
              end(partial_arg$3));
              return (function (param) do
                  return partial_arg$4;
                end);
            end
             end 
            var partial_arg$5 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$5)do
            return function (param) do
              return partial_arg$5;
            end
            end(partial_arg$5));
        case --[ Bool ]--9 :
            var tmp$2 = fmt[0];
            if (typeof tmp$2 ~= "number" and tmp$2.tag) then do
              var partial_arg$6 = make_iprintf(k, o, fmt[1]);
              var partial_arg$7 = (function(partial_arg$6)do
              return function partial_arg$7(param) do
                return partial_arg$6;
              end
              end(partial_arg$6));
              return (function (param) do
                  return partial_arg$7;
                end);
            end
             end 
            var partial_arg$8 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$8)do
            return function (param) do
              return partial_arg$8;
            end
            end(partial_arg$8));
        case --[ Flush ]--10 :
            _fmt = fmt[0];
            continue ;
        case --[ Format_subst ]--14 :
            var rest = fmt[2];
            var fmtty = fmt[1];
            return (function(k,fmtty,rest)do
            return function (param) do
              return make_iprintf(k, o, CamlinternalFormatBasics.concat_fmt(recast(param[0], fmtty), rest));
            end
            end(k,fmtty,rest));
        case --[ Alpha ]--15 :
            var partial_arg$9 = make_iprintf(k, o, fmt[0]);
            var partial_arg$10 = (function(partial_arg$9)do
            return function partial_arg$10(param) do
              return partial_arg$9;
            end
            end(partial_arg$9));
            return (function (param) do
                return partial_arg$10;
              end);
        case --[ String_literal ]--11 :
        case --[ Char_literal ]--12 :
        case --[ Formatting_lit ]--17 :
            exit = 2;
            break;
        case --[ Formatting_gen ]--18 :
            var match = fmt[0];
            if (match.tag) then do
              var rest$1 = fmt[1];
              _fmt = match[0][0];
              _k = (function(k,rest$1)do
              return function (koc) do
                return make_iprintf(k, koc, rest$1);
              end
              end(k,rest$1));
              continue ;
            end else do
              var rest$2 = fmt[1];
              _fmt = match[0][0];
              _k = (function(k,rest$2)do
              return function (koc) do
                return make_iprintf(k, koc, rest$2);
              end
              end(k,rest$2));
              continue ;
            end end 
        case --[ Reader ]--19 :
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    1797,
                    8
                  ]
                ];
        case --[ Format_arg ]--13 :
        case --[ Scan_char_set ]--20 :
            exit = 3;
            break;
        case --[ Scan_get_counter ]--21 :
            var partial_arg$11 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$11)do
            return function (param) do
              return partial_arg$11;
            end
            end(partial_arg$11));
        case --[ Char ]--0 :
        case --[ Caml_char ]--1 :
        case --[ Theta ]--16 :
        case --[ Scan_next_char ]--22 :
            exit = 1;
            break;
        case --[ Ignored_param ]--23 :
            return make_ignored_param((function(k)do
                      return function (x, param) do
                        return Curry._1(k, x);
                      end
                      end(k)), o, --[ End_of_acc ]--0, fmt[0], fmt[1]);
        case --[ Custom ]--24 :
            return fn_of_custom_arity(k, o, fmt[2], fmt[0]);
        default:
          var k$1 = k;
          var o$1 = o;
          var fmt$1 = fmt[3];
          var pad = fmt[1];
          var prec = fmt[2];
          if (typeof pad == "number") then do
            if (typeof prec == "number") then do
              if (prec ~= 0) then do
                var partial_arg$12 = make_iprintf(k$1, o$1, fmt$1);
                var partial_arg$13 = (function(partial_arg$12)do
                return function partial_arg$13(param) do
                  return partial_arg$12;
                end
                end(partial_arg$12));
                return (function (param) do
                    return partial_arg$13;
                  end);
              end else do
                var partial_arg$14 = make_iprintf(k$1, o$1, fmt$1);
                return (function(partial_arg$14)do
                return function (param) do
                  return partial_arg$14;
                end
                end(partial_arg$14));
              end end 
            end else do
              var partial_arg$15 = make_iprintf(k$1, o$1, fmt$1);
              return (function(partial_arg$15)do
              return function (param) do
                return partial_arg$15;
              end
              end(partial_arg$15));
            end end 
          end else if (pad.tag) then do
            if (typeof prec == "number") then do
              if (prec ~= 0) then do
                var partial_arg$16 = make_iprintf(k$1, o$1, fmt$1);
                var partial_arg$17 = (function(partial_arg$16)do
                return function partial_arg$17(param) do
                  return partial_arg$16;
                end
                end(partial_arg$16));
                var partial_arg$18 = function (param) do
                  return partial_arg$17;
                end;
                return (function (param) do
                    return partial_arg$18;
                  end);
              end else do
                var partial_arg$19 = make_iprintf(k$1, o$1, fmt$1);
                var partial_arg$20 = (function(partial_arg$19)do
                return function partial_arg$20(param) do
                  return partial_arg$19;
                end
                end(partial_arg$19));
                return (function (param) do
                    return partial_arg$20;
                  end);
              end end 
            end else do
              var partial_arg$21 = make_iprintf(k$1, o$1, fmt$1);
              var partial_arg$22 = (function(partial_arg$21)do
              return function partial_arg$22(param) do
                return partial_arg$21;
              end
              end(partial_arg$21));
              return (function (param) do
                  return partial_arg$22;
                end);
            end end 
          end else if (typeof prec == "number") then do
            if (prec ~= 0) then do
              var partial_arg$23 = make_iprintf(k$1, o$1, fmt$1);
              var partial_arg$24 = (function(partial_arg$23)do
              return function partial_arg$24(param) do
                return partial_arg$23;
              end
              end(partial_arg$23));
              return (function (param) do
                  return partial_arg$24;
                end);
            end else do
              var partial_arg$25 = make_iprintf(k$1, o$1, fmt$1);
              return (function(partial_arg$25)do
              return function (param) do
                return partial_arg$25;
              end
              end(partial_arg$25));
            end end 
          end else do
            var partial_arg$26 = make_iprintf(k$1, o$1, fmt$1);
            return (function(partial_arg$26)do
            return function (param) do
              return partial_arg$26;
            end
            end(partial_arg$26));
          end end  end  end 
      end
    end end 
    switch (exit) do
      case 1 :
          var partial_arg$27 = make_iprintf(k, o, fmt[0]);
          return (function(partial_arg$27)do
          return function (param) do
            return partial_arg$27;
          end
          end(partial_arg$27));
      case 2 :
          _fmt = fmt[1];
          continue ;
      case 3 :
          var partial_arg$28 = make_iprintf(k, o, fmt[2]);
          return (function(partial_arg$28)do
          return function (param) do
            return partial_arg$28;
          end
          end(partial_arg$28));
      
    end
  end;
end

function fn_of_custom_arity(k, o, fmt, param) do
  if (param) then do
    var partial_arg = fn_of_custom_arity(k, o, fmt, param[0]);
    return (function (param) do
        return partial_arg;
      end);
  end else do
    return make_iprintf(k, o, fmt);
  end end 
end

function output_acc(o, _acc) do
  while(true) do
    var acc = _acc;
    var exit = 0;
    if (typeof acc == "number") then do
      return --[ () ]--0;
    end else do
      switch (acc.tag | 0) do
        case --[ Acc_formatting_lit ]--0 :
            var s = string_of_formatting_lit(acc[1]);
            output_acc(o, acc[0]);
            return Pervasives.output_string(o, s);
        case --[ Acc_formatting_gen ]--1 :
            var match = acc[1];
            var p = acc[0];
            output_acc(o, p);
            if (match.tag) then do
              Pervasives.output_string(o, "@[");
              _acc = match[0];
              continue ;
            end else do
              Pervasives.output_string(o, "@{");
              _acc = match[0];
              continue ;
            end end 
        case --[ Acc_string_literal ]--2 :
        case --[ Acc_data_string ]--4 :
            exit = 1;
            break;
        case --[ Acc_char_literal ]--3 :
        case --[ Acc_data_char ]--5 :
            exit = 2;
            break;
        case --[ Acc_delay ]--6 :
            output_acc(o, acc[0]);
            return Curry._1(acc[1], o);
        case --[ Acc_flush ]--7 :
            output_acc(o, acc[0]);
            return Caml_io.caml_ml_flush(o);
        case --[ Acc_invalid_arg ]--8 :
            output_acc(o, acc[0]);
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  acc[1]
                ];
        
      end
    end end 
    switch (exit) do
      case 1 :
          output_acc(o, acc[0]);
          return Pervasives.output_string(o, acc[1]);
      case 2 :
          output_acc(o, acc[0]);
          return Caml_io.caml_ml_output_char(o, acc[1]);
      
    end
  end;
end

function bufput_acc(b, _acc) do
  while(true) do
    var acc = _acc;
    var exit = 0;
    if (typeof acc == "number") then do
      return --[ () ]--0;
    end else do
      switch (acc.tag | 0) do
        case --[ Acc_formatting_lit ]--0 :
            var s = string_of_formatting_lit(acc[1]);
            bufput_acc(b, acc[0]);
            return $$Buffer.add_string(b, s);
        case --[ Acc_formatting_gen ]--1 :
            var match = acc[1];
            var p = acc[0];
            bufput_acc(b, p);
            if (match.tag) then do
              $$Buffer.add_string(b, "@[");
              _acc = match[0];
              continue ;
            end else do
              $$Buffer.add_string(b, "@{");
              _acc = match[0];
              continue ;
            end end 
        case --[ Acc_string_literal ]--2 :
        case --[ Acc_data_string ]--4 :
            exit = 1;
            break;
        case --[ Acc_char_literal ]--3 :
        case --[ Acc_data_char ]--5 :
            exit = 2;
            break;
        case --[ Acc_delay ]--6 :
            bufput_acc(b, acc[0]);
            return Curry._1(acc[1], b);
        case --[ Acc_flush ]--7 :
            _acc = acc[0];
            continue ;
        case --[ Acc_invalid_arg ]--8 :
            bufput_acc(b, acc[0]);
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  acc[1]
                ];
        
      end
    end end 
    switch (exit) do
      case 1 :
          bufput_acc(b, acc[0]);
          return $$Buffer.add_string(b, acc[1]);
      case 2 :
          bufput_acc(b, acc[0]);
          return $$Buffer.add_char(b, acc[1]);
      
    end
  end;
end

function strput_acc(b, _acc) do
  while(true) do
    var acc = _acc;
    var exit = 0;
    if (typeof acc == "number") then do
      return --[ () ]--0;
    end else do
      switch (acc.tag | 0) do
        case --[ Acc_formatting_lit ]--0 :
            var s = string_of_formatting_lit(acc[1]);
            strput_acc(b, acc[0]);
            return $$Buffer.add_string(b, s);
        case --[ Acc_formatting_gen ]--1 :
            var match = acc[1];
            var p = acc[0];
            strput_acc(b, p);
            if (match.tag) then do
              $$Buffer.add_string(b, "@[");
              _acc = match[0];
              continue ;
            end else do
              $$Buffer.add_string(b, "@{");
              _acc = match[0];
              continue ;
            end end 
        case --[ Acc_string_literal ]--2 :
        case --[ Acc_data_string ]--4 :
            exit = 1;
            break;
        case --[ Acc_char_literal ]--3 :
        case --[ Acc_data_char ]--5 :
            exit = 2;
            break;
        case --[ Acc_delay ]--6 :
            strput_acc(b, acc[0]);
            return $$Buffer.add_string(b, Curry._1(acc[1], --[ () ]--0));
        case --[ Acc_flush ]--7 :
            _acc = acc[0];
            continue ;
        case --[ Acc_invalid_arg ]--8 :
            strput_acc(b, acc[0]);
            throw [
                  Caml_builtin_exceptions.invalid_argument,
                  acc[1]
                ];
        
      end
    end end 
    switch (exit) do
      case 1 :
          strput_acc(b, acc[0]);
          return $$Buffer.add_string(b, acc[1]);
      case 2 :
          strput_acc(b, acc[0]);
          return $$Buffer.add_char(b, acc[1]);
      
    end
  end;
end

function failwith_message(param) do
  var buf = $$Buffer.create(256);
  var k = function (param, acc) do
    strput_acc(buf, acc);
    var s = $$Buffer.contents(buf);
    throw [
          Caml_builtin_exceptions.failure,
          s
        ];
  end;
  return make_printf(k, --[ () ]--0, --[ End_of_acc ]--0, param[0]);
end

function open_box_of_string(str) do
  if (str == "") then do
    return --[ tuple ]--[
            0,
            --[ Pp_box ]--4
          ];
  end else do
    var len = #str;
    var invalid_box = function (param) do
      return Curry._1(failwith_message(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "invalid box description ",
                          --[ Caml_string ]--Block.__(3, [
                              --[ No_padding ]--0,
                              --[ End_of_format ]--0
                            ])
                        ]),
                      "invalid box description %S"
                    ]), str);
    end;
    var parse_spaces = function (_i) do
      while(true) do
        var i = _i;
        if (i == len) then do
          return i;
        end else do
          var match = Caml_string.get(str, i);
          if (match ~= 9) then do
            if (match ~= 32) then do
              return i;
            end else do
              _i = i + 1 | 0;
              continue ;
            end end 
          end else do
            _i = i + 1 | 0;
            continue ;
          end end 
        end end 
      end;
    end;
    var parse_lword = function (i, _j) do
      while(true) do
        var j = _j;
        if (j == len) then do
          return j;
        end else do
          var match = Caml_string.get(str, j);
          if (match > 122 or match < 97) then do
            return j;
          end else do
            _j = j + 1 | 0;
            continue ;
          end end 
        end end 
      end;
    end;
    var parse_int = function (i, _j) do
      while(true) do
        var j = _j;
        if (j == len) then do
          return j;
        end else do
          var match = Caml_string.get(str, j);
          if (match >= 48) then do
            if (match >= 58) then do
              return j;
            end else do
              _j = j + 1 | 0;
              continue ;
            end end 
          end else if (match ~= 45) then do
            return j;
          end else do
            _j = j + 1 | 0;
            continue ;
          end end  end 
        end end 
      end;
    end;
    var wstart = parse_spaces(0);
    var wend = parse_lword(wstart, wstart);
    var box_name = $$String.sub(str, wstart, wend - wstart | 0);
    var nstart = parse_spaces(wend);
    var nend = parse_int(nstart, nstart);
    var indent;
    if (nstart == nend) then do
      indent = 0;
    end else do
      try do
        indent = Caml_format.caml_int_of_string($$String.sub(str, nstart, nend - nstart | 0));
      end
      catch (raw_exn)do
        var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
        if (exn[0] == Caml_builtin_exceptions.failure) then do
          indent = invalid_box(--[ () ]--0);
        end else do
          throw exn;
        end end 
      end
    end end 
    var exp_end = parse_spaces(nend);
    if (exp_end ~= len) then do
      invalid_box(--[ () ]--0);
    end
     end 
    var box_type;
    switch (box_name) do
      case "" :
      case "b" :
          box_type = --[ Pp_box ]--4;
          break;
      case "h" :
          box_type = --[ Pp_hbox ]--0;
          break;
      case "hov" :
          box_type = --[ Pp_hovbox ]--3;
          break;
      case "hv" :
          box_type = --[ Pp_hvbox ]--2;
          break;
      case "v" :
          box_type = --[ Pp_vbox ]--1;
          break;
      default:
        box_type = invalid_box(--[ () ]--0);
    end
    return --[ tuple ]--[
            indent,
            box_type
          ];
  end end 
end

function make_padding_fmt_ebb(pad, fmt) do
  if (typeof pad == "number") then do
    return --[ Padding_fmt_EBB ]--[
            --[ No_padding ]--0,
            fmt
          ];
  end else if (pad.tag) then do
    return --[ Padding_fmt_EBB ]--[
            --[ Arg_padding ]--Block.__(1, [pad[0]]),
            fmt
          ];
  end else do
    return --[ Padding_fmt_EBB ]--[
            --[ Lit_padding ]--Block.__(0, [
                pad[0],
                pad[1]
              ]),
            fmt
          ];
  end end  end 
end

function make_precision_fmt_ebb(prec, fmt) do
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      return --[ Precision_fmt_EBB ]--[
              --[ Arg_precision ]--1,
              fmt
            ];
    end else do
      return --[ Precision_fmt_EBB ]--[
              --[ No_precision ]--0,
              fmt
            ];
    end end 
  end else do
    return --[ Precision_fmt_EBB ]--[
            --[ Lit_precision ]--[prec[0]],
            fmt
          ];
  end end 
end

function make_padprec_fmt_ebb(pad, prec, fmt) do
  var match = make_precision_fmt_ebb(prec, fmt);
  var fmt$prime = match[1];
  var prec$1 = match[0];
  if (typeof pad == "number") then do
    return --[ Padprec_fmt_EBB ]--[
            --[ No_padding ]--0,
            prec$1,
            fmt$prime
          ];
  end else if (pad.tag) then do
    return --[ Padprec_fmt_EBB ]--[
            --[ Arg_padding ]--Block.__(1, [pad[0]]),
            prec$1,
            fmt$prime
          ];
  end else do
    return --[ Padprec_fmt_EBB ]--[
            --[ Lit_padding ]--Block.__(0, [
                pad[0],
                pad[1]
              ]),
            prec$1,
            fmt$prime
          ];
  end end  end 
end

function fmt_ebb_of_string(legacy_behavior, str) do
  var legacy_behavior$1 = legacy_behavior ~= undefined ? legacy_behavior : true;
  var invalid_format_message = function (str_ind, msg) do
    return Curry._3(failwith_message(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "invalid format ",
                        --[ Caml_string ]--Block.__(3, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": at character number ",
                                --[ Int ]--Block.__(4, [
                                    --[ Int_d ]--0,
                                    --[ No_padding ]--0,
                                    --[ No_precision ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ", ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ End_of_format ]--0
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "invalid format %S: at character number %d, %s"
                  ]), str, str_ind, msg);
  end;
  var invalid_format_without = function (str_ind, c, s) do
    return Curry._4(failwith_message(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "invalid format ",
                        --[ Caml_string ]--Block.__(3, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": at character number ",
                                --[ Int ]--Block.__(4, [
                                    --[ Int_d ]--0,
                                    --[ No_padding ]--0,
                                    --[ No_precision ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ", '",
                                        --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                                "' without ",
                                                --[ String ]--Block.__(2, [
                                                    --[ No_padding ]--0,
                                                    --[ End_of_format ]--0
                                                  ])
                                              ])])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "invalid format %S: at character number %d, '%c' without %s"
                  ]), str, str_ind, c, s);
  end;
  var expected_character = function (str_ind, expected, read) do
    return Curry._4(failwith_message(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "invalid format ",
                        --[ Caml_string ]--Block.__(3, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": at character number ",
                                --[ Int ]--Block.__(4, [
                                    --[ Int_d ]--0,
                                    --[ No_padding ]--0,
                                    --[ No_precision ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ", ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ String_literal ]--Block.__(11, [
                                                " expected, read ",
                                                --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0])
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "invalid format %S: at character number %d, %s expected, read %C"
                  ]), str, str_ind, expected, read);
  end;
  var parse_after_at = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      return --[ Fmt_EBB ]--[--[ Char_literal ]--Block.__(12, [
                  --[ "@" ]--64,
                  --[ End_of_format ]--0
                ])];
    end else do
      var c = Caml_string.get(str, str_ind);
      if (c >= 65) then do
        if (c >= 94) then do
          switch (c) do
            case 123 :
                return parse_tag(true, str_ind + 1 | 0, end_ind);
            case 124 :
                break;
            case 125 :
                var beg_ind = str_ind + 1 | 0;
                var match = parse_literal(beg_ind, beg_ind, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Close_tag ]--1,
                            match[0]
                          ])];
            default:
              
          end
        end else if (c >= 91) then do
          switch (c - 91 | 0) do
            case 0 :
                return parse_tag(false, str_ind + 1 | 0, end_ind);
            case 1 :
                break;
            case 2 :
                var beg_ind$1 = str_ind + 1 | 0;
                var match$1 = parse_literal(beg_ind$1, beg_ind$1, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Close_box ]--0,
                            match$1[0]
                          ])];
            
          end
        end
         end  end 
      end else if (c ~= 10) then do
        if (c >= 32) then do
          switch (c - 32 | 0) do
            case 0 :
                var beg_ind$2 = str_ind + 1 | 0;
                var match$2 = parse_literal(beg_ind$2, beg_ind$2, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Break ]--Block.__(0, [
                                "@ ",
                                1,
                                0
                              ]),
                            match$2[0]
                          ])];
            case 5 :
                if ((str_ind + 1 | 0) < end_ind and Caml_string.get(str, str_ind + 1 | 0) == --[ "%" ]--37) then do
                  var beg_ind$3 = str_ind + 2 | 0;
                  var match$3 = parse_literal(beg_ind$3, beg_ind$3, end_ind);
                  return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                              --[ Escaped_percent ]--6,
                              match$3[0]
                            ])];
                end else do
                  var match$4 = parse_literal(str_ind, str_ind, end_ind);
                  return --[ Fmt_EBB ]--[--[ Char_literal ]--Block.__(12, [
                              --[ "@" ]--64,
                              match$4[0]
                            ])];
                end end 
            case 12 :
                var beg_ind$4 = str_ind + 1 | 0;
                var match$5 = parse_literal(beg_ind$4, beg_ind$4, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Break ]--Block.__(0, [
                                "@,",
                                0,
                                0
                              ]),
                            match$5[0]
                          ])];
            case 14 :
                var beg_ind$5 = str_ind + 1 | 0;
                var match$6 = parse_literal(beg_ind$5, beg_ind$5, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Flush_newline ]--4,
                            match$6[0]
                          ])];
            case 27 :
                var str_ind$1 = str_ind + 1 | 0;
                var end_ind$1 = end_ind;
                var match$7;
                try do
                  if (str_ind$1 == end_ind$1 or Caml_string.get(str, str_ind$1) ~= --[ "<" ]--60) then do
                    throw Caml_builtin_exceptions.not_found;
                  end
                   end 
                  var str_ind_1 = parse_spaces(str_ind$1 + 1 | 0, end_ind$1);
                  var match$8 = Caml_string.get(str, str_ind_1);
                  var exit = 0;
                  if (match$8 >= 48) then do
                    if (match$8 >= 58) then do
                      throw Caml_builtin_exceptions.not_found;
                    end
                     end 
                    exit = 1;
                  end else do
                    if (match$8 ~= 45) then do
                      throw Caml_builtin_exceptions.not_found;
                    end
                     end 
                    exit = 1;
                  end end 
                  if (exit == 1) then do
                    var match$9 = parse_integer(str_ind_1, end_ind$1);
                    var width = match$9[1];
                    var str_ind_3 = parse_spaces(match$9[0], end_ind$1);
                    var match$10 = Caml_string.get(str, str_ind_3);
                    var switcher = match$10 - 45 | 0;
                    if (switcher > 12 or switcher < 0) then do
                      if (switcher ~= 17) then do
                        throw Caml_builtin_exceptions.not_found;
                      end
                       end 
                      var s = $$String.sub(str, str_ind$1 - 2 | 0, (str_ind_3 - str_ind$1 | 0) + 3 | 0);
                      match$7 = --[ tuple ]--[
                        str_ind_3 + 1 | 0,
                        --[ Break ]--Block.__(0, [
                            s,
                            width,
                            0
                          ])
                      ];
                    end else if (switcher == 2 or switcher == 1) then do
                      throw Caml_builtin_exceptions.not_found;
                    end else do
                      var match$11 = parse_integer(str_ind_3, end_ind$1);
                      var str_ind_5 = parse_spaces(match$11[0], end_ind$1);
                      if (Caml_string.get(str, str_ind_5) ~= --[ ">" ]--62) then do
                        throw Caml_builtin_exceptions.not_found;
                      end
                       end 
                      var s$1 = $$String.sub(str, str_ind$1 - 2 | 0, (str_ind_5 - str_ind$1 | 0) + 3 | 0);
                      match$7 = --[ tuple ]--[
                        str_ind_5 + 1 | 0,
                        --[ Break ]--Block.__(0, [
                            s$1,
                            width,
                            match$11[1]
                          ])
                      ];
                    end end  end 
                  end
                   end 
                end
                catch (raw_exn)do
                  var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
                  if (exn == Caml_builtin_exceptions.not_found or exn[0] == Caml_builtin_exceptions.failure) then do
                    match$7 = --[ tuple ]--[
                      str_ind$1,
                      --[ Break ]--Block.__(0, [
                          "@;",
                          1,
                          0
                        ])
                    ];
                  end else do
                    throw exn;
                  end end 
                end
                var next_ind = match$7[0];
                var match$12 = parse_literal(next_ind, next_ind, end_ind$1);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            match$7[1],
                            match$12[0]
                          ])];
            case 28 :
                var str_ind$2 = str_ind + 1 | 0;
                var end_ind$2 = end_ind;
                var match$13;
                try do
                  var str_ind_1$1 = parse_spaces(str_ind$2, end_ind$2);
                  var match$14 = Caml_string.get(str, str_ind_1$1);
                  var exit$1 = 0;
                  if (match$14 >= 48) then do
                    if (match$14 >= 58) then do
                      match$13 = undefined;
                    end else do
                      exit$1 = 1;
                    end end 
                  end else if (match$14 ~= 45) then do
                    match$13 = undefined;
                  end else do
                    exit$1 = 1;
                  end end  end 
                  if (exit$1 == 1) then do
                    var match$15 = parse_integer(str_ind_1$1, end_ind$2);
                    var str_ind_3$1 = parse_spaces(match$15[0], end_ind$2);
                    if (Caml_string.get(str, str_ind_3$1) ~= --[ ">" ]--62) then do
                      throw Caml_builtin_exceptions.not_found;
                    end
                     end 
                    var s$2 = $$String.sub(str, str_ind$2 - 2 | 0, (str_ind_3$1 - str_ind$2 | 0) + 3 | 0);
                    match$13 = --[ tuple ]--[
                      str_ind_3$1 + 1 | 0,
                      --[ Magic_size ]--Block.__(1, [
                          s$2,
                          match$15[1]
                        ])
                    ];
                  end
                   end 
                end
                catch (raw_exn$1)do
                  var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
                  if (exn$1 == Caml_builtin_exceptions.not_found or exn$1[0] == Caml_builtin_exceptions.failure) then do
                    match$13 = undefined;
                  end else do
                    throw exn$1;
                  end end 
                end
                if (match$13 ~= undefined) then do
                  var match$16 = match$13;
                  var next_ind$1 = match$16[0];
                  var match$17 = parse_literal(next_ind$1, next_ind$1, end_ind$2);
                  return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                              match$16[1],
                              match$17[0]
                            ])];
                end else do
                  var match$18 = parse_literal(str_ind$2, str_ind$2, end_ind$2);
                  return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                              --[ Scan_indic ]--Block.__(2, [--[ "<" ]--60]),
                              match$18[0]
                            ])];
                end end 
            case 1 :
            case 2 :
            case 3 :
            case 4 :
            case 6 :
            case 7 :
            case 8 :
            case 9 :
            case 10 :
            case 11 :
            case 13 :
            case 15 :
            case 16 :
            case 17 :
            case 18 :
            case 19 :
            case 20 :
            case 21 :
            case 22 :
            case 23 :
            case 24 :
            case 25 :
            case 26 :
            case 29 :
            case 30 :
                break;
            case 31 :
                var beg_ind$6 = str_ind + 1 | 0;
                var match$19 = parse_literal(beg_ind$6, beg_ind$6, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ FFlush ]--2,
                            match$19[0]
                          ])];
            case 32 :
                var beg_ind$7 = str_ind + 1 | 0;
                var match$20 = parse_literal(beg_ind$7, beg_ind$7, end_ind);
                return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                            --[ Escaped_at ]--5,
                            match$20[0]
                          ])];
            
          end
        end
         end 
      end else do
        var beg_ind$8 = str_ind + 1 | 0;
        var match$21 = parse_literal(beg_ind$8, beg_ind$8, end_ind);
        return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                    --[ Force_newline ]--3,
                    match$21[0]
                  ])];
      end end  end 
      var beg_ind$9 = str_ind + 1 | 0;
      var match$22 = parse_literal(beg_ind$9, beg_ind$9, end_ind);
      return --[ Fmt_EBB ]--[--[ Formatting_lit ]--Block.__(17, [
                  --[ Scan_indic ]--Block.__(2, [c]),
                  match$22[0]
                ])];
    end end 
  end;
  var add_literal = function (lit_start, str_ind, fmt) do
    var size = str_ind - lit_start | 0;
    if (size ~= 0) then do
      if (size ~= 1) then do
        return --[ Fmt_EBB ]--[--[ String_literal ]--Block.__(11, [
                    $$String.sub(str, lit_start, size),
                    fmt
                  ])];
      end else do
        return --[ Fmt_EBB ]--[--[ Char_literal ]--Block.__(12, [
                    Caml_string.get(str, lit_start),
                    fmt
                  ])];
      end end 
    end else do
      return --[ Fmt_EBB ]--[fmt];
    end end 
  end;
  var parse_format = function (pct_ind, end_ind) do
    var pct_ind$1 = pct_ind;
    var str_ind = pct_ind + 1 | 0;
    var end_ind$1 = end_ind;
    if (str_ind == end_ind$1) then do
      invalid_format_message(end_ind$1, "unexpected end of format");
    end
     end 
    var match = Caml_string.get(str, str_ind);
    if (match ~= 95) then do
      return parse_flags(pct_ind$1, str_ind, end_ind$1, false);
    end else do
      return parse_flags(pct_ind$1, str_ind + 1 | 0, end_ind$1, true);
    end end 
  end;
  var parse_literal = function (lit_start, _str_ind, end_ind) do
    while(true) do
      var str_ind = _str_ind;
      if (str_ind == end_ind) then do
        return add_literal(lit_start, str_ind, --[ End_of_format ]--0);
      end else do
        var match = Caml_string.get(str, str_ind);
        if (match ~= 37) then do
          if (match ~= 64) then do
            _str_ind = str_ind + 1 | 0;
            continue ;
          end else do
            var match$1 = parse_after_at(str_ind + 1 | 0, end_ind);
            return add_literal(lit_start, str_ind, match$1[0]);
          end end 
        end else do
          var match$2 = parse_format(str_ind, end_ind);
          return add_literal(lit_start, str_ind, match$2[0]);
        end end 
      end end 
    end;
  end;
  var parse_spaces = function (_str_ind, end_ind) do
    while(true) do
      var str_ind = _str_ind;
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      if (Caml_string.get(str, str_ind) == --[ " " ]--32) then do
        _str_ind = str_ind + 1 | 0;
        continue ;
      end else do
        return str_ind;
      end end 
    end;
  end;
  var parse_flags = function (pct_ind, str_ind, end_ind, ign) do
    var zero = do
      contents: false
    end;
    var minus = do
      contents: false
    end;
    var plus = do
      contents: false
    end;
    var space = do
      contents: false
    end;
    var hash = do
      contents: false
    end;
    var set_flag = function (str_ind, flag) do
      if (flag.contents and !legacy_behavior$1) then do
        Curry._3(failwith_message(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "invalid format ",
                      --[ Caml_string ]--Block.__(3, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ": at character number ",
                              --[ Int ]--Block.__(4, [
                                  --[ Int_d ]--0,
                                  --[ No_padding ]--0,
                                  --[ No_precision ]--0,
                                  --[ String_literal ]--Block.__(11, [
                                      ", duplicate flag ",
                                      --[ Caml_char ]--Block.__(1, [--[ End_of_format ]--0])
                                    ])
                                ])
                            ])
                        ])
                    ]),
                  "invalid format %S: at character number %d, duplicate flag %C"
                ]), str, str_ind, Caml_string.get(str, str_ind));
      end
       end 
      flag.contents = true;
      return --[ () ]--0;
    end;
    var _str_ind = str_ind;
    while(true) do
      var str_ind$1 = _str_ind;
      if (str_ind$1 == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      var match = Caml_string.get(str, str_ind$1);
      switch (match) do
        case 32 :
            set_flag(str_ind$1, space);
            _str_ind = str_ind$1 + 1 | 0;
            continue ;
        case 35 :
            set_flag(str_ind$1, hash);
            _str_ind = str_ind$1 + 1 | 0;
            continue ;
        case 43 :
            set_flag(str_ind$1, plus);
            _str_ind = str_ind$1 + 1 | 0;
            continue ;
        case 45 :
            set_flag(str_ind$1, minus);
            _str_ind = str_ind$1 + 1 | 0;
            continue ;
        case 33 :
        case 34 :
        case 36 :
        case 37 :
        case 38 :
        case 39 :
        case 40 :
        case 41 :
        case 42 :
        case 44 :
        case 46 :
        case 47 :
            break;
        case 48 :
            set_flag(str_ind$1, zero);
            _str_ind = str_ind$1 + 1 | 0;
            continue ;
        default:
          
      end
      var pct_ind$1 = pct_ind;
      var str_ind$2 = str_ind$1;
      var end_ind$1 = end_ind;
      var zero$1 = zero.contents;
      var minus$1 = minus.contents;
      var plus$1 = plus.contents;
      var hash$1 = hash.contents;
      var space$1 = space.contents;
      var ign$1 = ign;
      if (str_ind$2 == end_ind$1) then do
        invalid_format_message(end_ind$1, "unexpected end of format");
      end
       end 
      var padty = zero$1 ? (
          minus$1 ? (
              legacy_behavior$1 ? --[ Left ]--0 : incompatible_flag(pct_ind$1, str_ind$2, --[ "-" ]--45, "0")
            ) : --[ Zeros ]--2
        ) : (
          minus$1 ? --[ Left ]--0 : --[ Right ]--1
        );
      var match$1 = Caml_string.get(str, str_ind$2);
      if (match$1 >= 48) then do
        if (match$1 < 58) then do
          var match$2 = parse_positive(str_ind$2, end_ind$1, 0);
          return parse_after_padding(pct_ind$1, match$2[0], end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[ Lit_padding ]--Block.__(0, [
                        padty,
                        match$2[1]
                      ]));
        end
         end 
      end else if (match$1 == 42) then do
        return parse_after_padding(pct_ind$1, str_ind$2 + 1 | 0, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[ Arg_padding ]--Block.__(1, [padty]));
      end
       end  end 
      switch (padty) do
        case --[ Left ]--0 :
            if (!legacy_behavior$1) then do
              invalid_format_without(str_ind$2 - 1 | 0, --[ "-" ]--45, "padding");
            end
             end 
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[ No_padding ]--0);
        case --[ Right ]--1 :
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[ No_padding ]--0);
        case --[ Zeros ]--2 :
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[ Lit_padding ]--Block.__(0, [
                          --[ Right ]--1,
                          0
                        ]));
        
      end
    end;
  end;
  var search_subformat_end = function (_str_ind, end_ind, c) do
    while(true) do
      var str_ind = _str_ind;
      if (str_ind == end_ind) then do
        Curry._3(failwith_message(--[ Format ]--[
                  --[ String_literal ]--Block.__(11, [
                      "invalid format ",
                      --[ Caml_string ]--Block.__(3, [
                          --[ No_padding ]--0,
                          --[ String_literal ]--Block.__(11, [
                              ": unclosed sub-format, expected \"",
                              --[ Char_literal ]--Block.__(12, [
                                  --[ "%" ]--37,
                                  --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                          "\" at character number ",
                                          --[ Int ]--Block.__(4, [
                                              --[ Int_d ]--0,
                                              --[ No_padding ]--0,
                                              --[ No_precision ]--0,
                                              --[ End_of_format ]--0
                                            ])
                                        ])])
                                ])
                            ])
                        ])
                    ]),
                  "invalid format %S: unclosed sub-format, expected \"%%%c\" at character number %d"
                ]), str, c, end_ind);
      end
       end 
      var match = Caml_string.get(str, str_ind);
      if (match ~= 37) then do
        _str_ind = str_ind + 1 | 0;
        continue ;
      end else do
        if ((str_ind + 1 | 0) == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        if (Caml_string.get(str, str_ind + 1 | 0) == c) then do
          return str_ind;
        end else do
          var match$1 = Caml_string.get(str, str_ind + 1 | 0);
          if (match$1 >= 95) then do
            if (match$1 >= 123) then do
              if (match$1 < 126) then do
                switch (match$1 - 123 | 0) do
                  case 0 :
                      var sub_end = search_subformat_end(str_ind + 2 | 0, end_ind, --[ "}" ]--125);
                      _str_ind = sub_end + 2 | 0;
                      continue ;
                  case 1 :
                      break;
                  case 2 :
                      return expected_character(str_ind + 1 | 0, "character ')'", --[ "}" ]--125);
                  
                end
              end
               end 
            end else if (match$1 < 96) then do
              if ((str_ind + 2 | 0) == end_ind) then do
                invalid_format_message(end_ind, "unexpected end of format");
              end
               end 
              var match$2 = Caml_string.get(str, str_ind + 2 | 0);
              if (match$2 ~= 40) then do
                if (match$2 ~= 123) then do
                  _str_ind = str_ind + 3 | 0;
                  continue ;
                end else do
                  var sub_end$1 = search_subformat_end(str_ind + 3 | 0, end_ind, --[ "}" ]--125);
                  _str_ind = sub_end$1 + 2 | 0;
                  continue ;
                end end 
              end else do
                var sub_end$2 = search_subformat_end(str_ind + 3 | 0, end_ind, --[ ")" ]--41);
                _str_ind = sub_end$2 + 2 | 0;
                continue ;
              end end 
            end
             end  end 
          end else if (match$1 ~= 40) then do
            if (match$1 == 41) then do
              return expected_character(str_ind + 1 | 0, "character '}'", --[ ")" ]--41);
            end
             end 
          end else do
            var sub_end$3 = search_subformat_end(str_ind + 2 | 0, end_ind, --[ ")" ]--41);
            _str_ind = sub_end$3 + 2 | 0;
            continue ;
          end end  end 
          _str_ind = str_ind + 2 | 0;
          continue ;
        end end 
      end end 
    end;
  end;
  var parse_positive = function (_str_ind, end_ind, _acc) do
    while(true) do
      var acc = _acc;
      var str_ind = _str_ind;
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      var c = Caml_string.get(str, str_ind);
      if (c > 57 or c < 48) then do
        return --[ tuple ]--[
                str_ind,
                acc
              ];
      end else do
        var new_acc = Caml_int32.imul(acc, 10) + (c - --[ "0" ]--48 | 0) | 0;
        _acc = new_acc;
        _str_ind = str_ind + 1 | 0;
        continue ;
      end end 
    end;
  end;
  var check_open_box = function (fmt) do
    if (typeof fmt == "number" or !(fmt.tag == --[ String_literal ]--11 and typeof fmt[1] == "number")) then do
      return --[ () ]--0;
    end else do
      try do
        open_box_of_string(fmt[0]);
        return --[ () ]--0;
      end
      catch (raw_exn)do
        var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
        if (exn[0] == Caml_builtin_exceptions.failure) then do
          return --[ () ]--0;
        end else do
          throw exn;
        end end 
      end
    end end 
  end;
  var parse_conversion = function (pct_ind, str_ind, end_ind, plus, hash, space, ign, pad, prec, padprec, symb) do
    var plus_used = false;
    var hash_used = false;
    var space_used = false;
    var ign_used = do
      contents: false
    end;
    var pad_used = do
      contents: false
    end;
    var prec_used = do
      contents: false
    end;
    var get_int_pad = function (param) do
      pad_used.contents = true;
      prec_used.contents = true;
      if (typeof prec == "number" and prec == 0) then do
        return pad;
      end
       end 
      if (typeof pad == "number") then do
        return --[ No_padding ]--0;
      end else if (pad.tag) then do
        if (pad[0] >= 2) then do
          if (legacy_behavior$1) then do
            return --[ Arg_padding ]--Block.__(1, [--[ Right ]--1]);
          end else do
            return incompatible_flag(pct_ind, str_ind, --[ "0" ]--48, "precision");
          end end 
        end else do
          return pad;
        end end 
      end else if (pad[0] >= 2) then do
        if (legacy_behavior$1) then do
          return --[ Lit_padding ]--Block.__(0, [
                    --[ Right ]--1,
                    pad[1]
                  ]);
        end else do
          return incompatible_flag(pct_ind, str_ind, --[ "0" ]--48, "precision");
        end end 
      end else do
        return pad;
      end end  end  end 
    end;
    var check_no_0 = function (symb, pad) do
      if (typeof pad == "number") then do
        return pad;
      end else if (pad.tag) then do
        if (pad[0] >= 2) then do
          if (legacy_behavior$1) then do
            return --[ Arg_padding ]--Block.__(1, [--[ Right ]--1]);
          end else do
            return incompatible_flag(pct_ind, str_ind, symb, "0");
          end end 
        end else do
          return pad;
        end end 
      end else if (pad[0] >= 2) then do
        if (legacy_behavior$1) then do
          return --[ Lit_padding ]--Block.__(0, [
                    --[ Right ]--1,
                    pad[1]
                  ]);
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "0");
        end end 
      end else do
        return pad;
      end end  end  end 
    end;
    var opt_of_pad = function (c, pad) do
      if (typeof pad == "number") then do
        return ;
      end else if (pad.tag) then do
        return incompatible_flag(pct_ind, str_ind, c, "'*'");
      end else do
        switch (pad[0]) do
          case --[ Left ]--0 :
              if (legacy_behavior$1) then do
                return pad[1];
              end else do
                return incompatible_flag(pct_ind, str_ind, c, "'-'");
              end end 
          case --[ Right ]--1 :
              return pad[1];
          case --[ Zeros ]--2 :
              if (legacy_behavior$1) then do
                return pad[1];
              end else do
                return incompatible_flag(pct_ind, str_ind, c, "'0'");
              end end 
          
        end
      end end  end 
    end;
    var get_prec_opt = function (param) do
      prec_used.contents = true;
      if (typeof prec == "number") then do
        if (prec ~= 0) then do
          return incompatible_flag(pct_ind, str_ind, --[ "_" ]--95, "'*'");
        end else do
          return ;
        end end 
      end else do
        return prec[0];
      end end 
    end;
    var fmt_result;
    var exit = 0;
    var exit$1 = 0;
    var exit$2 = 0;
    if (symb >= 124) then do
      exit$1 = 6;
    end else do
      switch (symb) do
        case 33 :
            var match = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[ Fmt_EBB ]--[--[ Flush ]--Block.__(10, [match[0]])];
            break;
        case 40 :
            var sub_end = search_subformat_end(str_ind, end_ind, --[ ")" ]--41);
            var beg_ind = sub_end + 2 | 0;
            var match$1 = parse_literal(beg_ind, beg_ind, end_ind);
            var fmt_rest = match$1[0];
            var match$2 = parse_literal(str_ind, str_ind, sub_end);
            var sub_fmtty = fmtty_of_fmt(match$2[0]);
            if (ign_used.contents = true, ign) then do
              var ignored_000 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
              var ignored = --[ Ignored_format_subst ]--Block.__(9, [
                  ignored_000,
                  sub_fmtty
                ]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored,
                    fmt_rest
                  ])];
            end else do
              fmt_result = --[ Fmt_EBB ]--[--[ Format_subst ]--Block.__(14, [
                    opt_of_pad(--[ "(" ]--40, (pad_used.contents = true, pad)),
                    sub_fmtty,
                    fmt_rest
                  ])];
            end end 
            break;
        case 44 :
            fmt_result = parse_literal(str_ind, str_ind, end_ind);
            break;
        case 37 :
        case 64 :
            exit$1 = 4;
            break;
        case 67 :
            var match$3 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$1 = match$3[0];
            fmt_result = (ign_used.contents = true, ign) ? --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    --[ Ignored_caml_char ]--1,
                    fmt_rest$1
                  ])] : --[ Fmt_EBB ]--[--[ Caml_char ]--Block.__(1, [fmt_rest$1])];
            break;
        case 78 :
            var match$4 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$2 = match$4[0];
            if (ign_used.contents = true, ign) then do
              var ignored$1 = --[ Ignored_scan_get_counter ]--Block.__(11, [--[ Token_counter ]--2]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$1,
                    fmt_rest$2
                  ])];
            end else do
              fmt_result = --[ Fmt_EBB ]--[--[ Scan_get_counter ]--Block.__(21, [
                    --[ Token_counter ]--2,
                    fmt_rest$2
                  ])];
            end end 
            break;
        case 83 :
            var pad$1 = check_no_0(symb, (pad_used.contents = true, padprec));
            var match$5 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$3 = match$5[0];
            if (ign_used.contents = true, ign) then do
              var ignored$2 = --[ Ignored_caml_string ]--Block.__(1, [opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, padprec))]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$2,
                    fmt_rest$3
                  ])];
            end else do
              var match$6 = make_padding_fmt_ebb(pad$1, fmt_rest$3);
              fmt_result = --[ Fmt_EBB ]--[--[ Caml_string ]--Block.__(3, [
                    match$6[0],
                    match$6[1]
                  ])];
            end end 
            break;
        case 91 :
            var match$7 = parse_char_set(str_ind, end_ind);
            var char_set = match$7[1];
            var next_ind = match$7[0];
            var match$8 = parse_literal(next_ind, next_ind, end_ind);
            var fmt_rest$4 = match$8[0];
            if (ign_used.contents = true, ign) then do
              var ignored_000$1 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
              var ignored$3 = --[ Ignored_scan_char_set ]--Block.__(10, [
                  ignored_000$1,
                  char_set
                ]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$3,
                    fmt_rest$4
                  ])];
            end else do
              fmt_result = --[ Fmt_EBB ]--[--[ Scan_char_set ]--Block.__(20, [
                    opt_of_pad(--[ "[" ]--91, (pad_used.contents = true, pad)),
                    char_set,
                    fmt_rest$4
                  ])];
            end end 
            break;
        case 32 :
        case 35 :
        case 43 :
        case 45 :
        case 95 :
            exit$1 = 5;
            break;
        case 97 :
            var match$9 = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[ Fmt_EBB ]--[--[ Alpha ]--Block.__(15, [match$9[0]])];
            break;
        case 66 :
        case 98 :
            exit$1 = 3;
            break;
        case 99 :
            var char_format = function (fmt_rest) do
              if (ign_used.contents = true, ign) then do
                return --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                            --[ Ignored_char ]--0,
                            fmt_rest
                          ])];
              end else do
                return --[ Fmt_EBB ]--[--[ Char ]--Block.__(0, [fmt_rest])];
              end end 
            end;
            var scan_format = function (fmt_rest) do
              if (ign_used.contents = true, ign) then do
                return --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                            --[ Ignored_scan_next_char ]--3,
                            fmt_rest
                          ])];
              end else do
                return --[ Fmt_EBB ]--[--[ Scan_next_char ]--Block.__(22, [fmt_rest])];
              end end 
            end;
            var match$10 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$5 = match$10[0];
            var match$11 = opt_of_pad(--[ "c" ]--99, (pad_used.contents = true, pad));
            fmt_result = match$11 ~= undefined ? (
                match$11 ~= 0 ? (
                    legacy_behavior$1 ? char_format(fmt_rest$5) : invalid_format_message(str_ind, "non-zero widths are unsupported for %c conversions")
                  ) : scan_format(fmt_rest$5)
              ) : char_format(fmt_rest$5);
            break;
        case 69 :
        case 70 :
        case 71 :
        case 72 :
        case 101 :
        case 102 :
        case 103 :
        case 104 :
            exit$1 = 2;
            break;
        case 76 :
        case 108 :
        case 110 :
            exit$2 = 8;
            break;
        case 114 :
            var match$12 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$6 = match$12[0];
            fmt_result = (ign_used.contents = true, ign) ? --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    --[ Ignored_reader ]--2,
                    fmt_rest$6
                  ])] : --[ Fmt_EBB ]--[--[ Reader ]--Block.__(19, [fmt_rest$6])];
            break;
        case 115 :
            var pad$2 = check_no_0(symb, (pad_used.contents = true, padprec));
            var match$13 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$7 = match$13[0];
            if (ign_used.contents = true, ign) then do
              var ignored$4 = --[ Ignored_string ]--Block.__(0, [opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, padprec))]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$4,
                    fmt_rest$7
                  ])];
            end else do
              var match$14 = make_padding_fmt_ebb(pad$2, fmt_rest$7);
              fmt_result = --[ Fmt_EBB ]--[--[ String ]--Block.__(2, [
                    match$14[0],
                    match$14[1]
                  ])];
            end end 
            break;
        case 116 :
            var match$15 = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[ Fmt_EBB ]--[--[ Theta ]--Block.__(16, [match$15[0]])];
            break;
        case 88 :
        case 100 :
        case 105 :
        case 111 :
        case 117 :
        case 120 :
            exit$2 = 7;
            break;
        case 0 :
        case 1 :
        case 2 :
        case 3 :
        case 4 :
        case 5 :
        case 6 :
        case 7 :
        case 8 :
        case 9 :
        case 10 :
        case 11 :
        case 12 :
        case 13 :
        case 14 :
        case 15 :
        case 16 :
        case 17 :
        case 18 :
        case 19 :
        case 20 :
        case 21 :
        case 22 :
        case 23 :
        case 24 :
        case 25 :
        case 26 :
        case 27 :
        case 28 :
        case 29 :
        case 30 :
        case 31 :
        case 34 :
        case 36 :
        case 38 :
        case 39 :
        case 41 :
        case 42 :
        case 46 :
        case 47 :
        case 48 :
        case 49 :
        case 50 :
        case 51 :
        case 52 :
        case 53 :
        case 54 :
        case 55 :
        case 56 :
        case 57 :
        case 58 :
        case 59 :
        case 60 :
        case 61 :
        case 62 :
        case 63 :
        case 65 :
        case 68 :
        case 73 :
        case 74 :
        case 75 :
        case 77 :
        case 79 :
        case 80 :
        case 81 :
        case 82 :
        case 84 :
        case 85 :
        case 86 :
        case 87 :
        case 89 :
        case 90 :
        case 92 :
        case 93 :
        case 94 :
        case 96 :
        case 106 :
        case 107 :
        case 109 :
        case 112 :
        case 113 :
        case 118 :
        case 119 :
        case 121 :
        case 122 :
            exit$1 = 6;
            break;
        case 123 :
            var sub_end$1 = search_subformat_end(str_ind, end_ind, --[ "}" ]--125);
            var match$16 = parse_literal(str_ind, str_ind, sub_end$1);
            var beg_ind$1 = sub_end$1 + 2 | 0;
            var match$17 = parse_literal(beg_ind$1, beg_ind$1, end_ind);
            var fmt_rest$8 = match$17[0];
            var sub_fmtty$1 = fmtty_of_fmt(match$16[0]);
            if (ign_used.contents = true, ign) then do
              var ignored_000$2 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
              var ignored$5 = --[ Ignored_format_arg ]--Block.__(8, [
                  ignored_000$2,
                  sub_fmtty$1
                ]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$5,
                    fmt_rest$8
                  ])];
            end else do
              fmt_result = --[ Fmt_EBB ]--[--[ Format_arg ]--Block.__(13, [
                    opt_of_pad(--[ "{" ]--123, (pad_used.contents = true, pad)),
                    sub_fmtty$1,
                    fmt_rest$8
                  ])];
            end end 
            break;
        
      end
    end end 
    switch (exit$2) do
      case 7 :
          plus_used = true;
          hash_used = true;
          space_used = true;
          var iconv = compute_int_conv(pct_ind, str_ind, plus, hash, space, symb);
          var match$18 = parse_literal(str_ind, str_ind, end_ind);
          var fmt_rest$9 = match$18[0];
          if (ign_used.contents = true, ign) then do
            var ignored_001 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
            var ignored$6 = --[ Ignored_int ]--Block.__(2, [
                iconv,
                ignored_001
              ]);
            fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                  ignored$6,
                  fmt_rest$9
                ])];
          end else do
            var match$19 = make_padprec_fmt_ebb(get_int_pad(--[ () ]--0), (prec_used.contents = true, prec), fmt_rest$9);
            fmt_result = --[ Fmt_EBB ]--[--[ Int ]--Block.__(4, [
                  iconv,
                  match$19[0],
                  match$19[1],
                  match$19[2]
                ])];
          end end 
          break;
      case 8 :
          if (str_ind == end_ind or !is_int_base(Caml_string.get(str, str_ind))) then do
            var match$20 = parse_literal(str_ind, str_ind, end_ind);
            var fmt_rest$10 = match$20[0];
            var counter = counter_of_char(symb);
            if (ign_used.contents = true, ign) then do
              var ignored$7 = --[ Ignored_scan_get_counter ]--Block.__(11, [counter]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$7,
                    fmt_rest$10
                  ])];
            end else do
              fmt_result = --[ Fmt_EBB ]--[--[ Scan_get_counter ]--Block.__(21, [
                    counter,
                    fmt_rest$10
                  ])];
            end end 
          end else do
            exit$1 = 6;
          end end 
          break;
      
    end
    switch (exit$1) do
      case 2 :
          plus_used = true;
          space_used = true;
          var fconv = compute_float_conv(pct_ind, str_ind, plus, space, symb);
          var match$21 = parse_literal(str_ind, str_ind, end_ind);
          var fmt_rest$11 = match$21[0];
          if (ign_used.contents = true, ign) then do
            var ignored_000$3 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
            var ignored_001$1 = get_prec_opt(--[ () ]--0);
            var ignored$8 = --[ Ignored_float ]--Block.__(6, [
                ignored_000$3,
                ignored_001$1
              ]);
            fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                  ignored$8,
                  fmt_rest$11
                ])];
          end else do
            var match$22 = make_padprec_fmt_ebb((pad_used.contents = true, pad), (prec_used.contents = true, prec), fmt_rest$11);
            fmt_result = --[ Fmt_EBB ]--[--[ Float ]--Block.__(8, [
                  fconv,
                  match$22[0],
                  match$22[1],
                  match$22[2]
                ])];
          end end 
          break;
      case 3 :
          var pad$3 = check_no_0(symb, (pad_used.contents = true, padprec));
          var match$23 = parse_literal(str_ind, str_ind, end_ind);
          var fmt_rest$12 = match$23[0];
          if (ign_used.contents = true, ign) then do
            var ignored$9 = --[ Ignored_bool ]--Block.__(7, [opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, padprec))]);
            fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                  ignored$9,
                  fmt_rest$12
                ])];
          end else do
            var match$24 = make_padding_fmt_ebb(pad$3, fmt_rest$12);
            fmt_result = --[ Fmt_EBB ]--[--[ Bool ]--Block.__(9, [
                  match$24[0],
                  match$24[1]
                ])];
          end end 
          break;
      case 4 :
          var match$25 = parse_literal(str_ind, str_ind, end_ind);
          fmt_result = --[ Fmt_EBB ]--[--[ Char_literal ]--Block.__(12, [
                symb,
                match$25[0]
              ])];
          break;
      case 5 :
          fmt_result = Curry._3(failwith_message(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "invalid format ",
                        --[ Caml_string ]--Block.__(3, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": at character number ",
                                --[ Int ]--Block.__(4, [
                                    --[ Int_d ]--0,
                                    --[ No_padding ]--0,
                                    --[ No_precision ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ", flag ",
                                        --[ Caml_char ]--Block.__(1, [--[ String_literal ]--Block.__(11, [
                                                " is only allowed after the '",
                                                --[ Char_literal ]--Block.__(12, [
                                                    --[ "%" ]--37,
                                                    --[ String_literal ]--Block.__(11, [
                                                        "', before padding and precision",
                                                        --[ End_of_format ]--0
                                                      ])
                                                  ])
                                              ])])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "invalid format %S: at character number %d, flag %C is only allowed after the '%%', before padding and precision"
                  ]), str, pct_ind, symb);
          break;
      case 6 :
          if (symb >= 108) then do
            if (symb >= 111) then do
              exit = 1;
            end else do
              switch (symb - 108 | 0) do
                case 0 :
                    plus_used = true;
                    hash_used = true;
                    space_used = true;
                    var iconv$1 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
                    var beg_ind$2 = str_ind + 1 | 0;
                    var match$26 = parse_literal(beg_ind$2, beg_ind$2, end_ind);
                    var fmt_rest$13 = match$26[0];
                    if (ign_used.contents = true, ign) then do
                      var ignored_001$2 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
                      var ignored$10 = --[ Ignored_int32 ]--Block.__(3, [
                          iconv$1,
                          ignored_001$2
                        ]);
                      fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                            ignored$10,
                            fmt_rest$13
                          ])];
                    end else do
                      var match$27 = make_padprec_fmt_ebb(get_int_pad(--[ () ]--0), (prec_used.contents = true, prec), fmt_rest$13);
                      fmt_result = --[ Fmt_EBB ]--[--[ Int32 ]--Block.__(5, [
                            iconv$1,
                            match$27[0],
                            match$27[1],
                            match$27[2]
                          ])];
                    end end 
                    break;
                case 1 :
                    exit = 1;
                    break;
                case 2 :
                    plus_used = true;
                    hash_used = true;
                    space_used = true;
                    var iconv$2 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
                    var beg_ind$3 = str_ind + 1 | 0;
                    var match$28 = parse_literal(beg_ind$3, beg_ind$3, end_ind);
                    var fmt_rest$14 = match$28[0];
                    if (ign_used.contents = true, ign) then do
                      var ignored_001$3 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
                      var ignored$11 = --[ Ignored_nativeint ]--Block.__(4, [
                          iconv$2,
                          ignored_001$3
                        ]);
                      fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                            ignored$11,
                            fmt_rest$14
                          ])];
                    end else do
                      var match$29 = make_padprec_fmt_ebb(get_int_pad(--[ () ]--0), (prec_used.contents = true, prec), fmt_rest$14);
                      fmt_result = --[ Fmt_EBB ]--[--[ Nativeint ]--Block.__(6, [
                            iconv$2,
                            match$29[0],
                            match$29[1],
                            match$29[2]
                          ])];
                    end end 
                    break;
                
              end
            end end 
          end else if (symb ~= 76) then do
            exit = 1;
          end else do
            plus_used = true;
            hash_used = true;
            space_used = true;
            var iconv$3 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
            var beg_ind$4 = str_ind + 1 | 0;
            var match$30 = parse_literal(beg_ind$4, beg_ind$4, end_ind);
            var fmt_rest$15 = match$30[0];
            if (ign_used.contents = true, ign) then do
              var ignored_001$4 = opt_of_pad(--[ "_" ]--95, (pad_used.contents = true, pad));
              var ignored$12 = --[ Ignored_int64 ]--Block.__(5, [
                  iconv$3,
                  ignored_001$4
                ]);
              fmt_result = --[ Fmt_EBB ]--[--[ Ignored_param ]--Block.__(23, [
                    ignored$12,
                    fmt_rest$15
                  ])];
            end else do
              var match$31 = make_padprec_fmt_ebb(get_int_pad(--[ () ]--0), (prec_used.contents = true, prec), fmt_rest$15);
              fmt_result = --[ Fmt_EBB ]--[--[ Int64 ]--Block.__(7, [
                    iconv$3,
                    match$31[0],
                    match$31[1],
                    match$31[2]
                  ])];
            end end 
          end end  end 
          break;
      
    end
    if (exit == 1) then do
      fmt_result = Curry._3(failwith_message(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "invalid format ",
                    --[ Caml_string ]--Block.__(3, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ": at character number ",
                            --[ Int ]--Block.__(4, [
                                --[ Int_d ]--0,
                                --[ No_padding ]--0,
                                --[ No_precision ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    ", invalid conversion \"",
                                    --[ Char_literal ]--Block.__(12, [
                                        --[ "%" ]--37,
                                        --[ Char ]--Block.__(0, [--[ Char_literal ]--Block.__(12, [
                                                --[ "\"" ]--34,
                                                --[ End_of_format ]--0
                                              ])])
                                      ])
                                  ])
                              ])
                          ])
                      ])
                  ]),
                "invalid format %S: at character number %d, invalid conversion \"%%%c\""
              ]), str, str_ind - 1 | 0, symb);
    end
     end 
    if (!legacy_behavior$1) then do
      if (!plus_used and plus) then do
        incompatible_flag(pct_ind, str_ind, symb, "'+'");
      end
       end 
      if (!hash_used and hash) then do
        incompatible_flag(pct_ind, str_ind, symb, "'#'");
      end
       end 
      if (!space_used and space) then do
        incompatible_flag(pct_ind, str_ind, symb, "' '");
      end
       end 
      if (!pad_used.contents and Caml_obj.caml_notequal(--[ Padding_EBB ]--[pad], --[ Padding_EBB ]--[--[ No_padding ]--0])) then do
        incompatible_flag(pct_ind, str_ind, symb, "`padding'");
      end
       end 
      if (!prec_used.contents and Caml_obj.caml_notequal(--[ Precision_EBB ]--[prec], --[ Precision_EBB ]--[--[ No_precision ]--0])) then do
        incompatible_flag(pct_ind, str_ind, ign ? --[ "_" ]--95 : symb, "`precision'");
      end
       end 
      if (ign and plus) then do
        incompatible_flag(pct_ind, str_ind, --[ "_" ]--95, "'+'");
      end
       end 
    end
     end 
    if (!ign_used.contents and ign) then do
      var exit$3 = 0;
      if (symb >= 38) then do
        if (symb ~= 44) then do
          if (symb ~= 64 or !legacy_behavior$1) then do
            exit$3 = 1;
          end
           end 
        end else if (!legacy_behavior$1) then do
          exit$3 = 1;
        end
         end  end 
      end else if (symb ~= 33) then do
        if (!(symb >= 37 and legacy_behavior$1)) then do
          exit$3 = 1;
        end
         end 
      end else if (!legacy_behavior$1) then do
        exit$3 = 1;
      end
       end  end  end 
      if (exit$3 == 1) then do
        incompatible_flag(pct_ind, str_ind, symb, "'_'");
      end
       end 
    end
     end 
    return fmt_result;
  end;
  var parse_integer = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    var match = Caml_string.get(str, str_ind);
    if (match >= 48) then do
      if (match >= 58) then do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                2814,
                11
              ]
            ];
      end
       end 
      return parse_positive(str_ind, end_ind, 0);
    end else do
      if (match ~= 45) then do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                2814,
                11
              ]
            ];
      end
       end 
      if ((str_ind + 1 | 0) == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      var c = Caml_string.get(str, str_ind + 1 | 0);
      if (c > 57 or c < 48) then do
        return expected_character(str_ind + 1 | 0, "digit", c);
      end else do
        var match$1 = parse_positive(str_ind + 1 | 0, end_ind, 0);
        return --[ tuple ]--[
                match$1[0],
                -match$1[1] | 0
              ];
      end end 
    end end 
  end;
  var incompatible_flag = function (pct_ind, str_ind, symb, option) do
    var subfmt = $$String.sub(str, pct_ind, str_ind - pct_ind | 0);
    return Curry._5(failwith_message(--[ Format ]--[
                    --[ String_literal ]--Block.__(11, [
                        "invalid format ",
                        --[ Caml_string ]--Block.__(3, [
                            --[ No_padding ]--0,
                            --[ String_literal ]--Block.__(11, [
                                ": at character number ",
                                --[ Int ]--Block.__(4, [
                                    --[ Int_d ]--0,
                                    --[ No_padding ]--0,
                                    --[ No_precision ]--0,
                                    --[ String_literal ]--Block.__(11, [
                                        ", ",
                                        --[ String ]--Block.__(2, [
                                            --[ No_padding ]--0,
                                            --[ String_literal ]--Block.__(11, [
                                                " is incompatible with '",
                                                --[ Char ]--Block.__(0, [--[ String_literal ]--Block.__(11, [
                                                        "' in sub-format ",
                                                        --[ Caml_string ]--Block.__(3, [
                                                            --[ No_padding ]--0,
                                                            --[ End_of_format ]--0
                                                          ])
                                                      ])])
                                              ])
                                          ])
                                      ])
                                  ])
                              ])
                          ])
                      ]),
                    "invalid format %S: at character number %d, %s is incompatible with '%c' in sub-format %S"
                  ]), str, pct_ind, option, symb, subfmt);
  end;
  var parse_after_padding = function (pct_ind, str_ind, end_ind, minus, plus, hash, space, ign, pad) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    var symb = Caml_string.get(str, str_ind);
    if (symb ~= 46) then do
      return parse_conversion(pct_ind, str_ind + 1 | 0, end_ind, plus, hash, space, ign, pad, --[ No_precision ]--0, pad, symb);
    end else do
      var pct_ind$1 = pct_ind;
      var str_ind$1 = str_ind + 1 | 0;
      var end_ind$1 = end_ind;
      var minus$1 = minus;
      var plus$1 = plus;
      var hash$1 = hash;
      var space$1 = space;
      var ign$1 = ign;
      var pad$1 = pad;
      if (str_ind$1 == end_ind$1) then do
        invalid_format_message(end_ind$1, "unexpected end of format");
      end
       end 
      var parse_literal = function (minus, str_ind) do
        var match = parse_positive(str_ind, end_ind$1, 0);
        return parse_after_precision(pct_ind$1, match[0], end_ind$1, minus, plus$1, hash$1, space$1, ign$1, pad$1, --[ Lit_precision ]--[match[1]]);
      end;
      var symb$1 = Caml_string.get(str, str_ind$1);
      var exit = 0;
      if (symb$1 >= 48) then do
        if (symb$1 < 58) then do
          return parse_literal(minus$1, str_ind$1);
        end
         end 
      end else if (symb$1 >= 42) then do
        switch (symb$1 - 42 | 0) do
          case 0 :
              return parse_after_precision(pct_ind$1, str_ind$1 + 1 | 0, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, pad$1, --[ Arg_precision ]--1);
          case 1 :
          case 3 :
              exit = 2;
              break;
          case 2 :
          case 4 :
          case 5 :
              break;
          
        end
      end
       end  end 
      if (exit == 2 and legacy_behavior$1) then do
        return parse_literal(minus$1 or symb$1 == --[ "-" ]--45, str_ind$1 + 1 | 0);
      end
       end 
      if (legacy_behavior$1) then do
        return parse_after_precision(pct_ind$1, str_ind$1, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, pad$1, --[ Lit_precision ]--[0]);
      end else do
        return invalid_format_without(str_ind$1 - 1 | 0, --[ "." ]--46, "precision");
      end end 
    end end 
  end;
  var is_int_base = function (symb) do
    switch (symb) do
      case 89 :
      case 90 :
      case 91 :
      case 92 :
      case 93 :
      case 94 :
      case 95 :
      case 96 :
      case 97 :
      case 98 :
      case 99 :
      case 101 :
      case 102 :
      case 103 :
      case 104 :
      case 106 :
      case 107 :
      case 108 :
      case 109 :
      case 110 :
      case 112 :
      case 113 :
      case 114 :
      case 115 :
      case 116 :
      case 118 :
      case 119 :
          return false;
      case 88 :
      case 100 :
      case 105 :
      case 111 :
      case 117 :
      case 120 :
          return true;
      default:
        return false;
    end
  end;
  var counter_of_char = function (symb) do
    if (symb >= 108) then do
      if (symb < 111) then do
        switch (symb - 108 | 0) do
          case 0 :
              return --[ Line_counter ]--0;
          case 1 :
              break;
          case 2 :
              return --[ Char_counter ]--1;
          
        end
      end
       end 
    end else if (symb == 76) then do
      return --[ Token_counter ]--2;
    end
     end  end 
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "camlinternalFormat.ml",
            2876,
            34
          ]
        ];
  end;
  var parse_char_set = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    var char_set = Bytes.make(32, --[ "\000" ]--0);
    var add_range = function (c, c$prime) do
      for(var i = c; i <= c$prime; ++i)do
        add_in_char_set(char_set, Pervasives.char_of_int(i));
      end
      return --[ () ]--0;
    end;
    var fail_single_percent = function (str_ind) do
      return Curry._2(failwith_message(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "invalid format ",
                          --[ Caml_string ]--Block.__(3, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  ": '",
                                  --[ Char_literal ]--Block.__(12, [
                                      --[ "%" ]--37,
                                      --[ String_literal ]--Block.__(11, [
                                          "' alone is not accepted in character sets, use ",
                                          --[ Char_literal ]--Block.__(12, [
                                              --[ "%" ]--37,
                                              --[ Char_literal ]--Block.__(12, [
                                                  --[ "%" ]--37,
                                                  --[ String_literal ]--Block.__(11, [
                                                      " instead at position ",
                                                      --[ Int ]--Block.__(4, [
                                                          --[ Int_d ]--0,
                                                          --[ No_padding ]--0,
                                                          --[ No_precision ]--0,
                                                          --[ Char_literal ]--Block.__(12, [
                                                              --[ "." ]--46,
                                                              --[ End_of_format ]--0
                                                            ])
                                                        ])
                                                    ])
                                                ])
                                            ])
                                        ])
                                    ])
                                ])
                            ])
                        ]),
                      "invalid format %S: '%%' alone is not accepted in character sets, use %%%% instead at position %d."
                    ]), str, str_ind);
    end;
    var parse_char_set_content = function (_str_ind, end_ind) do
      while(true) do
        var str_ind = _str_ind;
        if (str_ind == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        var c = Caml_string.get(str, str_ind);
        if (c ~= 45) then do
          if (c ~= 93) then do
            return parse_char_set_after_char(str_ind + 1 | 0, end_ind, c);
          end else do
            return str_ind + 1 | 0;
          end end 
        end else do
          add_in_char_set(char_set, --[ "-" ]--45);
          _str_ind = str_ind + 1 | 0;
          continue ;
        end end 
      end;
    end;
    var parse_char_set_after_char = function (_str_ind, end_ind, _c) do
      while(true) do
        var c = _c;
        var str_ind = _str_ind;
        if (str_ind == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        var c$prime = Caml_string.get(str, str_ind);
        var exit = 0;
        if (c$prime >= 46) then do
          if (c$prime ~= 64) then do
            if (c$prime == 93) then do
              add_in_char_set(char_set, c);
              return str_ind + 1 | 0;
            end
             end 
          end else do
            exit = 2;
          end end 
        end else if (c$prime ~= 37) then do
          if (c$prime >= 45) then do
            var str_ind$1 = str_ind + 1 | 0;
            var end_ind$1 = end_ind;
            var c$1 = c;
            if (str_ind$1 == end_ind$1) then do
              invalid_format_message(end_ind$1, "unexpected end of format");
            end
             end 
            var c$prime$1 = Caml_string.get(str, str_ind$1);
            if (c$prime$1 ~= 37) then do
              if (c$prime$1 ~= 93) then do
                add_range(c$1, c$prime$1);
                return parse_char_set_content(str_ind$1 + 1 | 0, end_ind$1);
              end else do
                add_in_char_set(char_set, c$1);
                add_in_char_set(char_set, --[ "-" ]--45);
                return str_ind$1 + 1 | 0;
              end end 
            end else do
              if ((str_ind$1 + 1 | 0) == end_ind$1) then do
                invalid_format_message(end_ind$1, "unexpected end of format");
              end
               end 
              var c$prime$2 = Caml_string.get(str, str_ind$1 + 1 | 0);
              if (c$prime$2 ~= 37 and c$prime$2 ~= 64) then do
                return fail_single_percent(str_ind$1);
              end
               end 
              add_range(c$1, c$prime$2);
              return parse_char_set_content(str_ind$1 + 2 | 0, end_ind$1);
            end end 
          end
           end 
        end else do
          exit = 2;
        end end  end 
        if (exit == 2 and c == --[ "%" ]--37) then do
          add_in_char_set(char_set, c$prime);
          return parse_char_set_content(str_ind + 1 | 0, end_ind);
        end
         end 
        if (c == --[ "%" ]--37) then do
          fail_single_percent(str_ind);
        end
         end 
        add_in_char_set(char_set, c);
        _c = c$prime;
        _str_ind = str_ind + 1 | 0;
        continue ;
      end;
    end;
    var parse_char_set_start = function (str_ind, end_ind) do
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      var c = Caml_string.get(str, str_ind);
      return parse_char_set_after_char(str_ind + 1 | 0, end_ind, c);
    end;
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    var match = Caml_string.get(str, str_ind);
    var match$1 = match ~= 94 ? --[ tuple ]--[
        str_ind,
        false
      ] : --[ tuple ]--[
        str_ind + 1 | 0,
        true
      ];
    var next_ind = parse_char_set_start(match$1[0], end_ind);
    var char_set$1 = Bytes.to_string(char_set);
    return --[ tuple ]--[
            next_ind,
            match$1[1] ? rev_char_set(char_set$1) : char_set$1
          ];
  end;
  var compute_int_conv = function (pct_ind, str_ind, _plus, _hash, _space, symb) do
    while(true) do
      var space = _space;
      var hash = _hash;
      var plus = _plus;
      var exit = 0;
      if (plus) then do
        if (hash) then do
          exit = 2;
        end else if (!space) then do
          if (symb ~= 100) then do
            if (symb == 105) then do
              return --[ Int_pi ]--4;
            end
             end 
          end else do
            return --[ Int_pd ]--1;
          end end 
        end
         end  end 
      end else if (hash) then do
        if (space) then do
          exit = 2;
        end else if (symb ~= 88) then do
          if (symb ~= 111) then do
            if (symb ~= 120) then do
              exit = 2;
            end else do
              return --[ Int_Cx ]--7;
            end end 
          end else do
            return --[ Int_Co ]--11;
          end end 
        end else do
          return --[ Int_CX ]--9;
        end end  end 
      end else if (space) then do
        if (symb ~= 100) then do
          if (symb == 105) then do
            return --[ Int_si ]--5;
          end
           end 
        end else do
          return --[ Int_sd ]--2;
        end end 
      end else do
        switch (symb) do
          case 88 :
              return --[ Int_X ]--8;
          case 100 :
              return --[ Int_d ]--0;
          case 105 :
              return --[ Int_i ]--3;
          case 111 :
              return --[ Int_o ]--10;
          case 117 :
              return --[ Int_u ]--12;
          case 89 :
          case 90 :
          case 91 :
          case 92 :
          case 93 :
          case 94 :
          case 95 :
          case 96 :
          case 97 :
          case 98 :
          case 99 :
          case 101 :
          case 102 :
          case 103 :
          case 104 :
          case 106 :
          case 107 :
          case 108 :
          case 109 :
          case 110 :
          case 112 :
          case 113 :
          case 114 :
          case 115 :
          case 116 :
          case 118 :
          case 119 :
              break;
          case 120 :
              return --[ Int_x ]--6;
          default:
            
        end
      end end  end  end 
      if (exit == 2) then do
        var exit$1 = 0;
        switch (symb) do
          case 88 :
              if (legacy_behavior$1) then do
                return --[ Int_CX ]--9;
              end
               end 
              break;
          case 111 :
              if (legacy_behavior$1) then do
                return --[ Int_Co ]--11;
              end
               end 
              break;
          case 100 :
          case 105 :
          case 117 :
              exit$1 = 3;
              break;
          case 89 :
          case 90 :
          case 91 :
          case 92 :
          case 93 :
          case 94 :
          case 95 :
          case 96 :
          case 97 :
          case 98 :
          case 99 :
          case 101 :
          case 102 :
          case 103 :
          case 104 :
          case 106 :
          case 107 :
          case 108 :
          case 109 :
          case 110 :
          case 112 :
          case 113 :
          case 114 :
          case 115 :
          case 116 :
          case 118 :
          case 119 :
              break;
          case 120 :
              if (legacy_behavior$1) then do
                return --[ Int_Cx ]--7;
              end
               end 
              break;
          default:
            
        end
        if (exit$1 == 3) then do
          if (legacy_behavior$1) then do
            _hash = false;
            continue ;
          end else do
            return incompatible_flag(pct_ind, str_ind, symb, "'#'");
          end end 
        end
         end 
      end
       end 
      if (plus) then do
        if (space) then do
          if (legacy_behavior$1) then do
            _space = false;
            continue ;
          end else do
            return incompatible_flag(pct_ind, str_ind, --[ " " ]--32, "'+'");
          end end 
        end else if (legacy_behavior$1) then do
          _plus = false;
          continue ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "'+'");
        end end  end 
      end else if (space) then do
        if (legacy_behavior$1) then do
          _space = false;
          continue ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "' '");
        end end 
      end else do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                2909,
                28
              ]
            ];
      end end  end 
    end;
  end;
  var compute_float_conv = function (pct_ind, str_ind, _plus, _space, symb) do
    while(true) do
      var space = _space;
      var plus = _plus;
      if (plus) then do
        if (space) then do
          if (legacy_behavior$1) then do
            _space = false;
            continue ;
          end else do
            return incompatible_flag(pct_ind, str_ind, --[ " " ]--32, "'+'");
          end end 
        end else do
          if (symb >= 73) then do
            switch (symb) do
              case 101 :
                  return --[ Float_pe ]--4;
              case 102 :
                  return --[ Float_pf ]--1;
              case 103 :
                  return --[ Float_pg ]--10;
              case 104 :
                  return --[ Float_ph ]--17;
              default:
                
            end
          end else if (symb >= 69) then do
            switch (symb - 69 | 0) do
              case 0 :
                  return --[ Float_pE ]--7;
              case 1 :
                  break;
              case 2 :
                  return --[ Float_pG ]--13;
              case 3 :
                  return --[ Float_pH ]--20;
              
            end
          end
           end  end 
          if (legacy_behavior$1) then do
            _plus = false;
            continue ;
          end else do
            return incompatible_flag(pct_ind, str_ind, symb, "'+'");
          end end 
        end end 
      end else if (space) then do
        if (symb >= 73) then do
          switch (symb) do
            case 101 :
                return --[ Float_se ]--5;
            case 102 :
                return --[ Float_sf ]--2;
            case 103 :
                return --[ Float_sg ]--11;
            case 104 :
                return --[ Float_sh ]--18;
            default:
              
          end
        end else if (symb >= 69) then do
          switch (symb - 69 | 0) do
            case 0 :
                return --[ Float_sE ]--8;
            case 1 :
                break;
            case 2 :
                return --[ Float_sG ]--14;
            case 3 :
                return --[ Float_sH ]--21;
            
          end
        end
         end  end 
        if (legacy_behavior$1) then do
          _space = false;
          continue ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "' '");
        end end 
      end else if (symb >= 73) then do
        switch (symb) do
          case 101 :
              return --[ Float_e ]--3;
          case 102 :
              return --[ Float_f ]--0;
          case 103 :
              return --[ Float_g ]--9;
          case 104 :
              return --[ Float_h ]--16;
          default:
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[ tuple ]--[
                    "camlinternalFormat.ml",
                    2943,
                    25
                  ]
                ];
        end
      end else if (symb >= 69) then do
        switch (symb - 69 | 0) do
          case 0 :
              return --[ Float_E ]--6;
          case 1 :
              return --[ Float_F ]--15;
          case 2 :
              return --[ Float_G ]--12;
          case 3 :
              return --[ Float_H ]--19;
          
        end
      end else do
        throw [
              Caml_builtin_exceptions.assert_failure,
              --[ tuple ]--[
                "camlinternalFormat.ml",
                2943,
                25
              ]
            ];
      end end  end  end  end 
    end;
  end;
  var parse_after_precision = function (pct_ind, str_ind, end_ind, minus, plus, hash, space, ign, pad, prec) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    var parse_conv = function (padprec) do
      return parse_conversion(pct_ind, str_ind + 1 | 0, end_ind, plus, hash, space, ign, pad, prec, padprec, Caml_string.get(str, str_ind));
    end;
    if (typeof pad == "number") then do
      if (typeof prec == "number" and prec == 0) then do
        return parse_conv(--[ No_padding ]--0);
      end
       end 
      if (minus) then do
        if (typeof prec == "number") then do
          return parse_conv(--[ Arg_padding ]--Block.__(1, [--[ Left ]--0]));
        end else do
          return parse_conv(--[ Lit_padding ]--Block.__(0, [
                        --[ Left ]--0,
                        prec[0]
                      ]));
        end end 
      end else if (typeof prec == "number") then do
        return parse_conv(--[ Arg_padding ]--Block.__(1, [--[ Right ]--1]));
      end else do
        return parse_conv(--[ Lit_padding ]--Block.__(0, [
                      --[ Right ]--1,
                      prec[0]
                    ]));
      end end  end 
    end else do
      return parse_conv(pad);
    end end 
  end;
  var parse_tag = function (is_open_tag, str_ind, end_ind) do
    try do
      if (str_ind == end_ind) then do
        throw Caml_builtin_exceptions.not_found;
      end
       end 
      var match = Caml_string.get(str, str_ind);
      if (match ~= 60) then do
        throw Caml_builtin_exceptions.not_found;
      end
       end 
      var ind = $$String.index_from(str, str_ind + 1 | 0, --[ ">" ]--62);
      if (ind >= end_ind) then do
        throw Caml_builtin_exceptions.not_found;
      end
       end 
      var sub_str = $$String.sub(str, str_ind, (ind - str_ind | 0) + 1 | 0);
      var beg_ind = ind + 1 | 0;
      var match$1 = parse_literal(beg_ind, beg_ind, end_ind);
      var match$2 = parse_literal(str_ind, str_ind, ind + 1 | 0);
      var sub_fmt = match$2[0];
      var sub_format = --[ Format ]--[
        sub_fmt,
        sub_str
      ];
      var formatting = is_open_tag ? --[ Open_tag ]--Block.__(0, [sub_format]) : (check_open_box(sub_fmt), --[ Open_box ]--Block.__(1, [sub_format]));
      return --[ Fmt_EBB ]--[--[ Formatting_gen ]--Block.__(18, [
                  formatting,
                  match$1[0]
                ])];
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        var match$3 = parse_literal(str_ind, str_ind, end_ind);
        var sub_format$1 = --[ Format ]--[
          --[ End_of_format ]--0,
          ""
        ];
        var formatting$1 = is_open_tag ? --[ Open_tag ]--Block.__(0, [sub_format$1]) : --[ Open_box ]--Block.__(1, [sub_format$1]);
        return --[ Fmt_EBB ]--[--[ Formatting_gen ]--Block.__(18, [
                    formatting$1,
                    match$3[0]
                  ])];
      end else do
        throw exn;
      end end 
    end
  end;
  return parse_literal(0, 0, #str);
end

function format_of_string_fmtty(str, fmtty) do
  var match = fmt_ebb_of_string(undefined, str);
  try do
    return --[ Format ]--[
            type_format(match[0], fmtty),
            str
          ];
  end
  catch (exn)do
    if (exn == Type_mismatch) then do
      return Curry._2(failwith_message(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "bad input: format type mismatch between ",
                          --[ Caml_string ]--Block.__(3, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  " and ",
                                  --[ Caml_string ]--Block.__(3, [
                                      --[ No_padding ]--0,
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ]),
                      "bad input: format type mismatch between %S and %S"
                    ]), str, string_of_fmtty(fmtty));
    end else do
      throw exn;
    end end 
  end
end

function format_of_string_format(str, param) do
  var match = fmt_ebb_of_string(undefined, str);
  try do
    return --[ Format ]--[
            type_format(match[0], fmtty_of_fmt(param[0])),
            str
          ];
  end
  catch (exn)do
    if (exn == Type_mismatch) then do
      return Curry._2(failwith_message(--[ Format ]--[
                      --[ String_literal ]--Block.__(11, [
                          "bad input: format type mismatch between ",
                          --[ Caml_string ]--Block.__(3, [
                              --[ No_padding ]--0,
                              --[ String_literal ]--Block.__(11, [
                                  " and ",
                                  --[ Caml_string ]--Block.__(3, [
                                      --[ No_padding ]--0,
                                      --[ End_of_format ]--0
                                    ])
                                ])
                            ])
                        ]),
                      "bad input: format type mismatch between %S and %S"
                    ]), str, param[1]);
    end else do
      throw exn;
    end end 
  end
end

exports.is_in_char_set = is_in_char_set;
exports.rev_char_set = rev_char_set;
exports.create_char_set = create_char_set;
exports.add_in_char_set = add_in_char_set;
exports.freeze_char_set = freeze_char_set;
exports.param_format_of_ignored_format = param_format_of_ignored_format;
exports.make_printf = make_printf;
exports.make_iprintf = make_iprintf;
exports.output_acc = output_acc;
exports.bufput_acc = bufput_acc;
exports.strput_acc = strput_acc;
exports.type_format = type_format;
exports.fmt_ebb_of_string = fmt_ebb_of_string;
exports.format_of_string_fmtty = format_of_string_fmtty;
exports.format_of_string_format = format_of_string_format;
exports.char_of_iconv = char_of_iconv;
exports.string_of_formatting_lit = string_of_formatting_lit;
exports.string_of_formatting_gen = string_of_formatting_gen;
exports.string_of_fmtty = string_of_fmtty;
exports.string_of_fmt = string_of_fmt;
exports.open_box_of_string = open_box_of_string;
exports.symm = symm;
exports.trans = trans;
exports.recast = recast;
--[ No side effect ]--
