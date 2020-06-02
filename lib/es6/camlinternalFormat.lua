

import * as Char from "./char.lua";
import * as Block from "./block.lua";
import * as Bytes from "./bytes.lua";
import * as Curry from "./curry.lua";
import * as __Buffer from "./buffer.lua";
import * as __String from "./string.lua";
import * as Caml_io from "./caml_io.lua";
import * as Caml_obj from "./caml_obj.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Caml_int32 from "./caml_int32.lua";
import * as Pervasives from "./pervasives.lua";
import * as Caml_format from "./caml_format.lua";
import * as Caml_string from "./caml_string.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";
import * as Caml_js_exceptions from "./caml_js_exceptions.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";
import * as CamlinternalFormatBasics from "./camlinternalFormatBasics.lua";

function create_char_set(param) do
  return Bytes.make(32, --[[ "\000" ]]0);
end end

function add_in_char_set(char_set, c) do
  str_ind = (c >>> 3);
  mask = (1 << (c & 7));
  char_set[str_ind] = Pervasives.char_of_int(Caml_bytes.get(char_set, str_ind) | mask);
  return --[[ () ]]0;
end end

freeze_char_set = Bytes.to_string;

function rev_char_set(char_set) do
  char_set$prime = Bytes.make(32, --[[ "\000" ]]0);
  for i = 0 , 31 , 1 do
    char_set$prime[i] = Pervasives.char_of_int(Caml_string.get(char_set, i) ^ 255);
  end
  return Caml_bytes.bytes_to_string(char_set$prime);
end end

function is_in_char_set(char_set, c) do
  str_ind = (c >>> 3);
  mask = (1 << (c & 7));
  return (Caml_string.get(char_set, str_ind) & mask) ~= 0;
end end

function pad_of_pad_opt(pad_opt) do
  if (pad_opt ~= undefined) then do
    return --[[ Lit_padding ]]Block.__(0, {
              --[[ Right ]]1,
              pad_opt
            });
  end else do
    return --[[ No_padding ]]0;
  end end 
end end

function prec_of_prec_opt(prec_opt) do
  if (prec_opt ~= undefined) then do
    return --[[ Lit_precision ]]{prec_opt};
  end else do
    return --[[ No_precision ]]0;
  end end 
end end

function param_format_of_ignored_format(ign, fmt) do
  if (typeof ign == "number") then do
    local ___conditional___=(ign);
    do
       if ___conditional___ = 0--[[ Ignored_char ]] then do
          return --[[ Param_format_EBB ]]{--[[ Char ]]Block.__(0, {fmt})};end end end 
       if ___conditional___ = 1--[[ Ignored_caml_char ]] then do
          return --[[ Param_format_EBB ]]{--[[ Caml_char ]]Block.__(1, {fmt})};end end end 
       if ___conditional___ = 2--[[ Ignored_reader ]] then do
          return --[[ Param_format_EBB ]]{--[[ Reader ]]Block.__(19, {fmt})};end end end 
       if ___conditional___ = 3--[[ Ignored_scan_next_char ]] then do
          return --[[ Param_format_EBB ]]{--[[ Scan_next_char ]]Block.__(22, {fmt})};end end end 
       do
      
    end
  end else do
    local ___conditional___=(ign.tag | 0);
    do
       if ___conditional___ = 0--[[ Ignored_string ]] then do
          return --[[ Param_format_EBB ]]{--[[ String ]]Block.__(2, {
                      pad_of_pad_opt(ign[0]),
                      fmt
                    })};end end end 
       if ___conditional___ = 1--[[ Ignored_caml_string ]] then do
          return --[[ Param_format_EBB ]]{--[[ Caml_string ]]Block.__(3, {
                      pad_of_pad_opt(ign[0]),
                      fmt
                    })};end end end 
       if ___conditional___ = 2--[[ Ignored_int ]] then do
          return --[[ Param_format_EBB ]]{--[[ Int ]]Block.__(4, {
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[[ No_precision ]]0,
                      fmt
                    })};end end end 
       if ___conditional___ = 3--[[ Ignored_int32 ]] then do
          return --[[ Param_format_EBB ]]{--[[ Int32 ]]Block.__(5, {
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[[ No_precision ]]0,
                      fmt
                    })};end end end 
       if ___conditional___ = 4--[[ Ignored_nativeint ]] then do
          return --[[ Param_format_EBB ]]{--[[ Nativeint ]]Block.__(6, {
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[[ No_precision ]]0,
                      fmt
                    })};end end end 
       if ___conditional___ = 5--[[ Ignored_int64 ]] then do
          return --[[ Param_format_EBB ]]{--[[ Int64 ]]Block.__(7, {
                      ign[0],
                      pad_of_pad_opt(ign[1]),
                      --[[ No_precision ]]0,
                      fmt
                    })};end end end 
       if ___conditional___ = 6--[[ Ignored_float ]] then do
          return --[[ Param_format_EBB ]]{--[[ Float ]]Block.__(8, {
                      --[[ Float_f ]]0,
                      pad_of_pad_opt(ign[0]),
                      prec_of_prec_opt(ign[1]),
                      fmt
                    })};end end end 
       if ___conditional___ = 7--[[ Ignored_bool ]] then do
          return --[[ Param_format_EBB ]]{--[[ Bool ]]Block.__(9, {
                      pad_of_pad_opt(ign[0]),
                      fmt
                    })};end end end 
       if ___conditional___ = 8--[[ Ignored_format_arg ]] then do
          return --[[ Param_format_EBB ]]{--[[ Format_arg ]]Block.__(13, {
                      ign[0],
                      ign[1],
                      fmt
                    })};end end end 
       if ___conditional___ = 9--[[ Ignored_format_subst ]] then do
          return --[[ Param_format_EBB ]]{--[[ Format_subst ]]Block.__(14, {
                      ign[0],
                      ign[1],
                      fmt
                    })};end end end 
       if ___conditional___ = 10--[[ Ignored_scan_char_set ]] then do
          return --[[ Param_format_EBB ]]{--[[ Scan_char_set ]]Block.__(20, {
                      ign[0],
                      ign[1],
                      fmt
                    })};end end end 
       if ___conditional___ = 11--[[ Ignored_scan_get_counter ]] then do
          return --[[ Param_format_EBB ]]{--[[ Scan_get_counter ]]Block.__(21, {
                      ign[0],
                      fmt
                    })};end end end 
       do
      
    end
  end end 
end end

function buffer_check_size(buf, overhead) do
  len = #buf.bytes;
  min_len = buf.ind + overhead | 0;
  if (min_len > len) then do
    new_len = Caml_primitive.caml_int_max((len << 1), min_len);
    new_str = Caml_bytes.caml_create_bytes(new_len);
    Bytes.blit(buf.bytes, 0, new_str, 0, len);
    buf.bytes = new_str;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function buffer_add_char(buf, c) do
  buffer_check_size(buf, 1);
  buf.bytes[buf.ind] = c;
  buf.ind = buf.ind + 1 | 0;
  return --[[ () ]]0;
end end

function buffer_add_string(buf, s) do
  str_len = #s;
  buffer_check_size(buf, str_len);
  __String.blit(s, 0, buf.bytes, buf.ind, str_len);
  buf.ind = buf.ind + str_len | 0;
  return --[[ () ]]0;
end end

function buffer_contents(buf) do
  return Bytes.sub_string(buf.bytes, 0, buf.ind);
end end

function char_of_iconv(iconv) do
  local ___conditional___=(iconv);
  do
     if ___conditional___ = 0--[[ Int_d ]]
     or ___conditional___ = 1--[[ Int_pd ]]
     or ___conditional___ = 2--[[ Int_sd ]] then do
        return --[[ "d" ]]100;end end end 
     if ___conditional___ = 3--[[ Int_i ]]
     or ___conditional___ = 4--[[ Int_pi ]]
     or ___conditional___ = 5--[[ Int_si ]] then do
        return --[[ "i" ]]105;end end end 
     if ___conditional___ = 6--[[ Int_x ]]
     or ___conditional___ = 7--[[ Int_Cx ]] then do
        return --[[ "x" ]]120;end end end 
     if ___conditional___ = 8--[[ Int_X ]]
     or ___conditional___ = 9--[[ Int_CX ]] then do
        return --[[ "X" ]]88;end end end 
     if ___conditional___ = 10--[[ Int_o ]]
     or ___conditional___ = 11--[[ Int_Co ]] then do
        return --[[ "o" ]]111;end end end 
     if ___conditional___ = 12--[[ Int_u ]] then do
        return --[[ "u" ]]117;end end end 
     do
    
  end
end end

function char_of_fconv(fconv) do
  local ___conditional___=(fconv);
  do
     if ___conditional___ = 0--[[ Float_f ]]
     or ___conditional___ = 1--[[ Float_pf ]]
     or ___conditional___ = 2--[[ Float_sf ]] then do
        return --[[ "f" ]]102;end end end 
     if ___conditional___ = 3--[[ Float_e ]]
     or ___conditional___ = 4--[[ Float_pe ]]
     or ___conditional___ = 5--[[ Float_se ]] then do
        return --[[ "e" ]]101;end end end 
     if ___conditional___ = 6--[[ Float_E ]]
     or ___conditional___ = 7--[[ Float_pE ]]
     or ___conditional___ = 8--[[ Float_sE ]] then do
        return --[[ "E" ]]69;end end end 
     if ___conditional___ = 9--[[ Float_g ]]
     or ___conditional___ = 10--[[ Float_pg ]]
     or ___conditional___ = 11--[[ Float_sg ]] then do
        return --[[ "g" ]]103;end end end 
     if ___conditional___ = 12--[[ Float_G ]]
     or ___conditional___ = 13--[[ Float_pG ]]
     or ___conditional___ = 14--[[ Float_sG ]] then do
        return --[[ "G" ]]71;end end end 
     if ___conditional___ = 15--[[ Float_F ]] then do
        return --[[ "F" ]]70;end end end 
     if ___conditional___ = 16--[[ Float_h ]]
     or ___conditional___ = 17--[[ Float_ph ]]
     or ___conditional___ = 18--[[ Float_sh ]] then do
        return --[[ "h" ]]104;end end end 
     if ___conditional___ = 19--[[ Float_H ]]
     or ___conditional___ = 20--[[ Float_pH ]]
     or ___conditional___ = 21--[[ Float_sH ]] then do
        return --[[ "H" ]]72;end end end 
     do
    
  end
end end

function char_of_counter(counter) do
  local ___conditional___=(counter);
  do
     if ___conditional___ = 0--[[ Line_counter ]] then do
        return --[[ "l" ]]108;end end end 
     if ___conditional___ = 1--[[ Char_counter ]] then do
        return --[[ "n" ]]110;end end end 
     if ___conditional___ = 2--[[ Token_counter ]] then do
        return --[[ "N" ]]78;end end end 
     do
    
  end
end end

function bprint_char_set(buf, char_set) do
  print_char = function (buf, i) do
    c = Pervasives.char_of_int(i);
    if (c ~= 37) then do
      if (c ~= 64) then do
        return buffer_add_char(buf, c);
      end else do
        buffer_add_char(buf, --[[ "%" ]]37);
        return buffer_add_char(buf, --[[ "@" ]]64);
      end end 
    end else do
      buffer_add_char(buf, --[[ "%" ]]37);
      return buffer_add_char(buf, --[[ "%" ]]37);
    end end 
  end end;
  print_out = function (set, _i) do
    while(true) do
      i = _i;
      if (i < 256) then do
        if (is_in_char_set(set, Pervasives.char_of_int(i))) then do
          set$1 = set;
          i$1 = i;
          match = Pervasives.char_of_int(i$1);
          switcher = match - 45 | 0;
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
          ::continue:: ;
        end end 
      end else do
        return 0;
      end end 
    end;
  end end;
  print_second = function (set, i) do
    if (is_in_char_set(set, Pervasives.char_of_int(i))) then do
      match = Pervasives.char_of_int(i);
      switcher = match - 45 | 0;
      if (switcher > 48 or switcher < 0) then do
        if (switcher >= 210) then do
          print_char(buf, 254);
          return print_char(buf, 255);
        end
         end 
      end else if ((switcher > 47 or switcher < 1) and not is_in_char_set(set, Pervasives.char_of_int(i + 1 | 0))) then do
        print_char(buf, i - 1 | 0);
        return print_out(set, i + 1 | 0);
      end
       end  end 
      if (is_in_char_set(set, Pervasives.char_of_int(i + 1 | 0))) then do
        set$1 = set;
        i$1 = i - 1 | 0;
        _j = i + 2 | 0;
        while(true) do
          j = _j;
          if (j == 256 or not is_in_char_set(set$1, Pervasives.char_of_int(j))) then do
            print_char(buf, i$1);
            print_char(buf, --[[ "-" ]]45);
            print_char(buf, j - 1 | 0);
            if (j < 256) then do
              return print_out(set$1, j + 1 | 0);
            end else do
              return 0;
            end end 
          end else do
            _j = j + 1 | 0;
            ::continue:: ;
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
  end end;
  print_start = function (set) do
    is_alone = function (c) do
      before = Char.chr(c - 1 | 0);
      after = Char.chr(c + 1 | 0);
      if (is_in_char_set(set, c)) then do
        return not (is_in_char_set(set, before) and is_in_char_set(set, after));
      end else do
        return false;
      end end 
    end end;
    if (is_alone(--[[ "]" ]]93)) then do
      buffer_add_char(buf, --[[ "]" ]]93);
    end
     end 
    print_out(set, 1);
    if (is_alone(--[[ "-" ]]45)) then do
      return buffer_add_char(buf, --[[ "-" ]]45);
    end else do
      return 0;
    end end 
  end end;
  buffer_add_char(buf, --[[ "[" ]]91);
  print_start(is_in_char_set(char_set, --[[ "\000" ]]0) and (buffer_add_char(buf, --[[ "^" ]]94), rev_char_set(char_set)) or char_set);
  return buffer_add_char(buf, --[[ "]" ]]93);
end end

function bprint_padty(buf, padty) do
  local ___conditional___=(padty);
  do
     if ___conditional___ = 0--[[ Left ]] then do
        return buffer_add_char(buf, --[[ "-" ]]45);end end end 
     if ___conditional___ = 1--[[ Right ]] then do
        return --[[ () ]]0;end end end 
     if ___conditional___ = 2--[[ Zeros ]] then do
        return buffer_add_char(buf, --[[ "0" ]]48);end end end 
     do
    
  end
end end

function bprint_ignored_flag(buf, ign_flag) do
  if (ign_flag) then do
    return buffer_add_char(buf, --[[ "_" ]]95);
  end else do
    return 0;
  end end 
end end

function bprint_pad_opt(buf, pad_opt) do
  if (pad_opt ~= undefined) then do
    return buffer_add_string(buf, String(pad_opt));
  end else do
    return --[[ () ]]0;
  end end 
end end

function bprint_padding(buf, pad) do
  if (typeof pad == "number") then do
    return --[[ () ]]0;
  end else do
    bprint_padty(buf, pad[0]);
    if (pad.tag) then do
      return buffer_add_char(buf, --[[ "*" ]]42);
    end else do
      return buffer_add_string(buf, String(pad[1]));
    end end 
  end end 
end end

function bprint_precision(buf, prec) do
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      return buffer_add_string(buf, ".*");
    end else do
      return --[[ () ]]0;
    end end 
  end else do
    buffer_add_char(buf, --[[ "." ]]46);
    return buffer_add_string(buf, String(prec[0]));
  end end 
end end

function bprint_iconv_flag(buf, iconv) do
  local ___conditional___=(iconv);
  do
     if ___conditional___ = 1--[[ Int_pd ]]
     or ___conditional___ = 4--[[ Int_pi ]] then do
        return buffer_add_char(buf, --[[ "+" ]]43);end end end 
     if ___conditional___ = 2--[[ Int_sd ]]
     or ___conditional___ = 5--[[ Int_si ]] then do
        return buffer_add_char(buf, --[[ " " ]]32);end end end 
     if ___conditional___ = 7--[[ Int_Cx ]]
     or ___conditional___ = 9--[[ Int_CX ]]
     or ___conditional___ = 11--[[ Int_Co ]] then do
        return buffer_add_char(buf, --[[ "#" ]]35);end end end 
     if ___conditional___ = 0--[[ Int_d ]]
     or ___conditional___ = 3--[[ Int_i ]]
     or ___conditional___ = 6--[[ Int_x ]]
     or ___conditional___ = 8--[[ Int_X ]]
     or ___conditional___ = 10--[[ Int_o ]]
     or ___conditional___ = 12--[[ Int_u ]] then do
        return --[[ () ]]0;end end end 
     do
    
  end
end end

