console = {log = print};

Mt = require "./mt";
For_loop_test = require "./for_loop_test";

Mt.from_pair_suites("for_loop_test", For_loop_test.suites);

exports = {}
--[[  Not a pure module ]]
