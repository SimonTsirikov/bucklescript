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
              switch (switcher + 65 | 0) do
                case 9 :
                case 10 :
                case 12 :
                case 13 :
                case 26 :
                case 32 :
                    Stream.junk(strm__);
                    continue ;
                case 34 :
                    Stream.junk(strm__);
                    reset_buffer(--[ () ]--0);
                    return --[ String ]--Block.__(4, [string(strm__)]);
                case 39 :
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
                    end end 
                case 40 :
                    Stream.junk(strm__);
                    var strm__$1 = strm__;
                    var match$2 = Stream.peek(strm__$1);
                    if (match$2 == 42) then do
                      Stream.junk(strm__$1);
                      comment(strm__$1);
                      return next_token(strm__$1);
                    end else do
                      return keyword_or_error(--[ "(" ]--40);
                    end end 
                case 45 :
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
                    end end 
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
                    exit = 4;
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
                case 11 :
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
                case 27 :
                case 28 :
                case 29 :
                case 30 :
                case 31 :
                case 41 :
                case 44 :
                case 46 :
                case 59 :
                    exit = 1;
                    break;
                case 33 :
                case 35 :
                case 36 :
                case 37 :
                case 38 :
                case 42 :
                case 43 :
                case 47 :
                case 58 :
                case 60 :
                case 61 :
                case 62 :
                case 63 :
                case 64 :
                    exit = 3;
                    break;
                
              end
            end end 
          end else do
            switch (switcher) do
              case 27 :
              case 29 :
                  exit = 3;
                  break;
              case 30 :
                  exit = 2;
                  break;
              case 26 :
              case 28 :
              case 31 :
                  exit = 1;
                  break;
              default:
                exit = 2;
            end
          end end 
        end else do
          exit = c >= 127 ? (
              c >= 192 ? 2 : 1
            ) : (
              c ~= 125 ? 3 : 1
            );
        end end 
        switch (exit) do
          case 1 :
              Stream.junk(strm__);
              return keyword_or_error(c);
          case 2 :
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
              end;
          case 3 :
              Stream.junk(strm__);
              reset_buffer(--[ () ]--0);
              store(c);
              return ident2(strm__);
          case 4 :
              Stream.junk(strm__);
              reset_buffer(--[ () ]--0);
              store(c);
              return number(strm__);
          
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
          switch (c - 33 | 0) do
            case 1 :
            case 6 :
            case 7 :
            case 8 :
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
            case 26 :
                return ident_or_keyword(get_string(--[ () ]--0));
            case 0 :
            case 2 :
            case 3 :
            case 4 :
            case 5 :
            case 9 :
            case 10 :
            case 12 :
            case 14 :
            case 25 :
            case 27 :
            case 28 :
            case 29 :
            case 30 :
            case 31 :
                break;
            
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
        switch (c1) do
          case 110 :
              Stream.junk(strm__);
              return --[ "\n" ]--10;
          case 114 :
              Stream.junk(strm__);
              return --[ "\r" ]--13;
          case 111 :
          case 112 :
          case 113 :
          case 115 :
              Stream.junk(strm__);
              return c1;
          case 116 :
              Stream.junk(strm__);
              return --[ "\t" ]--9;
          default:
            Stream.junk(strm__);
            return c1;
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
        switch (match) do
          case 40 :
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
              end end 
          case 41 :
              Stream.junk(strm__);
              continue ;
          case 42 :
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
              end;
          default:
            Stream.junk(strm__);
            continue ;
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
