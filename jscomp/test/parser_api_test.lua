--[['use strict';]]

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
  match$1 = match[0].pstr_desc;
  if (match$1.tag == --[[ Pstr_value ]]1 and not match$1[0]) then do
    match$2 = match$1[1];
    if (match$2) then do
      match$3 = match$2[0];
      match$4 = match$3.pvb_pat;
      match$5 = match$4.ppat_desc;
      if (typeof match$5 == "number" or match$5.tag) then do
        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
      end else do
        match$6 = match$5[0];
        if (match$6.txt == "v") then do
          match$7 = match$6.loc;
          match$8 = match$7.loc_start;
          if (match$8.pos_fname == "" and not (match$8.pos_lnum ~= 1 or match$8.pos_bol ~= 0 or match$8.pos_cnum ~= 4)) then do
            match$9 = match$7.loc_end;
            if (match$9.pos_fname == "" and not (match$9.pos_lnum ~= 1 or match$9.pos_bol ~= 0 or match$9.pos_cnum ~= 5 or match$7.loc_ghost)) then do
              match$10 = match$4.ppat_loc;
              match$11 = match$10.loc_start;
              if (match$11.pos_fname == "" and not (match$11.pos_lnum ~= 1 or match$11.pos_bol ~= 0 or match$11.pos_cnum ~= 4)) then do
                match$12 = match$10.loc_end;
                if (match$12.pos_fname == "" and not (match$12.pos_lnum ~= 1 or match$12.pos_bol ~= 0 or match$12.pos_cnum ~= 5 or match$10.loc_ghost or match$4.ppat_attributes)) then do
                  match$13 = match$3.pvb_expr;
                  match$14 = match$13.pexp_desc;
                  if (match$14.tag == --[[ Pexp_fun ]]4 and match$14[0] == "" and match$14[1] == undefined) then do
                    match$15 = match$14[2];
                    match$16 = match$15.ppat_desc;
                    if (typeof match$16 == "number" or match$16.tag) then do
                      eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                    end else do
                      match$17 = match$16[0];
                      if (match$17.txt == "str") then do
                        match$18 = match$17.loc;
                        match$19 = match$18.loc_start;
                        if (match$19.pos_fname == "" and not (match$19.pos_lnum ~= 1 or match$19.pos_bol ~= 0 or match$19.pos_cnum ~= 6)) then do
                          match$20 = match$18.loc_end;
                          if (match$20.pos_fname == "" and not (match$20.pos_lnum ~= 1 or match$20.pos_bol ~= 0 or match$20.pos_cnum ~= 9 or match$18.loc_ghost)) then do
                            match$21 = match$15.ppat_loc;
                            match$22 = match$21.loc_start;
                            if (match$22.pos_fname == "" and not (match$22.pos_lnum ~= 1 or match$22.pos_bol ~= 0 or match$22.pos_cnum ~= 6)) then do
                              match$23 = match$21.loc_end;
                              if (match$23.pos_fname == "" and not (match$23.pos_lnum ~= 1 or match$23.pos_bol ~= 0 or match$23.pos_cnum ~= 9 or match$21.loc_ghost or match$15.ppat_attributes)) then do
                                match$24 = match$14[3];
                                match$25 = match$24.pexp_desc;
                                if (match$25.tag == --[[ Pexp_apply ]]5) then do
                                  match$26 = match$25[0];
                                  match$27 = match$26.pexp_desc;
                                  if (match$27.tag) then do
                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                  end else do
                                    match$28 = match$27[0];
                                    match$29 = match$28.txt;
                                    local ___conditional___=(match$29.tag | 0);
                                    do
                                       if ___conditional___ = 0--[[ Lident ]] then do
                                          if (match$29[0] == "|>") then do
                                            match$30 = match$28.loc;
                                            match$31 = match$30.loc_start;
                                            if (match$31.pos_fname == "" and not (match$31.pos_lnum ~= 4 or match$31.pos_bol ~= 46 or match$31.pos_cnum ~= 48)) then do
                                              match$32 = match$30.loc_end;
                                              if (match$32.pos_fname == "" and not (match$32.pos_lnum ~= 4 or match$32.pos_bol ~= 46 or match$32.pos_cnum ~= 50 or match$30.loc_ghost)) then do
                                                match$33 = match$26.pexp_loc;
                                                match$34 = match$33.loc_start;
                                                if (match$34.pos_fname == "" and not (match$34.pos_lnum ~= 4 or match$34.pos_bol ~= 46 or match$34.pos_cnum ~= 48)) then do
                                                  match$35 = match$33.loc_end;
                                                  if (match$35.pos_fname == "" and not (match$35.pos_lnum ~= 4 or match$35.pos_bol ~= 46 or match$35.pos_cnum ~= 50 or match$33.loc_ghost or match$26.pexp_attributes)) then do
                                                    match$36 = match$25[1];
                                                    if (match$36) then do
                                                      match$37 = match$36[0];
                                                      if (match$37[0] == "") then do
                                                        match$38 = match$37[1];
                                                        match$39 = match$38.pexp_desc;
                                                        if (match$39.tag == --[[ Pexp_apply ]]5) then do
                                                          match$40 = match$39[0];
                                                          match$41 = match$40.pexp_desc;
                                                          if (match$41.tag) then do
                                                            eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                          end else do
                                                            match$42 = match$41[0];
                                                            match$43 = match$42.txt;
                                                            local ___conditional___=(match$43.tag | 0);
                                                            do
                                                               if ___conditional___ = 0--[[ Lident ]] then do
                                                                  if (match$43[0] == "|>") then do
                                                                    match$44 = match$42.loc;
                                                                    match$45 = match$44.loc_start;
                                                                    if (match$45.pos_fname == "" and not (match$45.pos_lnum ~= 3 or match$45.pos_bol ~= 21 or match$45.pos_cnum ~= 23)) then do
                                                                      match$46 = match$44.loc_end;
                                                                      if (match$46.pos_fname == "" and not (match$46.pos_lnum ~= 3 or match$46.pos_bol ~= 21 or match$46.pos_cnum ~= 25 or match$44.loc_ghost)) then do
                                                                        match$47 = match$40.pexp_loc;
                                                                        match$48 = match$47.loc_start;
                                                                        if (match$48.pos_fname == "" and not (match$48.pos_lnum ~= 3 or match$48.pos_bol ~= 21 or match$48.pos_cnum ~= 23)) then do
                                                                          match$49 = match$47.loc_end;
                                                                          if (match$49.pos_fname == "" and not (match$49.pos_lnum ~= 3 or match$49.pos_bol ~= 21 or match$49.pos_cnum ~= 25 or match$47.loc_ghost or match$40.pexp_attributes)) then do
                                                                            match$50 = match$39[1];
                                                                            if (match$50) then do
                                                                              match$51 = match$50[0];
                                                                              if (match$51[0] == "") then do
                                                                                match$52 = match$51[1];
                                                                                match$53 = match$52.pexp_desc;
                                                                                if (match$53.tag) then do
                                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                end else do
                                                                                  match$54 = match$53[0];
                                                                                  match$55 = match$54.txt;
                                                                                  local ___conditional___=(match$55.tag | 0);
                                                                                  do
                                                                                     if ___conditional___ = 0--[[ Lident ]] then do
                                                                                        if (match$55[0] == "str") then do
                                                                                          match$56 = match$54.loc;
                                                                                          match$57 = match$56.loc_start;
                                                                                          if (match$57.pos_fname == "" and not (match$57.pos_lnum ~= 2 or match$57.pos_bol ~= 13 or match$57.pos_cnum ~= 15)) then do
                                                                                            match$58 = match$56.loc_end;
                                                                                            if (match$58.pos_fname == "" and not (match$58.pos_lnum ~= 2 or match$58.pos_bol ~= 13 or match$58.pos_cnum ~= 18 or match$56.loc_ghost)) then do
                                                                                              match$59 = match$52.pexp_loc;
                                                                                              match$60 = match$59.loc_start;
                                                                                              if (match$60.pos_fname == "" and not (match$60.pos_lnum ~= 2 or match$60.pos_bol ~= 13 or match$60.pos_cnum ~= 15)) then do
                                                                                                match$61 = match$59.loc_end;
                                                                                                if (match$61.pos_fname == "" and not (match$61.pos_lnum ~= 2 or match$61.pos_bol ~= 13 or match$61.pos_cnum ~= 18 or match$59.loc_ghost or match$52.pexp_attributes)) then do
                                                                                                  match$62 = match$50[1];
                                                                                                  if (match$62) then do
                                                                                                    match$63 = match$62[0];
                                                                                                    if (match$63[0] == "") then do
                                                                                                      match$64 = match$63[1];
                                                                                                      match$65 = match$64.pexp_desc;
                                                                                                      if (match$65.tag) then do
                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                      end else do
                                                                                                        match$66 = match$65[0];
                                                                                                        match$67 = match$66.txt;
                                                                                                        local ___conditional___=(match$67.tag | 0);
                                                                                                        do
                                                                                                           if ___conditional___ = 1--[[ Ldot ]] then do
                                                                                                              match$68 = match$67[0];
                                                                                                              local ___conditional___=(match$68.tag | 0);
                                                                                                              do
                                                                                                                 if ___conditional___ = 0--[[ Lident ]] then do
                                                                                                                    if (match$68[0] == "Lexing" and match$67[1] == "from_string") then do
                                                                                                                      match$69 = match$66.loc;
                                                                                                                      match$70 = match$69.loc_start;
                                                                                                                      if (match$70.pos_fname == "" and not (match$70.pos_lnum ~= 3 or match$70.pos_bol ~= 21 or match$70.pos_cnum ~= 26)) then do
                                                                                                                        match$71 = match$69.loc_end;
                                                                                                                        if (match$71.pos_fname == "" and not (match$71.pos_lnum ~= 3 or match$71.pos_bol ~= 21 or match$71.pos_cnum ~= 44 or match$69.loc_ghost)) then do
                                                                                                                          match$72 = match$64.pexp_loc;
                                                                                                                          match$73 = match$72.loc_start;
                                                                                                                          if (match$73.pos_fname == "" and not (match$73.pos_lnum ~= 3 or match$73.pos_bol ~= 21 or match$73.pos_cnum ~= 26)) then do
                                                                                                                            match$74 = match$72.loc_end;
                                                                                                                            if (match$74.pos_fname == "" and not (match$74.pos_lnum ~= 3 or match$74.pos_bol ~= 21 or match$74.pos_cnum ~= 44 or match$72.loc_ghost or match$64.pexp_attributes or match$62[1])) then do
                                                                                                                              match$75 = match$38.pexp_loc;
                                                                                                                              match$76 = match$75.loc_start;
                                                                                                                              if (match$76.pos_fname == "" and not (match$76.pos_lnum ~= 2 or match$76.pos_bol ~= 13 or match$76.pos_cnum ~= 15)) then do
                                                                                                                                match$77 = match$75.loc_end;
                                                                                                                                if (match$77.pos_fname == "" and not (match$77.pos_lnum ~= 3 or match$77.pos_bol ~= 21 or match$77.pos_cnum ~= 44 or match$75.loc_ghost or match$38.pexp_attributes)) then do
                                                                                                                                  match$78 = match$36[1];
                                                                                                                                  if (match$78) then do
                                                                                                                                    match$79 = match$78[0];
                                                                                                                                    if (match$79[0] == "") then do
                                                                                                                                      match$80 = match$79[1];
                                                                                                                                      match$81 = match$80.pexp_desc;
                                                                                                                                      if (match$81.tag) then do
                                                                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);
                                                                                                                                      end else do
                                                                                                                                        match$82 = match$81[0];
                                                                                                                                        match$83 = match$82.txt;
                                                                                                                                        local ___conditional___=(match$83.tag | 0);
                                                                                                                                        do
                                                                                                                                           if ___conditional___ = 1--[[ Ldot ]] then do
                                                                                                                                              match$84 = match$83[0];
                                                                                                                                              local ___conditional___=(match$84.tag | 0);
                                                                                                                                              do
                                                                                                                                                 if ___conditional___ = 0--[[ Lident ]] then do
                                                                                                                                                    if (match$84[0] == "Parse" and match$83[1] == "implementation") then do
                                                                                                                                                      match$85 = match$82.loc;
                                                                                                                                                      match$86 = match$85.loc_start;
                                                                                                                                                      if (match$86.pos_fname == "" and not (match$86.pos_lnum ~= 4 or match$86.pos_bol ~= 46 or match$86.pos_cnum ~= 51)) then do
                                                                                                                                                        match$87 = match$85.loc_end;
                                                                                                                                                        if (match$87.pos_fname == "" and not (match$87.pos_lnum ~= 4 or match$87.pos_bol ~= 46 or match$87.pos_cnum ~= 71 or match$85.loc_ghost)) then do
                                                                                                                                                          match$88 = match$80.pexp_loc;
                                                                                                                                                          match$89 = match$88.loc_start;
                                                                                                                                                          if (match$89.pos_fname == "" and not (match$89.pos_lnum ~= 4 or match$89.pos_bol ~= 46 or match$89.pos_cnum ~= 51)) then do
                                                                                                                                                            match$90 = match$88.loc_end;
                                                                                                                                                            if (match$90.pos_fname == "" and not (match$90.pos_lnum ~= 4 or match$90.pos_bol ~= 46 or match$90.pos_cnum ~= 71 or match$88.loc_ghost or match$80.pexp_attributes or match$78[1])) then do
                                                                                                                                                              match$91 = match$24.pexp_loc;
                                                                                                                                                              match$92 = match$91.loc_start;
                                                                                                                                                              if (match$92.pos_fname == "" and not (match$92.pos_lnum ~= 2 or match$92.pos_bol ~= 13 or match$92.pos_cnum ~= 15)) then do
                                                                                                                                                                match$93 = match$91.loc_end;
                                                                                                                                                                if (match$93.pos_fname == "" and not (match$93.pos_lnum ~= 4 or match$93.pos_bol ~= 46 or match$93.pos_cnum ~= 71 or match$91.loc_ghost or match$24.pexp_attributes)) then do
                                                                                                                                                                  match$94 = match$13.pexp_loc;
                                                                                                                                                                  match$95 = match$94.loc_start;
                                                                                                                                                                  if (match$95.pos_fname == "" and not (match$95.pos_lnum ~= 1 or match$95.pos_bol ~= 0 or match$95.pos_cnum ~= 6)) then do
                                                                                                                                                                    match$96 = match$94.loc_end;
                                                                                                                                                                    if (match$96.pos_fname == "" and not (match$96.pos_lnum ~= 4 or match$96.pos_bol ~= 46 or match$96.pos_cnum ~= 71 or not (match$94.loc_ghost and not (match$13.pexp_attributes or match$3.pvb_attributes)))) then do
                                                                                                                                                                      match$97 = match$3.pvb_loc;
                                                                                                                                                                      match$98 = match$97.loc_start;
                                                                                                                                                                      if (match$98.pos_fname == "" and not (match$98.pos_lnum ~= 1 or match$98.pos_bol ~= 0 or match$98.pos_cnum ~= 0)) then do
                                                                                                                                                                        match$99 = match$97.loc_end;
                                                                                                                                                                        if (match$99.pos_fname == "" and not (match$99.pos_lnum ~= 4 or match$99.pos_bol ~= 46 or match$99.pos_cnum ~= 71 or match$97.loc_ghost or match$2[1])) then do
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
                                                                                                                                                    end end end else 
                                                                                                                                                 if ___conditional___ = 1--[[ Ldot ]]
                                                                                                                                                 or ___conditional___ = 2--[[ Lapply ]] then do
                                                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                                                                                                                 do end end end
                                                                                                                                                
                                                                                                                                              endend else 
                                                                                                                                           if ___conditional___ = 0--[[ Lident ]]
                                                                                                                                           or ___conditional___ = 2--[[ Lapply ]] then do
                                                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                                                                                                           do end end end
                                                                                                                                          
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
                                                                                                                    end end end else 
                                                                                                                 if ___conditional___ = 1--[[ Ldot ]]
                                                                                                                 or ___conditional___ = 2--[[ Lapply ]] then do
                                                                                                                    eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                                                                                 do end end end
                                                                                                                
                                                                                                              endend else 
                                                                                                           if ___conditional___ = 0--[[ Lident ]]
                                                                                                           or ___conditional___ = 2--[[ Lapply ]] then do
                                                                                                              eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                                                                           do end end end
                                                                                                          
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
                                                                                        end end end else 
                                                                                     if ___conditional___ = 1--[[ Ldot ]]
                                                                                     or ___conditional___ = 2--[[ Lapply ]] then do
                                                                                        eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                                                     do end end end
                                                                                    
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
                                                                  end end end else 
                                                               if ___conditional___ = 1--[[ Ldot ]]
                                                               or ___conditional___ = 2--[[ Lapply ]] then do
                                                                  eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                                               do end end end
                                                              
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
                                          end end end else 
                                       if ___conditional___ = 1--[[ Ldot ]]
                                       or ___conditional___ = 2--[[ Lapply ]] then do
                                          eq("File \"parser_api_test.ml\", line 211, characters 12-19", true, false);end else 
                                       do end end end
                                      
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

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.lex = lex;
exports.parse = parse;
--[[ match Not a pure module ]]
