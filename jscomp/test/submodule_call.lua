console = {log = print};

Curry = require "../../lib/js/curry";
Submodule = require "./submodule";

a0 = Submodule.A0.a0(1, 2);

a1 = Curry._2(Submodule.A0.A1.a1, 1, 2);

a2 = Curry._2(Submodule.A0.A1.A2.a2, 1, 2);

a3 = Curry._2(Submodule.A0.A1.A2.A3.a3, 1, 2);

a4 = Curry._2(Submodule.A0.A1.A2.A3.A4.a4, 1, 2);

exports = {}
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.a3 = a3;
exports.a4 = a4;
--[[ a0 Not a pure module ]]