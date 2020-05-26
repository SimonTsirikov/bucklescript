'use strict';

Bytes = require("./bytes.js");
Curry = require("./curry.js");
Caml_array = require("./caml_array.js");
Caml_bytes = require("./caml_bytes.js");
Caml_lexer = require("./caml_lexer.js");
Pervasives = require("./pervasives.js");
Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function engine(tbl, state, buf) do
  result = Caml_lexer.caml_lex_engine(tbl, state, buf);
  if (result >= 0) then do
    buf.lex_start_p = buf.lex_curr_p;
    init = buf.lex_curr_p;
    buf.lex_curr_p = do
      pos_fname: init.pos_fname,
      pos_lnum: init.pos_lnum,
      pos_bol: init.pos_bol,
      pos_cnum: buf.lex_abs_pos + buf.lex_curr_pos | 0
    end;
  end
   end 
  return result;
end end

function new_engine(tbl, state, buf) do
  result = Caml_lexer.caml_new_lex_engine(tbl, state, buf);
  if (result >= 0) then do
    buf.lex_start_p = buf.lex_curr_p;
    init = buf.lex_curr_p;
    buf.lex_curr_p = do
      pos_fname: init.pos_fname,
      pos_lnum: init.pos_lnum,
      pos_bol: init.pos_bol,
      pos_cnum: buf.lex_abs_pos + buf.lex_curr_pos | 0
    end;
  end
   end 
  return result;
end end

zero_pos = do
  pos_fname: "",
  pos_lnum: 1,
  pos_bol: 0,
  pos_cnum: 0
end;

