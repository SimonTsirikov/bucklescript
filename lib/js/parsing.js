'use strict';

var $$Array = require("./array.js");
var Curry = require("./curry.js");
var Lexing = require("./lexing.js");
var Caml_obj = require("./caml_obj.js");
var Caml_array = require("./caml_array.js");
var Caml_parser = require("./caml_parser.js");
var Caml_exceptions = require("./caml_exceptions.js");
var Caml_js_exceptions = require("./caml_js_exceptions.js");

var YYexit = Caml_exceptions.create("Parsing.YYexit");

var Parse_error = Caml_exceptions.create("Parsing.Parse_error");

var env = do
  s_stack: Caml_array.caml_make_vect(100, 0),
  v_stack: Caml_array.caml_make_vect(100, --[ () ]--0),
  symb_start_stack: Caml_array.caml_make_vect(100, Lexing.dummy_pos),
  symb_end_stack: Caml_array.caml_make_vect(100, Lexing.dummy_pos),
  stacksize: 100,
  stackbase: 0,
  curr_char: 0,
  lval: --[ () ]--0,
  symb_start: Lexing.dummy_pos,
  symb_end: Lexing.dummy_pos,
  asp: 0,
  rule_len: 0,
  rule_number: 0,
  sp: 0,
  state: 0,
  errflag: 0
end;

function grow_stacks(param) do
  var oldsize = env.stacksize;
  var newsize = (oldsize << 1);
  var new_s = Caml_array.caml_make_vect(newsize, 0);
  var new_v = Caml_array.caml_make_vect(newsize, --[ () ]--0);
  var new_start = Caml_array.caml_make_vect(newsize, Lexing.dummy_pos);
  var new_end = Caml_array.caml_make_vect(newsize, Lexing.dummy_pos);
  $$Array.blit(env.s_stack, 0, new_s, 0, oldsize);
  env.s_stack = new_s;
  $$Array.blit(env.v_stack, 0, new_v, 0, oldsize);
  env.v_stack = new_v;
  $$Array.blit(env.symb_start_stack, 0, new_start, 0, oldsize);
  env.symb_start_stack = new_start;
  $$Array.blit(env.symb_end_stack, 0, new_end, 0, oldsize);
  env.symb_end_stack = new_end;
  env.stacksize = newsize;
  return --[ () ]--0;
end

function clear_parser(param) do
  $$Array.fill(env.v_stack, 0, env.stacksize, --[ () ]--0);
  env.lval = --[ () ]--0;
  return --[ () ]--0;
end

var current_lookahead_fun = do
  contents: (function (param) do
      return false;
    end)
end;

