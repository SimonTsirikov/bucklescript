'use strict';

$$Array = require("./array.js");
Curry = require("./curry.js");
Lexing = require("./lexing.js");
Caml_obj = require("./caml_obj.js");
Caml_array = require("./caml_array.js");
Caml_parser = require("./caml_parser.js");
Caml_exceptions = require("./caml_exceptions.js");
Caml_js_exceptions = require("./caml_js_exceptions.js");

YYexit = Caml_exceptions.create("Parsing.YYexit");

Parse_error = Caml_exceptions.create("Parsing.Parse_error");

env = do
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
  oldsize = env.stacksize;
  newsize = (oldsize << 1);
  new_s = Caml_array.caml_make_vect(newsize, 0);
  new_v = Caml_array.caml_make_vect(newsize, --[ () ]--0);
  new_start = Caml_array.caml_make_vect(newsize, Lexing.dummy_pos);
  new_end = Caml_array.caml_make_vect(newsize, Lexing.dummy_pos);
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

current_lookahead_fun = do
  contents: (function (param) do
      return false;
    end)
end;

function yyparse(tables, start, lexer, lexbuf) do
  init_asp = env.asp;
  init_sp = env.sp;
  init_stackbase = env.stackbase;
  init_state = env.state;
  init_curr_char = env.curr_char;
  init_lval = env.lval;
  init_errflag = env.errflag;
  env.stackbase = env.sp + 1 | 0;
  env.curr_char = start;
  env.symb_end = lexbuf.lex_curr_p;
  try do
    _cmd = --[ Start ]--0;
    _arg = --[ () ]--0;
    while(true) do
      arg = _arg;
      cmd = _cmd;
      match = Caml_parser.caml_parse_engine(tables, env, cmd, arg);
      local ___conditional___=(match);
      do
         if ___conditional___ = 0--[ Read_token ]-- then do
            t = Curry._1(lexer, lexbuf);
            env.symb_start = lexbuf.lex_start_p;
            env.symb_end = lexbuf.lex_curr_p;
            _arg = t;
            _cmd = --[ Token_read ]--1;
            continue ;end end end 
         if ___conditional___ = 1--[ Raise_parse_error ]-- then do
            throw Parse_error;end end end 
         if ___conditional___ = 2--[ Grow_stacks_1 ]-- then do
            grow_stacks(--[ () ]--0);
            _arg = --[ () ]--0;
            _cmd = --[ Stacks_grown_1 ]--2;
            continue ;end end end 
         if ___conditional___ = 3--[ Grow_stacks_2 ]-- then do
            grow_stacks(--[ () ]--0);
            _arg = --[ () ]--0;
            _cmd = --[ Stacks_grown_2 ]--3;
            continue ;end end end 
         if ___conditional___ = 4--[ Compute_semantic_action ]-- then do
            match$1;
            try do
              match$1 = --[ tuple ]--[
                --[ Semantic_action_computed ]--4,
                Curry._1(Caml_array.caml_array_get(tables.actions, env.rule_number), env)
              ];
            end
            catch (exn)do
              if (exn == Parse_error) then do
                match$1 = --[ tuple ]--[
                  --[ Error_detected ]--5,
                  --[ () ]--0
                ];
              end else do
                throw exn;
              end end 
            end
            _arg = match$1[1];
            _cmd = match$1[0];
            continue ;end end end 
         if ___conditional___ = 5--[ Call_error_function ]-- then do
            Curry._1(tables.error_function, "syntax error");
            _arg = --[ () ]--0;
            _cmd = --[ Error_detected ]--5;
            continue ;end end end 
         do
        
      end
    end;
  end
  catch (raw_exn)do
    exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn);
    curr_char = env.curr_char;
    env.asp = init_asp;
    env.sp = init_sp;
    env.stackbase = init_stackbase;
    env.state = init_state;
    env.curr_char = init_curr_char;
    env.lval = init_lval;
    env.errflag = init_errflag;
    if (exn$1[0] == YYexit) then do
      return exn$1[1];
    end else do
      current_lookahead_fun.contents = (function (tok) do
          if (typeof tok ~= "number") then do
            return Caml_array.caml_array_get(tables.transl_block, tok.tag | 0) == curr_char;
          end else do
            return Caml_array.caml_array_get(tables.transl_const, tok) == curr_char;
          end end 
        end);
      throw exn$1;
    end end 
  end
end

function peek_val(env, n) do
  return Caml_array.caml_array_get(env.v_stack, env.asp - n | 0);
end

function symbol_start_pos(param) do
  _i = env.rule_len;
  while(true) do
    i = _i;
    if (i <= 0) then do
      return Caml_array.caml_array_get(env.symb_end_stack, env.asp);
    end else do
      st = Caml_array.caml_array_get(env.symb_start_stack, (env.asp - i | 0) + 1 | 0);
      en = Caml_array.caml_array_get(env.symb_end_stack, (env.asp - i | 0) + 1 | 0);
      if (Caml_obj.caml_notequal(st, en)) then do
        return st;
      end else do
        _i = i - 1 | 0;
        continue ;
      end end 
    end end 
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

set_trace = Caml_parser.caml_set_parser_trace;

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
