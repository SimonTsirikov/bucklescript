console = {log = print};

Mt = require "./mt";
Parser_api = require "./parser_api";

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

match = Parser_api.implementation(Parser_api.from_string("let v str = \n  str  \n  |> Lexing.from_string \n  |> Parse.implementation\n"));

if (match) then do
  match_1 = match[0].pstr_desc;
  if (match_1.tag == --[[ Pstr_value ]]1 and not match_1[0]) then do
    match_2 = match_1[1];
    if (match_2) then do
      match_3 = match_2[0];
      match_4 = match_3.pvb_pat;
      match_5 = match_4.ppat_desc;
      if (typeof match_5 == "number" or match_5.tag) then do
        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
      end else do
        match_6 = match_5[0];
        if (match_6.txt == "v") then do
          match_7 = match_6.loc;
          match_8 = match_7.loc_start;
          if (match_8.pos_fname == "" and not (match_8.pos_lnum ~= 1 or match_8.pos_bol ~= 0 or match_8.pos_cnum ~= 4)) then do
            match_9 = match_7.loc_end;
            if (match_9.pos_fname == "" and not (match_9.pos_lnum ~= 1 or match_9.pos_bol ~= 0 or match_9.pos_cnum ~= 5 or match_7.loc_ghost)) then do
              match_10 = match_4.ppat_loc;
              match_11 = match_10.loc_start;
              if (match_11.pos_fname == "" and not (match_11.pos_lnum ~= 1 or match_11.pos_bol ~= 0 or match_11.pos_cnum ~= 4)) then do
                match_12 = match_10.loc_end;
                if (match_12.pos_fname == "" and not (match_12.pos_lnum ~= 1 or match_12.pos_bol ~= 0 or match_12.pos_cnum ~= 5 or match_10.loc_ghost or match_4.ppat_attributes)) then do
                  match_13 = match_3.pvb_expr;
                  match_14 = match_13.pexp_desc;
                  if (match_14.tag == --[[ Pexp_fun ]]4 and match_14[0] == "" and match_14[1] == undefined) then do
                    match_15 = match_14[2];
                    match_16 = match_15.ppat_desc;
                    if (typeof match_16 == "number" or match_16.tag) then do
                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                    end else do
                      match_17 = match_16[0];
                      if (match_17.txt == "str") then do
                        match_18 = match_17.loc;
                        match_19 = match_18.loc_start;
                        if (match_19.pos_fname == "" and not (match_19.pos_lnum ~= 1 or match_19.pos_bol ~= 0 or match_19.pos_cnum ~= 6)) then do
                          match_20 = match_18.loc_end;
                          if (match_20.pos_fname == "" and not (match_20.pos_lnum ~= 1 or match_20.pos_bol ~= 0 or match_20.pos_cnum ~= 9 or match_18.loc_ghost)) then do
                            match_21 = match_15.ppat_loc;
                            match_22 = match_21.loc_start;
                            if (match_22.pos_fname == "" and not (match_22.pos_lnum ~= 1 or match_22.pos_bol ~= 0 or match_22.pos_cnum ~= 6)) then do
                              match_23 = match_21.loc_end;
                              if (match_23.pos_fname == "" and not (match_23.pos_lnum ~= 1 or match_23.pos_bol ~= 0 or match_23.pos_cnum ~= 9 or match_21.loc_ghost or match_15.ppat_attributes)) then do
                                match_24 = match_14[3];
                                match_25 = match_24.pexp_desc;
                                if (match_25.tag == --[[ Pexp_apply ]]5) then do
                                  match_26 = match_25[0];
                                  match_27 = match_26.pexp_desc;
                                  if (match_27.tag) then do
                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                  end else do
                                    match_28 = match_27[0];
                                    match_29 = match_28.txt;
                                    local ___conditional___=(match_29.tag | 0);
                                    do
                                       if ___conditional___ == 0--[[ Lident ]] then do
                                          if (match_29[0] == "|>") then do
                                            match_30 = match_28.loc;
                                            match_31 = match_30.loc_start;
                                            if (match_31.pos_fname == "" and not (match_31.pos_lnum ~= 4 or match_31.pos_bol ~= 46 or match_31.pos_cnum ~= 48)) then do
                                              match_32 = match_30.loc_end;
                                              if (match_32.pos_fname == "" and not (match_32.pos_lnum ~= 4 or match_32.pos_bol ~= 46 or match_32.pos_cnum ~= 50 or match_30.loc_ghost)) then do
                                                match_33 = match_26.pexp_loc;
                                                match_34 = match_33.loc_start;
                                                if (match_34.pos_fname == "" and not (match_34.pos_lnum ~= 4 or match_34.pos_bol ~= 46 or match_34.pos_cnum ~= 48)) then do
                                                  match_35 = match_33.loc_end;
                                                  if (match_35.pos_fname == "" and not (match_35.pos_lnum ~= 4 or match_35.pos_bol ~= 46 or match_35.pos_cnum ~= 50 or match_33.loc_ghost or match_26.pexp_attributes)) then do
                                                    match_36 = match_25[1];
                                                    if (match_36) then do
                                                      match_37 = match_36[0];
                                                      if (match_37[0] == "") then do
                                                        match_38 = match_37[1];
                                                        match_39 = match_38.pexp_desc;
                                                        if (match_39.tag == --[[ Pexp_apply ]]5) then do
                                                          match_40 = match_39[0];
                                                          match_41 = match_40.pexp_desc;
                                                          if (match_41.tag) then do
                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                          end else do
                                                            match_42 = match_41[0];
                                                            match_43 = match_42.txt;
                                                            local ___conditional___=(match_43.tag | 0);
                                                            do
                                                               if ___conditional___ == 0--[[ Lident ]] then do
                                                                  if (match_43[0] == "|>") then do
                                                                    match_44 = match_42.loc;
                                                                    match_45 = match_44.loc_start;
                                                                    if (match_45.pos_fname == "" and not (match_45.pos_lnum ~= 3 or match_45.pos_bol ~= 21 or match_45.pos_cnum ~= 23)) then do
                                                                      match_46 = match_44.loc_end;
                                                                      if (match_46.pos_fname == "" and not (match_46.pos_lnum ~= 3 or match_46.pos_bol ~= 21 or match_46.pos_cnum ~= 25 or match_44.loc_ghost)) then do
                                                                        match_47 = match_40.pexp_loc;
                                                                        match_48 = match_47.loc_start;
                                                                        if (match_48.pos_fname == "" and not (match_48.pos_lnum ~= 3 or match_48.pos_bol ~= 21 or match_48.pos_cnum ~= 23)) then do
                                                                          match_49 = match_47.loc_end;
                                                                          if (match_49.pos_fname == "" and not (match_49.pos_lnum ~= 3 or match_49.pos_bol ~= 21 or match_49.pos_cnum ~= 25 or match_47.loc_ghost or match_40.pexp_attributes)) then do
                                                                            match_50 = match_39[1];
                                                                            if (match_50) then do
                                                                              match_51 = match_50[0];
                                                                              if (match_51[0] == "") then do
                                                                                match_52 = match_51[1];
                                                                                match_53 = match_52.pexp_desc;
                                                                                if (match_53.tag) then do
                                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                end else do
                                                                                  match_54 = match_53[0];
                                                                                  match_55 = match_54.txt;
                                                                                  local ___conditional___=(match_55.tag | 0);
                                                                                  do
                                                                                     if ___conditional___ == 0--[[ Lident ]] then do
                                                                                        if (match_55[0] == "str") then do
                                                                                          match_56 = match_54.loc;
                                                                                          match_57 = match_56.loc_start;
                                                                                          if (match_57.pos_fname == "" and not (match_57.pos_lnum ~= 2 or match_57.pos_bol ~= 13 or match_57.pos_cnum ~= 15)) then do
                                                                                            match_58 = match_56.loc_end;
                                                                                            if (match_58.pos_fname == "" and not (match_58.pos_lnum ~= 2 or match_58.pos_bol ~= 13 or match_58.pos_cnum ~= 18 or match_56.loc_ghost)) then do
                                                                                              match_59 = match_52.pexp_loc;
                                                                                              match_60 = match_59.loc_start;
                                                                                              if (match_60.pos_fname == "" and not (match_60.pos_lnum ~= 2 or match_60.pos_bol ~= 13 or match_60.pos_cnum ~= 15)) then do
                                                                                                match_61 = match_59.loc_end;
                                                                                                if (match_61.pos_fname == "" and not (match_61.pos_lnum ~= 2 or match_61.pos_bol ~= 13 or match_61.pos_cnum ~= 18 or match_59.loc_ghost or match_52.pexp_attributes)) then do
                                                                                                  match_62 = match_50[1];
                                                                                                  if (match_62) then do
                                                                                                    match_63 = match_62[0];
                                                                                                    if (match_63[0] == "") then do
                                                                                                      match_64 = match_63[1];
                                                                                                      match_65 = match_64.pexp_desc;
                                                                                                      if (match_65.tag) then do
                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                      end else do
                                                                                                        match_66 = match_65[0];
                                                                                                        match_67 = match_66.txt;
                                                                                                        local ___conditional___=(match_67.tag | 0);
                                                                                                        do
                                                                                                           if ___conditional___ == 1--[[ Ldot ]] then do
                                                                                                              match_68 = match_67[0];
                                                                                                              local ___conditional___=(match_68.tag | 0);
                                                                                                              do
                                                                                                                 if ___conditional___ == 0--[[ Lident ]] then do
                                                                                                                    if (match_68[0] == "Lexing" and match_67[1] == "from_string") then do
                                                                                                                      match_69 = match_66.loc;
                                                                                                                      match_70 = match_69.loc_start;
                                                                                                                      if (match_70.pos_fname == "" and not (match_70.pos_lnum ~= 3 or match_70.pos_bol ~= 21 or match_70.pos_cnum ~= 26)) then do
                                                                                                                        match_71 = match_69.loc_end;
                                                                                                                        if (match_71.pos_fname == "" and not (match_71.pos_lnum ~= 3 or match_71.pos_bol ~= 21 or match_71.pos_cnum ~= 44 or match_69.loc_ghost)) then do
                                                                                                                          match_72 = match_64.pexp_loc;
                                                                                                                          match_73 = match_72.loc_start;
                                                                                                                          if (match_73.pos_fname == "" and not (match_73.pos_lnum ~= 3 or match_73.pos_bol ~= 21 or match_73.pos_cnum ~= 26)) then do
                                                                                                                            match_74 = match_72.loc_end;
                                                                                                                            if (match_74.pos_fname == "" and not (match_74.pos_lnum ~= 3 or match_74.pos_bol ~= 21 or match_74.pos_cnum ~= 44 or match_72.loc_ghost or match_64.pexp_attributes or match_62[1])) then do
                                                                                                                              match_75 = match_38.pexp_loc;
                                                                                                                              match_76 = match_75.loc_start;
                                                                                                                              if (match_76.pos_fname == "" and not (match_76.pos_lnum ~= 2 or match_76.pos_bol ~= 13 or match_76.pos_cnum ~= 15)) then do
                                                                                                                                match_77 = match_75.loc_end;
                                                                                                                                if (match_77.pos_fname == "" and not (match_77.pos_lnum ~= 3 or match_77.pos_bol ~= 21 or match_77.pos_cnum ~= 44 or match_75.loc_ghost or match_38.pexp_attributes)) then do
                                                                                                                                  match_78 = match_36[1];
                                                                                                                                  if (match_78) then do
                                                                                                                                    match_79 = match_78[0];
                                                                                                                                    if (match_79[0] == "") then do
                                                                                                                                      match_80 = match_79[1];
                                                                                                                                      match_81 = match_80.pexp_desc;
                                                                                                                                      if (match_81.tag) then do
                                                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                      end else do
                                                                                                                                        match_82 = match_81[0];
                                                                                                                                        match_83 = match_82.txt;
                                                                                                                                        local ___conditional___=(match_83.tag | 0);
                                                                                                                                        do
                                                                                                                                           if ___conditional___ == 1--[[ Ldot ]] then do
                                                                                                                                              match_84 = match_83[0];
                                                                                                                                              local ___conditional___=(match_84.tag | 0);
                                                                                                                                              do
                                                                                                                                                 if ___conditional___ == 0--[[ Lident ]] then do
                                                                                                                                                    if (match_84[0] == "Parse" and match_83[1] == "implementation") then do
                                                                                                                                                      match_85 = match_82.loc;
                                                                                                                                                      match_86 = match_85.loc_start;
                                                                                                                                                      if (match_86.pos_fname == "" and not (match_86.pos_lnum ~= 4 or match_86.pos_bol ~= 46 or match_86.pos_cnum ~= 51)) then do
                                                                                                                                                        match_87 = match_85.loc_end;
                                                                                                                                                        if (match_87.pos_fname == "" and not (match_87.pos_lnum ~= 4 or match_87.pos_bol ~= 46 or match_87.pos_cnum ~= 71 or match_85.loc_ghost)) then do
                                                                                                                                                          match_88 = match_80.pexp_loc;
                                                                                                                                                          match_89 = match_88.loc_start;
                                                                                                                                                          if (match_89.pos_fname == "" and not (match_89.pos_lnum ~= 4 or match_89.pos_bol ~= 46 or match_89.pos_cnum ~= 51)) then do
                                                                                                                                                            match_90 = match_88.loc_end;
                                                                                                                                                            if (match_90.pos_fname == "" and not (match_90.pos_lnum ~= 4 or match_90.pos_bol ~= 46 or match_90.pos_cnum ~= 71 or match_88.loc_ghost or match_80.pexp_attributes or match_78[1])) then do
                                                                                                                                                              match_91 = match_24.pexp_loc;
                                                                                                                                                              match_92 = match_91.loc_start;
                                                                                                                                                              if (match_92.pos_fname == "" and not (match_92.pos_lnum ~= 2 or match_92.pos_bol ~= 13 or match_92.pos_cnum ~= 15)) then do
                                                                                                                                                                match_93 = match_91.loc_end;
                                                                                                                                                                if (match_93.pos_fname == "" and not (match_93.pos_lnum ~= 4 or match_93.pos_bol ~= 46 or match_93.pos_cnum ~= 71 or match_91.loc_ghost or match_24.pexp_attributes)) then do
                                                                                                                                                                  match_94 = match_13.pexp_loc;
                                                                                                                                                                  match_95 = match_94.loc_start;
                                                                                                                                                                  if (match_95.pos_fname == "" and not (match_95.pos_lnum ~= 1 or match_95.pos_bol ~= 0 or match_95.pos_cnum ~= 6)) then do
                                                                                                                                                                    match_96 = match_94.loc_end;
                                                                                                                                                                    if (match_96.pos_fname == "" and not (match_96.pos_lnum ~= 4 or match_96.pos_bol ~= 46 or match_96.pos_cnum ~= 71 or not (match_94.loc_ghost and not (match_13.pexp_attributes or match_3.pvb_attributes)))) then do
                                                                                                                                                                      match_97 = match_3.pvb_loc;
                                                                                                                                                                      match_98 = match_97.loc_start;
                                                                                                                                                                      if (match_98.pos_fname == "" and not (match_98.pos_lnum ~= 1 or match_98.pos_bol ~= 0 or match_98.pos_cnum ~= 0)) then do
                                                                                                                                                                        match_99 = match_97.loc_end;
                                                                                                                                                                        if (match_99.pos_fname == "" and not (match_99.pos_lnum ~= 4 or match_99.pos_bol ~= 46 or match_99.pos_cnum ~= 71 or match_97.loc_ghost or match_2[1])) then do
                                                                                                                                                                          eq("File \"parser_api_test.ml\", line 210, characters 10-17", true, true);
                                                                                                                                                                        end else do
                                                                                                                                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                                        end end 
                                                                                                                                                                      end else do
                                                                                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                                      end end 
                                                                                                                                                                    end else do
                                                                                                                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                                    end end 
                                                                                                                                                                  end else do
                                                                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                                  end end 
                                                                                                                                                                end else do
                                                                                                                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                                end end 
                                                                                                                                                              end else do
                                                                                                                                                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                              end end 
                                                                                                                                                            end else do
                                                                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                            end end 
                                                                                                                                                          end else do
                                                                                                                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                          end end 
                                                                                                                                                        end else do
                                                                                                                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                        end end 
                                                                                                                                                      end else do
                                                                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                      end end 
                                                                                                                                                    end else do
                                                                                                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                                    end end  end else 
                                                                                                                                                 if ___conditional___ == 1--[[ Ldot ]]
                                                                                                                                                 or ___conditional___ == 2--[[ Lapply ]] then do
                                                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                                                                                                                 end end end end
                                                                                                                                                
                                                                                                                                              end end else 
                                                                                                                                           if ___conditional___ == 0--[[ Lident ]]
                                                                                                                                           or ___conditional___ == 2--[[ Lapply ]] then do
                                                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                                                                                                           end end end end
                                                                                                                                          
                                                                                                                                        end
                                                                                                                                      end end 
                                                                                                                                    end else do
                                                                                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                    end end 
                                                                                                                                  end else do
                                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                  end end 
                                                                                                                                end else do
                                                                                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                end end 
                                                                                                                              end else do
                                                                                                                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                              end end 
                                                                                                                            end else do
                                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                            end end 
                                                                                                                          end else do
                                                                                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                          end end 
                                                                                                                        end else do
                                                                                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                        end end 
                                                                                                                      end else do
                                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                      end end 
                                                                                                                    end else do
                                                                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                    end end  end else 
                                                                                                                 if ___conditional___ == 1--[[ Ldot ]]
                                                                                                                 or ___conditional___ == 2--[[ Lapply ]] then do
                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                                                                                 end end end end
                                                                                                                
                                                                                                              end end else 
                                                                                                           if ___conditional___ == 0--[[ Lident ]]
                                                                                                           or ___conditional___ == 2--[[ Lapply ]] then do
                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                                                                           end end end end
                                                                                                          
                                                                                                        end
                                                                                                      end end 
                                                                                                    end else do
                                                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                    end end 
                                                                                                  end else do
                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                  end end 
                                                                                                end else do
                                                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                end end 
                                                                                              end else do
                                                                                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                              end end 
                                                                                            end else do
                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                            end end 
                                                                                          end else do
                                                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                          end end 
                                                                                        end else do
                                                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                        end end  end else 
                                                                                     if ___conditional___ == 1--[[ Ldot ]]
                                                                                     or ___conditional___ == 2--[[ Lapply ]] then do
                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                                                     end end end end
                                                                                    
                                                                                  end
                                                                                end end 
                                                                              end else do
                                                                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                              end end 
                                                                            end else do
                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                            end end 
                                                                          end else do
                                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                          end end 
                                                                        end else do
                                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                        end end 
                                                                      end else do
                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                      end end 
                                                                    end else do
                                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                    end end 
                                                                  end else do
                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                  end end  end else 
                                                               if ___conditional___ == 1--[[ Ldot ]]
                                                               or ___conditional___ == 2--[[ Lapply ]] then do
                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                                               end end end end
                                                              
                                                            end
                                                          end end 
                                                        end else do
                                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                        end end 
                                                      end else do
                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                      end end 
                                                    end else do
                                                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                    end end 
                                                  end else do
                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                  end end 
                                                end else do
                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                end end 
                                              end else do
                                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                              end end 
                                            end else do
                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                            end end 
                                          end else do
                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                          end end  end else 
                                       if ___conditional___ == 1--[[ Ldot ]]
                                       or ___conditional___ == 2--[[ Lapply ]] then do
                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false); end else 
                                       end end end end
                                      
                                    end
                                  end end 
                                end else do
                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                end end 
                              end else do
                                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                              end end 
                            end else do
                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                            end end 
                          end else do
                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                          end end 
                        end else do
                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                        end end 
                      end else do
                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                      end end 
                    end end 
                  end else do
                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                  end end 
                end else do
                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                end end 
              end else do
                eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
              end end 
            end else do
              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
            end end 
          end else do
            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
          end end 
        end else do
          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
        end end 
      end end 
    end else do
      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
    end end 
  end else do
    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
  end end 
end else do
  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
end end 

Mt.from_pair_suites("Parser_api_test", suites.contents);

lex = Parser_api.from_string;

parse = Parser_api.implementation;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.lex = lex;
exports.parse = parse;
--[[ match Not a pure module ]]
