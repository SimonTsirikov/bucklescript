'use strict';

var List = require("../../lib/js/list.js");
var Curry = require("../../lib/js/curry.js");

function from_pair_suites(name, suites) do
  console.log(--[ tuple ]--[
        name,
        "testing"
      ]);
  return List.iter((function (param) do
                var name = param[0];
                var match = Curry._1(param[1], --[ () ]--0);
                local ___conditional___=(match.tag | 0);
                do
                   if ___conditional___ = 0--[ Eq ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "eq?",
                            match[1]
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 1--[ Neq ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "neq?",
                            match[1]
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 2--[ StrictEq ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "strict_eq?",
                            match[1]
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 3--[ StrictNeq ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "strict_neq?",
                            match[1]
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 4--[ Ok ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "ok?"
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 5--[ Approx ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[0],
                            "~",
                            match[1]
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 6--[ ApproxThreshold ]-- then do
                      console.log(--[ tuple ]--[
                            name,
                            match[1],
                            "~",
                            match[2],
                            " (",
                            match[0],
                            ")"
                          ]);
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 7--[ ThrowAny ]-- then do
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 8--[ Fail ]-- then do
                      console.log("failed");
                      return --[ () ]--0;end end end 
                   if ___conditional___ = 9--[ FailWith ]-- then do
                      console.log("failed: " .. match[0]);
                      return --[ () ]--0;end end end 
                   do
                  
                end
              end), suites);
end

exports.from_pair_suites = from_pair_suites;
--[ No side effect ]--