function from_function(f) do
  partial_arg = Caml_bytes.caml_create_bytes(512);
  return do
          refill_buff: (function (param) do
              read_fun = f;
              aux_buffer = partial_arg;
              lexbuf = param;
              read = Curry._2(read_fun, aux_buffer, #aux_buffer);
              n = read > 0 and read or (lexbuf.lex_eof_reached = true, 0);
              if ((lexbuf.lex_buffer_len + n | 0) > #lexbuf.lex_buffer) then do
                if (((lexbuf.lex_buffer_len - lexbuf.lex_start_pos | 0) + n | 0) <= #lexbuf.lex_buffer) then do
                  Bytes.blit(lexbuf.lex_buffer, lexbuf.lex_start_pos, lexbuf.lex_buffer, 0, lexbuf.lex_buffer_len - lexbuf.lex_start_pos | 0);
                end else do
                  newlen = (#lexbuf.lex_buffer << 1);
                  if (((lexbuf.lex_buffer_len - lexbuf.lex_start_pos | 0) + n | 0) > newlen) then do
                    throw [
                          Caml_builtin_exceptions.failure,
                          "Lexing.lex_refill: cannot grow buffer"
                        ];
                  end
                   end 
                  newbuf = Caml_bytes.caml_create_bytes(newlen);
                  Bytes.blit(lexbuf.lex_buffer, lexbuf.lex_start_pos, newbuf, 0, lexbuf.lex_buffer_len - lexbuf.lex_start_pos | 0);
                  lexbuf.lex_buffer = newbuf;
                end end 
                s = lexbuf.lex_start_pos;
                lexbuf.lex_abs_pos = lexbuf.lex_abs_pos + s | 0;
                lexbuf.lex_curr_pos = lexbuf.lex_curr_pos - s | 0;
                lexbuf.lex_start_pos = 0;
                lexbuf.lex_last_pos = lexbuf.lex_last_pos - s | 0;
                lexbuf.lex_buffer_len = lexbuf.lex_buffer_len - s | 0;
                t = lexbuf.lex_mem;
                for i = 0 , #t - 1 | 0 , 1 do
                  v = Caml_array.caml_array_get(t, i);
                  if (v >= 0) then do
                    Caml_array.caml_array_set(t, i, v - s | 0);
                  end
                   end 
                end
              end
               end 
              Bytes.blit(aux_buffer, 0, lexbuf.lex_buffer, lexbuf.lex_buffer_len, n);
              lexbuf.lex_buffer_len = lexbuf.lex_buffer_len + n | 0;
              return --[[ () ]]0;
            end end),
          lex_buffer: Caml_bytes.caml_create_bytes(1024),
          lex_buffer_len: 0,
          lex_abs_pos: 0,
          lex_start_pos: 0,
          lex_curr_pos: 0,
          lex_last_pos: 0,
          lex_last_action: 0,
          lex_eof_reached: false,
          lex_mem: [],
          lex_start_p: zero_pos,
          lex_curr_p: zero_pos
        end;
end end

function from_channel(ic) do
  return from_function((function (buf, n) do
                return Pervasives.input(ic, buf, 0, n);
              end end));
end end

function from_string(s) do
  return do
          refill_buff: (function (lexbuf) do
              lexbuf.lex_eof_reached = true;
              return --[[ () ]]0;
            end end),
          lex_buffer: Bytes.of_string(s),
          lex_buffer_len: #s,
          lex_abs_pos: 0,
          lex_start_pos: 0,
          lex_curr_pos: 0,
          lex_last_pos: 0,
          lex_last_action: 0,
          lex_eof_reached: true,
          lex_mem: [],
          lex_start_p: zero_pos,
          lex_curr_p: zero_pos
        end;
end end

function lexeme(lexbuf) do
  len = lexbuf.lex_curr_pos - lexbuf.lex_start_pos | 0;
  return Bytes.sub_string(lexbuf.lex_buffer, lexbuf.lex_start_pos, len);
end end

function sub_lexeme(lexbuf, i1, i2) do
  len = i2 - i1 | 0;
  return Bytes.sub_string(lexbuf.lex_buffer, i1, len);
end end

function sub_lexeme_opt(lexbuf, i1, i2) do
  if (i1 >= 0) then do
    len = i2 - i1 | 0;
    return Bytes.sub_string(lexbuf.lex_buffer, i1, len);
  end
   end 
end end

function sub_lexeme_char(lexbuf, i) do
  return Caml_bytes.get(lexbuf.lex_buffer, i);
end end

function sub_lexeme_char_opt(lexbuf, i) do
  if (i >= 0) then do
    return Caml_bytes.get(lexbuf.lex_buffer, i);
  end
   end 
end end

function lexeme_char(lexbuf, i) do
  return Caml_bytes.get(lexbuf.lex_buffer, lexbuf.lex_start_pos + i | 0);
end end

function lexeme_start(lexbuf) do
  return lexbuf.lex_start_p.pos_cnum;
end end

function lexeme_end(lexbuf) do
  return lexbuf.lex_curr_p.pos_cnum;
end end

function lexeme_start_p(lexbuf) do
  return lexbuf.lex_start_p;
end end

function lexeme_end_p(lexbuf) do
  return lexbuf.lex_curr_p;
end end

function new_line(lexbuf) do
  lcp = lexbuf.lex_curr_p;
  lexbuf.lex_curr_p = do
    pos_fname: lcp.pos_fname,
    pos_lnum: lcp.pos_lnum + 1 | 0,
    pos_bol: lcp.pos_cnum,
    pos_cnum: lcp.pos_cnum
  end;
  return --[[ () ]]0;
end end

function flush_input(lb) do
  lb.lex_curr_pos = 0;
  lb.lex_abs_pos = 0;
  init = lb.lex_curr_p;
  lb.lex_curr_p = do
    pos_fname: init.pos_fname,
    pos_lnum: init.pos_lnum,
    pos_bol: init.pos_bol,
    pos_cnum: 0
  end;
  lb.lex_buffer_len = 0;
  return --[[ () ]]0;
end end

dummy_pos = do
  pos_fname: "",
  pos_lnum: 0,
  pos_bol: 0,
  pos_cnum: -1
end;

exports.dummy_pos = dummy_pos;
exports.from_channel = from_channel;
exports.from_string = from_string;
exports.from_function = from_function;
exports.lexeme = lexeme;
exports.lexeme_char = lexeme_char;
exports.lexeme_start = lexeme_start;
exports.lexeme_end = lexeme_end;
exports.lexeme_start_p = lexeme_start_p;
exports.lexeme_end_p = lexeme_end_p;
exports.new_line = new_line;
exports.flush_input = flush_input;
exports.sub_lexeme = sub_lexeme;
exports.sub_lexeme_opt = sub_lexeme_opt;
exports.sub_lexeme_char = sub_lexeme_char;
exports.sub_lexeme_char_opt = sub_lexeme_char_opt;
exports.engine = engine;
exports.new_engine = new_engine;
--[[ No side effect ]]
