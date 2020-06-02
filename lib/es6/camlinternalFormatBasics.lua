

import * as Block from "./block.lua";

function erase_rel(param) do
  if (typeof param == "number") then do
    return --[[ End_of_fmtty ]]0;
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          return --[[ Char_ty ]]Block.__(0, {erase_rel(param[0])});end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          return --[[ String_ty ]]Block.__(1, {erase_rel(param[0])});end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          return --[[ Int_ty ]]Block.__(2, {erase_rel(param[0])});end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          return --[[ Int32_ty ]]Block.__(3, {erase_rel(param[0])});end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          return --[[ Nativeint_ty ]]Block.__(4, {erase_rel(param[0])});end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          return --[[ Int64_ty ]]Block.__(5, {erase_rel(param[0])});end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          return --[[ Float_ty ]]Block.__(6, {erase_rel(param[0])});end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          return --[[ Bool_ty ]]Block.__(7, {erase_rel(param[0])});end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          return --[[ Format_arg_ty ]]Block.__(8, {
                    param[0],
                    erase_rel(param[1])
                  });end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          ty1 = param[0];
          return --[[ Format_subst_ty ]]Block.__(9, {
                    ty1,
                    ty1,
                    erase_rel(param[2])
                  });end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          return --[[ Alpha_ty ]]Block.__(10, {erase_rel(param[0])});end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          return --[[ Theta_ty ]]Block.__(11, {erase_rel(param[0])});end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          return --[[ Any_ty ]]Block.__(12, {erase_rel(param[0])});end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          return --[[ Reader_ty ]]Block.__(13, {erase_rel(param[0])});end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          return --[[ Ignored_reader_ty ]]Block.__(14, {erase_rel(param[0])});end end end 
       do
      
    end
  end end 
end end