function yyparse(tables, start, lexer, lexbuf) do
  var init_asp = env.asp;
  var init_sp = env.sp;
  var init_stackbase = env.stackbase;
  var init_state = env.state;
  var init_curr_char = env.curr_char;
  var init_lval = env.lval;
  var init_errflag = env.errflag;
  env.stackbase = env.sp + 1 | 0;
  env.curr_char = start;
  env.symb_end = lexbuf.lex_curr_p;
  try do
    var _cmd = --[ Start ]--0;
    var _arg = --[ () ]--0;
    while(true) do
      var arg = _arg;
      var cmd = _cmd;
      var match = Caml_parser.caml_parse_engine(tables, env, cmd, arg);
      switch (match) do
        case --[ Read_token ]--0 :
            var t = Curry._1(lexer, lexbuf);
            env.symb_start = lexbuf.lex_start_p;
            env.symb_end = lexbuf.lex_curr_p;
            _arg = t;
            _cmd = --[ Token_read ]--1;
            continue ;
        case --[ Raise_parse_error ]--1 :
            throw Parse_error;
        case --[ Grow_stacks_1 ]--2 :
            grow_stacks(--[ () ]--0);
            _arg = --[ () ]--0;
            _cmd = --[ Stacks_grown_1 ]--2;
            continue ;
        case --[ Grow_stacks_2 ]--3 :
            grow_stacks(--[ () ]--0);
            _arg = --[ () ]--0;
            _cmd = --[ Stacks_grown_2 ]--3;
            continue ;
        case --[ Compute_semantic_action ]--4 :
            var match$1;
            try do
              match$1 = --[ tuple ]--[
                --[ Semantic_action_computed ]--4,
                Curry._1(Caml_array.caml_array_get(tables.actions, env.rule_number), env)
              ];
            end
            catch (exn)do
              if (exn == Parse_error) do
                match$1 = --[ tuple ]--[
                  --[ Error_detected ]--5,
                  --[ () ]--0
                ];
              end else do
                throw exn;
              end
            end
            _arg = match$1[1];
            _cmd = match$1[0];
            continue ;
        case --[ Call_error_function ]--5 :
            Curry._1(tables.error_function, "syntax error");
            _arg = --[ () ]--0;
            _cmd = --[ Error_detected ]--5;
            continue ;
        
      end
    end;
  end
  catch (raw_exn)do
    var exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn);
    var curr_char = env.curr_char;
    env.asp = init_asp;
    env.sp = init_sp;
    env.stackbase = init_stackbase;
    env.state = init_state;
    env.curr_char = init_curr_char;
    env.lval = init_lval;
    env.errflag = init_errflag;
    if (exn$1[0] == YYexit) do
      return exn$1[1];
    end else do
      current_lookahead_fun.contents = (function (tok) do
          if (typeof tok ~= "number") do
            return Caml_array.caml_array_get(tables.transl_block, tok.tag | 0) == curr_char;
          end else do
            return Caml_array.caml_array_get(tables.transl_const, tok) == curr_char;
          end
        end);
      throw exn$1;
    end
  end
end

function peek_val(env, n) do
  return Caml_array.caml_array_get(env.v_stack, env.asp - n | 0);
end

function symbol_start_pos(param) do
  var _i = env.rule_len;
  while(true) do
    var i = _i;
    if (i <= 0) do
      return Caml_array.caml_array_get(env.symb_end_stack, env.asp);
    end else do
      var st = Caml_array.caml_array_get(env.symb_start_stack, (env.asp - i | 0) + 1 | 0);
      var en = Caml_array.caml_array_get(env.symb_end_stack, (env.asp - i | 0) + 1 | 0);
      if (Caml_obj.caml_notequal(st, en)) do
        return st;
      end else do
        _i = i - 1 | 0;
        continue ;
      end
    end
  end;
end

function symbol_end_pos(param) do
  return Caml_array.caml_array_get(env.symb_end_stack, env.asp);
end

function rhs_start_pos(n) do
  return Caml_array.caml_array_get(env.symb_start_stack, env.asp - (env.rule_len - n | 0) | 0);
end

function rhs_end_pos(n) do
  return Caml_array.caml_array_get(env.symb_end_stack, env.asp - (env.rule_len - n | 0) | 0);
end

function symbol_start(param) do
  return symbol_start_pos(--[ () ]--0).pos_cnum;
end

function symbol_end(param) do
  return symbol_end_pos(--[ () ]--0).pos_cnum;
end

function rhs_start(n) do
  return rhs_start_pos(n).pos_cnum;
end

function rhs_end(n) do
  return rhs_end_pos(n).pos_cnum;
end

function is_current_lookahead(tok) do
  return Curry._1(current_lookahead_fun.contents, tok);
end

function parse_error(param) do
  return --[ () ]--0;
end

var set_trace = Caml_parser.caml_set_parser_trace;

exports.symbol_start = symbol_start;
exports.symbol_end = symbol_end;
exports.rhs_start = rhs_start;
exports.rhs_end = rhs_end;
exports.symbol_start_pos = symbol_start_pos;
exports.symbol_end_pos = symbol_end_pos;
exports.rhs_start_pos = rhs_start_pos;
exports.rhs_end_pos = rhs_end_pos;
exports.clear_parser = clear_parser;
exports.Parse_error = Parse_error;
exports.set_trace = set_trace;
exports.YYexit = YYexit;
exports.yyparse = yyparse;
exports.peek_val = peek_val;
exports.is_current_lookahead = is_current_lookahead;
exports.parse_error = parse_error;
--[ No side effect ]--