function bprint_int_fmt(buf, ign_flag, iconv, pad, prec) do
  buffer_add_char(buf, --[[ "%" ]]37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_iconv_flag(buf, iconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  return buffer_add_char(buf, char_of_iconv(iconv));
end end

function bprint_altint_fmt(buf, ign_flag, iconv, pad, prec, c) do
  buffer_add_char(buf, --[[ "%" ]]37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_iconv_flag(buf, iconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  buffer_add_char(buf, c);
  return buffer_add_char(buf, char_of_iconv(iconv));
end end

function bprint_fconv_flag(buf, fconv) do
  local ___conditional___=(fconv);
  do
     if ___conditional___ = 0--[[ Float_f ]]
     or ___conditional___ = 3--[[ Float_e ]]
     or ___conditional___ = 6--[[ Float_E ]]
     or ___conditional___ = 9--[[ Float_g ]]
     or ___conditional___ = 12--[[ Float_G ]]
     or ___conditional___ = 15--[[ Float_F ]]
     or ___conditional___ = 16--[[ Float_h ]]
     or ___conditional___ = 19--[[ Float_H ]] then do
        return --[[ () ]]0;end end end 
     if ___conditional___ = 1--[[ Float_pf ]]
     or ___conditional___ = 4--[[ Float_pe ]]
     or ___conditional___ = 7--[[ Float_pE ]]
     or ___conditional___ = 10--[[ Float_pg ]]
     or ___conditional___ = 13--[[ Float_pG ]]
     or ___conditional___ = 17--[[ Float_ph ]]
     or ___conditional___ = 20--[[ Float_pH ]] then do
        return buffer_add_char(buf, --[[ "+" ]]43);end end end 
     if ___conditional___ = 2--[[ Float_sf ]]
     or ___conditional___ = 5--[[ Float_se ]]
     or ___conditional___ = 8--[[ Float_sE ]]
     or ___conditional___ = 11--[[ Float_sg ]]
     or ___conditional___ = 14--[[ Float_sG ]]
     or ___conditional___ = 18--[[ Float_sh ]]
     or ___conditional___ = 21--[[ Float_sH ]] then do
        return buffer_add_char(buf, --[[ " " ]]32);end end end 
     do
    
  end
end end

function bprint_float_fmt(buf, ign_flag, fconv, pad, prec) do
  buffer_add_char(buf, --[[ "%" ]]37);
  bprint_ignored_flag(buf, ign_flag);
  bprint_fconv_flag(buf, fconv);
  bprint_padding(buf, pad);
  bprint_precision(buf, prec);
  return buffer_add_char(buf, char_of_fconv(fconv));
end end

function string_of_formatting_lit(formatting_lit) do
  if (typeof formatting_lit == "number") then do
    local ___conditional___=(formatting_lit);
    do
       if ___conditional___ = 0--[[ Close_box ]] then do
          return "@]";end end end 
       if ___conditional___ = 1--[[ Close_tag ]] then do
          return "@}";end end end 
       if ___conditional___ = 2--[[ FFlush ]] then do
          return "@?";end end end 
       if ___conditional___ = 3--[[ Force_newline ]] then do
          return "@\n";end end end 
       if ___conditional___ = 4--[[ Flush_newline ]] then do
          return "@.";end end end 
       if ___conditional___ = 5--[[ Escaped_at ]] then do
          return "@@";end end end 
       if ___conditional___ = 6--[[ Escaped_percent ]] then do
          return "@%";end end end 
       do
      
    end
  end else do
    local ___conditional___=(formatting_lit.tag | 0);
    do
       if ___conditional___ = 0--[[ Break ]]
       or ___conditional___ = 1--[[ Magic_size ]] then do
          return formatting_lit[0];end end end 
       if ___conditional___ = 2--[[ Scan_indic ]] then do
          return "@" .. Caml_bytes.bytes_to_string(Bytes.make(1, formatting_lit[0]));end end end 
       do
      
    end
  end end 
end end

function string_of_formatting_gen(formatting_gen) do
  return formatting_gen[0][1];
end end

function bprint_char_literal(buf, chr) do
  if (chr ~= 37) then do
    return buffer_add_char(buf, chr);
  end else do
    return buffer_add_string(buf, "%%");
  end end 
end end

function bprint_string_literal(buf, str) do
  for i = 0 , #str - 1 | 0 , 1 do
    bprint_char_literal(buf, Caml_string.get(str, i));
  end
  return --[[ () ]]0;
end end

function bprint_fmtty(buf, _fmtty) do
  while(true) do
    fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return --[[ () ]]0;
    end else do
      local ___conditional___=(fmtty.tag | 0);
      do
         if ___conditional___ = 0--[[ Char_ty ]] then do
            buffer_add_string(buf, "%c");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 1--[[ String_ty ]] then do
            buffer_add_string(buf, "%s");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 2--[[ Int_ty ]] then do
            buffer_add_string(buf, "%i");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 3--[[ Int32_ty ]] then do
            buffer_add_string(buf, "%li");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 4--[[ Nativeint_ty ]] then do
            buffer_add_string(buf, "%ni");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 5--[[ Int64_ty ]] then do
            buffer_add_string(buf, "%Li");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 6--[[ Float_ty ]] then do
            buffer_add_string(buf, "%f");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 7--[[ Bool_ty ]] then do
            buffer_add_string(buf, "%B");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 8--[[ Format_arg_ty ]] then do
            buffer_add_string(buf, "%{");
            bprint_fmtty(buf, fmtty[0]);
            buffer_add_string(buf, "%}");
            _fmtty = fmtty[1];
            ::continue:: ;end end end 
         if ___conditional___ = 9--[[ Format_subst_ty ]] then do
            buffer_add_string(buf, "%(");
            bprint_fmtty(buf, fmtty[0]);
            buffer_add_string(buf, "%)");
            _fmtty = fmtty[2];
            ::continue:: ;end end end 
         if ___conditional___ = 10--[[ Alpha_ty ]] then do
            buffer_add_string(buf, "%a");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 11--[[ Theta_ty ]] then do
            buffer_add_string(buf, "%t");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 12--[[ Any_ty ]] then do
            buffer_add_string(buf, "%?");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 13--[[ Reader_ty ]] then do
            buffer_add_string(buf, "%r");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
            buffer_add_string(buf, "%_r");
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         do
        
      end
    end end 
  end;
end end

function int_of_custom_arity(param) do
  if (param) then do
    return 1 + int_of_custom_arity(param[0]) | 0;
  end else do
    return 0;
  end end 
end end

function bprint_fmt(buf, fmt) do
  _fmt = fmt;
  _ign_flag = false;
  while(true) do
    ign_flag = _ign_flag;
    fmt$1 = _fmt;
    if (typeof fmt$1 == "number") then do
      return --[[ () ]]0;
    end else do
      local ___conditional___=(fmt$1.tag | 0);
      do
         if ___conditional___ = 0--[[ Char ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[[ "c" ]]99);
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 1--[[ Caml_char ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[[ "C" ]]67);
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 2--[[ String ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[[ "s" ]]115);
            _ign_flag = false;
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 3--[[ Caml_string ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[[ "S" ]]83);
            _ign_flag = false;
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 4--[[ Int ]] then do
            bprint_int_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2]);
            _ign_flag = false;
            _fmt = fmt$1[3];
            ::continue:: ;end end end 
         if ___conditional___ = 5--[[ Int32 ]] then do
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[[ "l" ]]108);
            _ign_flag = false;
            _fmt = fmt$1[3];
            ::continue:: ;end end end 
         if ___conditional___ = 6--[[ Nativeint ]] then do
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[[ "n" ]]110);
            _ign_flag = false;
            _fmt = fmt$1[3];
            ::continue:: ;end end end 
         if ___conditional___ = 7--[[ Int64 ]] then do
            bprint_altint_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2], --[[ "L" ]]76);
            _ign_flag = false;
            _fmt = fmt$1[3];
            ::continue:: ;end end end 
         if ___conditional___ = 8--[[ Float ]] then do
            bprint_float_fmt(buf, ign_flag, fmt$1[0], fmt$1[1], fmt$1[2]);
            _ign_flag = false;
            _fmt = fmt$1[3];
            ::continue:: ;end end end 
         if ___conditional___ = 9--[[ Bool ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_padding(buf, fmt$1[0]);
            buffer_add_char(buf, --[[ "B" ]]66);
            _ign_flag = false;
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 10--[[ Flush ]] then do
            buffer_add_string(buf, "%!");
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 11--[[ String_literal ]] then do
            bprint_string_literal(buf, fmt$1[0]);
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 12--[[ Char_literal ]] then do
            bprint_char_literal(buf, fmt$1[0]);
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 13--[[ Format_arg ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            buffer_add_char(buf, --[[ "{" ]]123);
            bprint_fmtty(buf, fmt$1[1]);
            buffer_add_char(buf, --[[ "%" ]]37);
            buffer_add_char(buf, --[[ "}" ]]125);
            _ign_flag = false;
            _fmt = fmt$1[2];
            ::continue:: ;end end end 
         if ___conditional___ = 14--[[ Format_subst ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            buffer_add_char(buf, --[[ "(" ]]40);
            bprint_fmtty(buf, fmt$1[1]);
            buffer_add_char(buf, --[[ "%" ]]37);
            buffer_add_char(buf, --[[ ")" ]]41);
            _ign_flag = false;
            _fmt = fmt$1[2];
            ::continue:: ;end end end 
         if ___conditional___ = 15--[[ Alpha ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[[ "a" ]]97);
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 16--[[ Theta ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[[ "t" ]]116);
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 17--[[ Formatting_lit ]] then do
            bprint_string_literal(buf, string_of_formatting_lit(fmt$1[0]));
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 18--[[ Formatting_gen ]] then do
            bprint_string_literal(buf, "@{");
            bprint_string_literal(buf, string_of_formatting_gen(fmt$1[0]));
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 19--[[ Reader ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, --[[ "r" ]]114);
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 20--[[ Scan_char_set ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_pad_opt(buf, fmt$1[0]);
            bprint_char_set(buf, fmt$1[1]);
            _ign_flag = false;
            _fmt = fmt$1[2];
            ::continue:: ;end end end 
         if ___conditional___ = 21--[[ Scan_get_counter ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            buffer_add_char(buf, char_of_counter(fmt$1[0]));
            _ign_flag = false;
            _fmt = fmt$1[1];
            ::continue:: ;end end end 
         if ___conditional___ = 22--[[ Scan_next_char ]] then do
            buffer_add_char(buf, --[[ "%" ]]37);
            bprint_ignored_flag(buf, ign_flag);
            bprint_string_literal(buf, "0c");
            _ign_flag = false;
            _fmt = fmt$1[0];
            ::continue:: ;end end end 
         if ___conditional___ = 23--[[ Ignored_param ]] then do
            match = param_format_of_ignored_format(fmt$1[0], fmt$1[1]);
            _ign_flag = true;
            _fmt = match[0];
            ::continue:: ;end end end 
         if ___conditional___ = 24--[[ Custom ]] then do
            for _i = 1 , int_of_custom_arity(fmt$1[0]) , 1 do
              buffer_add_char(buf, --[[ "%" ]]37);
              bprint_ignored_flag(buf, ign_flag);
              buffer_add_char(buf, --[[ "?" ]]63);
            end
            _ign_flag = false;
            _fmt = fmt$1[2];
            ::continue:: ;end end end 
         do
        
      end
    end end 
  end;
end end

function string_of_fmt(fmt) do
  buf = do
    ind: 0,
    bytes: Caml_bytes.caml_create_bytes(16)
  end;
  bprint_fmt(buf, fmt);
  return buffer_contents(buf);
end end

function symm(param) do
  if (typeof param == "number") then do
    return --[[ End_of_fmtty ]]0;
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          return --[[ Char_ty ]]Block.__(0, {symm(param[0])});end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          return --[[ String_ty ]]Block.__(1, {symm(param[0])});end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          return --[[ Int_ty ]]Block.__(2, {symm(param[0])});end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          return --[[ Int32_ty ]]Block.__(3, {symm(param[0])});end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          return --[[ Nativeint_ty ]]Block.__(4, {symm(param[0])});end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          return --[[ Int64_ty ]]Block.__(5, {symm(param[0])});end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          return --[[ Float_ty ]]Block.__(6, {symm(param[0])});end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          return --[[ Bool_ty ]]Block.__(7, {symm(param[0])});end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          return --[[ Format_arg_ty ]]Block.__(8, {
                    param[0],
                    symm(param[1])
                  });end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          return --[[ Format_subst_ty ]]Block.__(9, {
                    param[1],
                    param[0],
                    symm(param[2])
                  });end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          return --[[ Alpha_ty ]]Block.__(10, {symm(param[0])});end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          return --[[ Theta_ty ]]Block.__(11, {symm(param[0])});end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          return --[[ Any_ty ]]Block.__(12, {symm(param[0])});end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          return --[[ Reader_ty ]]Block.__(13, {symm(param[0])});end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          return --[[ Ignored_reader_ty ]]Block.__(14, {symm(param[0])});end end end 
       do
      
    end
  end end 
end end

function fmtty_rel_det(param) do
  if (typeof param == "number") then do
    return --[[ tuple ]]{
            (function (param) do
                return --[[ Refl ]]0;
              end end),
            (function (param) do
                return --[[ Refl ]]0;
              end end),
            (function (param) do
                return --[[ Refl ]]0;
              end end),
            (function (param) do
                return --[[ Refl ]]0;
              end end)
          };
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          match = fmtty_rel_det(param[0]);
          af = match[1];
          fa = match[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match[2],
                  match[3]
                };end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          match$1 = fmtty_rel_det(param[0]);
          af$1 = match$1[1];
          fa$1 = match$1[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$1, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$1, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$1[2],
                  match$1[3]
                };end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          match$2 = fmtty_rel_det(param[0]);
          af$2 = match$2[1];
          fa$2 = match$2[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$2, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$2, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$2[2],
                  match$2[3]
                };end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          match$3 = fmtty_rel_det(param[0]);
          af$3 = match$3[1];
          fa$3 = match$3[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$3, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$3, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$3[2],
                  match$3[3]
                };end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          match$4 = fmtty_rel_det(param[0]);
          af$4 = match$4[1];
          fa$4 = match$4[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$4, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$4, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$4[2],
                  match$4[3]
                };end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          match$5 = fmtty_rel_det(param[0]);
          af$5 = match$5[1];
          fa$5 = match$5[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$5, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$5, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$5[2],
                  match$5[3]
                };end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          match$6 = fmtty_rel_det(param[0]);
          af$6 = match$6[1];
          fa$6 = match$6[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$6, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$6, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$6[2],
                  match$6[3]
                };end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          match$7 = fmtty_rel_det(param[0]);
          af$7 = match$7[1];
          fa$7 = match$7[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$7, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$7, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$7[2],
                  match$7[3]
                };end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          match$8 = fmtty_rel_det(param[1]);
          af$8 = match$8[1];
          fa$8 = match$8[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$8, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$8, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$8[2],
                  match$8[3]
                };end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          match$9 = fmtty_rel_det(param[2]);
          de = match$9[3];
          ed = match$9[2];
          af$9 = match$9[1];
          fa$9 = match$9[0];
          ty = trans(symm(param[0]), param[1]);
          match$10 = fmtty_rel_det(ty);
          jd = match$10[3];
          dj = match$10[2];
          ga = match$10[1];
          ag = match$10[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$9, --[[ Refl ]]0);
                      Curry._1(ag, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(ga, --[[ Refl ]]0);
                      Curry._1(af$9, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(ed, --[[ Refl ]]0);
                      Curry._1(dj, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(jd, --[[ Refl ]]0);
                      Curry._1(de, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end)
                };end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          match$11 = fmtty_rel_det(param[0]);
          af$10 = match$11[1];
          fa$10 = match$11[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$10, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$10, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$11[2],
                  match$11[3]
                };end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          match$12 = fmtty_rel_det(param[0]);
          af$11 = match$12[1];
          fa$11 = match$12[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$11, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$11, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$12[2],
                  match$12[3]
                };end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          match$13 = fmtty_rel_det(param[0]);
          af$12 = match$13[1];
          fa$12 = match$13[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$12, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$12, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  match$13[2],
                  match$13[3]
                };end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          match$14 = fmtty_rel_det(param[0]);
          de$1 = match$14[3];
          ed$1 = match$14[2];
          af$13 = match$14[1];
          fa$13 = match$14[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$13, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$13, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(ed$1, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(de$1, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end)
                };end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          match$15 = fmtty_rel_det(param[0]);
          de$2 = match$15[3];
          ed$2 = match$15[2];
          af$14 = match$15[1];
          fa$14 = match$15[0];
          return --[[ tuple ]]{
                  (function (param) do
                      Curry._1(fa$14, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(af$14, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(ed$2, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end),
                  (function (param) do
                      Curry._1(de$2, --[[ Refl ]]0);
                      return --[[ Refl ]]0;
                    end end)
                };end end end 
       do
      
    end
  end end 
end end

function trans(ty1, ty2) do
  exit = 0;
  if (typeof ty1 == "number") then do
    if (typeof ty2 == "number") then do
      return --[[ End_of_fmtty ]]0;
    end else do
      local ___conditional___=(ty2.tag | 0);
      do
         if ___conditional___ = 8--[[ Format_arg_ty ]] then do
            exit = 6;end else 
         if ___conditional___ = 9--[[ Format_subst_ty ]] then do
            exit = 7;end else 
         if ___conditional___ = 10--[[ Alpha_ty ]] then do
            exit = 1;end else 
         if ___conditional___ = 11--[[ Theta_ty ]] then do
            exit = 2;end else 
         if ___conditional___ = 12--[[ Any_ty ]] then do
            exit = 3;end else 
         if ___conditional___ = 13--[[ Reader_ty ]] then do
            exit = 4;end else 
         if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
            exit = 5;end else 
         do end end end end end end end end
        else do
          error ({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "camlinternalFormat.ml",
              846,
              23
            }
          })
          end end
          
      end
    end end 
  end else do
    local ___conditional___=(ty1.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 0--[[ Char_ty ]] then do
                  return --[[ Char_ty ]]Block.__(0, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 1--[[ String_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 1--[[ String_ty ]] then do
                  return --[[ String_ty ]]Block.__(1, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 2--[[ Int_ty ]] then do
                  return --[[ Int_ty ]]Block.__(2, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 3--[[ Int32_ty ]] then do
                  return --[[ Int32_ty ]]Block.__(3, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 4--[[ Nativeint_ty ]] then do
                  return --[[ Nativeint_ty ]]Block.__(4, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 5--[[ Int64_ty ]] then do
                  return --[[ Int64_ty ]]Block.__(5, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 6--[[ Float_ty ]] then do
                  return --[[ Float_ty ]]Block.__(6, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          if (typeof ty2 == "number") then do
            exit = 8;
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 7--[[ Bool_ty ]] then do
                  return --[[ Bool_ty ]]Block.__(7, {trans(ty1[0], ty2[0])});end end end 
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  exit = 7;end else 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end end
              
            end
          end end end else 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                832,
                26
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  return --[[ Format_arg_ty ]]Block.__(8, {
                            trans(ty1[0], ty2[0]),
                            trans(ty1[1], ty2[1])
                          });end end end 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    832,
                    26
                  }
                })
                end end
                
            end
          end end end else 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                842,
                28
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 8--[[ Format_arg_ty ]] then do
                  exit = 6;end else 
               if ___conditional___ = 9--[[ Format_subst_ty ]] then do
                  ty = trans(symm(ty1[1]), ty2[0]);
                  match = fmtty_rel_det(ty);
                  Curry._1(match[1], --[[ Refl ]]0);
                  Curry._1(match[3], --[[ Refl ]]0);
                  return --[[ Format_subst_ty ]]Block.__(9, {
                            ty1[0],
                            ty2[1],
                            trans(ty1[2], ty2[2])
                          });end end end 
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  exit = 5;end else 
               do end end end end end end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    842,
                    28
                  }
                })
                end end
                
            end
          end end end else 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                810,
                21
              }
            })
          end else if (ty2.tag == --[[ Alpha_ty ]]10) then do
            return --[[ Alpha_ty ]]Block.__(10, {trans(ty1[0], ty2[0])});
          end else do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                810,
                21
              }
            })
          end end  end end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                814,
                21
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  return --[[ Theta_ty ]]Block.__(11, {trans(ty1[0], ty2[0])});end end end 
               do end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    814,
                    21
                  }
                })
                end end
                
            end
          end end end else 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                818,
                19
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  return --[[ Any_ty ]]Block.__(12, {trans(ty1[0], ty2[0])});end end end 
               do end end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    818,
                    19
                  }
                })
                end end
                
            end
          end end end else 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                822,
                22
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  return --[[ Reader_ty ]]Block.__(13, {trans(ty1[0], ty2[0])});end end end 
               do end end end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    822,
                    22
                  }
                })
                end end
                
            end
          end end end else 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          if (typeof ty2 == "number") then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                827,
                30
              }
            })
          end else do
            local ___conditional___=(ty2.tag | 0);
            do
               if ___conditional___ = 10--[[ Alpha_ty ]] then do
                  exit = 1;end else 
               if ___conditional___ = 11--[[ Theta_ty ]] then do
                  exit = 2;end else 
               if ___conditional___ = 12--[[ Any_ty ]] then do
                  exit = 3;end else 
               if ___conditional___ = 13--[[ Reader_ty ]] then do
                  exit = 4;end else 
               if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
                  return --[[ Ignored_reader_ty ]]Block.__(14, {trans(ty1[0], ty2[0])});end end end 
               do end end end end
              else do
                error ({
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]]{
                    "camlinternalFormat.ml",
                    827,
                    30
                  }
                })
                end end
                
            end
          end end end else 
       do end end end end end end end end end end end end end end
      
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ = 1 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            811,
            21
          }
        })end end end 
     if ___conditional___ = 2 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            815,
            21
          }
        })end end end 
     if ___conditional___ = 3 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            819,
            19
          }
        })end end end 
     if ___conditional___ = 4 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            823,
            22
          }
        })end end end 
     if ___conditional___ = 5 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            828,
            30
          }
        })end end end 
     if ___conditional___ = 6 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            833,
            26
          }
        })end end end 
     if ___conditional___ = 7 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            843,
            28
          }
        })end end end 
     if ___conditional___ = 8 then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            847,
            23
          }
        })end end end 
     do
    
  end
end end

function fmtty_of_formatting_gen(formatting_gen) do
  return fmtty_of_fmt(formatting_gen[0][0]);
end end

function fmtty_of_fmt(_fmtty) do
  while(true) do
    fmtty = _fmtty;
    if (typeof fmtty == "number") then do
      return --[[ End_of_fmtty ]]0;
    end else do
      local ___conditional___=(fmtty.tag | 0);
      do
         if ___conditional___ = 2--[[ String ]]
         or ___conditional___ = 3--[[ Caml_string ]]
         or ___conditional___ = 4--[[ Int ]] then do
            ty_rest = fmtty_of_fmt(fmtty[3]);
            prec_ty = fmtty_of_precision_fmtty(fmtty[2], --[[ Int_ty ]]Block.__(2, {ty_rest}));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty);end end end 
         if ___conditional___ = 5--[[ Int32 ]] then do
            ty_rest$1 = fmtty_of_fmt(fmtty[3]);
            prec_ty$1 = fmtty_of_precision_fmtty(fmtty[2], --[[ Int32_ty ]]Block.__(3, {ty_rest$1}));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$1);end end end 
         if ___conditional___ = 6--[[ Nativeint ]] then do
            ty_rest$2 = fmtty_of_fmt(fmtty[3]);
            prec_ty$2 = fmtty_of_precision_fmtty(fmtty[2], --[[ Nativeint_ty ]]Block.__(4, {ty_rest$2}));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$2);end end end 
         if ___conditional___ = 7--[[ Int64 ]] then do
            ty_rest$3 = fmtty_of_fmt(fmtty[3]);
            prec_ty$3 = fmtty_of_precision_fmtty(fmtty[2], --[[ Int64_ty ]]Block.__(5, {ty_rest$3}));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$3);end end end 
         if ___conditional___ = 8--[[ Float ]] then do
            ty_rest$4 = fmtty_of_fmt(fmtty[3]);
            prec_ty$4 = fmtty_of_precision_fmtty(fmtty[2], --[[ Float_ty ]]Block.__(6, {ty_rest$4}));
            return fmtty_of_padding_fmtty(fmtty[1], prec_ty$4);end end end 
         if ___conditional___ = 9--[[ Bool ]] then do
            return fmtty_of_padding_fmtty(fmtty[0], --[[ Bool_ty ]]Block.__(7, {fmtty_of_fmt(fmtty[1])}));end end end 
         if ___conditional___ = 10--[[ Flush ]] then do
            _fmtty = fmtty[0];
            ::continue:: ;end end end 
         if ___conditional___ = 13--[[ Format_arg ]] then do
            return --[[ Format_arg_ty ]]Block.__(8, {
                      fmtty[1],
                      fmtty_of_fmt(fmtty[2])
                    });end end end 
         if ___conditional___ = 14--[[ Format_subst ]] then do
            ty = fmtty[1];
            return --[[ Format_subst_ty ]]Block.__(9, {
                      ty,
                      ty,
                      fmtty_of_fmt(fmtty[2])
                    });end end end 
         if ___conditional___ = 15--[[ Alpha ]] then do
            return --[[ Alpha_ty ]]Block.__(10, {fmtty_of_fmt(fmtty[0])});end end end 
         if ___conditional___ = 16--[[ Theta ]] then do
            return --[[ Theta_ty ]]Block.__(11, {fmtty_of_fmt(fmtty[0])});end end end 
         if ___conditional___ = 11--[[ String_literal ]]
         or ___conditional___ = 12--[[ Char_literal ]]
         or ___conditional___ = 17--[[ Formatting_lit ]] then do
            _fmtty = fmtty[1];
            ::continue:: ;end end end 
         if ___conditional___ = 18--[[ Formatting_gen ]] then do
            return CamlinternalFormatBasics.concat_fmtty(fmtty_of_formatting_gen(fmtty[0]), fmtty_of_fmt(fmtty[1]));end end end 
         if ___conditional___ = 19--[[ Reader ]] then do
            return --[[ Reader_ty ]]Block.__(13, {fmtty_of_fmt(fmtty[0])});end end end 
         if ___conditional___ = 20--[[ Scan_char_set ]] then do
            return --[[ String_ty ]]Block.__(1, {fmtty_of_fmt(fmtty[2])});end end end 
         if ___conditional___ = 21--[[ Scan_get_counter ]] then do
            return --[[ Int_ty ]]Block.__(2, {fmtty_of_fmt(fmtty[1])});end end end 
         if ___conditional___ = 23--[[ Ignored_param ]] then do
            ign = fmtty[0];
            fmt = fmtty[1];
            if (typeof ign == "number") then do
              if (ign == --[[ Ignored_reader ]]2) then do
                return --[[ Ignored_reader_ty ]]Block.__(14, {fmtty_of_fmt(fmt)});
              end else do
                return fmtty_of_fmt(fmt);
              end end 
            end else if (ign.tag == --[[ Ignored_format_subst ]]9) then do
              return CamlinternalFormatBasics.concat_fmtty(ign[1], fmtty_of_fmt(fmt));
            end else do
              return fmtty_of_fmt(fmt);
            end end  end end end end 
         if ___conditional___ = 24--[[ Custom ]] then do
            return fmtty_of_custom(fmtty[0], fmtty_of_fmt(fmtty[2]));end end end 
         do
        else do
          return --[[ Char_ty ]]Block.__(0, {fmtty_of_fmt(fmtty[0])});
          end end
          
      end
    end end 
    return fmtty_of_padding_fmtty(fmtty[0], --[[ String_ty ]]Block.__(1, {fmtty_of_fmt(fmtty[1])}));
  end;
end end

function fmtty_of_custom(arity, fmtty) do
  if (arity) then do
    return --[[ Any_ty ]]Block.__(12, {fmtty_of_custom(arity[0], fmtty)});
  end else do
    return fmtty;
  end end 
end end

function fmtty_of_padding_fmtty(pad, fmtty) do
  if (typeof pad == "number" or not pad.tag) then do
    return fmtty;
  end else do
    return --[[ Int_ty ]]Block.__(2, {fmtty});
  end end 
end end

function fmtty_of_precision_fmtty(prec, fmtty) do
  if (typeof prec == "number" and prec ~= 0) then do
    return --[[ Int_ty ]]Block.__(2, {fmtty});
  end else do
    return fmtty;
  end end 
end end

Type_mismatch = Caml_exceptions.create("CamlinternalFormat.Type_mismatch");

function type_padding(pad, fmtty) do
  if (typeof pad == "number") then do
    return --[[ Padding_fmtty_EBB ]]{
            --[[ No_padding ]]0,
            fmtty
          };
  end else if (pad.tag) then do
    if (typeof fmtty == "number") then do
      error (Type_mismatch)
    end else if (fmtty.tag == --[[ Int_ty ]]2) then do
      return --[[ Padding_fmtty_EBB ]]{
              --[[ Arg_padding ]]Block.__(1, {pad[0]}),
              fmtty[0]
            };
    end else do
      error (Type_mismatch)
    end end  end 
  end else do
    return --[[ Padding_fmtty_EBB ]]{
            --[[ Lit_padding ]]Block.__(0, {
                pad[0],
                pad[1]
              }),
            fmtty
          };
  end end  end 
end end