function concat_fmtty(fmtty1, fmtty2) do
  if (typeof fmtty1 == "number") then do
    return fmtty2;
  end else do
    local ___conditional___=(fmtty1.tag | 0);
    do
       if ___conditional___ = 0--[[ Char_ty ]] then do
          return --[[ Char_ty ]]Block.__(0, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 1--[[ String_ty ]] then do
          return --[[ String_ty ]]Block.__(1, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 2--[[ Int_ty ]] then do
          return --[[ Int_ty ]]Block.__(2, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 3--[[ Int32_ty ]] then do
          return --[[ Int32_ty ]]Block.__(3, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 4--[[ Nativeint_ty ]] then do
          return --[[ Nativeint_ty ]]Block.__(4, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 5--[[ Int64_ty ]] then do
          return --[[ Int64_ty ]]Block.__(5, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 6--[[ Float_ty ]] then do
          return --[[ Float_ty ]]Block.__(6, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 7--[[ Bool_ty ]] then do
          return --[[ Bool_ty ]]Block.__(7, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 8--[[ Format_arg_ty ]] then do
          return --[[ Format_arg_ty ]]Block.__(8, {
                    fmtty1[0],
                    concat_fmtty(fmtty1[1], fmtty2)
                  });end end end 
       if ___conditional___ = 9--[[ Format_subst_ty ]] then do
          return --[[ Format_subst_ty ]]Block.__(9, {
                    fmtty1[0],
                    fmtty1[1],
                    concat_fmtty(fmtty1[2], fmtty2)
                  });end end end 
       if ___conditional___ = 10--[[ Alpha_ty ]] then do
          return --[[ Alpha_ty ]]Block.__(10, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 11--[[ Theta_ty ]] then do
          return --[[ Theta_ty ]]Block.__(11, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 12--[[ Any_ty ]] then do
          return --[[ Any_ty ]]Block.__(12, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 13--[[ Reader_ty ]] then do
          return --[[ Reader_ty ]]Block.__(13, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       if ___conditional___ = 14--[[ Ignored_reader_ty ]] then do
          return --[[ Ignored_reader_ty ]]Block.__(14, {concat_fmtty(fmtty1[0], fmtty2)});end end end 
       do
      
    end
  end end 
end end

function concat_fmt(fmt1, fmt2) do
  if (typeof fmt1 == "number") then do
    return fmt2;
  end else do
    local ___conditional___=(fmt1.tag | 0);
    do
       if ___conditional___ = 0--[[ Char ]] then do
          return --[[ Char ]]Block.__(0, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 1--[[ Caml_char ]] then do
          return --[[ Caml_char ]]Block.__(1, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 2--[[ String ]] then do
          return --[[ String ]]Block.__(2, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 3--[[ Caml_string ]] then do
          return --[[ Caml_string ]]Block.__(3, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 4--[[ Int ]] then do
          return --[[ Int ]]Block.__(4, {
                    fmt1[0],
                    fmt1[1],
                    fmt1[2],
                    concat_fmt(fmt1[3], fmt2)
                  });end end end 
       if ___conditional___ = 5--[[ Int32 ]] then do
          return --[[ Int32 ]]Block.__(5, {
                    fmt1[0],
                    fmt1[1],
                    fmt1[2],
                    concat_fmt(fmt1[3], fmt2)
                  });end end end 
       if ___conditional___ = 6--[[ Nativeint ]] then do
          return --[[ Nativeint ]]Block.__(6, {
                    fmt1[0],
                    fmt1[1],
                    fmt1[2],
                    concat_fmt(fmt1[3], fmt2)
                  });end end end 
       if ___conditional___ = 7--[[ Int64 ]] then do
          return --[[ Int64 ]]Block.__(7, {
                    fmt1[0],
                    fmt1[1],
                    fmt1[2],
                    concat_fmt(fmt1[3], fmt2)
                  });end end end 
       if ___conditional___ = 8--[[ Float ]] then do
          return --[[ Float ]]Block.__(8, {
                    fmt1[0],
                    fmt1[1],
                    fmt1[2],
                    concat_fmt(fmt1[3], fmt2)
                  });end end end 
       if ___conditional___ = 9--[[ Bool ]] then do
          return --[[ Bool ]]Block.__(9, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 10--[[ Flush ]] then do
          return --[[ Flush ]]Block.__(10, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 11--[[ String_literal ]] then do
          return --[[ String_literal ]]Block.__(11, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 12--[[ Char_literal ]] then do
          return --[[ Char_literal ]]Block.__(12, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 13--[[ Format_arg ]] then do
          return --[[ Format_arg ]]Block.__(13, {
                    fmt1[0],
                    fmt1[1],
                    concat_fmt(fmt1[2], fmt2)
                  });end end end 
       if ___conditional___ = 14--[[ Format_subst ]] then do
          return --[[ Format_subst ]]Block.__(14, {
                    fmt1[0],
                    fmt1[1],
                    concat_fmt(fmt1[2], fmt2)
                  });end end end 
       if ___conditional___ = 15--[[ Alpha ]] then do
          return --[[ Alpha ]]Block.__(15, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 16--[[ Theta ]] then do
          return --[[ Theta ]]Block.__(16, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 17--[[ Formatting_lit ]] then do
          return --[[ Formatting_lit ]]Block.__(17, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 18--[[ Formatting_gen ]] then do
          return --[[ Formatting_gen ]]Block.__(18, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 19--[[ Reader ]] then do
          return --[[ Reader ]]Block.__(19, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 20--[[ Scan_char_set ]] then do
          return --[[ Scan_char_set ]]Block.__(20, {
                    fmt1[0],
                    fmt1[1],
                    concat_fmt(fmt1[2], fmt2)
                  });end end end 
       if ___conditional___ = 21--[[ Scan_get_counter ]] then do
          return --[[ Scan_get_counter ]]Block.__(21, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 22--[[ Scan_next_char ]] then do
          return --[[ Scan_next_char ]]Block.__(22, {concat_fmt(fmt1[0], fmt2)});end end end 
       if ___conditional___ = 23--[[ Ignored_param ]] then do
          return --[[ Ignored_param ]]Block.__(23, {
                    fmt1[0],
                    concat_fmt(fmt1[1], fmt2)
                  });end end end 
       if ___conditional___ = 24--[[ Custom ]] then do
          return --[[ Custom ]]Block.__(24, {
                    fmt1[0],
                    fmt1[1],
                    concat_fmt(fmt1[2], fmt2)
                  });end end end 
       do
      
    end
  end end 
end end

export do
  concat_fmtty ,
  erase_rel ,
  concat_fmt ,
  
end
--[[ No side effect ]]
