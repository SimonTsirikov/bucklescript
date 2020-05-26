'use strict';

var Char = require("./char.js");
var List = require("./list.js");
var Block = require("./block.js");
var Bytes = require("./bytes.js");
var Stream = require("./stream.js");
var Hashtbl = require("./hashtbl.js");
var Caml_bytes = require("./caml_bytes.js");
var Caml_int32 = require("./caml_int32.js");
var Caml_format = require("./caml_format.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

var initial_buffer = Caml_bytes.caml_create_bytes(32);

var buffer = do
  contents: initial_buffer
end;

var bufpos = do
  contents: 0
end;

function reset_buffer(param) do
  buffer.contents = initial_buffer;
  bufpos.contents = 0;
  return --[ () ]--0;
end

function store(c) do
  if (bufpos.contents >= #buffer.contents) then do
    var newbuffer = Caml_bytes.caml_create_bytes((bufpos.contents << 1));
    Bytes.blit(buffer.contents, 0, newbuffer, 0, bufpos.contents);
    buffer.contents = newbuffer;
  end
   end 
  buffer.contents[bufpos.contents] = c;
  bufpos.contents = bufpos.contents + 1 | 0;
  return --[ () ]--0;
end

function get_string(param) do
  var s = Bytes.sub_string(buffer.contents, 0, bufpos.contents);
  buffer.contents = initial_buffer;
  return s;
end

function make_lexer(keywords) do
  var kwd_table = Hashtbl.create(undefined, 17);
  List.iter((function (s) do
          return Hashtbl.add(kwd_table, s, --[ Kwd ]--Block.__(0, [s]));
        end), keywords);
  var ident_or_keyword = function (id) do
    try do
      return Hashtbl.find(kwd_table, id);
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        return --[ Ident ]--Block.__(1, [id]);
      end else do
        throw exn;
      end end 
    end
  end;
  var keyword_or_error = function (c) do
    var s = Caml_bytes.bytes_to_string(Bytes.make(1, c));
    try do
      return Hashtbl.find(kwd_table, s);
    end
    catch (exn)do
      if (exn == Caml_builtin_exceptions.not_found) then do
        throw [
              Stream.$$Error,
              "Illegal character " .. s
            ];
      end
       end 
      throw exn;
    end
  end;
  var next_token = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        var c = match;
        var exit = 0;
        if (c < 124) then do
          var switcher = c - 65 | 0;
          if (switcher > 57 or switcher < 0) then do
            if (switcher >= 58) then do
              exit = 1;
            end else do
              local ___conditional___=(switcher + 65 | 0);
              do
                 if ___conditional___ = 9
                 or ___conditional___ = 10
                 or ___conditional___ = 12
                 or ___conditional___ = 13
                 or ___conditional___ = 26
                 or ___conditional___ = 32 then do
                    Stream.junk(strm__);
                    continue ;end end end 
                 if ___conditional___ = 34 then do
                    Stream.junk(strm__);
                    reset_buffer(--[ () ]--0);
                    return --[ String ]--Block.__(4, [string(strm__)]);end end end 
                 if ___conditional___ = 39 then do
                    Stream.junk(strm__);
                    var c$1;
                    try do
                      c$1 = $$char(strm__);
                    end
                    catch (exn)do
                      if (exn == Stream.Failure) then do
                        throw [
                              Stream.$$Error,
                              ""
                            ];
                      end
                       end 
                      throw exn;
                    end
                    var match$1 = Stream.peek(strm__);
                    if (match$1 ~= undefined) then do
                      if (match$1 ~= 39) then do
                        throw [
                              Stream.$$Error,
                              ""
                            ];
                      end
                       end 
                      Stream.junk(strm__);
                      return --[ Char ]--Block.__(5, [c$1]);
                    end else do
                      throw [
                            Stream.$$Error,
                            ""
                          ];
                    end end end end end 
                 if ___conditional___ = 40 then do
                    Stream.junk(strm__);
                    var strm__$1 = strm__;
                    var match$2 = Stream.peek(strm__$1);
                    if (match$2 == 42) then do
                      Stream.junk(strm__$1);
                      comment(strm__$1);
                      return next_token(strm__$1);
                    end else do
                      return keyword_or_error(--[ "(" ]--40);
                    end end end end end 
                 if ___conditional___ = 45 then do
                    Stream.junk(strm__);
                    var strm__$2 = strm__;
                    var match$3 = Stream.peek(strm__$2);
                    if (match$3 ~= undefined) then do
                      var c$2 = match$3;
                      if (c$2 > 57 or c$2 < 48) then do
                        reset_buffer(--[ () ]--0);
                        store(--[ "-" ]--45);
                        return ident2(strm__$2);
                      end else do
                        Stream.junk(strm__$2);
                        reset_buffer(--[ () ]--0);
                        store(--[ "-" ]--45);
                        store(c$2);
                        return number(strm__$2);
                      end end 
                    end else do
                      reset_buffer(--[ () ]--0);
                      store(--[ "-" ]--45);
                      return ident2(strm__$2);
                    end end end end end 
                 if ___conditional___ = 48
                 or ___conditional___ = 49
                 or ___conditional___ = 50
                 or ___conditional___ = 51
                 or ___conditional___ = 52
                 or ___conditional___ = 53
                 or ___conditional___ = 54
                 or ___conditional___ = 55
                 or ___conditional___ = 56
                 or ___conditional___ = 57 then do
                    exit = 4;end else 
                 if ___conditional___ = 0
                 or ___conditional___ = 1
                 or ___conditional___ = 2
                 or ___conditional___ = 3
                 or ___conditional___ = 4
                 or ___conditional___ = 5
                 or ___conditional___ = 6
                 or ___conditional___ = 7
                 or ___conditional___ = 8
                 or ___conditional___ = 11
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
                 or ___conditional___ = 27
                 or ___conditional___ = 28
                 or ___conditional___ = 29
                 or ___conditional___ = 30
                 or ___conditional___ = 31
                 or ___conditional___ = 41
                 or ___conditional___ = 44
                 or ___conditional___ = 46
                 or ___conditional___ = 59 then do
                    exit = 1;end else 
                 if ___conditional___ = 33
                 or ___conditional___ = 35
                 or ___conditional___ = 36
                 or ___conditional___ = 37
                 or ___conditional___ = 38
                 or ___conditional___ = 42
                 or ___conditional___ = 43
                 or ___conditional___ = 47
                 or ___conditional___ = 58
                 or ___conditional___ = 60
                 or ___conditional___ = 61
                 or ___conditional___ = 62
                 or ___conditional___ = 63
                 or ___conditional___ = 64 then do
                    exit = 3;end else 
                 do
                
              end
            end end 
          end else do
            local ___conditional___=(switcher);
            do
               if ___conditional___ = 27
               or ___conditional___ = 29 then do
                  exit = 3;end else 
               if ___conditional___ = 30 then do
                  exit = 2;end else 
               if ___conditional___ = 26
               or ___conditional___ = 28
               or ___conditional___ = 31 then do
                  exit = 1;end else 
               do end end end end
              else do
                exit = 2;
                end end
                
            end
          end end 
        end else do
          exit = c >= 127 ? (
              c >= 192 ? 2 : 1
            ) : (
              c ~= 125 ? 3 : 1
            );
        end end 
        local ___conditional___=(exit);
        do
           if ___conditional___ = 1 then do
              Stream.junk(strm__);
              return keyword_or_error(c);end end end 
           if ___conditional___ = 2 then do
              Stream.junk(strm__);
              reset_buffer(--[ () ]--0);
              store(c);
              var strm__$3 = strm__;
              while(true) do
                var match$4 = Stream.peek(strm__$3);
                if (match$4 ~= undefined) then do
                  var c$3 = match$4;
                  if (c$3 >= 91) then do
                    var switcher$1 = c$3 - 95 | 0;
                    if (switcher$1 > 27 or switcher$1 < 0) then do
                      if (switcher$1 < 97) then do
                        return ident_or_keyword(get_string(--[ () ]--0));
                      end
                       end 
                    end else if (switcher$1 == 1) then do
                      return ident_or_keyword(get_string(--[ () ]--0));
                    end
                     end  end 
                  end else if (c$3 >= 48) then do
                    if (!(c$3 > 64 or c$3 < 58)) then do
                      return ident_or_keyword(get_string(--[ () ]--0));
                    end
                     end 
                  end else if (c$3 ~= 39) then do
                    return ident_or_keyword(get_string(--[ () ]--0));
                  end
                   end  end  end 
                  Stream.junk(strm__$3);
                  store(c$3);
                  continue ;
                end else do
                  return ident_or_keyword(get_string(--[ () ]--0));
                end end 
              end;end end end 
           if ___conditional___ = 3 then do
              Stream.junk(strm__);
              reset_buffer(--[ () ]--0);
              store(c);
              return ident2(strm__);end end end 
           if ___conditional___ = 4 then do
              Stream.junk(strm__);
              reset_buffer(--[ () ]--0);
              store(c);
              return number(strm__);end end end 
           do
          
        end
      end else do
        return ;
      end end 
    end;
  end;
  var ident2 = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        var c = match;
        if (c >= 94) then do
          var switcher = c - 95 | 0;
          if (switcher > 30 or switcher < 0) then do
            if (switcher >= 32) then do
              return ident_or_keyword(get_string(--[ () ]--0));
            end
             end 
          end else if (switcher ~= 29) then do
            return ident_or_keyword(get_string(--[ () ]--0));
          end
           end  end 
        end else if (c >= 65) then do
          if (c ~= 92) then do
            return ident_or_keyword(get_string(--[ () ]--0));
          end
           end 
        end else if (c >= 33) then do
          local ___conditional___=(c - 33 | 0);
          do
             if ___conditional___ = 1
             or ___conditional___ = 6
             or ___conditional___ = 7
             or ___conditional___ = 8
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
             or ___conditional___ = 26 then do
                return ident_or_keyword(get_string(--[ () ]--0));end end end 
             if ___conditional___ = 0
             or ___conditional___ = 2
             or ___conditional___ = 3
             or ___conditional___ = 4
             or ___conditional___ = 5
             or ___conditional___ = 9
             or ___conditional___ = 10
             or ___conditional___ = 12
             or ___conditional___ = 14
             or ___conditional___ = 25
             or ___conditional___ = 27
             or ___conditional___ = 28
             or ___conditional___ = 29
             or ___conditional___ = 30
             or ___conditional___ = 31
             do
            
          end
        end else do
          return ident_or_keyword(get_string(--[ () ]--0));
        end end  end  end 
        Stream.junk(strm__);
        store(c);
        continue ;
      end else do
        return ident_or_keyword(get_string(--[ () ]--0));
      end end 
    end;
  end;
  var number = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        var c = match;
        if (c >= 58) then do
          if (!(c ~= 69 and c ~= 101)) then do
            Stream.junk(strm__);
            store(--[ "E" ]--69);
            return exponent_part(strm__);
          end
           end 
        end else if (c ~= 46) then do
          if (c >= 48) then do
            Stream.junk(strm__);
            store(c);
            continue ;
          end
           end 
        end else do
          Stream.junk(strm__);
          store(--[ "." ]--46);
          var strm__$1 = strm__;
          while(true) do
            var match$1 = Stream.peek(strm__$1);
            if (match$1 ~= undefined) then do
              var c$1 = match$1;
              var switcher = c$1 - 69 | 0;
              if (switcher > 32 or switcher < 0) then do
                if ((switcher + 21 >>> 0) <= 9) then do
                  Stream.junk(strm__$1);
                  store(c$1);
                  continue ;
                end
                 end 
              end else if (switcher > 31 or switcher < 1) then do
                Stream.junk(strm__$1);
                store(--[ "E" ]--69);
                return exponent_part(strm__$1);
              end
               end  end 
            end
             end 
            return --[ Float ]--Block.__(3, [Caml_format.caml_float_of_string(get_string(--[ () ]--0))]);
          end;
        end end  end 
      end
       end 
      return --[ Int ]--Block.__(2, [Caml_format.caml_int_of_string(get_string(--[ () ]--0))]);
    end;
  end;
  var exponent_part = function (strm__) do
    var match = Stream.peek(strm__);
    if (match ~= undefined) then do
      var c = match;
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
  end;
  var end_exponent_part = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        var c = match;
        if (c > 57 or c < 48) then do
          return --[ Float ]--Block.__(3, [Caml_format.caml_float_of_string(get_string(--[ () ]--0))]);
        end else do
          Stream.junk(strm__);
          store(c);
          continue ;
        end end 
      end else do
        return --[ Float ]--Block.__(3, [Caml_format.caml_float_of_string(get_string(--[ () ]--0))]);
      end end 
    end;
  end;
  var string = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        var c = match;
        Stream.junk(strm__);
        if (c ~= 34) then do
          if (c ~= 92) then do
            store(c);
            continue ;
          end else do
            var c$1;
            try do
              c$1 = $$escape(strm__);
            end
            catch (exn)do
              if (exn == Stream.Failure) then do
                throw [
                      Stream.$$Error,
                      ""
                    ];
              end
               end 
              throw exn;
            end
            store(c$1);
            continue ;
          end end 
        end else do
          return get_string(--[ () ]--0);
        end end 
      end else do
        throw Stream.Failure;
      end end 
    end;
  end;
  var $$char = function (strm__) do
    var match = Stream.peek(strm__);
    if (match ~= undefined) then do
      var c = match;
      Stream.junk(strm__);
      if (c ~= 92) then do
        return c;
      end else do
        try do
          return $$escape(strm__);
        end
        catch (exn)do
          if (exn == Stream.Failure) then do
            throw [
                  Stream.$$Error,
                  ""
                ];
          end
           end 
          throw exn;
        end
      end end 
    end else do
      throw Stream.Failure;
    end end 
  end;
  var $$escape = function (strm__) do
    var match = Stream.peek(strm__);
    if (match ~= undefined) then do
      var c1 = match;
      if (c1 >= 58) then do
        local ___conditional___=(c1);
        do
           if ___conditional___ = 110 then do
              Stream.junk(strm__);
              return --[ "\n" ]--10;end end end 
           if ___conditional___ = 114 then do
              Stream.junk(strm__);
              return --[ "\r" ]--13;end end end 
           if ___conditional___ = 111
           or ___conditional___ = 112
           or ___conditional___ = 113
           or ___conditional___ = 115 then do
              Stream.junk(strm__);
              return c1;end end end 
           if ___conditional___ = 116 then do
              Stream.junk(strm__);
              return --[ "\t" ]--9;end end end 
           do
          else do
            Stream.junk(strm__);
            return c1;
            end end
            
        end
      end else do
        Stream.junk(strm__);
        if (c1 >= 48) then do
          var match$1 = Stream.peek(strm__);
          if (match$1 ~= undefined) then do
            var c2 = match$1;
            if (c2 > 57 or c2 < 48) then do
              throw [
                    Stream.$$Error,
                    ""
                  ];
            end
             end 
            Stream.junk(strm__);
            var match$2 = Stream.peek(strm__);
            if (match$2 ~= undefined) then do
              var c3 = match$2;
              if (c3 > 57 or c3 < 48) then do
                throw [
                      Stream.$$Error,
                      ""
                    ];
              end
               end 
              Stream.junk(strm__);
              return Char.chr((Caml_int32.imul(c1 - 48 | 0, 100) + Caml_int32.imul(c2 - 48 | 0, 10) | 0) + (c3 - 48 | 0) | 0);
            end else do
              throw [
                    Stream.$$Error,
                    ""
                  ];
            end end 
          end else do
            throw [
                  Stream.$$Error,
                  ""
                ];
          end end 
        end else do
          return c1;
        end end 
      end end 
    end else do
      throw Stream.Failure;
    end end 
  end;
  var comment = function (strm__) do
    while(true) do
      var match = Stream.peek(strm__);
      if (match ~= undefined) then do
        local ___conditional___=(match);
        do
           if ___conditional___ = 40 then do
              Stream.junk(strm__);
              var strm__$1 = strm__;
              var match$1 = Stream.peek(strm__$1);
              if (match$1 ~= undefined) then do
                if (match$1 ~= 42) then do
                  Stream.junk(strm__$1);
                  return comment(strm__$1);
                end else do
                  Stream.junk(strm__$1);
                  comment(strm__$1);
                  return comment(strm__$1);
                end end 
              end else do
                throw Stream.Failure;
              end end end end end 
           if ___conditional___ = 41 then do
              Stream.junk(strm__);
              continue ;end end end 
           if ___conditional___ = 42 then do
              Stream.junk(strm__);
              var strm__$2 = strm__;
              while(true) do
                var match$2 = Stream.peek(strm__$2);
                if (match$2 ~= undefined) then do
                  var match$3 = match$2;
                  Stream.junk(strm__$2);
                  if (match$3 ~= 41) then do
                    if (match$3 ~= 42) then do
                      return comment(strm__$2);
                    end else do
                      continue ;
                    end end 
                  end else do
                    return --[ () ]--0;
                  end end 
                end else do
                  throw Stream.Failure;
                end end 
              end;end end end 
           do
          else do
            Stream.junk(strm__);
            continue ;
            end end
            
        end
      end else do
        throw Stream.Failure;
      end end 
    end;
  end;
  return (function (input) do
      return Stream.from((function (_count) do
                    return next_token(input);
                  end));
    end);
end

exports.make_lexer = make_lexer;
--[ No side effect ]--