function type_padprec(pad, prec, fmtty) do
  match = type_padding(pad, fmtty);
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      match$1 = match[1];
      if (typeof match$1 == "number") then do
        error (Type_mismatch)
      end else if (match$1.tag == --[[ Int_ty ]]2) then do
        return --[[ Padprec_fmtty_EBB ]]{
                match[0],
                --[[ Arg_precision ]]1,
                match$1[0]
              };
      end else do
        error (Type_mismatch)
      end end  end 
    end else do
      return --[[ Padprec_fmtty_EBB ]]{
              match[0],
              --[[ No_precision ]]0,
              match[1]
            };
    end end 
  end else do
    return --[[ Padprec_fmtty_EBB ]]{
            match[0],
            --[[ Lit_precision ]]{prec[0]},
            match[1]
          };
  end end 
end end

function type_ignored_format_substitution(sub_fmtty, fmt, fmtty) do
  if (typeof sub_fmtty == "number") then do
    return --[[ Fmtty_fmt_EBB ]]{
            --[[ End_of_fmtty ]]0,
            type_format_gen(fmt, fmtty)
          };
  end else do
    local ___conditional___=(sub_fmtty.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag) then do
            error (Type_mismatch)
          end else do
            match = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Char_ty ]]Block.__(0, {match[0]}),
                    match[1]
                  };
          end end  end end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ String_ty ]]1) then do
            match$1 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ String_ty ]]Block.__(1, {match$1[0]}),
                    match$1[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Int_ty ]]2) then do
            match$2 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Int_ty ]]Block.__(2, {match$2[0]}),
                    match$2[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Int32_ty ]]3) then do
            match$3 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Int32_ty ]]Block.__(3, {match$3[0]}),
                    match$3[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Nativeint_ty ]]4) then do
            match$4 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Nativeint_ty ]]Block.__(4, {match$4[0]}),
                    match$4[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Int64_ty ]]5) then do
            match$5 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Int64_ty ]]Block.__(5, {match$5[0]}),
                    match$5[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Float_ty ]]6) then do
            match$6 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Float_ty ]]Block.__(6, {match$6[0]}),
                    match$6[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Bool_ty ]]7) then do
            match$7 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Bool_ty ]]Block.__(7, {match$7[0]}),
                    match$7[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Format_arg_ty ]]8) then do
            sub2_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[[ Fmtty_EBB ]]{sub_fmtty[0]}, --[[ Fmtty_EBB ]]{sub2_fmtty$prime})) then do
              error (Type_mismatch)
            end
             end 
            match$8 = type_ignored_format_substitution(sub_fmtty[1], fmt, fmtty[1]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Format_arg_ty ]]Block.__(8, {
                        sub2_fmtty$prime,
                        match$8[0]
                      }),
                    match$8[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Format_subst_ty ]]9) then do
            sub2_fmtty$prime$1 = fmtty[1];
            sub1_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(sub_fmtty[0])}, --[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(sub1_fmtty$prime)})) then do
              error (Type_mismatch)
            end
             end 
            if (Caml_obj.caml_notequal(--[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(sub_fmtty[1])}, --[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(sub2_fmtty$prime$1)})) then do
              error (Type_mismatch)
            end
             end 
            sub_fmtty$prime = trans(symm(sub1_fmtty$prime), sub2_fmtty$prime$1);
            match$9 = fmtty_rel_det(sub_fmtty$prime);
            Curry._1(match$9[1], --[[ Refl ]]0);
            Curry._1(match$9[3], --[[ Refl ]]0);
            match$10 = type_ignored_format_substitution(CamlinternalFormatBasics.erase_rel(sub_fmtty[2]), fmt, fmtty[2]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Format_subst_ty ]]Block.__(9, {
                        sub1_fmtty$prime,
                        sub2_fmtty$prime$1,
                        symm(match$10[0])
                      }),
                    match$10[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Alpha_ty ]]10) then do
            match$11 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Alpha_ty ]]Block.__(10, {match$11[0]}),
                    match$11[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Theta_ty ]]11) then do
            match$12 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Theta_ty ]]Block.__(11, {match$12[0]}),
                    match$12[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          error (Type_mismatch)end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Reader_ty ]]13) then do
            match$13 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Reader_ty ]]Block.__(13, {match$13[0]}),
                    match$13[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Ignored_reader_ty ]]14) then do
            match$14 = type_ignored_format_substitution(sub_fmtty[0], fmt, fmtty[0]);
            return --[[ Fmtty_fmt_EBB ]]{
                    --[[ Ignored_reader_ty ]]Block.__(14, {match$14[0]}),
                    match$14[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       do
      
    end
  end end 
end end

function type_format_gen(fmt, fmtty) do
  if (typeof fmt == "number") then do
    return --[[ Fmt_fmtty_EBB ]]{
            --[[ End_of_format ]]0,
            fmtty
          };
  end else do
    local ___conditional___=(fmt.tag | 0);
    do
       if ___conditional___ = 0--[[ Char ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag) then do
            error (Type_mismatch)
          end else do
            match = type_format_gen(fmt[0], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Char ]]Block.__(0, {match[0]}),
                    match[1]
                  };
          end end  end end end end 
       if ___conditional___ = 1--[[ Caml_char ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag) then do
            error (Type_mismatch)
          end else do
            match$1 = type_format_gen(fmt[0], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Caml_char ]]Block.__(1, {match$1[0]}),
                    match$1[1]
                  };
          end end  end end end end 
       if ___conditional___ = 2--[[ String ]] then do
          match$2 = type_padding(fmt[0], fmtty);
          match$3 = match$2[1];
          if (typeof match$3 == "number") then do
            error (Type_mismatch)
          end else if (match$3.tag == --[[ String_ty ]]1) then do
            match$4 = type_format_gen(fmt[1], match$3[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ String ]]Block.__(2, {
                        match$2[0],
                        match$4[0]
                      }),
                    match$4[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 3--[[ Caml_string ]] then do
          match$5 = type_padding(fmt[0], fmtty);
          match$6 = match$5[1];
          if (typeof match$6 == "number") then do
            error (Type_mismatch)
          end else if (match$6.tag == --[[ String_ty ]]1) then do
            match$7 = type_format_gen(fmt[1], match$6[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Caml_string ]]Block.__(3, {
                        match$5[0],
                        match$7[0]
                      }),
                    match$7[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 4--[[ Int ]] then do
          match$8 = type_padprec(fmt[1], fmt[2], fmtty);
          match$9 = match$8[2];
          if (typeof match$9 == "number") then do
            error (Type_mismatch)
          end else if (match$9.tag == --[[ Int_ty ]]2) then do
            match$10 = type_format_gen(fmt[3], match$9[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Int ]]Block.__(4, {
                        fmt[0],
                        match$8[0],
                        match$8[1],
                        match$10[0]
                      }),
                    match$10[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 5--[[ Int32 ]] then do
          match$11 = type_padprec(fmt[1], fmt[2], fmtty);
          match$12 = match$11[2];
          if (typeof match$12 == "number") then do
            error (Type_mismatch)
          end else if (match$12.tag == --[[ Int32_ty ]]3) then do
            match$13 = type_format_gen(fmt[3], match$12[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Int32 ]]Block.__(5, {
                        fmt[0],
                        match$11[0],
                        match$11[1],
                        match$13[0]
                      }),
                    match$13[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 6--[[ Nativeint ]] then do
          match$14 = type_padprec(fmt[1], fmt[2], fmtty);
          match$15 = match$14[2];
          if (typeof match$15 == "number") then do
            error (Type_mismatch)
          end else if (match$15.tag == --[[ Nativeint_ty ]]4) then do
            match$16 = type_format_gen(fmt[3], match$15[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Nativeint ]]Block.__(6, {
                        fmt[0],
                        match$14[0],
                        match$14[1],
                        match$16[0]
                      }),
                    match$16[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 7--[[ Int64 ]] then do
          match$17 = type_padprec(fmt[1], fmt[2], fmtty);
          match$18 = match$17[2];
          if (typeof match$18 == "number") then do
            error (Type_mismatch)
          end else if (match$18.tag == --[[ Int64_ty ]]5) then do
            match$19 = type_format_gen(fmt[3], match$18[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Int64 ]]Block.__(7, {
                        fmt[0],
                        match$17[0],
                        match$17[1],
                        match$19[0]
                      }),
                    match$19[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 8--[[ Float ]] then do
          match$20 = type_padprec(fmt[1], fmt[2], fmtty);
          match$21 = match$20[2];
          if (typeof match$21 == "number") then do
            error (Type_mismatch)
          end else if (match$21.tag == --[[ Float_ty ]]6) then do
            match$22 = type_format_gen(fmt[3], match$21[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Float ]]Block.__(8, {
                        fmt[0],
                        match$20[0],
                        match$20[1],
                        match$22[0]
                      }),
                    match$22[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 9--[[ Bool ]] then do
          match$23 = type_padding(fmt[0], fmtty);
          match$24 = match$23[1];
          if (typeof match$24 == "number") then do
            error (Type_mismatch)
          end else if (match$24.tag == --[[ Bool_ty ]]7) then do
            match$25 = type_format_gen(fmt[1], match$24[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Bool ]]Block.__(9, {
                        match$23[0],
                        match$25[0]
                      }),
                    match$25[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 10--[[ Flush ]] then do
          match$26 = type_format_gen(fmt[0], fmtty);
          return --[[ Fmt_fmtty_EBB ]]{
                  --[[ Flush ]]Block.__(10, {match$26[0]}),
                  match$26[1]
                };end end end 
       if ___conditional___ = 11--[[ String_literal ]] then do
          match$27 = type_format_gen(fmt[1], fmtty);
          return --[[ Fmt_fmtty_EBB ]]{
                  --[[ String_literal ]]Block.__(11, {
                      fmt[0],
                      match$27[0]
                    }),
                  match$27[1]
                };end end end 
       if ___conditional___ = 12--[[ Char_literal ]] then do
          match$28 = type_format_gen(fmt[1], fmtty);
          return --[[ Fmt_fmtty_EBB ]]{
                  --[[ Char_literal ]]Block.__(12, {
                      fmt[0],
                      match$28[0]
                    }),
                  match$28[1]
                };end end end 
       if ___conditional___ = 13--[[ Format_arg ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Format_arg_ty ]]8) then do
            sub_fmtty$prime = fmtty[0];
            if (Caml_obj.caml_notequal(--[[ Fmtty_EBB ]]{fmt[1]}, --[[ Fmtty_EBB ]]{sub_fmtty$prime})) then do
              error (Type_mismatch)
            end
             end 
            match$29 = type_format_gen(fmt[2], fmtty[1]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Format_arg ]]Block.__(13, {
                        fmt[0],
                        sub_fmtty$prime,
                        match$29[0]
                      }),
                    match$29[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 14--[[ Format_subst ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Format_subst_ty ]]9) then do
            sub_fmtty1 = fmtty[0];
            if (Caml_obj.caml_notequal(--[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(fmt[1])}, --[[ Fmtty_EBB ]]{CamlinternalFormatBasics.erase_rel(sub_fmtty1)})) then do
              error (Type_mismatch)
            end
             end 
            match$30 = type_format_gen(fmt[2], CamlinternalFormatBasics.erase_rel(fmtty[2]));
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Format_subst ]]Block.__(14, {
                        fmt[0],
                        sub_fmtty1,
                        match$30[0]
                      }),
                    match$30[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 15--[[ Alpha ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Alpha_ty ]]10) then do
            match$31 = type_format_gen(fmt[0], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Alpha ]]Block.__(15, {match$31[0]}),
                    match$31[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 16--[[ Theta ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Theta_ty ]]11) then do
            match$32 = type_format_gen(fmt[0], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Theta ]]Block.__(16, {match$32[0]}),
                    match$32[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 17--[[ Formatting_lit ]] then do
          match$33 = type_format_gen(fmt[1], fmtty);
          return --[[ Fmt_fmtty_EBB ]]{
                  --[[ Formatting_lit ]]Block.__(17, {
                      fmt[0],
                      match$33[0]
                    }),
                  match$33[1]
                };end end end 
       if ___conditional___ = 18--[[ Formatting_gen ]] then do
          formatting_gen = fmt[0];
          fmt0 = fmt[1];
          fmtty0 = fmtty;
          if (formatting_gen.tag) then do
            match$34 = formatting_gen[0];
            match$35 = type_format_gen(match$34[0], fmtty0);
            match$36 = type_format_gen(fmt0, match$35[1]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Formatting_gen ]]Block.__(18, {
                        --[[ Open_box ]]Block.__(1, {--[[ Format ]]{
                              match$35[0],
                              match$34[1]
                            }}),
                        match$36[0]
                      }),
                    match$36[1]
                  };
          end else do
            match$37 = formatting_gen[0];
            match$38 = type_format_gen(match$37[0], fmtty0);
            match$39 = type_format_gen(fmt0, match$38[1]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Formatting_gen ]]Block.__(18, {
                        --[[ Open_tag ]]Block.__(0, {--[[ Format ]]{
                              match$38[0],
                              match$37[1]
                            }}),
                        match$39[0]
                      }),
                    match$39[1]
                  };
          end end end end end 
       if ___conditional___ = 19--[[ Reader ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Reader_ty ]]13) then do
            match$40 = type_format_gen(fmt[0], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Reader ]]Block.__(19, {match$40[0]}),
                    match$40[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 20--[[ Scan_char_set ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ String_ty ]]1) then do
            match$41 = type_format_gen(fmt[2], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Scan_char_set ]]Block.__(20, {
                        fmt[0],
                        fmt[1],
                        match$41[0]
                      }),
                    match$41[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 21--[[ Scan_get_counter ]] then do
          if (typeof fmtty == "number") then do
            error (Type_mismatch)
          end else if (fmtty.tag == --[[ Int_ty ]]2) then do
            match$42 = type_format_gen(fmt[1], fmtty[0]);
            return --[[ Fmt_fmtty_EBB ]]{
                    --[[ Scan_get_counter ]]Block.__(21, {
                        fmt[0],
                        match$42[0]
                      }),
                    match$42[1]
                  };
          end else do
            error (Type_mismatch)
          end end  end end end end 
       if ___conditional___ = 23--[[ Ignored_param ]] then do
          ign = fmt[0];
          fmt$1 = fmt[1];
          fmtty$1 = fmtty;
          if (typeof ign == "number") then do
            if (ign == --[[ Ignored_reader ]]2) then do
              if (typeof fmtty$1 == "number") then do
                error (Type_mismatch)
              end else if (fmtty$1.tag == --[[ Ignored_reader_ty ]]14) then do
                match$43 = type_format_gen(fmt$1, fmtty$1[0]);
                return --[[ Fmt_fmtty_EBB ]]{
                        --[[ Ignored_param ]]Block.__(23, {
                            --[[ Ignored_reader ]]2,
                            match$43[0]
                          }),
                        match$43[1]
                      };
              end else do
                error (Type_mismatch)
              end end  end 
            end else do
              return type_ignored_param_one(ign, fmt$1, fmtty$1);
            end end 
          end else do
            local ___conditional___=(ign.tag | 0);
            do
               if ___conditional___ = 8--[[ Ignored_format_arg ]] then do
                  return type_ignored_param_one(--[[ Ignored_format_arg ]]Block.__(8, {
                                ign[0],
                                ign[1]
                              }), fmt$1, fmtty$1);end end end 
               if ___conditional___ = 9--[[ Ignored_format_subst ]] then do
                  match$44 = type_ignored_format_substitution(ign[1], fmt$1, fmtty$1);
                  match$45 = match$44[1];
                  return --[[ Fmt_fmtty_EBB ]]{
                          --[[ Ignored_param ]]Block.__(23, {
                              --[[ Ignored_format_subst ]]Block.__(9, {
                                  ign[0],
                                  match$44[0]
                                }),
                              match$45[0]
                            }),
                          match$45[1]
                        };end end end 
               do
              else do
                return type_ignored_param_one(ign, fmt$1, fmtty$1);
                end end
                
            end
          end end end end end 
       if ___conditional___ = 22--[[ Scan_next_char ]]
       or ___conditional___ = 24--[[ Custom ]] then do
          error (Type_mismatch)end end end 
       do
      
    end
  end end 
end end

function type_ignored_param_one(ign, fmt, fmtty) do
  match = type_format_gen(fmt, fmtty);
  return --[[ Fmt_fmtty_EBB ]]{
          --[[ Ignored_param ]]Block.__(23, {
              ign,
              match[0]
            }),
          match[1]
        };
end end

function type_format(fmt, fmtty) do
  match = type_format_gen(fmt, fmtty);
  if (typeof match[1] == "number") then do
    return match[0];
  end else do
    error (Type_mismatch)
  end end 
end end

function recast(fmt, fmtty) do
  return type_format(fmt, CamlinternalFormatBasics.erase_rel(symm(fmtty)));
end end

function fix_padding(padty, width, str) do
  len = #str;
  width$1 = Pervasives.abs(width);
  padty$1 = width < 0 and --[[ Left ]]0 or padty;
  if (width$1 <= len) then do
    return str;
  end else do
    res = Bytes.make(width$1, padty$1 == --[[ Zeros ]]2 and --[[ "0" ]]48 or --[[ " " ]]32);
    local ___conditional___=(padty$1);
    do
       if ___conditional___ = 0--[[ Left ]] then do
          __String.blit(str, 0, res, 0, len);end else 
       if ___conditional___ = 1--[[ Right ]] then do
          __String.blit(str, 0, res, width$1 - len | 0, len);end else 
       if ___conditional___ = 2--[[ Zeros ]] then do
          if (len > 0 and (Caml_string.get(str, 0) == --[[ "+" ]]43 or Caml_string.get(str, 0) == --[[ "-" ]]45 or Caml_string.get(str, 0) == --[[ " " ]]32)) then do
            res[0] = Caml_string.get(str, 0);
            __String.blit(str, 1, res, (width$1 - len | 0) + 1 | 0, len - 1 | 0);
          end else if (len > 1 and Caml_string.get(str, 0) == --[[ "0" ]]48 and (Caml_string.get(str, 1) == --[[ "x" ]]120 or Caml_string.get(str, 1) == --[[ "X" ]]88)) then do
            res[1] = Caml_string.get(str, 1);
            __String.blit(str, 2, res, (width$1 - len | 0) + 2 | 0, len - 2 | 0);
          end else do
            __String.blit(str, 0, res, width$1 - len | 0, len);
          end end  end end else 
       do end end end end
      
    end
    return Caml_bytes.bytes_to_string(res);
  end end 
end end

function fix_int_precision(prec, str) do
  prec$1 = Pervasives.abs(prec);
  len = #str;
  c = Caml_string.get(str, 0);
  exit = 0;
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
      local ___conditional___=(c - 43 | 0);
      do
         if ___conditional___ = 0
         or ___conditional___ = 2 then do
            exit = 1;end else 
         if ___conditional___ = 1
         or ___conditional___ = 3
         or ___conditional___ = 4 then do
            return str;end end end 
         if ___conditional___ = 5 then do
            if ((prec$1 + 2 | 0) > len and len > 1 and (Caml_string.get(str, 1) == --[[ "x" ]]120 or Caml_string.get(str, 1) == --[[ "X" ]]88)) then do
              res = Bytes.make(prec$1 + 2 | 0, --[[ "0" ]]48);
              res[1] = Caml_string.get(str, 1);
              __String.blit(str, 2, res, (prec$1 - len | 0) + 4 | 0, len - 2 | 0);
              return Caml_bytes.bytes_to_string(res);
            end else do
              exit = 2;
            end end end else 
         if ___conditional___ = 6
         or ___conditional___ = 7
         or ___conditional___ = 8
         or ___conditional___ = 9
         or ___conditional___ = 10
         or ___conditional___ = 11
         or ___conditional___ = 12
         or ___conditional___ = 13
         or ___conditional___ = 14 then do
            exit = 2;end else 
         do end end end
        
      end
    end else do
      return str;
    end end 
  end else do
    exit = 1;
  end end  end 
  local ___conditional___=(exit);
  do
     if ___conditional___ = 1 then do
        if ((prec$1 + 1 | 0) > len) then do
          res$1 = Bytes.make(prec$1 + 1 | 0, --[[ "0" ]]48);
          res$1[0] = c;
          __String.blit(str, 1, res$1, (prec$1 - len | 0) + 2 | 0, len - 1 | 0);
          return Caml_bytes.bytes_to_string(res$1);
        end else do
          return str;
        end end end end end 
     if ___conditional___ = 2 then do
        if (prec$1 > len) then do
          res$2 = Bytes.make(prec$1, --[[ "0" ]]48);
          __String.blit(str, 0, res$2, prec$1 - len | 0, len);
          return Caml_bytes.bytes_to_string(res$2);
        end else do
          return str;
        end end end end end 
     do
    
  end
end end

function string_to_caml_string(str) do
  str$1 = __String.escaped(str);
  l = #str$1;
  res = Bytes.make(l + 2 | 0, --[[ "\"" ]]34);
  Caml_bytes.caml_blit_string(str$1, 0, res, 1, l);
  return Caml_bytes.bytes_to_string(res);
end end

function format_of_iconv(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[[ Int_d ]] then do
        return "%d";end end end 
     if ___conditional___ = 1--[[ Int_pd ]] then do
        return "%+d";end end end 
     if ___conditional___ = 2--[[ Int_sd ]] then do
        return "% d";end end end 
     if ___conditional___ = 3--[[ Int_i ]] then do
        return "%i";end end end 
     if ___conditional___ = 4--[[ Int_pi ]] then do
        return "%+i";end end end 
     if ___conditional___ = 5--[[ Int_si ]] then do
        return "% i";end end end 
     if ___conditional___ = 6--[[ Int_x ]] then do
        return "%x";end end end 
     if ___conditional___ = 7--[[ Int_Cx ]] then do
        return "%#x";end end end 
     if ___conditional___ = 8--[[ Int_X ]] then do
        return "%X";end end end 
     if ___conditional___ = 9--[[ Int_CX ]] then do
        return "%#X";end end end 
     if ___conditional___ = 10--[[ Int_o ]] then do
        return "%o";end end end 
     if ___conditional___ = 11--[[ Int_Co ]] then do
        return "%#o";end end end 
     if ___conditional___ = 12--[[ Int_u ]] then do
        return "%u";end end end 
     do
    
  end
end end

function format_of_iconvL(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[[ Int_d ]] then do
        return "%Ld";end end end 
     if ___conditional___ = 1--[[ Int_pd ]] then do
        return "%+Ld";end end end 
     if ___conditional___ = 2--[[ Int_sd ]] then do
        return "% Ld";end end end 
     if ___conditional___ = 3--[[ Int_i ]] then do
        return "%Li";end end end 
     if ___conditional___ = 4--[[ Int_pi ]] then do
        return "%+Li";end end end 
     if ___conditional___ = 5--[[ Int_si ]] then do
        return "% Li";end end end 
     if ___conditional___ = 6--[[ Int_x ]] then do
        return "%Lx";end end end 
     if ___conditional___ = 7--[[ Int_Cx ]] then do
        return "%#Lx";end end end 
     if ___conditional___ = 8--[[ Int_X ]] then do
        return "%LX";end end end 
     if ___conditional___ = 9--[[ Int_CX ]] then do
        return "%#LX";end end end 
     if ___conditional___ = 10--[[ Int_o ]] then do
        return "%Lo";end end end 
     if ___conditional___ = 11--[[ Int_Co ]] then do
        return "%#Lo";end end end 
     if ___conditional___ = 12--[[ Int_u ]] then do
        return "%Lu";end end end 
     do
    
  end
end end

function format_of_iconvl(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[[ Int_d ]] then do
        return "%ld";end end end 
     if ___conditional___ = 1--[[ Int_pd ]] then do
        return "%+ld";end end end 
     if ___conditional___ = 2--[[ Int_sd ]] then do
        return "% ld";end end end 
     if ___conditional___ = 3--[[ Int_i ]] then do
        return "%li";end end end 
     if ___conditional___ = 4--[[ Int_pi ]] then do
        return "%+li";end end end 
     if ___conditional___ = 5--[[ Int_si ]] then do
        return "% li";end end end 
     if ___conditional___ = 6--[[ Int_x ]] then do
        return "%lx";end end end 
     if ___conditional___ = 7--[[ Int_Cx ]] then do
        return "%#lx";end end end 
     if ___conditional___ = 8--[[ Int_X ]] then do
        return "%lX";end end end 
     if ___conditional___ = 9--[[ Int_CX ]] then do
        return "%#lX";end end end 
     if ___conditional___ = 10--[[ Int_o ]] then do
        return "%lo";end end end 
     if ___conditional___ = 11--[[ Int_Co ]] then do
        return "%#lo";end end end 
     if ___conditional___ = 12--[[ Int_u ]] then do
        return "%lu";end end end 
     do
    
  end
end end

function format_of_iconvn(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[[ Int_d ]] then do
        return "%nd";end end end 
     if ___conditional___ = 1--[[ Int_pd ]] then do
        return "%+nd";end end end 
     if ___conditional___ = 2--[[ Int_sd ]] then do
        return "% nd";end end end 
     if ___conditional___ = 3--[[ Int_i ]] then do
        return "%ni";end end end 
     if ___conditional___ = 4--[[ Int_pi ]] then do
        return "%+ni";end end end 
     if ___conditional___ = 5--[[ Int_si ]] then do
        return "% ni";end end end 
     if ___conditional___ = 6--[[ Int_x ]] then do
        return "%nx";end end end 
     if ___conditional___ = 7--[[ Int_Cx ]] then do
        return "%#nx";end end end 
     if ___conditional___ = 8--[[ Int_X ]] then do
        return "%nX";end end end 
     if ___conditional___ = 9--[[ Int_CX ]] then do
        return "%#nX";end end end 
     if ___conditional___ = 10--[[ Int_o ]] then do
        return "%no";end end end 
     if ___conditional___ = 11--[[ Int_Co ]] then do
        return "%#no";end end end 
     if ___conditional___ = 12--[[ Int_u ]] then do
        return "%nu";end end end 
     do
    
  end
end end

function format_of_fconv(fconv, prec) do
  if (fconv == --[[ Float_F ]]15) then do
    return "%.12g";
  end else do
    prec$1 = Pervasives.abs(prec);
    symb = char_of_fconv(fconv);
    buf = do
      ind: 0,
      bytes: Caml_bytes.caml_create_bytes(16)
    end;
    buffer_add_char(buf, --[[ "%" ]]37);
    bprint_fconv_flag(buf, fconv);
    buffer_add_char(buf, --[[ "." ]]46);
    buffer_add_string(buf, String(prec$1));
    buffer_add_char(buf, symb);
    return buffer_contents(buf);
  end end 
end end

function convert_int(iconv, n) do
  return Caml_format.caml_format_int(format_of_iconv(iconv), n);
end end

function convert_int32(iconv, n) do
  return Caml_format.caml_int32_format(format_of_iconvl(iconv), n);
end end

function convert_nativeint(iconv, n) do
  return Caml_format.caml_nativeint_format(format_of_iconvn(iconv), n);
end end

function convert_int64(iconv, n) do
  return Caml_format.caml_int64_format(format_of_iconvL(iconv), n);
end end

function convert_float(fconv, prec, x) do
  if (fconv >= 16) then do
    sign;
    if (fconv >= 17) then do
      local ___conditional___=(fconv - 17 | 0);
      do
         if ___conditional___ = 2--[[ Float_sf ]] then do
            sign = --[[ "-" ]]45;end else 
         if ___conditional___ = 0--[[ Float_f ]]
         or ___conditional___ = 3--[[ Float_e ]] then do
            sign = --[[ "+" ]]43;end else 
         if ___conditional___ = 1--[[ Float_pf ]]
         or ___conditional___ = 4--[[ Float_pe ]] then do
            sign = --[[ " " ]]32;end else 
         do end end end end
        
      end
    end else do
      sign = --[[ "-" ]]45;
    end end 
    str = Caml_format.caml_hexstring_of_float(x, prec, sign);
    if (fconv >= 19) then do
      return Caml_bytes.bytes_to_string(Bytes.uppercase_ascii(Caml_bytes.bytes_of_string(str)));
    end else do
      return str;
    end end 
  end else do
    str$1 = Caml_format.caml_format_float(format_of_fconv(fconv, prec), x);
    if (fconv ~= --[[ Float_F ]]15) then do
      return str$1;
    end else do
      len = #str$1;
      is_valid = function (_i) do
        while(true) do
          i = _i;
          if (i == len) then do
            return false;
          end else do
            match = Caml_string.get(str$1, i);
            switcher = match - 46 | 0;
            if (switcher > 23 or switcher < 0) then do
              if (switcher ~= 55) then do
                _i = i + 1 | 0;
                ::continue:: ;
              end else do
                return true;
              end end 
            end else if (switcher > 22 or switcher < 1) then do
              return true;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end  end 
          end end 
        end;
      end end;
      match = Pervasives.classify_float(x);
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
end end

function format_caml_char(c) do
  str = Char.escaped(c);
  l = #str;
  res = Bytes.make(l + 2 | 0, --[[ "'" ]]39);
  Caml_bytes.caml_blit_string(str, 0, res, 1, l);
  return Caml_bytes.bytes_to_string(res);
end end

function string_of_fmtty(fmtty) do
  buf = do
    ind: 0,
    bytes: Caml_bytes.caml_create_bytes(16)
  end;
  bprint_fmtty(buf, fmtty);
  return buffer_contents(buf);
end end

function make_printf(_k, o, _acc, _fmt) do
  while(true) do
    fmt = _fmt;
    acc = _acc;
    k = _k;
    if (typeof fmt == "number") then do
      return Curry._2(k, o, acc);
    end else do
      local ___conditional___=(fmt.tag | 0);
      do
         if ___conditional___ = 0--[[ Char ]] then do
            rest = fmt[0];
            return (function(k,acc,rest)do
            return function (c) do
              new_acc = --[[ Acc_data_char ]]Block.__(5, {
                  acc,
                  c
                });
              return make_printf(k, o, new_acc, rest);
            end end
            end(k,acc,rest));end end end 
         if ___conditional___ = 1--[[ Caml_char ]] then do
            rest$1 = fmt[0];
            return (function(k,acc,rest$1)do
            return function (c) do
              new_acc_001 = format_caml_char(c);
              new_acc = --[[ Acc_data_string ]]Block.__(4, {
                  acc,
                  new_acc_001
                });
              return make_printf(k, o, new_acc, rest$1);
            end end
            end(k,acc,rest$1));end end end 
         if ___conditional___ = 2--[[ String ]] then do
            return make_padding(k, o, acc, fmt[1], fmt[0], (function (str) do
                          return str;
                        end end));end end end 
         if ___conditional___ = 3--[[ Caml_string ]] then do
            return make_padding(k, o, acc, fmt[1], fmt[0], string_to_caml_string);end end end 
         if ___conditional___ = 4--[[ Int ]] then do
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int, fmt[0]);end end end 
         if ___conditional___ = 5--[[ Int32 ]] then do
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int32, fmt[0]);end end end 
         if ___conditional___ = 6--[[ Nativeint ]] then do
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_nativeint, fmt[0]);end end end 
         if ___conditional___ = 7--[[ Int64 ]] then do
            return make_int_padding_precision(k, o, acc, fmt[3], fmt[1], fmt[2], convert_int64, fmt[0]);end end end 
         if ___conditional___ = 8--[[ Float ]] then do
            k$1 = k;
            o$1 = o;
            acc$1 = acc;
            fmt$1 = fmt[3];
            pad = fmt[1];
            prec = fmt[2];
            fconv = fmt[0];
            if (typeof pad == "number") then do
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv)do
                  return function (p, x) do
                    str = convert_float(fconv, p, x);
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv)do
                  return function (x) do
                    str = convert_float(fconv, -6, x);
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv));
                end end 
              end else do
                p = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,p)do
                return function (x) do
                  str = convert_float(fconv, p, x);
                  return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                acc$1,
                                str
                              }), fmt$1);
                end end
                end(k$1,o$1,acc$1,fmt$1,fconv,p));
              end end 
            end else if (pad.tag) then do
              padty = pad[0];
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty)do
                  return function (w, p, x) do
                    str = fix_padding(padty, w, convert_float(fconv, p, x));
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty)do
                  return function (w, x) do
                    str = convert_float(fconv, -6, x);
                    str$prime = fix_padding(padty, w, str);
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str$prime
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty));
                end end 
              end else do
                p$1 = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,padty,p$1)do
                return function (w, x) do
                  str = fix_padding(padty, w, convert_float(fconv, p$1, x));
                  return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                acc$1,
                                str
                              }), fmt$1);
                end end
                end(k$1,o$1,acc$1,fmt$1,fconv,padty,p$1));
              end end 
            end else do
              w = pad[1];
              padty$1 = pad[0];
              if (typeof prec == "number") then do
                if (prec ~= 0) then do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w)do
                  return function (p, x) do
                    str = fix_padding(padty$1, w, convert_float(fconv, p, x));
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w));
                end else do
                  return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w)do
                  return function (x) do
                    str = convert_float(fconv, -6, x);
                    str$prime = fix_padding(padty$1, w, str);
                    return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                  acc$1,
                                  str$prime
                                }), fmt$1);
                  end end
                  end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w));
                end end 
              end else do
                p$2 = prec[0];
                return (function(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w,p$2)do
                return function (x) do
                  str = fix_padding(padty$1, w, convert_float(fconv, p$2, x));
                  return make_printf(k$1, o$1, --[[ Acc_data_string ]]Block.__(4, {
                                acc$1,
                                str
                              }), fmt$1);
                end end
                end(k$1,o$1,acc$1,fmt$1,fconv,padty$1,w,p$2));
              end end 
            end end  end end end end 
         if ___conditional___ = 9--[[ Bool ]] then do
            return make_padding(k, o, acc, fmt[1], fmt[0], Pervasives.string_of_bool);end end end 
         if ___conditional___ = 10--[[ Flush ]] then do
            _fmt = fmt[0];
            _acc = --[[ Acc_flush ]]Block.__(7, {acc});
            ::continue:: ;end end end 
         if ___conditional___ = 11--[[ String_literal ]] then do
            _fmt = fmt[1];
            _acc = --[[ Acc_string_literal ]]Block.__(2, {
                acc,
                fmt[0]
              });
            ::continue:: ;end end end 
         if ___conditional___ = 12--[[ Char_literal ]] then do
            _fmt = fmt[1];
            _acc = --[[ Acc_char_literal ]]Block.__(3, {
                acc,
                fmt[0]
              });
            ::continue:: ;end end end 
         if ___conditional___ = 13--[[ Format_arg ]] then do
            rest$2 = fmt[2];
            ty = string_of_fmtty(fmt[1]);
            return (function(k,acc,rest$2,ty)do
            return function (str) do
              return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                            acc,
                            ty
                          }), rest$2);
            end end
            end(k,acc,rest$2,ty));end end end 
         if ___conditional___ = 14--[[ Format_subst ]] then do
            rest$3 = fmt[2];
            fmtty = fmt[1];
            return (function(k,acc,fmtty,rest$3)do
            return function (param) do
              return make_printf(k, o, acc, CamlinternalFormatBasics.concat_fmt(recast(param[0], fmtty), rest$3));
            end end
            end(k,acc,fmtty,rest$3));end end end 
         if ___conditional___ = 15--[[ Alpha ]] then do
            rest$4 = fmt[0];
            return (function(k,acc,rest$4)do
            return function (f, x) do
              return make_printf(k, o, --[[ Acc_delay ]]Block.__(6, {
                            acc,
                            (function (o) do
                                return Curry._2(f, o, x);
                              end end)
                          }), rest$4);
            end end
            end(k,acc,rest$4));end end end 
         if ___conditional___ = 16--[[ Theta ]] then do
            rest$5 = fmt[0];
            return (function(k,acc,rest$5)do
            return function (f) do
              return make_printf(k, o, --[[ Acc_delay ]]Block.__(6, {
                            acc,
                            f
                          }), rest$5);
            end end
            end(k,acc,rest$5));end end end 
         if ___conditional___ = 17--[[ Formatting_lit ]] then do
            _fmt = fmt[1];
            _acc = --[[ Acc_formatting_lit ]]Block.__(0, {
                acc,
                fmt[0]
              });
            ::continue:: ;end end end 
         if ___conditional___ = 18--[[ Formatting_gen ]] then do
            match = fmt[0];
            if (match.tag) then do
              rest$6 = fmt[1];
              k$prime = (function(k,acc,rest$6)do
              return function k$prime(koc, kacc) do
                return make_printf(k, koc, --[[ Acc_formatting_gen ]]Block.__(1, {
                              acc,
                              --[[ Acc_open_box ]]Block.__(1, {kacc})
                            }), rest$6);
              end end
              end(k,acc,rest$6));
              _fmt = match[0][0];
              _acc = --[[ End_of_acc ]]0;
              _k = k$prime;
              ::continue:: ;
            end else do
              rest$7 = fmt[1];
              k$prime$1 = (function(k,acc,rest$7)do
              return function k$prime$1(koc, kacc) do
                return make_printf(k, koc, --[[ Acc_formatting_gen ]]Block.__(1, {
                              acc,
                              --[[ Acc_open_tag ]]Block.__(0, {kacc})
                            }), rest$7);
              end end
              end(k,acc,rest$7));
              _fmt = match[0][0];
              _acc = --[[ End_of_acc ]]0;
              _k = k$prime$1;
              ::continue:: ;
            end end end end end 
         if ___conditional___ = 19--[[ Reader ]] then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                1525,
                4
              }
            })end end end 
         if ___conditional___ = 20--[[ Scan_char_set ]] then do
            rest$8 = fmt[2];
            new_acc = --[[ Acc_invalid_arg ]]Block.__(8, {
                acc,
                "Printf: bad conversion %["
              });
            return (function(k,rest$8,new_acc)do
            return function (param) do
              return make_printf(k, o, new_acc, rest$8);
            end end
            end(k,rest$8,new_acc));end end end 
         if ___conditional___ = 21--[[ Scan_get_counter ]] then do
            rest$9 = fmt[1];
            return (function(k,acc,rest$9)do
            return function (n) do
              new_acc_001 = Caml_format.caml_format_int("%u", n);
              new_acc = --[[ Acc_data_string ]]Block.__(4, {
                  acc,
                  new_acc_001
                });
              return make_printf(k, o, new_acc, rest$9);
            end end
            end(k,acc,rest$9));end end end 
         if ___conditional___ = 22--[[ Scan_next_char ]] then do
            rest$10 = fmt[0];
            return (function(k,acc,rest$10)do
            return function (c) do
              new_acc = --[[ Acc_data_char ]]Block.__(5, {
                  acc,
                  c
                });
              return make_printf(k, o, new_acc, rest$10);
            end end
            end(k,acc,rest$10));end end end 
         if ___conditional___ = 23--[[ Ignored_param ]] then do
            return make_ignored_param(k, o, acc, fmt[0], fmt[1]);end end end 
         if ___conditional___ = 24--[[ Custom ]] then do
            return make_custom(k, o, acc, fmt[2], fmt[0], Curry._1(fmt[1], --[[ () ]]0));end end end 
         do
        
      end
    end end 
  end;
