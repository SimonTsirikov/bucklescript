console = {log = print};

Char = require "./char";
List = require "./list";
Block = require "./block";
Bytes = require "./bytes";
Stream = require "./stream";
Hashtbl = require "./hashtbl";
Caml_bytes = require "./caml_bytes";
Caml_int32 = require "./caml_int32";
Caml_format = require "./caml_format";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

initial_buffer = Caml_bytes.caml_create_bytes(32);

buffer = do
  contents: initial_buffer
end;

bufpos = do
  contents: 0
end;

function reset_buffer(param) do
  buffer.contents = initial_buffer;
  bufpos.contents = 0;
  return --[[ () ]]0;
end end

function store(c) do
  if (bufpos.contents >= #buffer.contents) then do
    newbuffer = Caml_bytes.caml_create_bytes((bufpos.contents << 1));
    Bytes.blit(buffer.contents, 0, newbuffer, 0, bufpos.contents);
    buffer.contents = newbuffer;
  end
   end 
  buffer.contents[bufpos.contents] = c;
  bufpos.contents = bufpos.contents + 1 | 0;
  return --[[ () ]]0;
end end

function get_string(param) do
  s = Bytes.sub_string(buffer.contents, 0, bufpos.contents);
  buffer.contents = initial_buffer;
  return s;
end end

function make_lexer(keywords) do
  kwd_table = Hashtbl.create(undefined, 17);
  List.iter((function(s) do
          return Hashtbl.add(kwd_table, s, --[[ Kwd ]]Block.__(0, {s}));
        end end), keywords);
  ident_or_keyword = function(id) do
    xpcall(function() do
      return Hashtbl.find(kwd_table, id);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        return --[[ Ident ]]Block.__(1, {id});
      end else do
        error(exn)
      end end 
    end end)
  end end;
  keyword_or_error = function(c) do
    s = Caml_bytes.bytes_to_string(Bytes.make(1, c));
    xpcall(function() do
      return Hashtbl.find(kwd_table, s);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.not_found) then do
        error({
          Stream.__Error,
          "Illegal character " .. s
        })
      end
       end 
      error(exn)
    end end)
  end end;
  next_token = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        c = match;
        exit = 0;
        if (c < 124) then do
          switcher = c - 65 | 0;
          if (switcher > 57 or switcher < 0) then do
            if (switcher >= 58) then do
              exit = 1;
            end else do
              local ___conditional___=(switcher + 65 | 0);
              do
                 if ___conditional___ == 9
                 or ___conditional___ == 10
                 or ___conditional___ == 12
                 or ___conditional___ == 13
                 or ___conditional___ == 26
                 or ___conditional___ == 32 then do
                    Stream.junk(strm__);
                    ::continue:: ; end end 
                 if ___conditional___ == 34 then do
                    Stream.junk(strm__);
                    reset_buffer(--[[ () ]]0);
                    return --[[ String ]]Block.__(4, {string(strm__)}); end end 
                 if ___conditional___ == 39 then do
                    Stream.junk(strm__);
                    c_1;
                    xpcall(function() do
                      c_1 = __char(strm__);
                    end end,function(exn) do
                      if (exn == Stream.Failure) then do
                        error({
                          Stream.__Error,
                          ""
                        })
                      end
                       end 
                      error(exn)
                    end end)
                    match_1 = Stream.peek(strm__);
                    if (match_1 ~= undefined) then do
                      if (match_1 ~= 39) then do
                        error({
                          Stream.__Error,
                          ""
                        })
                      end
                       end 
                      Stream.junk(strm__);
                      return --[[ Char ]]Block.__(5, {c_1});
                    end else do
                      error({
                        Stream.__Error,
                        ""
                      })
                    end end  end end 
                 if ___conditional___ == 40 then do
                    Stream.junk(strm__);
                    strm___1 = strm__;
                    match_2 = Stream.peek(strm___1);
                    if (match_2 == 42) then do
                      Stream.junk(strm___1);
                      comment(strm___1);
                      return next_token(strm___1);
                    end else do
                      return keyword_or_error(--[[ "(" ]]40);
                    end end  end end 
                 if ___conditional___ == 45 then do
                    Stream.junk(strm__);
                    strm___2 = strm__;
                    match_3 = Stream.peek(strm___2);
                    if (match_3 ~= undefined) then do
                      c_2 = match_3;
                      if (c_2 > 57 or c_2 < 48) then do
                        reset_buffer(--[[ () ]]0);
                        store(--[[ "-" ]]45);
                        return ident2(strm___2);
                      end else do
                        Stream.junk(strm___2);
                        reset_buffer(--[[ () ]]0);
                        store(--[[ "-" ]]45);
                        store(c_2);
                        return number(strm___2);
                      end end 
                    end else do
                      reset_buffer(--[[ () ]]0);
                      store(--[[ "-" ]]45);
                      return ident2(strm___2);
                    end end  end end 
                 if ___conditional___ == 48
                 or ___conditional___ == 49
                 or ___conditional___ == 50
                 or ___conditional___ == 51
                 or ___conditional___ == 52
                 or ___conditional___ == 53
                 or ___conditional___ == 54
                 or ___conditional___ == 55
                 or ___conditional___ == 56
                 or ___conditional___ == 57 then do
                    exit = 4; end else 
                 if ___conditional___ == 0
                 or ___conditional___ == 1
                 or ___conditional___ == 2
                 or ___conditional___ == 3
                 or ___conditional___ == 4
                 or ___conditional___ == 5
                 or ___conditional___ == 6
                 or ___conditional___ == 7
                 or ___conditional___ == 8
                 or ___conditional___ == 11
                 or ___conditional___ == 14
                 or ___conditional___ == 15
                 or ___conditional___ == 16
                 or ___conditional___ == 17
                 or ___conditional___ == 18
                 or ___conditional___ == 19
                 or ___conditional___ == 20
                 or ___conditional___ == 21
                 or ___conditional___ == 22
                 or ___conditional___ == 23
                 or ___conditional___ == 24
                 or ___conditional___ == 25
                 or ___conditional___ == 27
                 or ___conditional___ == 28
                 or ___conditional___ == 29
                 or ___conditional___ == 30
                 or ___conditional___ == 31
                 or ___conditional___ == 41
                 or ___conditional___ == 44
                 or ___conditional___ == 46
                 or ___conditional___ == 59 then do
                    exit = 1; end else 
                 if ___conditional___ == 33
                 or ___conditional___ == 35
                 or ___conditional___ == 36
                 or ___conditional___ == 37
                 or ___conditional___ == 38
                 or ___conditional___ == 42
                 or ___conditional___ == 43
                 or ___conditional___ == 47
                 or ___conditional___ == 58
                 or ___conditional___ == 60
                 or ___conditional___ == 61
                 or ___conditional___ == 62
                 or ___conditional___ == 63
                 or ___conditional___ == 64 then do
                    exit = 3; end else 
                 end end end end end end
                
              end
            end end 
          end else do
            local ___conditional___=(switcher);
            do
               if ___conditional___ == 27
               or ___conditional___ == 29 then do
                  exit = 3; end else 
               if ___conditional___ == 30 then do
                  exit = 2; end else 
               if ___conditional___ == 26
               or ___conditional___ == 28
               or ___conditional___ == 31 then do
                  exit = 1; end else 
               end end end end end end
              exit = 2;
                
            end
          end end 
        end else do
          exit = c >= 127 and (
              c >= 192 and 2 or 1
            ) or (
              c ~= 125 and 3 or 1
            );
        end end 
        local ___conditional___=(exit);
        do
           if ___conditional___ == 1 then do
              Stream.junk(strm__);
              return keyword_or_error(c); end end 
           if ___conditional___ == 2 then do
              Stream.junk(strm__);
              reset_buffer(--[[ () ]]0);
              store(c);
              strm___3 = strm__;
              while(true) do
                match_4 = Stream.peek(strm___3);
                if (match_4 ~= undefined) then do
                  c_3 = match_4;
                  if (c_3 >= 91) then do
                    switcher_1 = c_3 - 95 | 0;
                    if (switcher_1 > 27 or switcher_1 < 0) then do
                      if (switcher_1 < 97) then do
                        return ident_or_keyword(get_string(--[[ () ]]0));
                      end
                       end 
                    end else if (switcher_1 == 1) then do
                      return ident_or_keyword(get_string(--[[ () ]]0));
                    end
                     end  end 
                  end else if (c_3 >= 48) then do
                    if (not (c_3 > 64 or c_3 < 58)) then do
                      return ident_or_keyword(get_string(--[[ () ]]0));
                    end
                     end 
                  end else if (c_3 ~= 39) then do
                    return ident_or_keyword(get_string(--[[ () ]]0));
                  end
                   end  end  end 
                  Stream.junk(strm___3);
                  store(c_3);
                  ::continue:: ;
                end else do
                  return ident_or_keyword(get_string(--[[ () ]]0));
                end end 
              end; end end 
           if ___conditional___ == 3 then do
              Stream.junk(strm__);
              reset_buffer(--[[ () ]]0);
              store(c);
              return ident2(strm__); end end 
           if ___conditional___ == 4 then do
              Stream.junk(strm__);
              reset_buffer(--[[ () ]]0);
              store(c);
              return number(strm__); end end 
          
        end
      end else do
        return ;
      end end 
    end;
  end end;
  ident2 = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        c = match;
        if (c >= 94) then do
          switcher = c - 95 | 0;
          if (switcher > 30 or switcher < 0) then do
            if (switcher >= 32) then do
              return ident_or_keyword(get_string(--[[ () ]]0));
            end
             end 
          end else if (switcher ~= 29) then do
            return ident_or_keyword(get_string(--[[ () ]]0));
          end
           end  end 
        end else if (c >= 65) then do
          if (c ~= 92) then do
            return ident_or_keyword(get_string(--[[ () ]]0));
          end
           end 
        end else if (c >= 33) then do
          local ___conditional___=(c - 33 | 0);
          do
             if ___conditional___ == 1
             or ___conditional___ == 6
             or ___conditional___ == 7
             or ___conditional___ == 8
             or ___conditional___ == 11
             or ___conditional___ == 13
             or ___conditional___ == 15
             or ___conditional___ == 16
             or ___conditional___ == 17
             or ___conditional___ == 18
             or ___conditional___ == 19
             or ___conditional___ == 20
             or ___conditional___ == 21
             or ___conditional___ == 22
             or ___conditional___ == 23
             or ___conditional___ == 24
             or ___conditional___ == 26 then do
                return ident_or_keyword(get_string(--[[ () ]]0)); end end 
             if ___conditional___ == 0
             or ___conditional___ == 2
             or ___conditional___ == 3
             or ___conditional___ == 4
             or ___conditional___ == 5
             or ___conditional___ == 9
             or ___conditional___ == 10
             or ___conditional___ == 12
             or ___conditional___ == 14
             or ___conditional___ == 25
             or ___conditional___ == 27
             or ___conditional___ == 28
             or ___conditional___ == 29
             or ___conditional___ == 30
             or ___conditional___ == 31
             end
            
          end
        end else do
          return ident_or_keyword(get_string(--[[ () ]]0));
        end end  end  end 
        Stream.junk(strm__);
        store(c);
        ::continue:: ;
      end else do
        return ident_or_keyword(get_string(--[[ () ]]0));
      end end 
    end;
  end end;
  number = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        c = match;
        if (c >= 58) then do
          if (not (c ~= 69 and c ~= 101)) then do
            Stream.junk(strm__);
            store(--[[ "E" ]]69);
            return exponent_part(strm__);
          end
           end 
        end else if (c ~= 46) then do
          if (c >= 48) then do
            Stream.junk(strm__);
            store(c);
            ::continue:: ;
          end
           end 
        end else do
          Stream.junk(strm__);
          store(--[[ "." ]]46);
          strm___1 = strm__;
          while(true) do
            match_1 = Stream.peek(strm___1);
            if (match_1 ~= undefined) then do
              c_1 = match_1;
              switcher = c_1 - 69 | 0;
              if (switcher > 32 or switcher < 0) then do
                if ((switcher + 21 >>> 0) <= 9) then do
                  Stream.junk(strm___1);
                  store(c_1);
                  ::continue:: ;
                end
                 end 
              end else if (switcher > 31 or switcher < 1) then do
                Stream.junk(strm___1);
                store(--[[ "E" ]]69);
                return exponent_part(strm___1);
              end
               end  end 
            end
             end 
            return --[[ Float ]]Block.__(3, {Caml_format.caml_float_of_string(get_string(--[[ () ]]0))});
          end;
        end end  end 
      end
       end 
      return --[[ Int ]]Block.__(2, {Caml_format.caml_int_of_string(get_string(--[[ () ]]0))});
    end;
  end end;
  exponent_part = function(strm__) do
    match = Stream.peek(strm__);
    if (match ~= undefined) then do
      c = match;
      if (c ~= 43 and c ~= 45) then do
        return end_exponent_part(strm__);
      end else do
        Stream.junk(strm__);
        store(c);
        return end_exponent_part(strm__);
      end end 
    end else do
      return end_exponent_part(strm__);
    end end 
  end end;
  end_exponent_part = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        c = match;
        if (c > 57 or c < 48) then do
          return --[[ Float ]]Block.__(3, {Caml_format.caml_float_of_string(get_string(--[[ () ]]0))});
        end else do
          Stream.junk(strm__);
          store(c);
          ::continue:: ;
        end end 
      end else do
        return --[[ Float ]]Block.__(3, {Caml_format.caml_float_of_string(get_string(--[[ () ]]0))});
      end end 
    end;
  end end;
  string = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        c = match;
        Stream.junk(strm__);
        if (c ~= 34) then do
          if (c ~= 92) then do
            store(c);
            ::continue:: ;
          end else do
            c_1;
            xpcall(function() do
              c_1 = __escape(strm__);
            end end,function(exn) do
              if (exn == Stream.Failure) then do
                error({
                  Stream.__Error,
                  ""
                })
              end
               end 
              error(exn)
            end end)
            store(c_1);
            ::continue:: ;
          end end 
        end else do
          return get_string(--[[ () ]]0);
        end end 
      end else do
        error(Stream.Failure)
      end end 
    end;
  end end;
  __char = function(strm__) do
    match = Stream.peek(strm__);
    if (match ~= undefined) then do
      c = match;
      Stream.junk(strm__);
      if (c ~= 92) then do
        return c;
      end else do
        xpcall(function() do
          return __escape(strm__);
        end end,function(exn) do
          if (exn == Stream.Failure) then do
            error({
              Stream.__Error,
              ""
            })
          end
           end 
          error(exn)
        end end)
      end end 
    end else do
      error(Stream.Failure)
    end end 
  end end;
  __escape = function(strm__) do
    match = Stream.peek(strm__);
    if (match ~= undefined) then do
      c1 = match;
      if (c1 >= 58) then do
        local ___conditional___=(c1);
        do
           if ___conditional___ == 110 then do
              Stream.junk(strm__);
              return --[[ "\n" ]]10; end end 
           if ___conditional___ == 114 then do
              Stream.junk(strm__);
              return --[[ "\r" ]]13; end end 
           if ___conditional___ == 111
           or ___conditional___ == 112
           or ___conditional___ == 113
           or ___conditional___ == 115 then do
              Stream.junk(strm__);
              return c1; end end 
           if ___conditional___ == 116 then do
              Stream.junk(strm__);
              return --[[ "\t" ]]9; end end 
          Stream.junk(strm__);
            return c1;
            
        end
      end else do
        Stream.junk(strm__);
        if (c1 >= 48) then do
          match_1 = Stream.peek(strm__);
          if (match_1 ~= undefined) then do
            c2 = match_1;
            if (c2 > 57 or c2 < 48) then do
              error({
                Stream.__Error,
                ""
              })
            end
             end 
            Stream.junk(strm__);
            match_2 = Stream.peek(strm__);
            if (match_2 ~= undefined) then do
              c3 = match_2;
              if (c3 > 57 or c3 < 48) then do
                error({
                  Stream.__Error,
                  ""
                })
              end
               end 
              Stream.junk(strm__);
              return Char.chr((Caml_int32.imul(c1 - 48 | 0, 100) + Caml_int32.imul(c2 - 48 | 0, 10) | 0) + (c3 - 48 | 0) | 0);
            end else do
              error({
                Stream.__Error,
                ""
              })
            end end 
          end else do
            error({
              Stream.__Error,
              ""
            })
          end end 
        end else do
          return c1;
        end end 
      end end 
    end else do
      error(Stream.Failure)
    end end 
  end end;
  comment = function(strm__) do
    while(true) do
      match = Stream.peek(strm__);
      if (match ~= undefined) then do
        local ___conditional___=(match);
        do
           if ___conditional___ == 40 then do
              Stream.junk(strm__);
              strm___1 = strm__;
              match_1 = Stream.peek(strm___1);
              if (match_1 ~= undefined) then do
                if (match_1 ~= 42) then do
                  Stream.junk(strm___1);
                  return comment(strm___1);
                end else do
                  Stream.junk(strm___1);
                  comment(strm___1);
                  return comment(strm___1);
                end end 
              end else do
                error(Stream.Failure)
              end end  end end 
           if ___conditional___ == 41 then do
              Stream.junk(strm__);
              ::continue:: ; end end 
           if ___conditional___ == 42 then do
              Stream.junk(strm__);
              strm___2 = strm__;
              while(true) do
                match_2 = Stream.peek(strm___2);
                if (match_2 ~= undefined) then do
                  match_3 = match_2;
                  Stream.junk(strm___2);
                  if (match_3 ~= 41) then do
                    if (match_3 ~= 42) then do
                      return comment(strm___2);
                    end else do
                      ::continue:: ;
                    end end 
                  end else do
                    return --[[ () ]]0;
                  end end 
                end else do
                  error(Stream.Failure)
                end end 
              end; end end 
          Stream.junk(strm__);
            ::continue:: ;
            
        end
      end else do
        error(Stream.Failure)
      end end 
    end;
  end end;
  return (function(input) do
      return Stream.from((function(_count) do
                    return next_token(input);
                  end end));
    end end);
end end

exports = {}
exports.make_lexer = make_lexer;
--[[ No side effect ]]
