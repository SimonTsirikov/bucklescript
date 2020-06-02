console.log = print;

Curry = require "../../lib/js/curry";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function peek_queue(param) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "format_regression.ml",
      10,
      19
    }
  })
end end

function int_of_size(param) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "format_regression.ml",
      11,
      20
    }
  })
end end

function take_queue(param) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "format_regression.ml",
      12,
      19
    }
  })
end end

function format_pp_token(param, param_1) do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "format_regression.ml",
      13,
      26
    }
  })
end end

function advance_loop(state) do
  while(true) do
    match = peek_queue(state.pp_queue);
    size = match.elem_size;
    size_1 = int_of_size(size);
    if (size_1 < 0 and (state.pp_right_total - state.pp_left_total | 0) < state.pp_space_left) then do
      return 0;
    end else do
      take_queue(state.pp_queue);
      Curry._1(format_pp_token(state, size_1 < 0 and 1000000010 or size_1), match.token);
      state.pp_left_total = match.length + state.pp_left_total | 0;
      ::continue:: ;
    end end 
  end;
end end

pp_infinity = 1000000010;

exports.peek_queue = peek_queue;
exports.int_of_size = int_of_size;
exports.take_queue = take_queue;
exports.format_pp_token = format_pp_token;
exports.pp_infinity = pp_infinity;
exports.advance_loop = advance_loop;
--[[ No side effect ]]