end end

function make_ignored_param(k, o, acc, ign, fmt) do
  if (typeof ign == "number") then do
    if (ign == --[[ Ignored_reader ]]2) then do
      error ({
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]]{
          "camlinternalFormat.ml",
          1593,
          39
        }
      })
    end else do
      return make_invalid_arg(k, o, acc, fmt);
    end end 
  end else if (ign.tag == --[[ Ignored_format_subst ]]9) then do
    return make_from_fmtty(k, o, acc, ign[1], fmt);
  end else do
    return make_invalid_arg(k, o, acc, fmt);
  end end  end 
end end

function make_from_fmtty(k, o, acc, fmtty, fmt) do
  if (typeof fmtty == "number") then do
    return make_invalid_arg(k, o, acc, fmt);
  end else do
    local ___conditional___=(fmtty.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          rest = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest, fmt);
            end end);end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          rest$1 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$1, fmt);
            end end);end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          rest$2 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$2, fmt);
            end end);end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          rest$3 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$3, fmt);
            end end);end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          rest$4 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$4, fmt);
            end end);end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          rest$5 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$5, fmt);
            end end);end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          rest$6 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$6, fmt);
            end end);end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          rest$7 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$7, fmt);
            end end);end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          rest$8 = fmtty[1];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$8, fmt);
            end end);end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          rest$9 = fmtty[2];
          ty = trans(symm(fmtty[0]), fmtty[1]);
          return (function (param) do
              return make_from_fmtty(k, o, acc, CamlinternalFormatBasics.concat_fmtty(ty, rest$9), fmt);
            end end);end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          rest$10 = fmtty[0];
          return (function (param, param$1) do
              return make_from_fmtty(k, o, acc, rest$10, fmt);
            end end);end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          rest$11 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$11, fmt);
            end end);end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          rest$12 = fmtty[0];
          return (function (param) do
              return make_from_fmtty(k, o, acc, rest$12, fmt);
            end end);end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          error ({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "camlinternalFormat.ml",
              1616,
              31
            }
          })end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          error ({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "camlinternalFormat.ml",
              1617,
              31
            }
          })end end end 
       do
      
    end
  end end 
end end

function make_invalid_arg(k, o, acc, fmt) do
  return make_printf(k, o, --[[ Acc_invalid_arg ]]Block.__(8, {
                acc,
                "Printf: bad conversion %_"
              }), fmt);
end end

function make_padding(k, o, acc, fmt, pad, trans) do
  if (typeof pad == "number") then do
    return (function (x) do
        new_acc_001 = Curry._1(trans, x);
        new_acc = --[[ Acc_data_string ]]Block.__(4, {
            acc,
            new_acc_001
          });
        return make_printf(k, o, new_acc, fmt);
      end end);
  end else if (pad.tag) then do
    padty = pad[0];
    return (function (w, x) do
        new_acc_001 = fix_padding(padty, w, Curry._1(trans, x));
        new_acc = --[[ Acc_data_string ]]Block.__(4, {
            acc,
            new_acc_001
          });
        return make_printf(k, o, new_acc, fmt);
      end end);
  end else do
    width = pad[1];
    padty$1 = pad[0];
    return (function (x) do
        new_acc_001 = fix_padding(padty$1, width, Curry._1(trans, x));
        new_acc = --[[ Acc_data_string ]]Block.__(4, {
            acc,
            new_acc_001
          });
        return make_printf(k, o, new_acc, fmt);
      end end);
  end end  end 
end end

function make_int_padding_precision(k, o, acc, fmt, pad, prec, trans, iconv) do
  if (typeof pad == "number") then do
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (p, x) do
            str = fix_int_precision(p, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end else do
        return (function (x) do
            str = Curry._2(trans, iconv, x);
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end end 
    end else do
      p = prec[0];
      return (function (x) do
          str = fix_int_precision(p, Curry._2(trans, iconv, x));
          return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                        acc,
                        str
                      }), fmt);
        end end);
    end end 
  end else if (pad.tag) then do
    padty = pad[0];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (w, p, x) do
            str = fix_padding(padty, w, fix_int_precision(p, Curry._2(trans, iconv, x)));
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end else do
        return (function (w, x) do
            str = fix_padding(padty, w, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end end 
    end else do
      p$1 = prec[0];
      return (function (w, x) do
          str = fix_padding(padty, w, fix_int_precision(p$1, Curry._2(trans, iconv, x)));
          return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                        acc,
                        str
                      }), fmt);
        end end);
    end end 
  end else do
    w = pad[1];
    padty$1 = pad[0];
    if (typeof prec == "number") then do
      if (prec ~= 0) then do
        return (function (p, x) do
            str = fix_padding(padty$1, w, fix_int_precision(p, Curry._2(trans, iconv, x)));
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end else do
        return (function (x) do
            str = fix_padding(padty$1, w, Curry._2(trans, iconv, x));
            return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                          acc,
                          str
                        }), fmt);
          end end);
      end end 
    end else do
      p$2 = prec[0];
      return (function (x) do
          str = fix_padding(padty$1, w, fix_int_precision(p$2, Curry._2(trans, iconv, x)));
          return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                        acc,
                        str
                      }), fmt);
        end end);
    end end 
  end end  end 
end end

function make_custom(k, o, acc, rest, arity, f) do
  if (arity) then do
    arity$1 = arity[0];
    return (function (x) do
        return make_custom(k, o, acc, rest, arity$1, Curry._1(f, x));
      end end);
  end else do
    return make_printf(k, o, --[[ Acc_data_string ]]Block.__(4, {
                  acc,
                  f
                }), rest);
  end end 
end end

