


out_of_memory = --[[ tuple ]]{
  "Out_of_memory",
  0
};

sys_error = --[[ tuple ]]{
  "Sys_error",
  -1
};

failure = --[[ tuple ]]{
  "Failure",
  -2
};

invalid_argument = --[[ tuple ]]{
  "Invalid_argument",
  -3
};

end_of_file = --[[ tuple ]]{
  "End_of_file",
  -4
};

division_by_zero = --[[ tuple ]]{
  "Division_by_zero",
  -5
};

not_found = --[[ tuple ]]{
  "Not_found",
  -6
};

match_failure = --[[ tuple ]]{
  "Match_failure",
  -7
};

stack_overflow = --[[ tuple ]]{
  "Stack_overflow",
  -8
};

sys_blocked_io = --[[ tuple ]]{
  "Sys_blocked_io",
  -9
};

assert_failure = --[[ tuple ]]{
  "Assert_failure",
  -10
};

undefined_recursive_module = --[[ tuple ]]{
  "Undefined_recursive_module",
  -11
};

out_of_memory.tag = 248;

sys_error.tag = 248;

failure.tag = 248;

invalid_argument.tag = 248;

end_of_file.tag = 248;

division_by_zero.tag = 248;

not_found.tag = 248;

match_failure.tag = 248;

stack_overflow.tag = 248;

sys_blocked_io.tag = 248;

assert_failure.tag = 248;

undefined_recursive_module.tag = 248;

export do
  out_of_memory ,
  sys_error ,
  failure ,
  invalid_argument ,
  end_of_file ,
  division_by_zero ,
  not_found ,
  match_failure ,
  stack_overflow ,
  sys_blocked_io ,
  assert_failure ,
  undefined_recursive_module ,
  
end
--[[  Not a pure module ]]