function make_iprintf(_k, o, _fmt) do
  while(true) do
    fmt = _fmt;
    k = _k;
    exit = 0;
    if (typeof fmt == "number") then do
      return Curry._1(k, o);
    end else do
      local ___conditional___=(fmt.tag | 0);
      do
         if ___conditional___ = 2--[[ String ]] then do
            tmp = fmt[0];
            if (typeof tmp ~= "number" and tmp.tag) then do
              partial_arg = make_iprintf(k, o, fmt[1]);
              partial_arg$1 = (function(partial_arg)do
              return function partial_arg$1(param) do
                return partial_arg;
              end end
              end(partial_arg));
              return (function (param) do
                  return partial_arg$1;
                end end);
            end
             end 
            partial_arg$2 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$2)do
            return function (param) do
              return partial_arg$2;
            end end
            end(partial_arg$2));end end end 
         if ___conditional___ = 3--[[ Caml_string ]] then do
            tmp$1 = fmt[0];
            if (typeof tmp$1 ~= "number" and tmp$1.tag) then do
              partial_arg$3 = make_iprintf(k, o, fmt[1]);
              partial_arg$4 = (function(partial_arg$3)do
              return function partial_arg$4(param) do
                return partial_arg$3;
              end end
              end(partial_arg$3));
              return (function (param) do
                  return partial_arg$4;
                end end);
            end
             end 
            partial_arg$5 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$5)do
            return function (param) do
              return partial_arg$5;
            end end
            end(partial_arg$5));end end end 
         if ___conditional___ = 9--[[ Bool ]] then do
            tmp$2 = fmt[0];
            if (typeof tmp$2 ~= "number" and tmp$2.tag) then do
              partial_arg$6 = make_iprintf(k, o, fmt[1]);
              partial_arg$7 = (function(partial_arg$6)do
              return function partial_arg$7(param) do
                return partial_arg$6;
              end end
              end(partial_arg$6));
              return (function (param) do
                  return partial_arg$7;
                end end);
            end
             end 
            partial_arg$8 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$8)do
            return function (param) do
              return partial_arg$8;
            end end
            end(partial_arg$8));end end end 
         if ___conditional___ = 10--[[ Flush ]] then do
            _fmt = fmt[0];
            ::continue:: ;end end end 
         if ___conditional___ = 14--[[ Format_subst ]] then do
            rest = fmt[2];
            fmtty = fmt[1];
            return (function(k,fmtty,rest)do
            return function (param) do
              return make_iprintf(k, o, CamlinternalFormatBasics.concat_fmt(recast(param[0], fmtty), rest));
            end end
            end(k,fmtty,rest));end end end 
         if ___conditional___ = 15--[[ Alpha ]] then do
            partial_arg$9 = make_iprintf(k, o, fmt[0]);
            partial_arg$10 = (function(partial_arg$9)do
            return function partial_arg$10(param) do
              return partial_arg$9;
            end end
            end(partial_arg$9));
            return (function (param) do
                return partial_arg$10;
              end end);end end end 
         if ___conditional___ = 11--[[ String_literal ]]
         or ___conditional___ = 12--[[ Char_literal ]]
         or ___conditional___ = 17--[[ Formatting_lit ]] then do
            exit = 2;end else 
         if ___conditional___ = 18--[[ Formatting_gen ]] then do
            match = fmt[0];
            if (match.tag) then do
              rest$1 = fmt[1];
              _fmt = match[0][0];
              _k = (function(k,rest$1)do
              return function (koc) do
                return make_iprintf(k, koc, rest$1);
              end end
              end(k,rest$1));
              ::continue:: ;
            end else do
              rest$2 = fmt[1];
              _fmt = match[0][0];
              _k = (function(k,rest$2)do
              return function (koc) do
                return make_iprintf(k, koc, rest$2);
              end end
              end(k,rest$2));
              ::continue:: ;
            end end end end end 
         if ___conditional___ = 19--[[ Reader ]] then do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                1797,
                8
              }
            })end end end 
         if ___conditional___ = 13--[[ Format_arg ]]
         or ___conditional___ = 20--[[ Scan_char_set ]] then do
            exit = 3;end else 
         if ___conditional___ = 21--[[ Scan_get_counter ]] then do
            partial_arg$11 = make_iprintf(k, o, fmt[1]);
            return (function(partial_arg$11)do
            return function (param) do
              return partial_arg$11;
            end end
            end(partial_arg$11));end end end 
         if ___conditional___ = 0--[[ Char ]]
         or ___conditional___ = 1--[[ Caml_char ]]
         or ___conditional___ = 16--[[ Theta ]]
         or ___conditional___ = 22--[[ Scan_next_char ]] then do
            exit = 1;end else 
         if ___conditional___ = 23--[[ Ignored_param ]] then do
            return make_ignored_param((function(k)do
                      return function (x, param) do
                        return Curry._1(k, x);
                      end end
                      end(k)), o, --[[ End_of_acc ]]0, fmt[0], fmt[1]);end end end 
         if ___conditional___ = 24--[[ Custom ]] then do
            return fn_of_custom_arity(k, o, fmt[2], fmt[0]);end end end 
         do
        else do
          k$1 = k;
          o$1 = o;
          fmt$1 = fmt[3];
          pad = fmt[1];
          prec = fmt[2];
          if (typeof pad == "number") then do
            if (typeof prec == "number") then do
              if (prec ~= 0) then do
                partial_arg$12 = make_iprintf(k$1, o$1, fmt$1);
                partial_arg$13 = (function(partial_arg$12)do
                return function partial_arg$13(param) do
                  return partial_arg$12;
                end end
                end(partial_arg$12));
                return (function (param) do
                    return partial_arg$13;
                  end end);
              end else do
                partial_arg$14 = make_iprintf(k$1, o$1, fmt$1);
                return (function(partial_arg$14)do
                return function (param) do
                  return partial_arg$14;
                end end
                end(partial_arg$14));
              end end 
            end else do
              partial_arg$15 = make_iprintf(k$1, o$1, fmt$1);
              return (function(partial_arg$15)do
              return function (param) do
                return partial_arg$15;
              end end
              end(partial_arg$15));
            end end 
          end else if (pad.tag) then do
            if (typeof prec == "number") then do
              if (prec ~= 0) then do
                partial_arg$16 = make_iprintf(k$1, o$1, fmt$1);
                partial_arg$17 = (function(partial_arg$16)do
                return function partial_arg$17(param) do
                  return partial_arg$16;
                end end
                end(partial_arg$16));
                partial_arg$18 = function (param) do
                  return partial_arg$17;
                end end;
                return (function (param) do
                    return partial_arg$18;
                  end end);
              end else do
                partial_arg$19 = make_iprintf(k$1, o$1, fmt$1);
                partial_arg$20 = (function(partial_arg$19)do
                return function partial_arg$20(param) do
                  return partial_arg$19;
                end end
                end(partial_arg$19));
                return (function (param) do
                    return partial_arg$20;
                  end end);
              end end 
            end else do
              partial_arg$21 = make_iprintf(k$1, o$1, fmt$1);
              partial_arg$22 = (function(partial_arg$21)do
              return function partial_arg$22(param) do
                return partial_arg$21;
              end end
              end(partial_arg$21));
              return (function (param) do
                  return partial_arg$22;
                end end);
            end end 
          end else if (typeof prec == "number") then do
            if (prec ~= 0) then do
              partial_arg$23 = make_iprintf(k$1, o$1, fmt$1);
              partial_arg$24 = (function(partial_arg$23)do
              return function partial_arg$24(param) do
                return partial_arg$23;
              end end
              end(partial_arg$23));
              return (function (param) do
                  return partial_arg$24;
                end end);
            end else do
              partial_arg$25 = make_iprintf(k$1, o$1, fmt$1);
              return (function(partial_arg$25)do
              return function (param) do
                return partial_arg$25;
              end end
              end(partial_arg$25));
            end end 
          end else do
            partial_arg$26 = make_iprintf(k$1, o$1, fmt$1);
            return (function(partial_arg$26)do
            return function (param) do
              return partial_arg$26;
            end end
            end(partial_arg$26));
          end end  end  end 
          end end
          
      end
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ = 1 then do
          partial_arg$27 = make_iprintf(k, o, fmt[0]);
          return (function(partial_arg$27)do
          return function (param) do
            return partial_arg$27;
          end end
          end(partial_arg$27));end end end 
       if ___conditional___ = 2 then do
          _fmt = fmt[1];
          ::continue:: ;end end end 
       if ___conditional___ = 3 then do
          partial_arg$28 = make_iprintf(k, o, fmt[2]);
          return (function(partial_arg$28)do
          return function (param) do
            return partial_arg$28;
          end end
          end(partial_arg$28));end end end 
       do
      
    end
  end;
end end

function fn_of_custom_arity(k, o, fmt, param) do
  if (param) then do
    partial_arg = fn_of_custom_arity(k, o, fmt, param[0]);
    return (function (param) do
        return partial_arg;
      end end);
  end else do
    return make_iprintf(k, o, fmt);
  end end 
end end

function output_acc(o, _acc) do
  while(true) do
    acc = _acc;
    exit = 0;
    if (typeof acc == "number") then do
      return --[[ () ]]0;
    end else do
      local ___conditional___=(acc.tag | 0);
      do
         if ___conditional___ = 0--[[ Acc_formatting_lit ]] then do
            s = string_of_formatting_lit(acc[1]);
            output_acc(o, acc[0]);
            return Pervasives.output_string(o, s);end end end 
         if ___conditional___ = 1--[[ Acc_formatting_gen ]] then do
            match = acc[1];
            p = acc[0];
            output_acc(o, p);
            if (match.tag) then do
              Pervasives.output_string(o, "@[");
              _acc = match[0];
              ::continue:: ;
            end else do
              Pervasives.output_string(o, "@{");
              _acc = match[0];
              ::continue:: ;
            end end end end end 
         if ___conditional___ = 2--[[ Acc_string_literal ]]
         or ___conditional___ = 4--[[ Acc_data_string ]] then do
            exit = 1;end else 
         if ___conditional___ = 3--[[ Acc_char_literal ]]
         or ___conditional___ = 5--[[ Acc_data_char ]] then do
            exit = 2;end else 
         if ___conditional___ = 6--[[ Acc_delay ]] then do
            output_acc(o, acc[0]);
            return Curry._1(acc[1], o);end end end 
         if ___conditional___ = 7--[[ Acc_flush ]] then do
            output_acc(o, acc[0]);
            return Caml_io.caml_ml_flush(o);end end end 
         if ___conditional___ = 8--[[ Acc_invalid_arg ]] then do
            output_acc(o, acc[0]);
            error ({
              Caml_builtin_exceptions.invalid_argument,
              acc[1]
            })end end end 
         do
        
      end
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ = 1 then do
          output_acc(o, acc[0]);
          return Pervasives.output_string(o, acc[1]);end end end 
       if ___conditional___ = 2 then do
          output_acc(o, acc[0]);
          return Caml_io.caml_ml_output_char(o, acc[1]);end end end 
       do
      
    end
  end;
end end

function bufput_acc(b, _acc) do
  while(true) do
    acc = _acc;
    exit = 0;
    if (typeof acc == "number") then do
      return --[[ () ]]0;
    end else do
      local ___conditional___=(acc.tag | 0);
      do
         if ___conditional___ = 0--[[ Acc_formatting_lit ]] then do
            s = string_of_formatting_lit(acc[1]);
            bufput_acc(b, acc[0]);
            return __Buffer.add_string(b, s);end end end 
         if ___conditional___ = 1--[[ Acc_formatting_gen ]] then do
            match = acc[1];
            p = acc[0];
            bufput_acc(b, p);
            if (match.tag) then do
              __Buffer.add_string(b, "@[");
              _acc = match[0];
              ::continue:: ;
            end else do
              __Buffer.add_string(b, "@{");
              _acc = match[0];
              ::continue:: ;
            end end end end end 
         if ___conditional___ = 2--[[ Acc_string_literal ]]
         or ___conditional___ = 4--[[ Acc_data_string ]] then do
            exit = 1;end else 
         if ___conditional___ = 3--[[ Acc_char_literal ]]
         or ___conditional___ = 5--[[ Acc_data_char ]] then do
            exit = 2;end else 
         if ___conditional___ = 6--[[ Acc_delay ]] then do
            bufput_acc(b, acc[0]);
            return Curry._1(acc[1], b);end end end 
         if ___conditional___ = 7--[[ Acc_flush ]] then do
            _acc = acc[0];
            ::continue:: ;end end end 
         if ___conditional___ = 8--[[ Acc_invalid_arg ]] then do
            bufput_acc(b, acc[0]);
            error ({
              Caml_builtin_exceptions.invalid_argument,
              acc[1]
            })end end end 
         do
        
      end
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ = 1 then do
          bufput_acc(b, acc[0]);
          return __Buffer.add_string(b, acc[1]);end end end 
       if ___conditional___ = 2 then do
          bufput_acc(b, acc[0]);
          return __Buffer.add_char(b, acc[1]);end end end 
       do
      
    end
  end;
end end

function strput_acc(b, _acc) do
  while(true) do
    acc = _acc;
    exit = 0;
    if (typeof acc == "number") then do
      return --[[ () ]]0;
    end else do
      local ___conditional___=(acc.tag | 0);
      do
         if ___conditional___ = 0--[[ Acc_formatting_lit ]] then do
            s = string_of_formatting_lit(acc[1]);
            strput_acc(b, acc[0]);
            return __Buffer.add_string(b, s);end end end 
         if ___conditional___ = 1--[[ Acc_formatting_gen ]] then do
            match = acc[1];
            p = acc[0];
            strput_acc(b, p);
            if (match.tag) then do
              __Buffer.add_string(b, "@[");
              _acc = match[0];
              ::continue:: ;
            end else do
              __Buffer.add_string(b, "@{");
              _acc = match[0];
              ::continue:: ;
            end end end end end 
         if ___conditional___ = 2--[[ Acc_string_literal ]]
         or ___conditional___ = 4--[[ Acc_data_string ]] then do
            exit = 1;end else 
         if ___conditional___ = 3--[[ Acc_char_literal ]]
         or ___conditional___ = 5--[[ Acc_data_char ]] then do
            exit = 2;end else 
         if ___conditional___ = 6--[[ Acc_delay ]] then do
            strput_acc(b, acc[0]);
            return __Buffer.add_string(b, Curry._1(acc[1], --[[ () ]]0));end end end 
         if ___conditional___ = 7--[[ Acc_flush ]] then do
            _acc = acc[0];
            ::continue:: ;end end end 
         if ___conditional___ = 8--[[ Acc_invalid_arg ]] then do
            strput_acc(b, acc[0]);
            error ({
              Caml_builtin_exceptions.invalid_argument,
              acc[1]
            })end end end 
         do
        
      end
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ = 1 then do
          strput_acc(b, acc[0]);
          return __Buffer.add_string(b, acc[1]);end end end 
       if ___conditional___ = 2 then do
          strput_acc(b, acc[0]);
          return __Buffer.add_char(b, acc[1]);end end end 
       do
      
    end
  end;
end end

function failwith_message(param) do
  buf = __Buffer.create(256);
  k = function (param, acc) do
    strput_acc(buf, acc);
    s = __Buffer.contents(buf);
    error ({
      Caml_builtin_exceptions.failure,
      s
    })
  end end;
  return make_printf(k, --[[ () ]]0, --[[ End_of_acc ]]0, param[0]);
end end

function open_box_of_string(str) do
  if (str == "") then do
    return --[[ tuple ]]{
            0,
            --[[ Pp_box ]]4
          };
  end else do
    len = #str;
    invalid_box = function (param) do
      return Curry._1(failwith_message(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "invalid box description ",
                          --[[ Caml_string ]]Block.__(3, {
                              --[[ No_padding ]]0,
                              --[[ End_of_format ]]0
                            })
                        }),
                      "invalid box description %S"
                    }), str);
    end end;
    parse_spaces = function (_i) do
      while(true) do
        i = _i;
        if (i == len) then do
          return i;
        end else do
          match = Caml_string.get(str, i);
          if (match ~= 9) then do
            if (match ~= 32) then do
              return i;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end 
        end end 
      end;
    end end;
    parse_lword = function (i, _j) do
      while(true) do
        j = _j;
        if (j == len) then do
          return j;
        end else do
          match = Caml_string.get(str, j);
          if (match > 122 or match < 97) then do
            return j;
          end else do
            _j = j + 1 | 0;
            ::continue:: ;
          end end 
        end end 
      end;
    end end;
    parse_int = function (i, _j) do
      while(true) do
        j = _j;
        if (j == len) then do
          return j;
        end else do
          match = Caml_string.get(str, j);
          if (match >= 48) then do
            if (match >= 58) then do
              return j;
            end else do
              _j = j + 1 | 0;
              ::continue:: ;
            end end 
          end else if (match ~= 45) then do
            return j;
          end else do
            _j = j + 1 | 0;
            ::continue:: ;
          end end  end 
        end end 
      end;
    end end;
    wstart = parse_spaces(0);
    wend = parse_lword(wstart, wstart);
    box_name = __String.sub(str, wstart, wend - wstart | 0);
    nstart = parse_spaces(wend);
    nend = parse_int(nstart, nstart);
    indent;
    if (nstart == nend) then do
      indent = 0;
    end else do
      xpcall(function() do
        indent = Caml_format.caml_int_of_string(__String.sub(str, nstart, nend - nstart | 0));
      end end,function(raw_exn) return do
        exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
        if (exn[0] == Caml_builtin_exceptions.failure) then do
          indent = invalid_box(--[[ () ]]0);
        end else do
          error (exn)
        end end 
      end end)
    end end 
    exp_end = parse_spaces(nend);
    if (exp_end ~= len) then do
      invalid_box(--[[ () ]]0);
    end
     end 
    box_type;
    local ___conditional___=(box_name);
    do
       if ___conditional___ = ""
       or ___conditional___ = "b" then do
          box_type = --[[ Pp_box ]]4;end else 
       if ___conditional___ = "h" then do
          box_type = --[[ Pp_hbox ]]0;end else 
       if ___conditional___ = "hov" then do
          box_type = --[[ Pp_hovbox ]]3;end else 
       if ___conditional___ = "hv" then do
          box_type = --[[ Pp_hvbox ]]2;end else 
       if ___conditional___ = "v" then do
          box_type = --[[ Pp_vbox ]]1;end else 
       do end end end end end end
      else do
        box_type = invalid_box(--[[ () ]]0);
        end end
        
    end
    return --[[ tuple ]]{
            indent,
            box_type
          };
  end end 
end end

function make_padding_fmt_ebb(pad, fmt) do
  if (typeof pad == "number") then do
    return --[[ Padding_fmt_EBB ]]{
            --[[ No_padding ]]0,
            fmt
          };
  end else if (pad.tag) then do
    return --[[ Padding_fmt_EBB ]]{
            --[[ Arg_padding ]]Block.__(1, {pad[0]}),
            fmt
          };
  end else do
    return --[[ Padding_fmt_EBB ]]{
            --[[ Lit_padding ]]Block.__(0, {
                pad[0],
                pad[1]
              }),
            fmt
          };
  end end  end 
end end

function make_precision_fmt_ebb(prec, fmt) do
  if (typeof prec == "number") then do
    if (prec ~= 0) then do
      return --[[ Precision_fmt_EBB ]]{
              --[[ Arg_precision ]]1,
              fmt
            };
    end else do
      return --[[ Precision_fmt_EBB ]]{
              --[[ No_precision ]]0,
              fmt
            };
    end end 
  end else do
    return --[[ Precision_fmt_EBB ]]{
            --[[ Lit_precision ]]{prec[0]},
            fmt
          };
  end end 
end end

function make_padprec_fmt_ebb(pad, prec, fmt) do
  match = make_precision_fmt_ebb(prec, fmt);
  fmt$prime = match[1];
  prec$1 = match[0];
  if (typeof pad == "number") then do
    return --[[ Padprec_fmt_EBB ]]{
            --[[ No_padding ]]0,
            prec$1,
            fmt$prime
          };
  end else if (pad.tag) then do
    return --[[ Padprec_fmt_EBB ]]{
            --[[ Arg_padding ]]Block.__(1, {pad[0]}),
            prec$1,
            fmt$prime
          };
  end else do
    return --[[ Padprec_fmt_EBB ]]{
            --[[ Lit_padding ]]Block.__(0, {
                pad[0],
                pad[1]
              }),
            prec$1,
            fmt$prime
          };
  end end  end 
end end

function fmt_ebb_of_string(legacy_behavior, str) do
  legacy_behavior$1 = legacy_behavior ~= undefined and legacy_behavior or true;
  invalid_format_message = function (str_ind, msg) do
    return Curry._3(failwith_message(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "invalid format ",
                        --[[ Caml_string ]]Block.__(3, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": at character number ",
                                --[[ Int ]]Block.__(4, {
                                    --[[ Int_d ]]0,
                                    --[[ No_padding ]]0,
                                    --[[ No_precision ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ", ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ End_of_format ]]0
                                          })
                                      })
                                  })
                              })
                          })
                      }),
                    "invalid format %S: at character number %d, %s"
                  }), str, str_ind, msg);
  end end;
  invalid_format_without = function (str_ind, c, s) do
    return Curry._4(failwith_message(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "invalid format ",
                        --[[ Caml_string ]]Block.__(3, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": at character number ",
                                --[[ Int ]]Block.__(4, {
                                    --[[ Int_d ]]0,
                                    --[[ No_padding ]]0,
                                    --[[ No_precision ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ", '",
                                        --[[ Char ]]Block.__(0, {--[[ String_literal ]]Block.__(11, {
                                                "' without ",
                                                --[[ String ]]Block.__(2, {
                                                    --[[ No_padding ]]0,
                                                    --[[ End_of_format ]]0
                                                  })
                                              })})
                                      })
                                  })
                              })
                          })
                      }),
                    "invalid format %S: at character number %d, '%c' without %s"
                  }), str, str_ind, c, s);
  end end;
  expected_character = function (str_ind, expected, read) do
    return Curry._4(failwith_message(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "invalid format ",
                        --[[ Caml_string ]]Block.__(3, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": at character number ",
                                --[[ Int ]]Block.__(4, {
                                    --[[ Int_d ]]0,
                                    --[[ No_padding ]]0,
                                    --[[ No_precision ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ", ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ String_literal ]]Block.__(11, {
                                                " expected, read ",
                                                --[[ Caml_char ]]Block.__(1, {--[[ End_of_format ]]0})
                                              })
                                          })
                                      })
                                  })
                              })
                          })
                      }),
                    "invalid format %S: at character number %d, %s expected, read %C"
                  }), str, str_ind, expected, read);
  end end;
  parse_after_at = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      return --[[ Fmt_EBB ]]{--[[ Char_literal ]]Block.__(12, {
                  --[[ "@" ]]64,
                  --[[ End_of_format ]]0
                })};
    end else do
      c = Caml_string.get(str, str_ind);
      if (c >= 65) then do
        if (c >= 94) then do
          local ___conditional___=(c);
          do
             if ___conditional___ = 123 then do
                return parse_tag(true, str_ind + 1 | 0, end_ind);end end end 
             if ___conditional___ = 124
             or ___conditional___ = 125 then do
                beg_ind = str_ind + 1 | 0;
                match = parse_literal(beg_ind, beg_ind, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Close_tag ]]1,
                            match[0]
                          })};end end end 
             do
            else do
              end end
              
          end
        end else if (c >= 91) then do
          local ___conditional___=(c - 91 | 0);
          do
             if ___conditional___ = 0 then do
                return parse_tag(false, str_ind + 1 | 0, end_ind);end end end 
             if ___conditional___ = 1
             or ___conditional___ = 2 then do
                beg_ind$1 = str_ind + 1 | 0;
                match$1 = parse_literal(beg_ind$1, beg_ind$1, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Close_box ]]0,
                            match$1[0]
                          })};end end end 
             do
            
          end
        end
         end  end 
      end else if (c ~= 10) then do
        if (c >= 32) then do
          local ___conditional___=(c - 32 | 0);
          do
             if ___conditional___ = 0 then do
                beg_ind$2 = str_ind + 1 | 0;
                match$2 = parse_literal(beg_ind$2, beg_ind$2, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Break ]]Block.__(0, {
                                "@ ",
                                1,
                                0
                              }),
                            match$2[0]
                          })};end end end 
             if ___conditional___ = 5 then do
                if ((str_ind + 1 | 0) < end_ind and Caml_string.get(str, str_ind + 1 | 0) == --[[ "%" ]]37) then do
                  beg_ind$3 = str_ind + 2 | 0;
                  match$3 = parse_literal(beg_ind$3, beg_ind$3, end_ind);
                  return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                              --[[ Escaped_percent ]]6,
                              match$3[0]
                            })};
                end else do
                  match$4 = parse_literal(str_ind, str_ind, end_ind);
                  return --[[ Fmt_EBB ]]{--[[ Char_literal ]]Block.__(12, {
                              --[[ "@" ]]64,
                              match$4[0]
                            })};
                end end end end end 
             if ___conditional___ = 12 then do
                beg_ind$4 = str_ind + 1 | 0;
                match$5 = parse_literal(beg_ind$4, beg_ind$4, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Break ]]Block.__(0, {
                                "@,",
                                0,
                                0
                              }),
                            match$5[0]
                          })};end end end 
             if ___conditional___ = 14 then do
                beg_ind$5 = str_ind + 1 | 0;
                match$6 = parse_literal(beg_ind$5, beg_ind$5, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Flush_newline ]]4,
                            match$6[0]
                          })};end end end 
             if ___conditional___ = 27 then do
                str_ind$1 = str_ind + 1 | 0;
                end_ind$1 = end_ind;
                match$7;
                xpcall(function() do
                  if (str_ind$1 == end_ind$1 or Caml_string.get(str, str_ind$1) ~= --[[ "<" ]]60) then do
                    error (Caml_builtin_exceptions.not_found)
                  end
                   end 
                  str_ind_1 = parse_spaces(str_ind$1 + 1 | 0, end_ind$1);
                  match$8 = Caml_string.get(str, str_ind_1);
                  exit = 0;
                  if (match$8 >= 48) then do
                    if (match$8 >= 58) then do
                      error (Caml_builtin_exceptions.not_found)
                    end
                     end 
                    exit = 1;
                  end else do
                    if (match$8 ~= 45) then do
                      error (Caml_builtin_exceptions.not_found)
                    end
                     end 
                    exit = 1;
                  end end 
                  if (exit == 1) then do
                    match$9 = parse_integer(str_ind_1, end_ind$1);
                    width = match$9[1];
                    str_ind_3 = parse_spaces(match$9[0], end_ind$1);
                    match$10 = Caml_string.get(str, str_ind_3);
                    switcher = match$10 - 45 | 0;
                    if (switcher > 12 or switcher < 0) then do
                      if (switcher ~= 17) then do
                        error (Caml_builtin_exceptions.not_found)
                      end
                       end 
                      s = __String.sub(str, str_ind$1 - 2 | 0, (str_ind_3 - str_ind$1 | 0) + 3 | 0);
                      match$7 = --[[ tuple ]]{
                        str_ind_3 + 1 | 0,
                        --[[ Break ]]Block.__(0, {
                            s,
                            width,
                            0
                          })
                      };
                    end else if (switcher == 2 or switcher == 1) then do
                      error (Caml_builtin_exceptions.not_found)
                    end else do
                      match$11 = parse_integer(str_ind_3, end_ind$1);
                      str_ind_5 = parse_spaces(match$11[0], end_ind$1);
                      if (Caml_string.get(str, str_ind_5) ~= --[[ ">" ]]62) then do
                        error (Caml_builtin_exceptions.not_found)
                      end
                       end 
                      s$1 = __String.sub(str, str_ind$1 - 2 | 0, (str_ind_5 - str_ind$1 | 0) + 3 | 0);
                      match$7 = --[[ tuple ]]{
                        str_ind_5 + 1 | 0,
                        --[[ Break ]]Block.__(0, {
                            s$1,
                            width,
                            match$11[1]
                          })
                      };
                    end end  end 
                  end
                   end 
                end end,function(raw_exn) return do
                  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
                  if (exn == Caml_builtin_exceptions.not_found or exn[0] == Caml_builtin_exceptions.failure) then do
                    match$7 = --[[ tuple ]]{
                      str_ind$1,
                      --[[ Break ]]Block.__(0, {
                          "@;",
                          1,
                          0
                        })
                    };
                  end else do
                    error (exn)
                  end end 
                end end)
                next_ind = match$7[0];
                match$12 = parse_literal(next_ind, next_ind, end_ind$1);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            match$7[1],
                            match$12[0]
                          })};end end end 
             if ___conditional___ = 28 then do
                str_ind$2 = str_ind + 1 | 0;
                end_ind$2 = end_ind;
                match$13;
                xpcall(function() do
                  str_ind_1$1 = parse_spaces(str_ind$2, end_ind$2);
                  match$14 = Caml_string.get(str, str_ind_1$1);
                  exit$1 = 0;
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
                    match$15 = parse_integer(str_ind_1$1, end_ind$2);
                    str_ind_3$1 = parse_spaces(match$15[0], end_ind$2);
                    if (Caml_string.get(str, str_ind_3$1) ~= --[[ ">" ]]62) then do
                      error (Caml_builtin_exceptions.not_found)
                    end
                     end 
                    s$2 = __String.sub(str, str_ind$2 - 2 | 0, (str_ind_3$1 - str_ind$2 | 0) + 3 | 0);
                    match$13 = --[[ tuple ]]{
                      str_ind_3$1 + 1 | 0,
                      --[[ Magic_size ]]Block.__(1, {
                          s$2,
                          match$15[1]
                        })
                    };
                  end
                   end 
                end end,function(raw_exn$1) return do
                  exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
                  if (exn$1 == Caml_builtin_exceptions.not_found or exn$1[0] == Caml_builtin_exceptions.failure) then do
                    match$13 = undefined;
                  end else do
                    error (exn$1)
                  end end 
                end end)
                if (match$13 ~= undefined) then do
                  match$16 = match$13;
                  next_ind$1 = match$16[0];
                  match$17 = parse_literal(next_ind$1, next_ind$1, end_ind$2);
                  return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                              match$16[1],
                              match$17[0]
                            })};
                end else do
                  match$18 = parse_literal(str_ind$2, str_ind$2, end_ind$2);
                  return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                              --[[ Scan_indic ]]Block.__(2, {--[[ "<" ]]60}),
                              match$18[0]
                            })};
                end end end end end 
             if ___conditional___ = 1
             or ___conditional___ = 2
             or ___conditional___ = 3
             or ___conditional___ = 4
             or ___conditional___ = 6
             or ___conditional___ = 7
             or ___conditional___ = 8
             or ___conditional___ = 9
             or ___conditional___ = 10
             or ___conditional___ = 11
             or ___conditional___ = 13
             or ___conditional___ = 15
             or ___conditional___ = 16
             or ___conditional___ = 17
             or ___conditional___ = 18
             or ___conditional___ = 19
             or ___conditional___ = 20
             or ___conditional___ = 21
             or ___conditional___ = 22
             or ___conditional___ = 23
             or ___conditional___ = 24
             or ___conditional___ = 25
             or ___conditional___ = 26
             or ___conditional___ = 29
             or ___conditional___ = 30
             or ___conditional___ = 31 then do
                beg_ind$6 = str_ind + 1 | 0;
                match$19 = parse_literal(beg_ind$6, beg_ind$6, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ FFlush ]]2,
                            match$19[0]
                          })};end end end 
             if ___conditional___ = 32 then do
                beg_ind$7 = str_ind + 1 | 0;
                match$20 = parse_literal(beg_ind$7, beg_ind$7, end_ind);
                return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                            --[[ Escaped_at ]]5,
                            match$20[0]
                          })};end end end 
             do
            
          end
        end
         end 
      end else do
        beg_ind$8 = str_ind + 1 | 0;
        match$21 = parse_literal(beg_ind$8, beg_ind$8, end_ind);
        return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                    --[[ Force_newline ]]3,
                    match$21[0]
                  })};
      end end  end 
      beg_ind$9 = str_ind + 1 | 0;
      match$22 = parse_literal(beg_ind$9, beg_ind$9, end_ind);
      return --[[ Fmt_EBB ]]{--[[ Formatting_lit ]]Block.__(17, {
                  --[[ Scan_indic ]]Block.__(2, {c}),
                  match$22[0]
                })};
    end end 
  end end;
  add_literal = function (lit_start, str_ind, fmt) do
    size = str_ind - lit_start | 0;
    if (size ~= 0) then do
      if (size ~= 1) then do
        return --[[ Fmt_EBB ]]{--[[ String_literal ]]Block.__(11, {
                    __String.sub(str, lit_start, size),
                    fmt
                  })};
      end else do
        return --[[ Fmt_EBB ]]{--[[ Char_literal ]]Block.__(12, {
                    Caml_string.get(str, lit_start),
                    fmt
                  })};
      end end 
    end else do
      return --[[ Fmt_EBB ]]{fmt};
    end end 
  end end;
  parse_format = function (pct_ind, end_ind) do
    pct_ind$1 = pct_ind;
    str_ind = pct_ind + 1 | 0;
    end_ind$1 = end_ind;
    if (str_ind == end_ind$1) then do
      invalid_format_message(end_ind$1, "unexpected end of format");
    end
     end 
    match = Caml_string.get(str, str_ind);
    if (match ~= 95) then do
      return parse_flags(pct_ind$1, str_ind, end_ind$1, false);
    end else do
      return parse_flags(pct_ind$1, str_ind + 1 | 0, end_ind$1, true);
    end end 
  end end;
  parse_literal = function (lit_start, _str_ind, end_ind) do
    while(true) do
      str_ind = _str_ind;
      if (str_ind == end_ind) then do
        return add_literal(lit_start, str_ind, --[[ End_of_format ]]0);
      end else do
        match = Caml_string.get(str, str_ind);
        if (match ~= 37) then do
          if (match ~= 64) then do
            _str_ind = str_ind + 1 | 0;
            ::continue:: ;
          end else do
            match$1 = parse_after_at(str_ind + 1 | 0, end_ind);
            return add_literal(lit_start, str_ind, match$1[0]);
          end end 
        end else do
          match$2 = parse_format(str_ind, end_ind);
          return add_literal(lit_start, str_ind, match$2[0]);
        end end 
      end end 
    end;
  end end;
  parse_spaces = function (_str_ind, end_ind) do
    while(true) do
      str_ind = _str_ind;
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      if (Caml_string.get(str, str_ind) == --[[ " " ]]32) then do
        _str_ind = str_ind + 1 | 0;
        ::continue:: ;
      end else do
        return str_ind;
      end end 
    end;
  end end;
  parse_flags = function (pct_ind, str_ind, end_ind, ign) do
    zero = do
      contents: false
    end;
    minus = do
      contents: false
    end;
    plus = do
      contents: false
    end;
    space = do
      contents: false
    end;
    hash = do
      contents: false
    end;
    set_flag = function (str_ind, flag) do
      if (flag.contents and not legacy_behavior$1) then do
        Curry._3(failwith_message(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "invalid format ",
                      --[[ Caml_string ]]Block.__(3, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ": at character number ",
                              --[[ Int ]]Block.__(4, {
                                  --[[ Int_d ]]0,
                                  --[[ No_padding ]]0,
                                  --[[ No_precision ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      ", duplicate flag ",
                                      --[[ Caml_char ]]Block.__(1, {--[[ End_of_format ]]0})
                                    })
                                })
                            })
                        })
                    }),
                  "invalid format %S: at character number %d, duplicate flag %C"
                }), str, str_ind, Caml_string.get(str, str_ind));
      end
       end 
      flag.contents = true;
      return --[[ () ]]0;
    end end;
    _str_ind = str_ind;
    while(true) do
      str_ind$1 = _str_ind;
      if (str_ind$1 == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      match = Caml_string.get(str, str_ind$1);
      local ___conditional___=(match);
      do
         if ___conditional___ = 32 then do
            set_flag(str_ind$1, space);
            _str_ind = str_ind$1 + 1 | 0;
            ::continue:: ;end end end 
         if ___conditional___ = 35 then do
            set_flag(str_ind$1, hash);
            _str_ind = str_ind$1 + 1 | 0;
            ::continue:: ;end end end 
         if ___conditional___ = 43 then do
            set_flag(str_ind$1, plus);
            _str_ind = str_ind$1 + 1 | 0;
            ::continue:: ;end end end 
         if ___conditional___ = 45 then do
            set_flag(str_ind$1, minus);
            _str_ind = str_ind$1 + 1 | 0;
            ::continue:: ;end end end 
         if ___conditional___ = 33
         or ___conditional___ = 34
         or ___conditional___ = 36
         or ___conditional___ = 37
         or ___conditional___ = 38
         or ___conditional___ = 39
         or ___conditional___ = 40
         or ___conditional___ = 41
         or ___conditional___ = 42
         or ___conditional___ = 44
         or ___conditional___ = 46
         or ___conditional___ = 47
         or ___conditional___ = 48 then do
            set_flag(str_ind$1, zero);
            _str_ind = str_ind$1 + 1 | 0;
            ::continue:: ;end end end 
         do
        else do
          end end
          
      end
      pct_ind$1 = pct_ind;
      str_ind$2 = str_ind$1;
      end_ind$1 = end_ind;
      zero$1 = zero.contents;
      minus$1 = minus.contents;
      plus$1 = plus.contents;
      hash$1 = hash.contents;
      space$1 = space.contents;
      ign$1 = ign;
      if (str_ind$2 == end_ind$1) then do
        invalid_format_message(end_ind$1, "unexpected end of format");
      end
       end 
      padty = zero$1 and (
          minus$1 and (
              legacy_behavior$1 and --[[ Left ]]0 or incompatible_flag(pct_ind$1, str_ind$2, --[[ "-" ]]45, "0")
            ) or --[[ Zeros ]]2
        ) or (
          minus$1 and --[[ Left ]]0 or --[[ Right ]]1
        );
      match$1 = Caml_string.get(str, str_ind$2);
      if (match$1 >= 48) then do
        if (match$1 < 58) then do
          match$2 = parse_positive(str_ind$2, end_ind$1, 0);
          return parse_after_padding(pct_ind$1, match$2[0], end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[[ Lit_padding ]]Block.__(0, {
                        padty,
                        match$2[1]
                      }));
        end
         end 
      end else if (match$1 == 42) then do
        return parse_after_padding(pct_ind$1, str_ind$2 + 1 | 0, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[[ Arg_padding ]]Block.__(1, {padty}));
      end
       end  end 
      local ___conditional___=(padty);
      do
         if ___conditional___ = 0--[[ Left ]] then do
            if (not legacy_behavior$1) then do
              invalid_format_without(str_ind$2 - 1 | 0, --[[ "-" ]]45, "padding");
            end
             end 
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[[ No_padding ]]0);end end end 
         if ___conditional___ = 1--[[ Right ]] then do
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[[ No_padding ]]0);end end end 
         if ___conditional___ = 2--[[ Zeros ]] then do
            return parse_after_padding(pct_ind$1, str_ind$2, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, --[[ Lit_padding ]]Block.__(0, {
                          --[[ Right ]]1,
                          0
                        }));end end end 
         do
        
      end
    end;
  end end;
  search_subformat_end = function (_str_ind, end_ind, c) do
    while(true) do
      str_ind = _str_ind;
      if (str_ind == end_ind) then do
        Curry._3(failwith_message(--[[ Format ]]{
                  --[[ String_literal ]]Block.__(11, {
                      "invalid format ",
                      --[[ Caml_string ]]Block.__(3, {
                          --[[ No_padding ]]0,
                          --[[ String_literal ]]Block.__(11, {
                              ": unclosed sub-format, expected \"",
                              --[[ Char_literal ]]Block.__(12, {
                                  --[[ "%" ]]37,
                                  --[[ Char ]]Block.__(0, {--[[ String_literal ]]Block.__(11, {
                                          "\" at character number ",
                                          --[[ Int ]]Block.__(4, {
                                              --[[ Int_d ]]0,
                                              --[[ No_padding ]]0,
                                              --[[ No_precision ]]0,
                                              --[[ End_of_format ]]0
                                            })
                                        })})
                                })
                            })
                        })
                    }),
                  "invalid format %S: unclosed sub-format, expected \"%%%c\" at character number %d"
                }), str, c, end_ind);
      end
       end 
      match = Caml_string.get(str, str_ind);
      if (match ~= 37) then do
        _str_ind = str_ind + 1 | 0;
        ::continue:: ;
      end else do
        if ((str_ind + 1 | 0) == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        if (Caml_string.get(str, str_ind + 1 | 0) == c) then do
          return str_ind;
        end else do
          match$1 = Caml_string.get(str, str_ind + 1 | 0);
          if (match$1 >= 95) then do
            if (match$1 >= 123) then do
              if (match$1 < 126) then do
                local ___conditional___=(match$1 - 123 | 0);
                do
                   if ___conditional___ = 0 then do
                      sub_end = search_subformat_end(str_ind + 2 | 0, end_ind, --[[ "}" ]]125);
                      _str_ind = sub_end + 2 | 0;
                      ::continue:: ;end end end 
                   if ___conditional___ = 1
                   or ___conditional___ = 2 then do
                      return expected_character(str_ind + 1 | 0, "character ')'", --[[ "}" ]]125);end end end 
                   do
                  
                end
              end
               end 
            end else if (match$1 < 96) then do
              if ((str_ind + 2 | 0) == end_ind) then do
                invalid_format_message(end_ind, "unexpected end of format");
              end
               end 
              match$2 = Caml_string.get(str, str_ind + 2 | 0);
              if (match$2 ~= 40) then do
                if (match$2 ~= 123) then do
                  _str_ind = str_ind + 3 | 0;
                  ::continue:: ;
                end else do
                  sub_end$1 = search_subformat_end(str_ind + 3 | 0, end_ind, --[[ "}" ]]125);
                  _str_ind = sub_end$1 + 2 | 0;
                  ::continue:: ;
                end end 
              end else do
                sub_end$2 = search_subformat_end(str_ind + 3 | 0, end_ind, --[[ ")" ]]41);
                _str_ind = sub_end$2 + 2 | 0;
                ::continue:: ;
              end end 
            end
             end  end 
          end else if (match$1 ~= 40) then do
            if (match$1 == 41) then do
              return expected_character(str_ind + 1 | 0, "character '}'", --[[ ")" ]]41);
            end
             end 
          end else do
            sub_end$3 = search_subformat_end(str_ind + 2 | 0, end_ind, --[[ ")" ]]41);
            _str_ind = sub_end$3 + 2 | 0;
            ::continue:: ;
          end end  end 
          _str_ind = str_ind + 2 | 0;
          ::continue:: ;
        end end 
      end end 
    end;
  end end;
  parse_positive = function (_str_ind, end_ind, _acc) do
    while(true) do
      acc = _acc;
      str_ind = _str_ind;
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      c = Caml_string.get(str, str_ind);
      if (c > 57 or c < 48) then do
        return --[[ tuple ]]{
                str_ind,
                acc
              };
      end else do
        new_acc = Caml_int32.imul(acc, 10) + (c - --[[ "0" ]]48 | 0) | 0;
        _acc = new_acc;
        _str_ind = str_ind + 1 | 0;
        ::continue:: ;
      end end 
    end;
  end end;
  check_open_box = function (fmt) do
    if (typeof fmt == "number" or not (fmt.tag == --[[ String_literal ]]11 and typeof fmt[1] == "number")) then do
      return --[[ () ]]0;
    end else do
      xpcall(function() do
        open_box_of_string(fmt[0]);
        return --[[ () ]]0;
      end end,function(raw_exn) return do
        exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
        if (exn[0] == Caml_builtin_exceptions.failure) then do
          return --[[ () ]]0;
        end else do
          error (exn)
        end end 
      end end)
    end end 
  end end;
  parse_conversion = function (pct_ind, str_ind, end_ind, plus, hash, space, ign, pad, prec, padprec, symb) do
    plus_used = false;
    hash_used = false;
    space_used = false;
    ign_used = do
      contents: false
    end;
    pad_used = do
      contents: false
    end;
    prec_used = do
      contents: false
    end;
    get_int_pad = function (param) do
      pad_used.contents = true;
      prec_used.contents = true;
      if (typeof prec == "number" and prec == 0) then do
        return pad;
      end
       end 
      if (typeof pad == "number") then do
        return --[[ No_padding ]]0;
      end else if (pad.tag) then do
        if (pad[0] >= 2) then do
          if (legacy_behavior$1) then do
            return --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1});
          end else do
            return incompatible_flag(pct_ind, str_ind, --[[ "0" ]]48, "precision");
          end end 
        end else do
          return pad;
        end end 
      end else if (pad[0] >= 2) then do
        if (legacy_behavior$1) then do
          return --[[ Lit_padding ]]Block.__(0, {
                    --[[ Right ]]1,
                    pad[1]
                  });
        end else do
          return incompatible_flag(pct_ind, str_ind, --[[ "0" ]]48, "precision");
        end end 
      end else do
        return pad;
      end end  end  end 
    end end;
    check_no_0 = function (symb, pad) do
      if (typeof pad == "number") then do
        return pad;
      end else if (pad.tag) then do
        if (pad[0] >= 2) then do
          if (legacy_behavior$1) then do
            return --[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1});
          end else do
            return incompatible_flag(pct_ind, str_ind, symb, "0");
          end end 
        end else do
          return pad;
        end end 
      end else if (pad[0] >= 2) then do
        if (legacy_behavior$1) then do
          return --[[ Lit_padding ]]Block.__(0, {
                    --[[ Right ]]1,
                    pad[1]
                  });
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "0");
        end end 
      end else do
        return pad;
      end end  end  end 
    end end;
    opt_of_pad = function (c, pad) do
      if (typeof pad == "number") then do
        return ;
      end else if (pad.tag) then do
        return incompatible_flag(pct_ind, str_ind, c, "'*'");
      end else do
        local ___conditional___=(pad[0]);
        do
           if ___conditional___ = 0--[[ Left ]] then do
              if (legacy_behavior$1) then do
                return pad[1];
              end else do
                return incompatible_flag(pct_ind, str_ind, c, "'-'");
              end end end end end 
           if ___conditional___ = 1--[[ Right ]] then do
              return pad[1];end end end 
           if ___conditional___ = 2--[[ Zeros ]] then do
              if (legacy_behavior$1) then do
                return pad[1];
              end else do
                return incompatible_flag(pct_ind, str_ind, c, "'0'");
              end end end end end 
           do
          
        end
      end end  end 
    end end;
    get_prec_opt = function (param) do
      prec_used.contents = true;
      if (typeof prec == "number") then do
        if (prec ~= 0) then do
          return incompatible_flag(pct_ind, str_ind, --[[ "_" ]]95, "'*'");
        end else do
          return ;
        end end 
      end else do
        return prec[0];
      end end 
    end end;
    fmt_result;
    exit = 0;
    exit$1 = 0;
    exit$2 = 0;
    if (symb >= 124) then do
      exit$1 = 6;
    end else do
      local ___conditional___=(symb);
      do
         if ___conditional___ = 33 then do
            match = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Flush ]]Block.__(10, {match[0]})};end else 
         if ___conditional___ = 40 then do
            sub_end = search_subformat_end(str_ind, end_ind, --[[ ")" ]]41);
            beg_ind = sub_end + 2 | 0;
            match$1 = parse_literal(beg_ind, beg_ind, end_ind);
            fmt_rest = match$1[0];
            match$2 = parse_literal(str_ind, str_ind, sub_end);
            sub_fmtty = fmtty_of_fmt(match$2[0]);
            if (ign_used.contents = true, ign) then do
              ignored_000 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
              ignored = --[[ Ignored_format_subst ]]Block.__(9, {
                  ignored_000,
                  sub_fmtty
                });
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored,
                    fmt_rest
                  })};
            end else do
              fmt_result = --[[ Fmt_EBB ]]{--[[ Format_subst ]]Block.__(14, {
                    opt_of_pad(--[[ "(" ]]40, (pad_used.contents = true, pad)),
                    sub_fmtty,
                    fmt_rest
                  })};
            end end end else 
         if ___conditional___ = 44 then do
            fmt_result = parse_literal(str_ind, str_ind, end_ind);end else 
         if ___conditional___ = 37
         or ___conditional___ = 64 then do
            exit$1 = 4;end else 
         if ___conditional___ = 67 then do
            match$3 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$1 = match$3[0];
            fmt_result = (ign_used.contents = true, ign) and --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    --[[ Ignored_caml_char ]]1,
                    fmt_rest$1
                  })} or --[[ Fmt_EBB ]]{--[[ Caml_char ]]Block.__(1, {fmt_rest$1})};end else 
         if ___conditional___ = 78 then do
            match$4 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$2 = match$4[0];
            if (ign_used.contents = true, ign) then do
              ignored$1 = --[[ Ignored_scan_get_counter ]]Block.__(11, {--[[ Token_counter ]]2});
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$1,
                    fmt_rest$2
                  })};
            end else do
              fmt_result = --[[ Fmt_EBB ]]{--[[ Scan_get_counter ]]Block.__(21, {
                    --[[ Token_counter ]]2,
                    fmt_rest$2
                  })};
            end end end else 
         if ___conditional___ = 83 then do
            pad$1 = check_no_0(symb, (pad_used.contents = true, padprec));
            match$5 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$3 = match$5[0];
            if (ign_used.contents = true, ign) then do
              ignored$2 = --[[ Ignored_caml_string ]]Block.__(1, {opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, padprec))});
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$2,
                    fmt_rest$3
                  })};
            end else do
              match$6 = make_padding_fmt_ebb(pad$1, fmt_rest$3);
              fmt_result = --[[ Fmt_EBB ]]{--[[ Caml_string ]]Block.__(3, {
                    match$6[0],
                    match$6[1]
                  })};
            end end end else 
         if ___conditional___ = 91 then do
            match$7 = parse_char_set(str_ind, end_ind);
            char_set = match$7[1];
            next_ind = match$7[0];
            match$8 = parse_literal(next_ind, next_ind, end_ind);
            fmt_rest$4 = match$8[0];
            if (ign_used.contents = true, ign) then do
              ignored_000$1 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
              ignored$3 = --[[ Ignored_scan_char_set ]]Block.__(10, {
                  ignored_000$1,
                  char_set
                });
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$3,
                    fmt_rest$4
                  })};
            end else do
              fmt_result = --[[ Fmt_EBB ]]{--[[ Scan_char_set ]]Block.__(20, {
                    opt_of_pad(--[[ "[" ]]91, (pad_used.contents = true, pad)),
                    char_set,
                    fmt_rest$4
                  })};
            end end end else 
         if ___conditional___ = 32
         or ___conditional___ = 35
         or ___conditional___ = 43
         or ___conditional___ = 45
         or ___conditional___ = 95 then do
            exit$1 = 5;end else 
         if ___conditional___ = 97 then do
            match$9 = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Alpha ]]Block.__(15, {match$9[0]})};end else 
         if ___conditional___ = 66
         or ___conditional___ = 98 then do
            exit$1 = 3;end else 
         if ___conditional___ = 99 then do
            char_format = function (fmt_rest) do
              if (ign_used.contents = true, ign) then do
                return --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                            --[[ Ignored_char ]]0,
                            fmt_rest
                          })};
              end else do
                return --[[ Fmt_EBB ]]{--[[ Char ]]Block.__(0, {fmt_rest})};
              end end 
            end end;
            scan_format = function (fmt_rest) do
              if (ign_used.contents = true, ign) then do
                return --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                            --[[ Ignored_scan_next_char ]]3,
                            fmt_rest
                          })};
              end else do
                return --[[ Fmt_EBB ]]{--[[ Scan_next_char ]]Block.__(22, {fmt_rest})};
              end end 
            end end;
            match$10 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$5 = match$10[0];
            match$11 = opt_of_pad(--[[ "c" ]]99, (pad_used.contents = true, pad));
            fmt_result = match$11 ~= undefined and (
                match$11 ~= 0 and (
                    legacy_behavior$1 and char_format(fmt_rest$5) or invalid_format_message(str_ind, "non-zero widths are unsupported for %c conversions")
                  ) or scan_format(fmt_rest$5)
              ) or char_format(fmt_rest$5);end else 
         if ___conditional___ = 69
         or ___conditional___ = 70
         or ___conditional___ = 71
         or ___conditional___ = 72
         or ___conditional___ = 101
         or ___conditional___ = 102
         or ___conditional___ = 103
         or ___conditional___ = 104 then do
            exit$1 = 2;end else 
         if ___conditional___ = 76
         or ___conditional___ = 108
         or ___conditional___ = 110 then do
            exit$2 = 8;end else 
         if ___conditional___ = 114 then do
            match$12 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$6 = match$12[0];
            fmt_result = (ign_used.contents = true, ign) and --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    --[[ Ignored_reader ]]2,
                    fmt_rest$6
                  })} or --[[ Fmt_EBB ]]{--[[ Reader ]]Block.__(19, {fmt_rest$6})};end else 
         if ___conditional___ = 115 then do
            pad$2 = check_no_0(symb, (pad_used.contents = true, padprec));
            match$13 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$7 = match$13[0];
            if (ign_used.contents = true, ign) then do
              ignored$4 = --[[ Ignored_string ]]Block.__(0, {opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, padprec))});
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$4,
                    fmt_rest$7
                  })};
            end else do
              match$14 = make_padding_fmt_ebb(pad$2, fmt_rest$7);
              fmt_result = --[[ Fmt_EBB ]]{--[[ String ]]Block.__(2, {
                    match$14[0],
                    match$14[1]
                  })};
            end end end else 
         if ___conditional___ = 116 then do
            match$15 = parse_literal(str_ind, str_ind, end_ind);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Theta ]]Block.__(16, {match$15[0]})};end else 
         if ___conditional___ = 88
         or ___conditional___ = 100
         or ___conditional___ = 105
         or ___conditional___ = 111
         or ___conditional___ = 117
         or ___conditional___ = 120 then do
            exit$2 = 7;end else 
         if ___conditional___ = 0
         or ___conditional___ = 1
         or ___conditional___ = 2
         or ___conditional___ = 3
         or ___conditional___ = 4
         or ___conditional___ = 5
         or ___conditional___ = 6
         or ___conditional___ = 7
         or ___conditional___ = 8
         or ___conditional___ = 9
         or ___conditional___ = 10
         or ___conditional___ = 11
         or ___conditional___ = 12
         or ___conditional___ = 13
         or ___conditional___ = 14
         or ___conditional___ = 15
         or ___conditional___ = 16
         or ___conditional___ = 17
         or ___conditional___ = 18
         or ___conditional___ = 19
         or ___conditional___ = 20
         or ___conditional___ = 21
         or ___conditional___ = 22
         or ___conditional___ = 23
         or ___conditional___ = 24
         or ___conditional___ = 25
         or ___conditional___ = 26
         or ___conditional___ = 27
         or ___conditional___ = 28
         or ___conditional___ = 29
         or ___conditional___ = 30
         or ___conditional___ = 31
         or ___conditional___ = 34
         or ___conditional___ = 36
         or ___conditional___ = 38
         or ___conditional___ = 39
         or ___conditional___ = 41
         or ___conditional___ = 42
         or ___conditional___ = 46
         or ___conditional___ = 47
         or ___conditional___ = 48
         or ___conditional___ = 49
         or ___conditional___ = 50
         or ___conditional___ = 51
         or ___conditional___ = 52
         or ___conditional___ = 53
         or ___conditional___ = 54
         or ___conditional___ = 55
         or ___conditional___ = 56
         or ___conditional___ = 57
         or ___conditional___ = 58
         or ___conditional___ = 59
         or ___conditional___ = 60
         or ___conditional___ = 61
         or ___conditional___ = 62
         or ___conditional___ = 63
         or ___conditional___ = 65
         or ___conditional___ = 68
         or ___conditional___ = 73
         or ___conditional___ = 74
         or ___conditional___ = 75
         or ___conditional___ = 77
         or ___conditional___ = 79
         or ___conditional___ = 80
         or ___conditional___ = 81
         or ___conditional___ = 82
         or ___conditional___ = 84
         or ___conditional___ = 85
         or ___conditional___ = 86
         or ___conditional___ = 87
         or ___conditional___ = 89
         or ___conditional___ = 90
         or ___conditional___ = 92
         or ___conditional___ = 93
         or ___conditional___ = 94
         or ___conditional___ = 96
         or ___conditional___ = 106
         or ___conditional___ = 107
         or ___conditional___ = 109
         or ___conditional___ = 112
         or ___conditional___ = 113
         or ___conditional___ = 118
         or ___conditional___ = 119
         or ___conditional___ = 121
         or ___conditional___ = 122 then do
            exit$1 = 6;end else 
         if ___conditional___ = 123 then do
            sub_end$1 = search_subformat_end(str_ind, end_ind, --[[ "}" ]]125);
            match$16 = parse_literal(str_ind, str_ind, sub_end$1);
            beg_ind$1 = sub_end$1 + 2 | 0;
            match$17 = parse_literal(beg_ind$1, beg_ind$1, end_ind);
            fmt_rest$8 = match$17[0];
            sub_fmtty$1 = fmtty_of_fmt(match$16[0]);
            if (ign_used.contents = true, ign) then do
              ignored_000$2 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
              ignored$5 = --[[ Ignored_format_arg ]]Block.__(8, {
                  ignored_000$2,
                  sub_fmtty$1
                });
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$5,
                    fmt_rest$8
                  })};
            end else do
              fmt_result = --[[ Fmt_EBB ]]{--[[ Format_arg ]]Block.__(13, {
                    opt_of_pad(--[[ "{" ]]123, (pad_used.contents = true, pad)),
                    sub_fmtty$1,
                    fmt_rest$8
                  })};
            end end end else 
         do end end end end end end end end end end end end end end end end end end end end end
        
      end
    end end 
    local ___conditional___=(exit$2);
    do
       if ___conditional___ = 7 then do
          plus_used = true;
          hash_used = true;
          space_used = true;
          iconv = compute_int_conv(pct_ind, str_ind, plus, hash, space, symb);
          match$18 = parse_literal(str_ind, str_ind, end_ind);
          fmt_rest$9 = match$18[0];
          if (ign_used.contents = true, ign) then do
            ignored_001 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
            ignored$6 = --[[ Ignored_int ]]Block.__(2, {
                iconv,
                ignored_001
              });
            fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                  ignored$6,
                  fmt_rest$9
                })};
          end else do
            match$19 = make_padprec_fmt_ebb(get_int_pad(--[[ () ]]0), (prec_used.contents = true, prec), fmt_rest$9);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Int ]]Block.__(4, {
                  iconv,
                  match$19[0],
                  match$19[1],
                  match$19[2]
                })};
          end end end else 
       if ___conditional___ = 8 then do
          if (str_ind == end_ind or not is_int_base(Caml_string.get(str, str_ind))) then do
            match$20 = parse_literal(str_ind, str_ind, end_ind);
            fmt_rest$10 = match$20[0];
            counter = counter_of_char(symb);
            if (ign_used.contents = true, ign) then do
              ignored$7 = --[[ Ignored_scan_get_counter ]]Block.__(11, {counter});
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$7,
                    fmt_rest$10
                  })};
            end else do
              fmt_result = --[[ Fmt_EBB ]]{--[[ Scan_get_counter ]]Block.__(21, {
                    counter,
                    fmt_rest$10
                  })};
            end end 
          end else do
            exit$1 = 6;
          end end end else 
       do end end end
      
    end
    local ___conditional___=(exit$1);
    do
       if ___conditional___ = 2 then do
          plus_used = true;
          space_used = true;
          fconv = compute_float_conv(pct_ind, str_ind, plus, space, symb);
          match$21 = parse_literal(str_ind, str_ind, end_ind);
          fmt_rest$11 = match$21[0];
          if (ign_used.contents = true, ign) then do
            ignored_000$3 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
            ignored_001$1 = get_prec_opt(--[[ () ]]0);
            ignored$8 = --[[ Ignored_float ]]Block.__(6, {
                ignored_000$3,
                ignored_001$1
              });
            fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                  ignored$8,
                  fmt_rest$11
                })};
          end else do
            match$22 = make_padprec_fmt_ebb((pad_used.contents = true, pad), (prec_used.contents = true, prec), fmt_rest$11);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Float ]]Block.__(8, {
                  fconv,
                  match$22[0],
                  match$22[1],
                  match$22[2]
                })};
          end end end else 
       if ___conditional___ = 3 then do
          pad$3 = check_no_0(symb, (pad_used.contents = true, padprec));
          match$23 = parse_literal(str_ind, str_ind, end_ind);
          fmt_rest$12 = match$23[0];
          if (ign_used.contents = true, ign) then do
            ignored$9 = --[[ Ignored_bool ]]Block.__(7, {opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, padprec))});
            fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                  ignored$9,
                  fmt_rest$12
                })};
          end else do
            match$24 = make_padding_fmt_ebb(pad$3, fmt_rest$12);
            fmt_result = --[[ Fmt_EBB ]]{--[[ Bool ]]Block.__(9, {
                  match$24[0],
                  match$24[1]
                })};
          end end end else 
       if ___conditional___ = 4 then do
          match$25 = parse_literal(str_ind, str_ind, end_ind);
          fmt_result = --[[ Fmt_EBB ]]{--[[ Char_literal ]]Block.__(12, {
                symb,
                match$25[0]
              })};end else 
       if ___conditional___ = 5 then do
          fmt_result = Curry._3(failwith_message(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "invalid format ",
                        --[[ Caml_string ]]Block.__(3, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": at character number ",
                                --[[ Int ]]Block.__(4, {
                                    --[[ Int_d ]]0,
                                    --[[ No_padding ]]0,
                                    --[[ No_precision ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ", flag ",
                                        --[[ Caml_char ]]Block.__(1, {--[[ String_literal ]]Block.__(11, {
                                                " is only allowed after the '",
                                                --[[ Char_literal ]]Block.__(12, {
                                                    --[[ "%" ]]37,
                                                    --[[ String_literal ]]Block.__(11, {
                                                        "', before padding and precision",
                                                        --[[ End_of_format ]]0
                                                      })
                                                  })
                                              })})
                                      })
                                  })
                              })
                          })
                      }),
                    "invalid format %S: at character number %d, flag %C is only allowed after the '%%', before padding and precision"
                  }), str, pct_ind, symb);end else 
       if ___conditional___ = 6 then do
          if (symb >= 108) then do
            if (symb >= 111) then do
              exit = 1;
            end else do
              local ___conditional___=(symb - 108 | 0);
              do
                 if ___conditional___ = 0 then do
                    plus_used = true;
                    hash_used = true;
                    space_used = true;
                    iconv$1 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
                    beg_ind$2 = str_ind + 1 | 0;
                    match$26 = parse_literal(beg_ind$2, beg_ind$2, end_ind);
                    fmt_rest$13 = match$26[0];
                    if (ign_used.contents = true, ign) then do
                      ignored_001$2 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
                      ignored$10 = --[[ Ignored_int32 ]]Block.__(3, {
                          iconv$1,
                          ignored_001$2
                        });
                      fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                            ignored$10,
                            fmt_rest$13
                          })};
                    end else do
                      match$27 = make_padprec_fmt_ebb(get_int_pad(--[[ () ]]0), (prec_used.contents = true, prec), fmt_rest$13);
                      fmt_result = --[[ Fmt_EBB ]]{--[[ Int32 ]]Block.__(5, {
                            iconv$1,
                            match$27[0],
                            match$27[1],
                            match$27[2]
                          })};
                    end end end else 
                 if ___conditional___ = 1 then do
                    exit = 1;end else 
                 if ___conditional___ = 2 then do
                    plus_used = true;
                    hash_used = true;
                    space_used = true;
                    iconv$2 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
                    beg_ind$3 = str_ind + 1 | 0;
                    match$28 = parse_literal(beg_ind$3, beg_ind$3, end_ind);
                    fmt_rest$14 = match$28[0];
                    if (ign_used.contents = true, ign) then do
                      ignored_001$3 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
                      ignored$11 = --[[ Ignored_nativeint ]]Block.__(4, {
                          iconv$2,
                          ignored_001$3
                        });
                      fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                            ignored$11,
                            fmt_rest$14
                          })};
                    end else do
                      match$29 = make_padprec_fmt_ebb(get_int_pad(--[[ () ]]0), (prec_used.contents = true, prec), fmt_rest$14);
                      fmt_result = --[[ Fmt_EBB ]]{--[[ Nativeint ]]Block.__(6, {
                            iconv$2,
                            match$29[0],
                            match$29[1],
                            match$29[2]
                          })};
                    end end end else 
                 do end end end end
                
              end
            end end 
          end else if (symb ~= 76) then do
            exit = 1;
          end else do
            plus_used = true;
            hash_used = true;
            space_used = true;
            iconv$3 = compute_int_conv(pct_ind, str_ind + 1 | 0, plus, hash, space, Caml_string.get(str, str_ind));
            beg_ind$4 = str_ind + 1 | 0;
            match$30 = parse_literal(beg_ind$4, beg_ind$4, end_ind);
            fmt_rest$15 = match$30[0];
            if (ign_used.contents = true, ign) then do
              ignored_001$4 = opt_of_pad(--[[ "_" ]]95, (pad_used.contents = true, pad));
              ignored$12 = --[[ Ignored_int64 ]]Block.__(5, {
                  iconv$3,
                  ignored_001$4
                });
              fmt_result = --[[ Fmt_EBB ]]{--[[ Ignored_param ]]Block.__(23, {
                    ignored$12,
                    fmt_rest$15
                  })};
            end else do
              match$31 = make_padprec_fmt_ebb(get_int_pad(--[[ () ]]0), (prec_used.contents = true, prec), fmt_rest$15);
              fmt_result = --[[ Fmt_EBB ]]{--[[ Int64 ]]Block.__(7, {
                    iconv$3,
                    match$31[0],
                    match$31[1],
                    match$31[2]
                  })};
            end end 
          end end  end end else 
       do end end end end end end
      
    end
    if (exit == 1) then do
      fmt_result = Curry._3(failwith_message(--[[ Format ]]{
                --[[ String_literal ]]Block.__(11, {
                    "invalid format ",
                    --[[ Caml_string ]]Block.__(3, {
                        --[[ No_padding ]]0,
                        --[[ String_literal ]]Block.__(11, {
                            ": at character number ",
                            --[[ Int ]]Block.__(4, {
                                --[[ Int_d ]]0,
                                --[[ No_padding ]]0,
                                --[[ No_precision ]]0,
                                --[[ String_literal ]]Block.__(11, {
                                    ", invalid conversion \"",
                                    --[[ Char_literal ]]Block.__(12, {
                                        --[[ "%" ]]37,
                                        --[[ Char ]]Block.__(0, {--[[ Char_literal ]]Block.__(12, {
                                                --[[ "\"" ]]34,
                                                --[[ End_of_format ]]0
                                              })})
                                      })
                                  })
                              })
                          })
                      })
                  }),
                "invalid format %S: at character number %d, invalid conversion \"%%%c\""
              }), str, str_ind - 1 | 0, symb);
    end
     end 
    if (not legacy_behavior$1) then do
      if (not plus_used and plus) then do
        incompatible_flag(pct_ind, str_ind, symb, "'+'");
      end
       end 
      if (not hash_used and hash) then do
        incompatible_flag(pct_ind, str_ind, symb, "'#'");
      end
       end 
      if (not space_used and space) then do
        incompatible_flag(pct_ind, str_ind, symb, "' '");
      end
       end 
      if (not pad_used.contents and Caml_obj.caml_notequal(--[[ Padding_EBB ]]{pad}, --[[ Padding_EBB ]]{--[[ No_padding ]]0})) then do
        incompatible_flag(pct_ind, str_ind, symb, "`padding'");
      end
       end 
      if (not prec_used.contents and Caml_obj.caml_notequal(--[[ Precision_EBB ]]{prec}, --[[ Precision_EBB ]]{--[[ No_precision ]]0})) then do
        incompatible_flag(pct_ind, str_ind, ign and --[[ "_" ]]95 or symb, "`precision'");
      end
       end 
      if (ign and plus) then do
        incompatible_flag(pct_ind, str_ind, --[[ "_" ]]95, "'+'");
      end
       end 
    end
     end 
    if (not ign_used.contents and ign) then do
      exit$3 = 0;
      if (symb >= 38) then do
        if (symb ~= 44) then do
          if (symb ~= 64 or not legacy_behavior$1) then do
            exit$3 = 1;
          end
           end 
        end else if (not legacy_behavior$1) then do
          exit$3 = 1;
        end
         end  end 
      end else if (symb ~= 33) then do
        if (not (symb >= 37 and legacy_behavior$1)) then do
          exit$3 = 1;
        end
         end 
      end else if (not legacy_behavior$1) then do
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
  end end;
  parse_integer = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    match = Caml_string.get(str, str_ind);
    if (match >= 48) then do
      if (match >= 58) then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            2814,
            11
          }
        })
      end
       end 
      return parse_positive(str_ind, end_ind, 0);
    end else do
      if (match ~= 45) then do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            2814,
            11
          }
        })
      end
       end 
      if ((str_ind + 1 | 0) == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      c = Caml_string.get(str, str_ind + 1 | 0);
      if (c > 57 or c < 48) then do
        return expected_character(str_ind + 1 | 0, "digit", c);
      end else do
        match$1 = parse_positive(str_ind + 1 | 0, end_ind, 0);
        return --[[ tuple ]]{
                match$1[0],
                -match$1[1] | 0
              };
      end end 
    end end 
  end end;
  incompatible_flag = function (pct_ind, str_ind, symb, option) do
    subfmt = __String.sub(str, pct_ind, str_ind - pct_ind | 0);
    return Curry._5(failwith_message(--[[ Format ]]{
                    --[[ String_literal ]]Block.__(11, {
                        "invalid format ",
                        --[[ Caml_string ]]Block.__(3, {
                            --[[ No_padding ]]0,
                            --[[ String_literal ]]Block.__(11, {
                                ": at character number ",
                                --[[ Int ]]Block.__(4, {
                                    --[[ Int_d ]]0,
                                    --[[ No_padding ]]0,
                                    --[[ No_precision ]]0,
                                    --[[ String_literal ]]Block.__(11, {
                                        ", ",
                                        --[[ String ]]Block.__(2, {
                                            --[[ No_padding ]]0,
                                            --[[ String_literal ]]Block.__(11, {
                                                " is incompatible with '",
                                                --[[ Char ]]Block.__(0, {--[[ String_literal ]]Block.__(11, {
                                                        "' in sub-format ",
                                                        --[[ Caml_string ]]Block.__(3, {
                                                            --[[ No_padding ]]0,
                                                            --[[ End_of_format ]]0
                                                          })
                                                      })})
                                              })
                                          })
                                      })
                                  })
                              })
                          })
                      }),
                    "invalid format %S: at character number %d, %s is incompatible with '%c' in sub-format %S"
                  }), str, pct_ind, option, symb, subfmt);
  end end;
  parse_after_padding = function (pct_ind, str_ind, end_ind, minus, plus, hash, space, ign, pad) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    symb = Caml_string.get(str, str_ind);
    if (symb ~= 46) then do
      return parse_conversion(pct_ind, str_ind + 1 | 0, end_ind, plus, hash, space, ign, pad, --[[ No_precision ]]0, pad, symb);
    end else do
      pct_ind$1 = pct_ind;
      str_ind$1 = str_ind + 1 | 0;
      end_ind$1 = end_ind;
      minus$1 = minus;
      plus$1 = plus;
      hash$1 = hash;
      space$1 = space;
      ign$1 = ign;
      pad$1 = pad;
      if (str_ind$1 == end_ind$1) then do
        invalid_format_message(end_ind$1, "unexpected end of format");
      end
       end 
      parse_literal = function (minus, str_ind) do
        match = parse_positive(str_ind, end_ind$1, 0);
        return parse_after_precision(pct_ind$1, match[0], end_ind$1, minus, plus$1, hash$1, space$1, ign$1, pad$1, --[[ Lit_precision ]]{match[1]});
      end end;
      symb$1 = Caml_string.get(str, str_ind$1);
      exit = 0;
      if (symb$1 >= 48) then do
        if (symb$1 < 58) then do
          return parse_literal(minus$1, str_ind$1);
        end
         end 
      end else if (symb$1 >= 42) then do
        local ___conditional___=(symb$1 - 42 | 0);
        do
           if ___conditional___ = 0 then do
              return parse_after_precision(pct_ind$1, str_ind$1 + 1 | 0, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, pad$1, --[[ Arg_precision ]]1);end end end 
           if ___conditional___ = 1
           or ___conditional___ = 3 then do
              exit = 2;end else 
           if ___conditional___ = 2
           or ___conditional___ = 4
           or ___conditional___ = 5
           do end
          
        end
      end
       end  end 
      if (exit == 2 and legacy_behavior$1) then do
        return parse_literal(minus$1 or symb$1 == --[[ "-" ]]45, str_ind$1 + 1 | 0);
      end
       end 
      if (legacy_behavior$1) then do
        return parse_after_precision(pct_ind$1, str_ind$1, end_ind$1, minus$1, plus$1, hash$1, space$1, ign$1, pad$1, --[[ Lit_precision ]]{0});
      end else do
        return invalid_format_without(str_ind$1 - 1 | 0, --[[ "." ]]46, "precision");
      end end 
    end end 
  end end;
  is_int_base = function (symb) do
    local ___conditional___=(symb);
    do
       if ___conditional___ = 89
       or ___conditional___ = 90
       or ___conditional___ = 91
       or ___conditional___ = 92
       or ___conditional___ = 93
       or ___conditional___ = 94
       or ___conditional___ = 95
       or ___conditional___ = 96
       or ___conditional___ = 97
       or ___conditional___ = 98
       or ___conditional___ = 99
       or ___conditional___ = 101
       or ___conditional___ = 102
       or ___conditional___ = 103
       or ___conditional___ = 104
       or ___conditional___ = 106
       or ___conditional___ = 107
       or ___conditional___ = 108
       or ___conditional___ = 109
       or ___conditional___ = 110
       or ___conditional___ = 112
       or ___conditional___ = 113
       or ___conditional___ = 114
       or ___conditional___ = 115
       or ___conditional___ = 116
       or ___conditional___ = 118
       or ___conditional___ = 119 then do
          return false;end end end 
       if ___conditional___ = 88
       or ___conditional___ = 100
       or ___conditional___ = 105
       or ___conditional___ = 111
       or ___conditional___ = 117
       or ___conditional___ = 120 then do
          return true;end end end 
       do
      else do
        return false;
        end end
        
    end
  end end;
  counter_of_char = function (symb) do
    if (symb >= 108) then do
      if (symb < 111) then do
        local ___conditional___=(symb - 108 | 0);
        do
           if ___conditional___ = 0 then do
              return --[[ Line_counter ]]0;end end end 
           if ___conditional___ = 1
           or ___conditional___ = 2 then do
              return --[[ Char_counter ]]1;end end end 
           do
          
        end
      end
       end 
    end else if (symb == 76) then do
      return --[[ Token_counter ]]2;
    end
     end  end 
    error ({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "camlinternalFormat.ml",
        2876,
        34
      }
    })
  end end;
  parse_char_set = function (str_ind, end_ind) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    char_set = Bytes.make(32, --[[ "\000" ]]0);
    add_range = function (c, c$prime) do
      for i = c , c$prime , 1 do
        add_in_char_set(char_set, Pervasives.char_of_int(i));
      end
      return --[[ () ]]0;
    end end;
    fail_single_percent = function (str_ind) do
      return Curry._2(failwith_message(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "invalid format ",
                          --[[ Caml_string ]]Block.__(3, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  ": '",
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "%" ]]37,
                                      --[[ String_literal ]]Block.__(11, {
                                          "' alone is not accepted in character sets, use ",
                                          --[[ Char_literal ]]Block.__(12, {
                                              --[[ "%" ]]37,
                                              --[[ Char_literal ]]Block.__(12, {
                                                  --[[ "%" ]]37,
                                                  --[[ String_literal ]]Block.__(11, {
                                                      " instead at position ",
                                                      --[[ Int ]]Block.__(4, {
                                                          --[[ Int_d ]]0,
                                                          --[[ No_padding ]]0,
                                                          --[[ No_precision ]]0,
                                                          --[[ Char_literal ]]Block.__(12, {
                                                              --[[ "." ]]46,
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
                      "invalid format %S: '%%' alone is not accepted in character sets, use %%%% instead at position %d."
                    }), str, str_ind);
    end end;
    parse_char_set_content = function (_str_ind, end_ind) do
      while(true) do
        str_ind = _str_ind;
        if (str_ind == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        c = Caml_string.get(str, str_ind);
        if (c ~= 45) then do
          if (c ~= 93) then do
            return parse_char_set_after_char(str_ind + 1 | 0, end_ind, c);
          end else do
            return str_ind + 1 | 0;
          end end 
        end else do
          add_in_char_set(char_set, --[[ "-" ]]45);
          _str_ind = str_ind + 1 | 0;
          ::continue:: ;
        end end 
      end;
    end end;
    parse_char_set_after_char = function (_str_ind, end_ind, _c) do
      while(true) do
        c = _c;
        str_ind = _str_ind;
        if (str_ind == end_ind) then do
          invalid_format_message(end_ind, "unexpected end of format");
        end
         end 
        c$prime = Caml_string.get(str, str_ind);
        exit = 0;
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
            str_ind$1 = str_ind + 1 | 0;
            end_ind$1 = end_ind;
            c$1 = c;
            if (str_ind$1 == end_ind$1) then do
              invalid_format_message(end_ind$1, "unexpected end of format");
            end
             end 
            c$prime$1 = Caml_string.get(str, str_ind$1);
            if (c$prime$1 ~= 37) then do
              if (c$prime$1 ~= 93) then do
                add_range(c$1, c$prime$1);
                return parse_char_set_content(str_ind$1 + 1 | 0, end_ind$1);
              end else do
                add_in_char_set(char_set, c$1);
                add_in_char_set(char_set, --[[ "-" ]]45);
                return str_ind$1 + 1 | 0;
              end end 
            end else do
              if ((str_ind$1 + 1 | 0) == end_ind$1) then do
                invalid_format_message(end_ind$1, "unexpected end of format");
              end
               end 
              c$prime$2 = Caml_string.get(str, str_ind$1 + 1 | 0);
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
        if (exit == 2 and c == --[[ "%" ]]37) then do
          add_in_char_set(char_set, c$prime);
          return parse_char_set_content(str_ind + 1 | 0, end_ind);
        end
         end 
        if (c == --[[ "%" ]]37) then do
          fail_single_percent(str_ind);
        end
         end 
        add_in_char_set(char_set, c);
        _c = c$prime;
        _str_ind = str_ind + 1 | 0;
        ::continue:: ;
      end;
    end end;
    parse_char_set_start = function (str_ind, end_ind) do
      if (str_ind == end_ind) then do
        invalid_format_message(end_ind, "unexpected end of format");
      end
       end 
      c = Caml_string.get(str, str_ind);
      return parse_char_set_after_char(str_ind + 1 | 0, end_ind, c);
    end end;
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    match = Caml_string.get(str, str_ind);
    match$1 = match ~= 94 and --[[ tuple ]]{
        str_ind,
        false
      } or --[[ tuple ]]{
        str_ind + 1 | 0,
        true
      };
    next_ind = parse_char_set_start(match$1[0], end_ind);
    char_set$1 = Bytes.to_string(char_set);
    return --[[ tuple ]]{
            next_ind,
            match$1[1] and rev_char_set(char_set$1) or char_set$1
          };
  end end;
  compute_int_conv = function (pct_ind, str_ind, _plus, _hash, _space, symb) do
    while(true) do
      space = _space;
      hash = _hash;
      plus = _plus;
      exit = 0;
      if (plus) then do
        if (hash) then do
          exit = 2;
        end else if (not space) then do
          if (symb ~= 100) then do
            if (symb == 105) then do
              return --[[ Int_pi ]]4;
            end
             end 
          end else do
            return --[[ Int_pd ]]1;
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
              return --[[ Int_Cx ]]7;
            end end 
          end else do
            return --[[ Int_Co ]]11;
          end end 
        end else do
          return --[[ Int_CX ]]9;
        end end  end 
      end else if (space) then do
        if (symb ~= 100) then do
          if (symb == 105) then do
            return --[[ Int_si ]]5;
          end
           end 
        end else do
          return --[[ Int_sd ]]2;
        end end 
      end else do
        local ___conditional___=(symb);
        do
           if ___conditional___ = 88 then do
              return --[[ Int_X ]]8;end end end 
           if ___conditional___ = 100 then do
              return --[[ Int_d ]]0;end end end 
           if ___conditional___ = 105 then do
              return --[[ Int_i ]]3;end end end 
           if ___conditional___ = 111 then do
              return --[[ Int_o ]]10;end end end 
           if ___conditional___ = 117 then do
              return --[[ Int_u ]]12;end end end 
           if ___conditional___ = 89
           or ___conditional___ = 90
           or ___conditional___ = 91
           or ___conditional___ = 92
           or ___conditional___ = 93
           or ___conditional___ = 94
           or ___conditional___ = 95
           or ___conditional___ = 96
           or ___conditional___ = 97
           or ___conditional___ = 98
           or ___conditional___ = 99
           or ___conditional___ = 101
           or ___conditional___ = 102
           or ___conditional___ = 103
           or ___conditional___ = 104
           or ___conditional___ = 106
           or ___conditional___ = 107
           or ___conditional___ = 108
           or ___conditional___ = 109
           or ___conditional___ = 110
           or ___conditional___ = 112
           or ___conditional___ = 113
           or ___conditional___ = 114
           or ___conditional___ = 115
           or ___conditional___ = 116
           or ___conditional___ = 118
           or ___conditional___ = 119
           or ___conditional___ = 120 then do
              return --[[ Int_x ]]6;end end end 
           do
          else do
            end end
            
        end
      end end  end  end 
      if (exit == 2) then do
        exit$1 = 0;
        local ___conditional___=(symb);
        do
           if ___conditional___ = 88 then do
              if (legacy_behavior$1) then do
                return --[[ Int_CX ]]9;
              end
               end end else 
           if ___conditional___ = 111 then do
              if (legacy_behavior$1) then do
                return --[[ Int_Co ]]11;
              end
               end end else 
           if ___conditional___ = 100
           or ___conditional___ = 105
           or ___conditional___ = 117 then do
              exit$1 = 3;end else 
           if ___conditional___ = 89
           or ___conditional___ = 90
           or ___conditional___ = 91
           or ___conditional___ = 92
           or ___conditional___ = 93
           or ___conditional___ = 94
           or ___conditional___ = 95
           or ___conditional___ = 96
           or ___conditional___ = 97
           or ___conditional___ = 98
           or ___conditional___ = 99
           or ___conditional___ = 101
           or ___conditional___ = 102
           or ___conditional___ = 103
           or ___conditional___ = 104
           or ___conditional___ = 106
           or ___conditional___ = 107
           or ___conditional___ = 108
           or ___conditional___ = 109
           or ___conditional___ = 110
           or ___conditional___ = 112
           or ___conditional___ = 113
           or ___conditional___ = 114
           or ___conditional___ = 115
           or ___conditional___ = 116
           or ___conditional___ = 118
           or ___conditional___ = 119
           or ___conditional___ = 120 then do
              if (legacy_behavior$1) then do
                return --[[ Int_Cx ]]7;
              end
               end end else 
           do end end end end end
          else do
            end end
            
        end
        if (exit$1 == 3) then do
          if (legacy_behavior$1) then do
            _hash = false;
            ::continue:: ;
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
            ::continue:: ;
          end else do
            return incompatible_flag(pct_ind, str_ind, --[[ " " ]]32, "'+'");
          end end 
        end else if (legacy_behavior$1) then do
          _plus = false;
          ::continue:: ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "'+'");
        end end  end 
      end else if (space) then do
        if (legacy_behavior$1) then do
          _space = false;
          ::continue:: ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "' '");
        end end 
      end else do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            2909,
            28
          }
        })
      end end  end 
    end;
  end end;
  compute_float_conv = function (pct_ind, str_ind, _plus, _space, symb) do
    while(true) do
      space = _space;
      plus = _plus;
      if (plus) then do
        if (space) then do
          if (legacy_behavior$1) then do
            _space = false;
            ::continue:: ;
          end else do
            return incompatible_flag(pct_ind, str_ind, --[[ " " ]]32, "'+'");
          end end 
        end else do
          if (symb >= 73) then do
            local ___conditional___=(symb);
            do
               if ___conditional___ = 101 then do
                  return --[[ Float_pe ]]4;end end end 
               if ___conditional___ = 102 then do
                  return --[[ Float_pf ]]1;end end end 
               if ___conditional___ = 103 then do
                  return --[[ Float_pg ]]10;end end end 
               if ___conditional___ = 104 then do
                  return --[[ Float_ph ]]17;end end end 
               do
              else do
                end end
                
            end
          end else if (symb >= 69) then do
            local ___conditional___=(symb - 69 | 0);
            do
               if ___conditional___ = 0 then do
                  return --[[ Float_pE ]]7;end end end 
               if ___conditional___ = 1
               or ___conditional___ = 2 then do
                  return --[[ Float_pG ]]13;end end end 
               if ___conditional___ = 3 then do
                  return --[[ Float_pH ]]20;end end end 
               do
              
            end
          end
           end  end 
          if (legacy_behavior$1) then do
            _plus = false;
            ::continue:: ;
          end else do
            return incompatible_flag(pct_ind, str_ind, symb, "'+'");
          end end 
        end end 
      end else if (space) then do
        if (symb >= 73) then do
          local ___conditional___=(symb);
          do
             if ___conditional___ = 101 then do
                return --[[ Float_se ]]5;end end end 
             if ___conditional___ = 102 then do
                return --[[ Float_sf ]]2;end end end 
             if ___conditional___ = 103 then do
                return --[[ Float_sg ]]11;end end end 
             if ___conditional___ = 104 then do
                return --[[ Float_sh ]]18;end end end 
             do
            else do
              end end
              
          end
        end else if (symb >= 69) then do
          local ___conditional___=(symb - 69 | 0);
          do
             if ___conditional___ = 0 then do
                return --[[ Float_sE ]]8;end end end 
             if ___conditional___ = 1
             or ___conditional___ = 2 then do
                return --[[ Float_sG ]]14;end end end 
             if ___conditional___ = 3 then do
                return --[[ Float_sH ]]21;end end end 
             do
            
          end
        end
         end  end 
        if (legacy_behavior$1) then do
          _space = false;
          ::continue:: ;
        end else do
          return incompatible_flag(pct_ind, str_ind, symb, "' '");
        end end 
      end else if (symb >= 73) then do
        local ___conditional___=(symb);
        do
           if ___conditional___ = 101 then do
              return --[[ Float_e ]]3;end end end 
           if ___conditional___ = 102 then do
              return --[[ Float_f ]]0;end end end 
           if ___conditional___ = 103 then do
              return --[[ Float_g ]]9;end end end 
           if ___conditional___ = 104 then do
              return --[[ Float_h ]]16;end end end 
           do
          else do
            error ({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "camlinternalFormat.ml",
                2943,
                25
              }
            })
            end end
            
        end
      end else if (symb >= 69) then do
        local ___conditional___=(symb - 69 | 0);
        do
           if ___conditional___ = 0 then do
              return --[[ Float_E ]]6;end end end 
           if ___conditional___ = 1 then do
              return --[[ Float_F ]]15;end end end 
           if ___conditional___ = 2 then do
              return --[[ Float_G ]]12;end end end 
           if ___conditional___ = 3 then do
              return --[[ Float_H ]]19;end end end 
           do
          
        end
      end else do
        error ({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "camlinternalFormat.ml",
            2943,
            25
          }
        })
      end end  end  end  end 
    end;
  end end;
  parse_after_precision = function (pct_ind, str_ind, end_ind, minus, plus, hash, space, ign, pad, prec) do
    if (str_ind == end_ind) then do
      invalid_format_message(end_ind, "unexpected end of format");
    end
     end 
    parse_conv = function (padprec) do
      return parse_conversion(pct_ind, str_ind + 1 | 0, end_ind, plus, hash, space, ign, pad, prec, padprec, Caml_string.get(str, str_ind));
    end end;
    if (typeof pad == "number") then do
      if (typeof prec == "number" and prec == 0) then do
        return parse_conv(--[[ No_padding ]]0);
      end
       end 
      if (minus) then do
        if (typeof prec == "number") then do
          return parse_conv(--[[ Arg_padding ]]Block.__(1, {--[[ Left ]]0}));
        end else do
          return parse_conv(--[[ Lit_padding ]]Block.__(0, {
                        --[[ Left ]]0,
                        prec[0]
                      }));
        end end 
      end else if (typeof prec == "number") then do
        return parse_conv(--[[ Arg_padding ]]Block.__(1, {--[[ Right ]]1}));
      end else do
        return parse_conv(--[[ Lit_padding ]]Block.__(0, {
                      --[[ Right ]]1,
                      prec[0]
                    }));
      end end  end 
    end else do
      return parse_conv(pad);
    end end 
  end end;
  parse_tag = function (is_open_tag, str_ind, end_ind) do
    xpcall(function() do
      if (str_ind == end_ind) then do
        error (Caml_builtin_exceptions.not_found)
      end
       end 
      match = Caml_string.get(str, str_ind);
      if (match ~= 60) then do
        error (Caml_builtin_exceptions.not_found)
      end
       end 
      ind = __String.index_from(str, str_ind + 1 | 0, --[[ ">" ]]62);
      if (ind >= end_ind) then do
        error (Caml_builtin_exceptions.not_found)
      end
       end 
      sub_str = __String.sub(str, str_ind, (ind - str_ind | 0) + 1 | 0);
      beg_ind = ind + 1 | 0;
      match$1 = parse_literal(beg_ind, beg_ind, end_ind);
      match$2 = parse_literal(str_ind, str_ind, ind + 1 | 0);
      sub_fmt = match$2[0];
      sub_format = --[[ Format ]]{
        sub_fmt,
        sub_str
      };
      formatting = is_open_tag and --[[ Open_tag ]]Block.__(0, {sub_format}) or (check_open_box(sub_fmt), --[[ Open_box ]]Block.__(1, {sub_format}));
      return --[[ Fmt_EBB ]]{--[[ Formatting_gen ]]Block.__(18, {
                  formatting,
                  match$1[0]
                })};
    end end,function(exn) return do
      if (exn == Caml_builtin_exceptions.not_found) then do
        match$3 = parse_literal(str_ind, str_ind, end_ind);
        sub_format$1 = --[[ Format ]]{
          --[[ End_of_format ]]0,
          ""
        };
        formatting$1 = is_open_tag and --[[ Open_tag ]]Block.__(0, {sub_format$1}) or --[[ Open_box ]]Block.__(1, {sub_format$1});
        return --[[ Fmt_EBB ]]{--[[ Formatting_gen ]]Block.__(18, {
                    formatting$1,
                    match$3[0]
                  })};
      end else do
        error (exn)
      end end 
    end end)
  end end;
  return parse_literal(0, 0, #str);
end end

function format_of_string_fmtty(str, fmtty) do
  match = fmt_ebb_of_string(undefined, str);
  xpcall(function() do
    return --[[ Format ]]{
            type_format(match[0], fmtty),
            str
          };
  end end,function(exn) return do
    if (exn == Type_mismatch) then do
      return Curry._2(failwith_message(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "bad input: format type mismatch between ",
                          --[[ Caml_string ]]Block.__(3, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " and ",
                                  --[[ Caml_string ]]Block.__(3, {
                                      --[[ No_padding ]]0,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        }),
                      "bad input: format type mismatch between %S and %S"
                    }), str, string_of_fmtty(fmtty));
    end else do
      error (exn)
    end end 
  end end)
end end

function format_of_string_format(str, param) do
  match = fmt_ebb_of_string(undefined, str);
  xpcall(function() do
    return --[[ Format ]]{
            type_format(match[0], fmtty_of_fmt(param[0])),
            str
          };
  end end,function(exn) return do
    if (exn == Type_mismatch) then do
      return Curry._2(failwith_message(--[[ Format ]]{
                      --[[ String_literal ]]Block.__(11, {
                          "bad input: format type mismatch between ",
                          --[[ Caml_string ]]Block.__(3, {
                              --[[ No_padding ]]0,
                              --[[ String_literal ]]Block.__(11, {
                                  " and ",
                                  --[[ Caml_string ]]Block.__(3, {
                                      --[[ No_padding ]]0,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            })
                        }),
                      "bad input: format type mismatch between %S and %S"
                    }), str, param[1]);
    end else do
      error (exn)
    end end 
  end end)
end end

export do
  is_in_char_set ,
  rev_char_set ,
  create_char_set ,
  add_in_char_set ,
  freeze_char_set ,
  param_format_of_ignored_format ,
  make_printf ,
  make_iprintf ,
  output_acc ,
  bufput_acc ,
  strput_acc ,
  type_format ,
  fmt_ebb_of_string ,
  format_of_string_fmtty ,
  format_of_string_format ,
  char_of_iconv ,
  string_of_formatting_lit ,
  string_of_formatting_gen ,
  string_of_fmtty ,
  string_of_fmt ,
  open_box_of_string ,
  symm ,
  trans ,
  recast ,
  
end
--[[ No side effect ]]
