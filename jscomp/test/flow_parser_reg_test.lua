__console = {log = print};

Mt = require "..mt";
Fs = require "fs";
Sys = require "......lib.js.sys";
Char = require "......lib.js.char";
List = require "......lib.js.list";
Path = require "path";
__Array = require "......lib.js.array";
Block = require "......lib.js.block";
Curry = require "......lib.js.curry";
Queue = require "......lib.js.queue";
__Buffer = require "......lib.js.buffer";
Lexing = require "......lib.js.lexing";
Printf = require "......lib.js.printf";
__String = require "......lib.js.string";
Hashtbl = require "......lib.js.hashtbl";
Caml_obj = require "......lib.js.caml_obj";
Filename = require "......lib.js.filename";
Caml_array = require "......lib.js.caml_array";
Caml_bytes = require "......lib.js.caml_bytes";
Pervasives = require "......lib.js.pervasives";
Caml_format = require "......lib.js.caml_format";
Caml_module = require "......lib.js.caml_module";
Caml_option = require "......lib.js.caml_option";
Caml_primitive = require "......lib.js.caml_primitive";
Caml_exceptions = require "......lib.js.caml_exceptions";
Caml_js_exceptions = require "......lib.js.caml_js_exceptions";
Caml_builtin_exceptions = require "......lib.js.caml_builtin_exceptions";

none = {
  source = nil,
  start = {
    line = 0,
    column = 0,
    offset = 0
  },
  _end = {
    line = 0,
    column = 0,
    offset = 0
  }
};

function from_lb_p(source, start, _end) do
  return {
          source = source,
          start = {
            line = start.pos_lnum,
            column = start.pos_cnum - start.pos_bol | 0,
            offset = start.pos_cnum
          },
          _end = {
            line = _end.pos_lnum,
            column = Caml_primitive.caml_int_max(0, _end.pos_cnum - _end.pos_bol | 0),
            offset = _end.pos_cnum
          }
        };
end end

function from_lb(source, lb) do
  start = lb.lex_start_p;
  _end = lb.lex_curr_p;
  return from_lb_p(source, start, _end);
end end

function from_curr_lb(source, lb) do
  curr = lb.lex_curr_p;
  return from_lb_p(source, curr, curr);
end end

function btwn(loc1, loc2) do
  return {
          source = loc1.source,
          start = loc1.start,
          _end = loc2._end
        };
end end

function btwn_exclusive(loc1, loc2) do
  return {
          source = loc1.source,
          start = loc1._end,
          _end = loc2.start
        };
end end

function string_of_filename(param) do
  if (type(param) == "number") then do
    return "(global)";
  end else do
    return param[1];
  end end 
end end

function order_of_filename(param) do
  if (type(param) == "number") then do
    return 1;
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ LibFile ]] then do
          return 2; end end 
       if ___conditional___ == 1--[[ SourceFile ]]
       or ___conditional___ == 2--[[ JsonFile ]] then do
          return 3; end end 
      
    end
  end end 
end end

function source_cmp(a, b) do
  if (a ~= nil) then do
    if (b ~= nil) then do
      fn2 = b;
      fn1 = a;
      k = order_of_filename(fn1) - order_of_filename(fn2) | 0;
      if (k ~= 0) then do
        return k;
      end else do
        return Caml_primitive.caml_string_compare(string_of_filename(fn1), string_of_filename(fn2));
      end end 
    end else do
      return -1;
    end end 
  end else if (b ~= nil) then do
    return 1;
  end else do
    return 0;
  end end  end 
end end

function pos_cmp(a, b) do
  return Caml_obj.caml_compare(--[[ tuple ]]{
              a.line,
              a.column
            }, --[[ tuple ]]{
              b.line,
              b.column
            });
end end

function compare(loc1, loc2) do
  k = source_cmp(loc1.source, loc2.source);
  if (k == 0) then do
    k_1 = pos_cmp(loc1.start, loc2.start);
    if (k_1 == 0) then do
      return pos_cmp(loc1._end, loc2._end);
    end else do
      return k_1;
    end end 
  end else do
    return k;
  end end 
end end

__Error = Caml_exceptions.create("Flow_parser_reg_test.Parse_error.Error");

function error(param) do
  if (type(param) == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ == 0--[[ UnexpectedNumber ]] then do
          return "Unexpected number"; end end 
       if ___conditional___ == 1--[[ UnexpectedString ]] then do
          return "Unexpected string"; end end 
       if ___conditional___ == 2--[[ UnexpectedIdentifier ]] then do
          return "Unexpected identifier"; end end 
       if ___conditional___ == 3--[[ UnexpectedReserved ]] then do
          return "Unexpected reserved word"; end end 
       if ___conditional___ == 4--[[ UnexpectedEOS ]] then do
          return "Unexpected end of input"; end end 
       if ___conditional___ == 5--[[ UnexpectedTypeAlias ]] then do
          return "Type aliases are not allowed in untyped mode"; end end 
       if ___conditional___ == 6--[[ UnexpectedTypeAnnotation ]] then do
          return "Type annotations are not allowed in untyped mode"; end end 
       if ___conditional___ == 7--[[ UnexpectedTypeDeclaration ]] then do
          return "Type declarations are not allowed in untyped mode"; end end 
       if ___conditional___ == 8--[[ UnexpectedTypeImport ]] then do
          return "Type imports are not allowed in untyped mode"; end end 
       if ___conditional___ == 9--[[ UnexpectedTypeExport ]] then do
          return "Type exports are not allowed in untyped mode"; end end 
       if ___conditional___ == 10--[[ UnexpectedTypeInterface ]] then do
          return "Interfaces are not allowed in untyped mode"; end end 
       if ___conditional___ == 11--[[ NewlineAfterThrow ]] then do
          return "Illegal newline after throw"; end end 
       if ___conditional___ == 12--[[ InvalidRegExp ]] then do
          return "Invalid regular expression"; end end 
       if ___conditional___ == 13--[[ UnterminatedRegExp ]] then do
          return "Invalid regular expression: missing /"; end end 
       if ___conditional___ == 14--[[ InvalidLHSInAssignment ]] then do
          return "Invalid left-hand side in assignment"; end end 
       if ___conditional___ == 15--[[ InvalidLHSInExponentiation ]] then do
          return "Invalid left-hand side in exponentiation expression"; end end 
       if ___conditional___ == 16--[[ InvalidLHSInForIn ]] then do
          return "Invalid left-hand side in for-in"; end end 
       if ___conditional___ == 17--[[ InvalidLHSInForOf ]] then do
          return "Invalid left-hand side in for-of"; end end 
       if ___conditional___ == 18--[[ ExpectedPatternFoundExpression ]] then do
          return "Expected an object pattern, array pattern, or an identifier but found an expression instead"; end end 
       if ___conditional___ == 19--[[ MultipleDefaultsInSwitch ]] then do
          return "More than one default clause in switch statement"; end end 
       if ___conditional___ == 20--[[ NoCatchOrFinally ]] then do
          return "Missing catch or finally after try"; end end 
       if ___conditional___ == 21--[[ IllegalContinue ]] then do
          return "Illegal continue statement"; end end 
       if ___conditional___ == 22--[[ IllegalBreak ]] then do
          return "Illegal break statement"; end end 
       if ___conditional___ == 23--[[ IllegalReturn ]] then do
          return "Illegal return statement"; end end 
       if ___conditional___ == 24--[[ IllegalYield ]] then do
          return "Illegal yield expression"; end end 
       if ___conditional___ == 25--[[ StrictModeWith ]] then do
          return "Strict mode code may not include a with statement"; end end 
       if ___conditional___ == 26--[[ StrictCatchVariable ]] then do
          return "Catch variable may not be eval or arguments in strict mode"; end end 
       if ___conditional___ == 27--[[ StrictVarName ]] then do
          return "Variable name may not be eval or arguments in strict mode"; end end 
       if ___conditional___ == 28--[[ StrictParamName ]] then do
          return "Parameter name eval or arguments is not allowed in strict mode"; end end 
       if ___conditional___ == 29--[[ StrictParamDupe ]] then do
          return "Strict mode function may not have duplicate parameter names"; end end 
       if ___conditional___ == 30--[[ StrictFunctionName ]] then do
          return "Function name may not be eval or arguments in strict mode"; end end 
       if ___conditional___ == 31--[[ StrictOctalLiteral ]] then do
          return "Octal literals are not allowed in strict mode."; end end 
       if ___conditional___ == 32--[[ StrictDelete ]] then do
          return "Delete of an unqualified identifier in strict mode."; end end 
       if ___conditional___ == 33--[[ StrictDuplicateProperty ]] then do
          return "Duplicate data property in object literal not allowed in strict mode"; end end 
       if ___conditional___ == 34--[[ AccessorDataProperty ]] then do
          return "Object literal may not have data and accessor property with the same name"; end end 
       if ___conditional___ == 35--[[ AccessorGetSet ]] then do
          return "Object literal may not have multiple get/set accessors with the same name"; end end 
       if ___conditional___ == 36--[[ StrictLHSAssignment ]] then do
          return "Assignment to eval or arguments is not allowed in strict mode"; end end 
       if ___conditional___ == 37--[[ StrictLHSPostfix ]] then do
          return "Postfix increment/decrement may not have eval or arguments operand in strict mode"; end end 
       if ___conditional___ == 38--[[ StrictLHSPrefix ]] then do
          return "Prefix increment/decrement may not have eval or arguments operand in strict mode"; end end 
       if ___conditional___ == 39--[[ StrictReservedWord ]] then do
          return "Use of future reserved word in strict mode"; end end 
       if ___conditional___ == 40--[[ JSXAttributeValueEmptyExpression ]] then do
          return "JSX attributes must only be assigned a non-empty expression"; end end 
       if ___conditional___ == 41--[[ InvalidJSXAttributeValue ]] then do
          return "JSX value should be either an expression or a quoted JSX text"; end end 
       if ___conditional___ == 42--[[ NoUninitializedConst ]] then do
          return "Const must be initialized"; end end 
       if ___conditional___ == 43--[[ NoUninitializedDestructuring ]] then do
          return "Destructuring assignment must be initialized"; end end 
       if ___conditional___ == 44--[[ NewlineBeforeArrow ]] then do
          return "Illegal newline before arrow"; end end 
       if ___conditional___ == 45--[[ StrictFunctionStatement ]] then do
          return "In strict mode code, functions can only be declared at top level or immediately within another function."; end end 
       if ___conditional___ == 46--[[ AdjacentJSXElements ]] then do
          return "Unexpected token <. Remember, adjacent JSX elements must be wrapped in an enclosing parent tag"; end end 
       if ___conditional___ == 47--[[ ParameterAfterRestParameter ]] then do
          return "Rest parameter must be final parameter of an argument list"; end end 
       if ___conditional___ == 48--[[ AsyncGenerator ]] then do
          return "A function may not be both async and a generator"; end end 
       if ___conditional___ == 49--[[ DeclareAsync ]] then do
          return "async is an implementation detail and isn't necessary for your declare function statement. It is sufficient for your declare function to just have a Promise return type."; end end 
       if ___conditional___ == 50--[[ DeclareExportLet ]] then do
          return "`declare export let` is not supported. Use `declare export var` instead."; end end 
       if ___conditional___ == 51--[[ DeclareExportConst ]] then do
          return "`declare export const` is not supported. Use `declare export var` instead."; end end 
       if ___conditional___ == 52--[[ DeclareExportType ]] then do
          return "`declare export type` is not supported. Use `export type` instead."; end end 
       if ___conditional___ == 53--[[ DeclareExportInterface ]] then do
          return "`declare export interface` is not supported. Use `export interface` instead."; end end 
       if ___conditional___ == 54--[[ UnexpectedExportStarAs ]] then do
          return "`export * as` is an early-stage proposal and is not enabled by default. To enable support in the parser, use the `esproposal_export_star_as` option"; end end 
       if ___conditional___ == 55--[[ ExportNamelessClass ]] then do
          return "When exporting a class as a named export, you must specify a class name. Did you mean `export default class ...`?"; end end 
       if ___conditional___ == 56--[[ ExportNamelessFunction ]] then do
          return "When exporting a function as a named export, you must specify a function name. Did you mean `export default function ...`?"; end end 
       if ___conditional___ == 57--[[ UnsupportedDecorator ]] then do
          return "Found a decorator in an unsupported position."; end end 
       if ___conditional___ == 58--[[ MissingTypeParamDefault ]] then do
          return "Type parameter declaration needs a default, since a preceding type parameter declaration has a default."; end end 
       if ___conditional___ == 59--[[ WindowsFloatOfString ]] then do
          return "The Windows version of OCaml has a bug in how it parses hexidecimal numbers. It is fixed in OCaml 4.03.0. Until we can switch to 4.03.0, please avoid either hexidecimal notation or Windows."; end end 
       if ___conditional___ == 60--[[ DuplicateDeclareModuleExports ]] then do
          return "Duplicate `declare module.exports` statement!"; end end 
       if ___conditional___ == 61--[[ AmbiguousDeclareModuleKind ]] then do
          return "Found both `declare module.exports` and `declare export` in the same module. Modules can only have 1 since they are either an ES module xor they are a CommonJS module."; end end 
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Assertion ]] then do
          return "Unexpected parser state: " .. param[1]; end end 
       if ___conditional___ == 1--[[ UnexpectedToken ]] then do
          return "Unexpected token " .. param[1]; end end 
       if ___conditional___ == 2--[[ UnexpectedTokenWithSuggestion ]] then do
          return Curry._2(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Unexpected token `",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ String_literal ]]Block.__(11, {
                                      "`. Did you mean `",
                                      --[[ String ]]Block.__(2, {
                                          --[[ No_padding ]]0,
                                          --[[ String_literal ]]Block.__(11, {
                                              "`?",
                                              --[[ End_of_format ]]0
                                            })
                                        })
                                    })
                                })
                            }),
                          "Unexpected token `%s`. Did you mean `%s`?"
                        }), param[1], param[2]); end end 
       if ___conditional___ == 3--[[ InvalidRegExpFlags ]] then do
          return "Invalid flags supplied to RegExp constructor '" .. (param[1] .. "'"); end end 
       if ___conditional___ == 4--[[ UnknownLabel ]] then do
          return "Undefined label '" .. (param[1] .. "'"); end end 
       if ___conditional___ == 5--[[ Redeclaration ]] then do
          return param[1] .. (" '" .. (param[2] .. "' has already been declared")); end end 
       if ___conditional___ == 6--[[ ExpectedJSXClosingTag ]] then do
          return "Expected corresponding JSX closing tag for " .. param[1]; end end 
       if ___conditional___ == 7--[[ DuplicateExport ]] then do
          return Curry._1(Printf.sprintf(--[[ Format ]]{
                          --[[ String_literal ]]Block.__(11, {
                              "Duplicate export for `",
                              --[[ String ]]Block.__(2, {
                                  --[[ No_padding ]]0,
                                  --[[ Char_literal ]]Block.__(12, {
                                      --[[ "`" ]]96,
                                      --[[ End_of_format ]]0
                                    })
                                })
                            }),
                          "Duplicate export for `%s`"
                        }), param[1]); end end 
      
    end
  end end 
end end

Literal = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      44,
      6
    }, --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "RegExp"
          }}}));

Type = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      191,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Param"
                  }}}),
            "Function"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Indexer"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "CallProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Identifier"
                  }}}),
            "Generic"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "StringLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "NumberLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "BooleanLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                            --[[ Module ]]Block.__(0, {{}}),
                            "Variance"
                          }}}),
                    "TypeParam"
                  }}}),
            "ParameterDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ParameterInstantiation"
          }
        }}));

Statement = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      493,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Block"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "If"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Labeled"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Break"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Continue"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "With"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TypeAlias"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Case"
                  }}}),
            "Switch"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Return"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Throw"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "CatchClause"
                  }}}),
            "Try"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Declarator"
                  }}}),
            "VariableDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "While"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DoWhile"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "For"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ForIn"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ForOf"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Let"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Interface"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareVariable"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareFunction"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareModule"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Specifier"
                  }}}),
            "ExportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareExportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "NamedSpecifier"
                  }}}),
            "ImportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Expression"
          }
        }}));

Expression = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      758,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "SpreadElement"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Array"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Element"
                  }}}),
            "TemplateLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TaggedTemplate"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Sequence"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Unary"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Binary"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Assignment"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Update"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Logical"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Conditional"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "New"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Call"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Member"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Yield"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Block"
                  }}}),
            "Comprehension"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Generator"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Let"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TypeCast"
          }
        }}));

JSX = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      861,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Identifier"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "NamespacedName"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ExpressionContainer"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Text"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Attribute"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "SpreadAttribute"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "MemberExpression"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Opening"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Closing"
          }
        }}));

Pattern = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      919,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadElement"
                  }}}),
            "Array"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Assignment"
          }
        }}));

Class = Caml_module.init_mod(--[[ tuple ]]{
      "spider_monkey_ast.ml",
      978,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Method"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Property"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Implements"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Body"
          }
        }}));

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{--[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "RegExp"
          }}}), Literal, Literal);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Param"
                  }}}),
            "Function"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Indexer"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "CallProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Identifier"
                  }}}),
            "Generic"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "StringLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "NumberLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "BooleanLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                            --[[ Module ]]Block.__(0, {{}}),
                            "Variance"
                          }}}),
                    "TypeParam"
                  }}}),
            "ParameterDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ParameterInstantiation"
          }
        }}), Type, Type);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Block"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "If"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Labeled"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Break"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Continue"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "With"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TypeAlias"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Case"
                  }}}),
            "Switch"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Return"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Throw"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "CatchClause"
                  }}}),
            "Try"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Declarator"
                  }}}),
            "VariableDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "While"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DoWhile"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "For"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ForIn"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ForOf"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Let"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Interface"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareVariable"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareFunction"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareModule"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Specifier"
                  }}}),
            "ExportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "DeclareExportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "NamedSpecifier"
                  }}}),
            "ImportDeclaration"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Expression"
          }
        }}), Statement, Statement);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "SpreadElement"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Array"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Element"
                  }}}),
            "TemplateLiteral"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TaggedTemplate"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Sequence"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Unary"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Binary"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Assignment"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Update"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Logical"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Conditional"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "New"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Call"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Member"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Yield"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Block"
                  }}}),
            "Comprehension"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Generator"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Let"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "TypeCast"
          }
        }}), Expression, Expression);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Identifier"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "NamespacedName"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "ExpressionContainer"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Text"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Attribute"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "SpreadAttribute"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "MemberExpression"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Opening"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Closing"
          }
        }}), JSX, JSX);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "Property"
                  },
                  --[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadProperty"
                  }
                }}),
            "Object"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{--[[ tuple ]]{
                    --[[ Module ]]Block.__(0, {{}}),
                    "SpreadElement"
                  }}}),
            "Array"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Assignment"
          }
        }}), Pattern, Pattern);

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Method"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Property"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Implements"
          },
          --[[ tuple ]]{
            --[[ Module ]]Block.__(0, {{}}),
            "Body"
          }
        }}), Class, Class);

function token_to_string(param) do
  if (type(param) == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
          return "T_IDENTIFIER"; end end 
       if ___conditional___ == 1--[[ T_LCURLY ]] then do
          return "T_LCURLY"; end end 
       if ___conditional___ == 2--[[ T_RCURLY ]] then do
          return "T_RCURLY"; end end 
       if ___conditional___ == 3--[[ T_LPAREN ]] then do
          return "T_LPAREN"; end end 
       if ___conditional___ == 4--[[ T_RPAREN ]] then do
          return "T_RPAREN"; end end 
       if ___conditional___ == 5--[[ T_LBRACKET ]] then do
          return "T_LBRACKET"; end end 
       if ___conditional___ == 6--[[ T_RBRACKET ]] then do
          return "T_RBRACKET"; end end 
       if ___conditional___ == 7--[[ T_SEMICOLON ]] then do
          return "T_SEMICOLON"; end end 
       if ___conditional___ == 8--[[ T_COMMA ]] then do
          return "T_COMMA"; end end 
       if ___conditional___ == 9--[[ T_PERIOD ]] then do
          return "T_PERIOD"; end end 
       if ___conditional___ == 10--[[ T_ARROW ]] then do
          return "T_ARROW"; end end 
       if ___conditional___ == 11--[[ T_ELLIPSIS ]] then do
          return "T_ELLIPSIS"; end end 
       if ___conditional___ == 12--[[ T_AT ]] then do
          return "T_AT"; end end 
       if ___conditional___ == 13--[[ T_FUNCTION ]] then do
          return "T_FUNCTION"; end end 
       if ___conditional___ == 14--[[ T_IF ]] then do
          return "T_IF"; end end 
       if ___conditional___ == 15--[[ T_IN ]] then do
          return "T_IN"; end end 
       if ___conditional___ == 16--[[ T_INSTANCEOF ]] then do
          return "T_INSTANCEOF"; end end 
       if ___conditional___ == 17--[[ T_RETURN ]] then do
          return "T_RETURN"; end end 
       if ___conditional___ == 18--[[ T_SWITCH ]] then do
          return "T_SWITCH"; end end 
       if ___conditional___ == 19--[[ T_THIS ]] then do
          return "T_THIS"; end end 
       if ___conditional___ == 20--[[ T_THROW ]] then do
          return "T_THROW"; end end 
       if ___conditional___ == 21--[[ T_TRY ]] then do
          return "T_TRY"; end end 
       if ___conditional___ == 22--[[ T_VAR ]] then do
          return "T_VAR"; end end 
       if ___conditional___ == 23--[[ T_WHILE ]] then do
          return "T_WHILE"; end end 
       if ___conditional___ == 24--[[ T_WITH ]] then do
          return "T_WITH"; end end 
       if ___conditional___ == 25--[[ T_CONST ]] then do
          return "T_CONST"; end end 
       if ___conditional___ == 26--[[ T_LET ]] then do
          return "T_LET"; end end 
       if ___conditional___ == 27--[[ T_NULL ]] then do
          return "T_NULL"; end end 
       if ___conditional___ == 28--[[ T_FALSE ]] then do
          return "T_FALSE"; end end 
       if ___conditional___ == 29--[[ T_TRUE ]] then do
          return "T_TRUE"; end end 
       if ___conditional___ == 30--[[ T_BREAK ]] then do
          return "T_BREAK"; end end 
       if ___conditional___ == 31--[[ T_CASE ]] then do
          return "T_CASE"; end end 
       if ___conditional___ == 32--[[ T_CATCH ]] then do
          return "T_CATCH"; end end 
       if ___conditional___ == 33--[[ T_CONTINUE ]] then do
          return "T_CONTINUE"; end end 
       if ___conditional___ == 34--[[ T_DEFAULT ]] then do
          return "T_DEFAULT"; end end 
       if ___conditional___ == 35--[[ T_DO ]] then do
          return "T_DO"; end end 
       if ___conditional___ == 36--[[ T_FINALLY ]] then do
          return "T_FINALLY"; end end 
       if ___conditional___ == 37--[[ T_FOR ]] then do
          return "T_FOR"; end end 
       if ___conditional___ == 38--[[ T_CLASS ]] then do
          return "T_CLASS"; end end 
       if ___conditional___ == 39--[[ T_EXTENDS ]] then do
          return "T_EXTENDS"; end end 
       if ___conditional___ == 40--[[ T_STATIC ]] then do
          return "T_STATIC"; end end 
       if ___conditional___ == 41--[[ T_ELSE ]] then do
          return "T_ELSE"; end end 
       if ___conditional___ == 42--[[ T_NEW ]] then do
          return "T_NEW"; end end 
       if ___conditional___ == 43--[[ T_DELETE ]] then do
          return "T_DELETE"; end end 
       if ___conditional___ == 44--[[ T_TYPEOF ]] then do
          return "T_TYPEOF"; end end 
       if ___conditional___ == 45--[[ T_VOID ]] then do
          return "T_VOID"; end end 
       if ___conditional___ == 46--[[ T_ENUM ]] then do
          return "T_ENUM"; end end 
       if ___conditional___ == 47--[[ T_EXPORT ]] then do
          return "T_EXPORT"; end end 
       if ___conditional___ == 48--[[ T_IMPORT ]] then do
          return "T_IMPORT"; end end 
       if ___conditional___ == 49--[[ T_SUPER ]] then do
          return "T_SUPER"; end end 
       if ___conditional___ == 50--[[ T_IMPLEMENTS ]] then do
          return "T_IMPLEMENTS"; end end 
       if ___conditional___ == 51--[[ T_INTERFACE ]] then do
          return "T_INTERFACE"; end end 
       if ___conditional___ == 52--[[ T_PACKAGE ]] then do
          return "T_PACKAGE"; end end 
       if ___conditional___ == 53--[[ T_PRIVATE ]] then do
          return "T_PRIVATE"; end end 
       if ___conditional___ == 54--[[ T_PROTECTED ]] then do
          return "T_PROTECTED"; end end 
       if ___conditional___ == 55--[[ T_PUBLIC ]] then do
          return "T_PUBLIC"; end end 
       if ___conditional___ == 56--[[ T_YIELD ]] then do
          return "T_YIELD"; end end 
       if ___conditional___ == 57--[[ T_DEBUGGER ]] then do
          return "T_DEBUGGER"; end end 
       if ___conditional___ == 58--[[ T_DECLARE ]] then do
          return "T_DECLARE"; end end 
       if ___conditional___ == 59--[[ T_TYPE ]] then do
          return "T_TYPE"; end end 
       if ___conditional___ == 60--[[ T_OF ]] then do
          return "T_OF"; end end 
       if ___conditional___ == 61--[[ T_ASYNC ]] then do
          return "T_ASYNC"; end end 
       if ___conditional___ == 62--[[ T_AWAIT ]] then do
          return "T_AWAIT"; end end 
       if ___conditional___ == 63--[[ T_RSHIFT3_ASSIGN ]] then do
          return "T_RSHIFT3_ASSIGN"; end end 
       if ___conditional___ == 64--[[ T_RSHIFT_ASSIGN ]] then do
          return "T_RSHIFT_ASSIGN"; end end 
       if ___conditional___ == 65--[[ T_LSHIFT_ASSIGN ]] then do
          return "T_LSHIFT_ASSIGN"; end end 
       if ___conditional___ == 66--[[ T_BIT_XOR_ASSIGN ]] then do
          return "T_BIT_XOR_ASSIGN"; end end 
       if ___conditional___ == 67--[[ T_BIT_OR_ASSIGN ]] then do
          return "T_BIT_OR_ASSIGN"; end end 
       if ___conditional___ == 68--[[ T_BIT_AND_ASSIGN ]] then do
          return "T_BIT_AND_ASSIGN"; end end 
       if ___conditional___ == 69--[[ T_MOD_ASSIGN ]] then do
          return "T_MOD_ASSIGN"; end end 
       if ___conditional___ == 70--[[ T_DIV_ASSIGN ]] then do
          return "T_DIV_ASSIGN"; end end 
       if ___conditional___ == 71--[[ T_MULT_ASSIGN ]] then do
          return "T_MULT_ASSIGN"; end end 
       if ___conditional___ == 72--[[ T_EXP_ASSIGN ]] then do
          return "T_EXP_ASSIGN"; end end 
       if ___conditional___ == 73--[[ T_MINUS_ASSIGN ]] then do
          return "T_MINUS_ASSIGN"; end end 
       if ___conditional___ == 74--[[ T_PLUS_ASSIGN ]] then do
          return "T_PLUS_ASSIGN"; end end 
       if ___conditional___ == 75--[[ T_ASSIGN ]] then do
          return "T_ASSIGN"; end end 
       if ___conditional___ == 76--[[ T_PLING ]] then do
          return "T_PLING"; end end 
       if ___conditional___ == 77--[[ T_COLON ]] then do
          return "T_COLON"; end end 
       if ___conditional___ == 78--[[ T_OR ]] then do
          return "T_OR"; end end 
       if ___conditional___ == 79--[[ T_AND ]] then do
          return "T_AND"; end end 
       if ___conditional___ == 80--[[ T_BIT_OR ]] then do
          return "T_BIT_OR"; end end 
       if ___conditional___ == 81--[[ T_BIT_XOR ]] then do
          return "T_BIT_XOR"; end end 
       if ___conditional___ == 82--[[ T_BIT_AND ]] then do
          return "T_BIT_AND"; end end 
       if ___conditional___ == 83--[[ T_EQUAL ]] then do
          return "T_EQUAL"; end end 
       if ___conditional___ == 84--[[ T_NOT_EQUAL ]] then do
          return "T_NOT_EQUAL"; end end 
       if ___conditional___ == 85--[[ T_STRICT_EQUAL ]] then do
          return "T_STRICT_EQUAL"; end end 
       if ___conditional___ == 86--[[ T_STRICT_NOT_EQUAL ]] then do
          return "T_STRICT_NOT_EQUAL"; end end 
       if ___conditional___ == 87--[[ T_LESS_THAN_EQUAL ]] then do
          return "T_LESS_THAN_EQUAL"; end end 
       if ___conditional___ == 88--[[ T_GREATER_THAN_EQUAL ]] then do
          return "T_GREATER_THAN_EQUAL"; end end 
       if ___conditional___ == 89--[[ T_LESS_THAN ]] then do
          return "T_LESS_THAN"; end end 
       if ___conditional___ == 90--[[ T_GREATER_THAN ]] then do
          return "T_GREATER_THAN"; end end 
       if ___conditional___ == 91--[[ T_LSHIFT ]] then do
          return "T_LSHIFT"; end end 
       if ___conditional___ == 92--[[ T_RSHIFT ]] then do
          return "T_RSHIFT"; end end 
       if ___conditional___ == 93--[[ T_RSHIFT3 ]] then do
          return "T_RSHIFT3"; end end 
       if ___conditional___ == 94--[[ T_PLUS ]] then do
          return "T_PLUS"; end end 
       if ___conditional___ == 95--[[ T_MINUS ]] then do
          return "T_MINUS"; end end 
       if ___conditional___ == 96--[[ T_DIV ]] then do
          return "T_DIV"; end end 
       if ___conditional___ == 97--[[ T_MULT ]] then do
          return "T_MULT"; end end 
       if ___conditional___ == 98--[[ T_EXP ]] then do
          return "T_EXP"; end end 
       if ___conditional___ == 99--[[ T_MOD ]] then do
          return "T_MOD"; end end 
       if ___conditional___ == 100--[[ T_NOT ]] then do
          return "T_NOT"; end end 
       if ___conditional___ == 101--[[ T_BIT_NOT ]] then do
          return "T_BIT_NOT"; end end 
       if ___conditional___ == 102--[[ T_INCR ]] then do
          return "T_INCR"; end end 
       if ___conditional___ == 103--[[ T_DECR ]] then do
          return "T_DECR"; end end 
       if ___conditional___ == 104--[[ T_ERROR ]] then do
          return "T_ERROR"; end end 
       if ___conditional___ == 105--[[ T_EOF ]] then do
          return "T_EOF"; end end 
       if ___conditional___ == 106--[[ T_JSX_IDENTIFIER ]] then do
          return "T_JSX_IDENTIFIER"; end end 
       if ___conditional___ == 107--[[ T_ANY_TYPE ]] then do
          return "T_ANY_TYPE"; end end 
       if ___conditional___ == 108--[[ T_BOOLEAN_TYPE ]] then do
          return "T_BOOLEAN_TYPE"; end end 
       if ___conditional___ == 109--[[ T_NUMBER_TYPE ]] then do
          return "T_NUMBER_TYPE"; end end 
       if ___conditional___ == 110--[[ T_STRING_TYPE ]] then do
          return "T_STRING_TYPE"; end end 
       if ___conditional___ == 111--[[ T_VOID_TYPE ]] then do
          return "T_VOID_TYPE"; end end 
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ T_NUMBER ]] then do
          return "T_NUMBER"; end end 
       if ___conditional___ == 1--[[ T_STRING ]] then do
          return "T_STRING"; end end 
       if ___conditional___ == 2--[[ T_TEMPLATE_PART ]] then do
          return "T_TEMPLATE_PART"; end end 
       if ___conditional___ == 3--[[ T_REGEXP ]] then do
          return "T_REGEXP"; end end 
       if ___conditional___ == 4--[[ T_JSX_TEXT ]] then do
          return "T_JSX_TEXT"; end end 
       if ___conditional___ == 5--[[ T_NUMBER_SINGLETON_TYPE ]] then do
          return "T_NUMBER_SINGLETON_TYPE"; end end 
      
    end
  end end 
end end

function yyback(n, lexbuf) do
  lexbuf.lex_curr_pos = lexbuf.lex_curr_pos - n | 0;
  currp = lexbuf.lex_curr_p;
  lexbuf.lex_curr_p = {
    pos_fname = currp.pos_fname,
    pos_lnum = currp.pos_lnum,
    pos_bol = currp.pos_bol,
    pos_cnum = currp.pos_cnum - n | 0
  };
  return --[[ () ]]0;
end end

function back(lb) do
  n = lb.lex_curr_p.pos_cnum - lb.lex_start_p.pos_cnum | 0;
  return yyback(n, lb);
end end

empty_lex_state = {
  lex_errors_acc = --[[ [] ]]0,
  lex_comments_acc = --[[ [] ]]0
};

function new_lex_env(lex_source, lex_lb, enable_types_in_comments) do
  return {
          lex_source = lex_source,
          lex_lb = lex_lb,
          lex_in_comment_syntax = false,
          lex_enable_comment_syntax = enable_types_in_comments,
          lex_state = empty_lex_state
        };
end end

function get_and_clear_state(env) do
  state = env.lex_state;
  env_1 = state ~= empty_lex_state and ({
        lex_source = env.lex_source,
        lex_lb = env.lex_lb,
        lex_in_comment_syntax = env.lex_in_comment_syntax,
        lex_enable_comment_syntax = env.lex_enable_comment_syntax,
        lex_state = empty_lex_state
      }) or env;
  return --[[ tuple ]]{
          env_1,
          state
        };
end end

function with_lexbuf(lexbuf, env) do
  return {
          lex_source = env.lex_source,
          lex_lb = lexbuf,
          lex_in_comment_syntax = env.lex_in_comment_syntax,
          lex_enable_comment_syntax = env.lex_enable_comment_syntax,
          lex_state = env.lex_state
        };
end end

function in_comment_syntax(is_in, env) do
  if (is_in ~= env.lex_in_comment_syntax) then do
    return {
            lex_source = env.lex_source,
            lex_lb = env.lex_lb,
            lex_in_comment_syntax = is_in,
            lex_enable_comment_syntax = env.lex_enable_comment_syntax,
            lex_state = env.lex_state
          };
  end else do
    return env;
  end end 
end end

function get_result_and_clear_state(param) do
  lex_token = param[2];
  match = get_and_clear_state(param[1]);
  state = match[2];
  env = match[1];
  match_1;
  exit = 0;
  if (type(lex_token) == "number") then do
    exit = 2;
  end else do
    local ___conditional___=(lex_token.tag | 0);
    do
       if ___conditional___ == 2--[[ T_TEMPLATE_PART ]] then do
          match_2 = lex_token[1];
          match_1 = --[[ tuple ]]{
            match_2[1],
            match_2[2].literal
          }; end else 
       if ___conditional___ == 3--[[ T_REGEXP ]] then do
          match_3 = lex_token[1];
          match_1 = --[[ tuple ]]{
            match_3[1],
            "/" .. (match_3[2] .. ("/" .. match_3[3]))
          }; end else 
       if ___conditional___ == 1--[[ T_STRING ]]
       or ___conditional___ == 4--[[ T_JSX_TEXT ]] then do
          exit = 1; end else 
       end end end end end end
      exit = 2;
        
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        match_4 = lex_token[1];
        match_1 = --[[ tuple ]]{
          match_4[1],
          match_4[3]
        }; end else 
     if ___conditional___ == 2 then do
        match_1 = --[[ tuple ]]{
          from_lb(env.lex_source, env.lex_lb),
          Lexing.lexeme(env.lex_lb)
        }; end else 
     end end end end
    
  end
  return --[[ tuple ]]{
          env,
          {
            lex_token = lex_token,
            lex_loc = match_1[1],
            lex_value = match_1[2],
            lex_errors = List.rev(state.lex_errors_acc),
            lex_comments = List.rev(state.lex_comments_acc)
          }
        };
end end

function lex_error(env, loc, err) do
  lex_errors_acc_000 = --[[ tuple ]]{
    loc,
    err
  };
  lex_errors_acc_001 = env.lex_state.lex_errors_acc;
  lex_errors_acc = --[[ :: ]]{
    lex_errors_acc_000,
    lex_errors_acc_001
  };
  init = env.lex_state;
  return {
          lex_source = env.lex_source,
          lex_lb = env.lex_lb,
          lex_in_comment_syntax = env.lex_in_comment_syntax,
          lex_enable_comment_syntax = env.lex_enable_comment_syntax,
          lex_state = {
            lex_errors_acc = lex_errors_acc,
            lex_comments_acc = init.lex_comments_acc
          }
        };
end end

function unexpected_error(env, loc, value) do
  return lex_error(env, loc, --[[ UnexpectedToken ]]Block.__(1, {value}));
end end

function unexpected_error_w_suggest(env, loc, value, suggest) do
  return lex_error(env, loc, --[[ UnexpectedTokenWithSuggestion ]]Block.__(2, {
                value,
                suggest
              }));
end end

function illegal_number(env, lexbuf, word, token) do
  loc = from_lb(env.lex_source, lexbuf);
  yyback(#word, lexbuf);
  env_1 = lex_error(env, loc, --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
  return --[[ tuple ]]{
          env_1,
          token
        };
end end

No_good = Caml_exceptions.create("Flow_parser_reg_test.Lexer_flow.FloatOfString.No_good");

function eat(f) do
  match = f.todo;
  if (match) then do
    return {
            negative = f.negative,
            mantissa = f.mantissa,
            exponent = f.exponent,
            decimal_exponent = f.decimal_exponent,
            todo = match[2]
          };
  end else do
    error(No_good)
  end end 
end end

function start(str) do
  todo = {
    contents = --[[ [] ]]0
  };
  __String.iter((function(c) do
          todo.contents = --[[ :: ]]{
            c,
            todo.contents
          };
          return --[[ () ]]0;
        end end), str);
  return {
          negative = false,
          mantissa = 0,
          exponent = 0,
          decimal_exponent = nil,
          todo = List.rev(todo.contents)
        };
end end

function parse_sign(f) do
  match = f.todo;
  if (match) then do
    local ___conditional___=(match[1]);
    do
       if ___conditional___ == 43 then do
          return eat(f); end end 
       if ___conditional___ == 44 then do
          return f; end end 
       if ___conditional___ == 45 then do
          init = eat(f);
          return {
                  negative = true,
                  mantissa = init.mantissa,
                  exponent = init.exponent,
                  decimal_exponent = init.decimal_exponent,
                  todo = init.todo
                }; end end 
      return f;
        
    end
  end else do
    return f;
  end end 
end end

function parse_hex_symbol(f) do
  match = f.todo;
  if (match) then do
    if (match[1] ~= 48) then do
      error(No_good)
    end
     end 
    match_1 = match[2];
    if (match_1) then do
      match_2 = match_1[1];
      if (match_2 ~= 88) then do
        if (match_2 ~= 120) then do
          error(No_good)
        end
         end 
        return eat(eat(f));
      end else do
        return eat(eat(f));
      end end 
    end else do
      error(No_good)
    end end 
  end else do
    error(No_good)
  end end 
end end

function parse_exponent(f) do
  todo_str = __String.concat("", List.map(Char.escaped, f.todo));
  exponent;
  xpcall(function() do
    exponent = Caml_format.caml_int_of_string(todo_str);
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[1] == Caml_builtin_exceptions.failure) then do
      error(No_good)
    end
     end 
    error(exn)
  end end)
  return {
          negative = f.negative,
          mantissa = f.mantissa,
          exponent = exponent,
          decimal_exponent = f.decimal_exponent,
          todo = --[[ [] ]]0
        };
end end

function parse_body(_f) do
  while(true) do
    f = _f;
    match = f.todo;
    if (match) then do
      c = match[1];
      if (c >= 81) then do
        if (c ~= 95) then do
          if (c == 112) then do
            return parse_exponent(eat(f));
          end
           end 
        end else do
          _f = eat(f);
          ::continue:: ;
        end end 
      end else if (c ~= 46) then do
        if (c >= 80) then do
          return parse_exponent(eat(f));
        end
         end 
      end else if (f.decimal_exponent == nil) then do
        init = eat(f);
        _f = {
          negative = init.negative,
          mantissa = init.mantissa,
          exponent = init.exponent,
          decimal_exponent = 0,
          todo = init.todo
        };
        ::continue:: ;
      end else do
        error(No_good)
      end end  end  end 
      ref_char_code;
      if (c >= --[[ "0" ]]48 and c <= --[[ "9" ]]57) then do
        ref_char_code = --[[ "0" ]]48;
      end else if (c >= --[[ "A" ]]65 and c <= --[[ "F" ]]70) then do
        ref_char_code = 55;
      end else if (c >= --[[ "a" ]]97 and c <= --[[ "f" ]]102) then do
        ref_char_code = 87;
      end else do
        error(No_good)
      end end  end  end 
      value = c - ref_char_code | 0;
      match_1 = f.decimal_exponent;
      decimal_exponent = match_1 ~= nil and match_1 - 4 | 0 or nil;
      mantissa = (f.mantissa << 4) + value | 0;
      init_1 = eat(f);
      _f = {
        negative = init_1.negative,
        mantissa = mantissa,
        exponent = init_1.exponent,
        decimal_exponent = decimal_exponent,
        todo = init_1.todo
      };
      ::continue:: ;
    end else do
      return f;
    end end 
  end;
end end

function float_of_string(str) do
  xpcall(function() do
    return Caml_format.caml_float_of_string(str);
  end end,function(e) do
    if (Sys.win32) then do
      xpcall(function() do
        f = parse_body(parse_hex_symbol(parse_sign(start(str))));
        if (f.todo ~= --[[ [] ]]0) then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "lexer_flow.mll",
              546,
              4
            }
          })
        end
         end 
        ret = f.mantissa;
        match = f.decimal_exponent;
        exponent = match ~= nil and f.exponent + match | 0 or f.exponent;
        ret_1 = exponent == 0 and ret or __Math.pow(ret, exponent);
        if (f.negative) then do
          return -ret_1;
        end else do
          return ret_1;
        end end 
      end end,function(exn) do
        if (exn == No_good) then do
          error(e)
        end
         end 
        error(exn)
      end end)
    end else do
      error(e)
    end end 
  end end)
end end

function save_comment(env, start, _end, buf, multiline) do
  loc = btwn(start, _end);
  s = __Buffer.contents(buf);
  c = multiline and --[[ Block ]]Block.__(0, {s}) or --[[ Line ]]Block.__(1, {s});
  lex_comments_acc_000 = --[[ tuple ]]{
    loc,
    c
  };
  lex_comments_acc_001 = env.lex_state.lex_comments_acc;
  lex_comments_acc = --[[ :: ]]{
    lex_comments_acc_000,
    lex_comments_acc_001
  };
  init = env.lex_state;
  return {
          lex_source = env.lex_source,
          lex_lb = env.lex_lb,
          lex_in_comment_syntax = env.lex_in_comment_syntax,
          lex_enable_comment_syntax = env.lex_enable_comment_syntax,
          lex_state = {
            lex_errors_acc = init.lex_errors_acc,
            lex_comments_acc = lex_comments_acc
          }
        };
end end

function unicode_fix_cols(lb) do
  count = function(_start, stop, _acc) do
    while(true) do
      acc = _acc;
      start = _start;
      if (start == stop) then do
        return acc;
      end else do
        c = Caml_bytes.get(lb.lex_buffer, start);
        acc_1 = (c & 192) == 128 and acc + 1 | 0 or acc;
        _acc = acc_1;
        _start = start + 1 | 0;
        ::continue:: ;
      end end 
    end;
  end end;
  bytes = count(lb.lex_start_pos, lb.lex_curr_pos, 0);
  new_bol = lb.lex_curr_p.pos_bol + bytes | 0;
  init = lb.lex_curr_p;
  lb.lex_curr_p = {
    pos_fname = init.pos_fname,
    pos_lnum = init.pos_lnum,
    pos_bol = new_bol,
    pos_cnum = init.pos_cnum
  };
  return --[[ () ]]0;
end end

function oct_to_int(x) do
  if (x > 55 or x < 48) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "lexer_flow.mll",
        604,
        11
      }
    })
  end
   end 
  return x - --[[ "0" ]]48 | 0;
end end

function hexa_to_int(x) do
  if (x >= 65) then do
    if (x >= 97) then do
      if (x < 103) then do
        return (x - --[[ "a" ]]97 | 0) + 10 | 0;
      end
       end 
    end else if (x < 71) then do
      return (x - --[[ "A" ]]65 | 0) + 10 | 0;
    end
     end  end 
  end else if (not (x > 57 or x < 48)) then do
    return x - --[[ "0" ]]48 | 0;
  end
   end  end 
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "lexer_flow.mll",
      610,
      11
    }
  })
end end

function utf16to8(code) do
  if (code >= 65536) then do
    return --[[ :: ]]{
            Char.chr(240 | (code >>> 18)),
            --[[ :: ]]{
              Char.chr(128 | (code >>> 12) & 63),
              --[[ :: ]]{
                Char.chr(128 | (code >>> 6) & 63),
                --[[ :: ]]{
                  Char.chr(128 | code & 63),
                  --[[ [] ]]0
                }
              }
            }
          };
  end else if (code >= 2048) then do
    return --[[ :: ]]{
            Char.chr(224 | (code >>> 12)),
            --[[ :: ]]{
              Char.chr(128 | (code >>> 6) & 63),
              --[[ :: ]]{
                Char.chr(128 | code & 63),
                --[[ [] ]]0
              }
            }
          };
  end else if (code >= 128) then do
    return --[[ :: ]]{
            Char.chr(192 | (code >>> 6)),
            --[[ :: ]]{
              Char.chr(128 | code & 63),
              --[[ [] ]]0
            }
          };
  end else do
    return --[[ :: ]]{
            Char.chr(code),
            --[[ [] ]]0
          };
  end end  end  end 
end end

function mk_num_singleton(number_type, num, neg) do
  value;
  if (number_type ~= 0) then do
    local ___conditional___=(number_type - 1 | 0);
    do
       if ___conditional___ == 0--[[ BINARY ]] then do
          value = Caml_format.caml_int_of_string("0o" .. num); end else 
       if ___conditional___ == 1--[[ LEGACY_OCTAL ]] then do
          value = Caml_format.caml_int_of_string(num); end else 
       if ___conditional___ == 2--[[ OCTAL ]] then do
          value = float_of_string(num); end else 
       end end end end end end
      
    end
  end else do
    value = Caml_format.caml_int_of_string(num);
  end end 
  value_1 = neg == "" and value or -value;
  return --[[ T_NUMBER_SINGLETON_TYPE ]]Block.__(5, {
            number_type,
            value_1
          });
end end

keywords = Hashtbl.create(nil, 53);

type_keywords = Hashtbl.create(nil, 53);

List.iter((function(param) do
        return Hashtbl.add(keywords, param[1], param[2]);
      end end), --[[ :: ]]{
      --[[ tuple ]]{
        "function",
        --[[ T_FUNCTION ]]13
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "if",
          --[[ T_IF ]]14
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "in",
            --[[ T_IN ]]15
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "instanceof",
              --[[ T_INSTANCEOF ]]16
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "return",
                --[[ T_RETURN ]]17
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "switch",
                  --[[ T_SWITCH ]]18
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "this",
                    --[[ T_THIS ]]19
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "throw",
                      --[[ T_THROW ]]20
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "try",
                        --[[ T_TRY ]]21
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "var",
                          --[[ T_VAR ]]22
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "while",
                            --[[ T_WHILE ]]23
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "with",
                              --[[ T_WITH ]]24
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "const",
                                --[[ T_CONST ]]25
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "let",
                                  --[[ T_LET ]]26
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    "null",
                                    --[[ T_NULL ]]27
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "false",
                                      --[[ T_FALSE ]]28
                                    },
                                    --[[ :: ]]{
                                      --[[ tuple ]]{
                                        "true",
                                        --[[ T_TRUE ]]29
                                      },
                                      --[[ :: ]]{
                                        --[[ tuple ]]{
                                          "break",
                                          --[[ T_BREAK ]]30
                                        },
                                        --[[ :: ]]{
                                          --[[ tuple ]]{
                                            "case",
                                            --[[ T_CASE ]]31
                                          },
                                          --[[ :: ]]{
                                            --[[ tuple ]]{
                                              "catch",
                                              --[[ T_CATCH ]]32
                                            },
                                            --[[ :: ]]{
                                              --[[ tuple ]]{
                                                "continue",
                                                --[[ T_CONTINUE ]]33
                                              },
                                              --[[ :: ]]{
                                                --[[ tuple ]]{
                                                  "default",
                                                  --[[ T_DEFAULT ]]34
                                                },
                                                --[[ :: ]]{
                                                  --[[ tuple ]]{
                                                    "do",
                                                    --[[ T_DO ]]35
                                                  },
                                                  --[[ :: ]]{
                                                    --[[ tuple ]]{
                                                      "finally",
                                                      --[[ T_FINALLY ]]36
                                                    },
                                                    --[[ :: ]]{
                                                      --[[ tuple ]]{
                                                        "for",
                                                        --[[ T_FOR ]]37
                                                      },
                                                      --[[ :: ]]{
                                                        --[[ tuple ]]{
                                                          "class",
                                                          --[[ T_CLASS ]]38
                                                        },
                                                        --[[ :: ]]{
                                                          --[[ tuple ]]{
                                                            "extends",
                                                            --[[ T_EXTENDS ]]39
                                                          },
                                                          --[[ :: ]]{
                                                            --[[ tuple ]]{
                                                              "static",
                                                              --[[ T_STATIC ]]40
                                                            },
                                                            --[[ :: ]]{
                                                              --[[ tuple ]]{
                                                                "else",
                                                                --[[ T_ELSE ]]41
                                                              },
                                                              --[[ :: ]]{
                                                                --[[ tuple ]]{
                                                                  "new",
                                                                  --[[ T_NEW ]]42
                                                                },
                                                                --[[ :: ]]{
                                                                  --[[ tuple ]]{
                                                                    "delete",
                                                                    --[[ T_DELETE ]]43
                                                                  },
                                                                  --[[ :: ]]{
                                                                    --[[ tuple ]]{
                                                                      "typeof",
                                                                      --[[ T_TYPEOF ]]44
                                                                    },
                                                                    --[[ :: ]]{
                                                                      --[[ tuple ]]{
                                                                        "void",
                                                                        --[[ T_VOID ]]45
                                                                      },
                                                                      --[[ :: ]]{
                                                                        --[[ tuple ]]{
                                                                          "enum",
                                                                          --[[ T_ENUM ]]46
                                                                        },
                                                                        --[[ :: ]]{
                                                                          --[[ tuple ]]{
                                                                            "export",
                                                                            --[[ T_EXPORT ]]47
                                                                          },
                                                                          --[[ :: ]]{
                                                                            --[[ tuple ]]{
                                                                              "import",
                                                                              --[[ T_IMPORT ]]48
                                                                            },
                                                                            --[[ :: ]]{
                                                                              --[[ tuple ]]{
                                                                                "super",
                                                                                --[[ T_SUPER ]]49
                                                                              },
                                                                              --[[ :: ]]{
                                                                                --[[ tuple ]]{
                                                                                  "implements",
                                                                                  --[[ T_IMPLEMENTS ]]50
                                                                                },
                                                                                --[[ :: ]]{
                                                                                  --[[ tuple ]]{
                                                                                    "interface",
                                                                                    --[[ T_INTERFACE ]]51
                                                                                  },
                                                                                  --[[ :: ]]{
                                                                                    --[[ tuple ]]{
                                                                                      "package",
                                                                                      --[[ T_PACKAGE ]]52
                                                                                    },
                                                                                    --[[ :: ]]{
                                                                                      --[[ tuple ]]{
                                                                                        "private",
                                                                                        --[[ T_PRIVATE ]]53
                                                                                      },
                                                                                      --[[ :: ]]{
                                                                                        --[[ tuple ]]{
                                                                                          "protected",
                                                                                          --[[ T_PROTECTED ]]54
                                                                                        },
                                                                                        --[[ :: ]]{
                                                                                          --[[ tuple ]]{
                                                                                            "public",
                                                                                            --[[ T_PUBLIC ]]55
                                                                                          },
                                                                                          --[[ :: ]]{
                                                                                            --[[ tuple ]]{
                                                                                              "yield",
                                                                                              --[[ T_YIELD ]]56
                                                                                            },
                                                                                            --[[ :: ]]{
                                                                                              --[[ tuple ]]{
                                                                                                "debugger",
                                                                                                --[[ T_DEBUGGER ]]57
                                                                                              },
                                                                                              --[[ :: ]]{
                                                                                                --[[ tuple ]]{
                                                                                                  "declare",
                                                                                                  --[[ T_DECLARE ]]58
                                                                                                },
                                                                                                --[[ :: ]]{
                                                                                                  --[[ tuple ]]{
                                                                                                    "type",
                                                                                                    --[[ T_TYPE ]]59
                                                                                                  },
                                                                                                  --[[ :: ]]{
                                                                                                    --[[ tuple ]]{
                                                                                                      "of",
                                                                                                      --[[ T_OF ]]60
                                                                                                    },
                                                                                                    --[[ :: ]]{
                                                                                                      --[[ tuple ]]{
                                                                                                        "async",
                                                                                                        --[[ T_ASYNC ]]61
                                                                                                      },
                                                                                                      --[[ :: ]]{
                                                                                                        --[[ tuple ]]{
                                                                                                          "await",
                                                                                                          --[[ T_AWAIT ]]62
                                                                                                        },
                                                                                                        --[[ [] ]]0
                                                                                                      }
                                                                                                    }
                                                                                                  }
                                                                                                }
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    }
                                                                                  }
                                                                                }
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });

List.iter((function(param) do
        return Hashtbl.add(type_keywords, param[1], param[2]);
      end end), --[[ :: ]]{
      --[[ tuple ]]{
        "static",
        --[[ T_STATIC ]]40
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "typeof",
          --[[ T_TYPEOF ]]44
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "any",
            --[[ T_ANY_TYPE ]]107
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "bool",
              --[[ T_BOOLEAN_TYPE ]]108
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "boolean",
                --[[ T_BOOLEAN_TYPE ]]108
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "true",
                  --[[ T_TRUE ]]29
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "false",
                    --[[ T_FALSE ]]28
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "number",
                      --[[ T_NUMBER_TYPE ]]109
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "string",
                        --[[ T_STRING_TYPE ]]110
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "void",
                          --[[ T_VOID_TYPE ]]111
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "null",
                            --[[ T_NULL ]]27
                          },
                          --[[ [] ]]0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    });

__ocaml_lex_tables = {
  lex_base = "\0\0\xb2\xff\xb3\xff\xb9\xffB\0C\0T\0W\0F\0I\0J\0K\0M\0e\0\xdd\xff\xde\xff\xdf\xff\xe0\xff\xe3\xff\xe4\xff\xe5\xff\xe6\xff\xe7\xff\xe8\xff\xc0\0L\0e\0\x17\x01n\x01\xf6\xff\xf7\xffl\0u\0v\0\0\0\x0e\0\x0f\0\x07\x003\x01\xfe\xff\xff\xff\x01\0\x12\0(\0\f\0\x15\0*\0\f\0=\0-\0\t\0\xb6\xff\xf9\xff\xe0\x01B\0u\0\x0f\x000\x004\0\x17\0\xe5\x01(\x008\0\x1a\0K\0:\0\x17\0\xfb\xffh\0a\0\xac\0q\0m\0y\0q\0i\0{\0{\0\xa8\0\xca\xff\xfa\xff\xc9\xff\xf8\xff\x0b\x02\xa5\x02\xfc\x02S\x03\xaa\x03\x01\x04X\x04\xaf\x04\x06\x05]\x05\xb4\x05\x0b\x06b\x06\xb9\x06\xc3\x01\x10\x07g\x07\xbe\x07\x15\bl\b\xc3\b\x1a\tq\t\xc8\t\xb8\0\xe2\xffE\x02\xc7\xff\xdc\xff\xc6\xff\xdb\xff\xb7\xff\xaa\0\xda\xff\xab\0\xd9\xff\xac\0\xd8\xff\xd2\xff\xad\0\xd7\xff\xb0\0\xd0\xff\xcf\xff\xcc\xff\xd4\xff\xcb\xff\xd3\xff\xc8\xff\xc5\xff:\n\xcf\xff\xd0\xff\xd2\xff\xd6\xff\xd7\xff\xb0\0\xdc\xff\xdd\xff\xe0\xff\xe1\xff\xe2\xff\xe3\xff\xe6\xff\xe7\xff\xe8\xff\xe9\xff\xea\xff\xeb\xff\x94\n\xfa\n\xd6\x01Q\x0b\xa8\x0b\x1a\f\xf9\xff\xcc\0\xf1\0A\0}\0~\0\xa3\0\xc4\x0b\xff\xffa\0\x9d\0\xc1\0\xa4\0\x90\0\xc6\0\xb2\0\xcb\t\xd2\0\x95\0\xfa\xff\x1f\f\xe9\0\x1c\x01\x9c\0\xf2\0\xf3\0\xf9\0$\f\xe7\0\xf7\0\xf5\0\xdf\x0b\x15\x01\xd7\0\xfc\xff(\x01!\x01m\x012\x01/\x01E\x01=\x015\x01G\x01G\x01\xfb\xff\xf3\x01\xf2\0.\x01I\x01P\x01K\f=\x01L\x01/\x01\xec\x0bk\x010\x01x\f\xff\fV\r\xad\r\0\x02\x04\x0e[\x0e\xb2\x0e\t\x0f`\x0f\xb7\x0f\x0e\x10e\x10\xbc\x10\x13\x11j\x11\xc1\x11\x18\x12o\x12\xc6\x12\x1d\x13t\x13\xcb\x13\"\x14\xcf\x01\xe5\xffy\x14\xd0\x14'\x15~\x15\xd4\xff\x1b\f\xfc\xff\xfd\xff\xfe\xff\xff\xff\xcf\x15\xee\xff\x01\0\xef\xff\x18\x16\xf4\xff\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xf9\xff\xf1\x02H\x03>\x16\xfe\xff\xff\xffU\x16\xfd\xff\x9f\x03\xfc\xff{\x16\x92\x16\xb8\x16\xcf\x16\xf2\xff\xf5\x16\xf1\xff\xd7\x02\xfb\xff\xd2\x01\xfe\xff\xff\xff\xcf\x01\xfd\xff\xfc\xff;\x02\xfd\xff\xfe\xff\xff\xff\0\x17\xf9\xff\xe8\x01G\x01\x83\x01\x90\x01y\x01)\fC\x15\xfe\xff\xff\xff]\x01\x9b\x01\x9c\x01*\x02\x90\x01\xa0\x01\x82\x01\x87\x15\xad\x01o\x01\xfb\xff\xfc\xff\x0b\x16\xf8\xff\x04\0\xf9\xff\xfa\xff8\x17,\x03\xff\xff\xfd\xff\x05\0\xfe\xff\xc0\x17\x96\t\xfb\xff\xfc\xff\xeb\x01\xff\xff\xfd\xff\xfe\xff2\x18\xf1\xff\xf2\xff\x8a\x18\xf4\xff\xf5\xff\xf6\xff\xf7\xff\xf8\xff\xfa\xff<\x02\x7f\x01\xc9\x01\xe7\x01+\x02\x88\x167\x18\xfe\xff\xff\xff\x8f\x01 \x02!\x023\x02\x15\x02%\x02!\x02\xbd\x16L\x02\x0f\x02\xfb\xff\xfc\xff|\f\xfb\xff\xfc\xff\xfd\xff\xfe\xff\x06\0\xff\xff\xfc\x18\xf9\xff\xf8\x18\x07\0\xfd\xff\xfe\xff\xff\xffO\x19\xdf\n_\f\x84\x17\x9c\x19\xfc\xff\xfb\xff\xd3\x19\xfa\xff*\x1a\x81\x1a\xd8\x1a/\x1b\x86\x1b\x96\x02\xf8\x1b\xfa\xff\xfb\xff\xb5\x02%\x02b\x02\x82\x02\xf3\x02\x04\x19K\x1b\xff\xff(\x02e\x02\xa9\x02J\x03r\x02\x85\x02\x8c\x02\xc9\x16\xb7\x02y\x02\xfc\xff\xfd\xff\xc3\x16\xf9\xff\xfa\xff\b\0\xfc\xff\xbf\x02\xfe\xff\xff\xff\xfd\xff\xfb\xff",
  lex_backtrk = "\xff\xff\xff\xff\xff\xff\xff\xffD\0A\0>\0=\0<\0;\0E\0G\0B\0C\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x16\0K\0\x1e\0\x15\0\x15\0\xff\xff\xff\xffM\0?\0J\0M\0M\0M\0M\0\x02\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x03\0\xff\xff\x04\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff@\0\xff\xff\xff\xff\xff\xff\xff\xff\x14\0\x14\0\x15\0\x14\0\x0f\0\x14\0\x14\0\x0b\0\n\0\r\0\f\0\x0e\0\x0e\0\x0e\0\xff\xff\x0e\0\x0e\0\x13\0\x12\0\x11\0\x10\0\x15\0\x13\0\x12\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff)\0\xff\xff*\0\xff\xff.\0\xff\xff\xff\xff2\0\xff\xff1\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff$\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x13\0\x13\0\x1b\0\x12\0\x12\0.\0\xff\xff&\x000\x000\x000\x000\x000\0\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x02\0\xff\xff\x03\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x12\0\x11\0\x11\0\x10\0\xff\xff\x10\0\x0f\0\x0f\0\x12\0\x11\0\f\0\x11\0\x11\0\b\0\x07\0\n\0\t\0\x0b\0\x0b\0\x0b\0\x0b\0\x0b\0\x0e\0\r\0\xff\xff\xff\xff\x13\0\x13\0\x13\0\x13\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x10\0\xff\xff\x0f\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\f\0\x05\0\x0f\0\xff\xff\xff\xff\xff\xff\xff\xff\x04\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x04\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x05\0\x06\0\x06\0\x06\0\x06\0\x02\0\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x06\0\xff\xff\xff\xff\x04\0\x07\0\xff\xff\xff\xff\x01\0\xff\xff\x03\0\xff\xff\xff\xff\xff\xff\x04\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\f\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x06\0\x0e\0\x0e\0\x0e\0\x0e\0\x02\0\x01\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\x06\0\x02\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x05\0\x05\0\x05\0\x05\0\x05\0\x01\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x05\0\xff\xff\x06\0\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_default = "\x01\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\xff\xff\0\0\xff\xff\0\0\xff\xff\0\0\0\0\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x86\0\0\0\0\0\0\0\0\0\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xf8\0\0\0\0\0\0\0\0\0\xfd\0\0\0\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\0\0\x18\x01\0\0\xff\xff\0\0\0\0\xff\xff\0\0\0\0 \x01\0\0\0\0\0\0$\x01\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0;\x01\0\0\xff\xff\0\0\0\0\xff\xffB\x01\0\0\0\0\xff\xff\0\0\xff\xffG\x01\0\0\0\0\xff\xff\0\0\0\0\0\0N\x01\0\0\0\0\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0m\x01\0\0\0\0\0\0\0\0\xff\xff\0\0t\x01\0\0\xff\xff\xff\xff\0\0\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x8a\x01\0\0\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xa1\x01\0\0\0\0\xff\xff\0\0\xff\xff\0\0\0\0\0\0\0\0",
  lex_trans = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0&\0(\0\xff\0&\0&\0=\x01D\x01r\x01w\x01\xa9\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0&\0\n\0\x1e\0\x1f\0\x18\0\x05\0\r\0\x1e\0\x15\0\x14\0 \0\x07\0\x10\0\x06\0\x1a\0!\0\x1c\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x0f\0\x11\0\t\0\x0b\0\b\0\x0e\0\x19\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x13\0'\0\x12\0\x04\0\x18\0\x1d\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x17\0\f\0\x16\0\x03\0\x84\0\x83\0\x82\0\x80\0{\0z\0w\0x\0u\0s\0r\0p\0o\0m\0R\x001\x000\0/\0\x81\x001\0k\0\x7f\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0N\x005\0.\0n\0&\0P\x004\0.\0-\x000\0/\0&\0&\0-\0&\0D\0C\0A\0>\0O\x003\0@\0?\0<\0=\0<\0<\0<\x002\x002\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0&\0q\0B\0<\0<\0<\0<\0<\0<\0<\0<\0<\0<\0<\0<\0E\0F\0G\0H\0I\0J\0K\0L\0M\0C\0%\0$\0#\0\x18\0Q\0l\0t\0v\0y\0}\0|\0&\0~\0\xf6\0\"\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0<\0\xcb\0\xb0\0\xaf\0\xae\0\xad\0\x02\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\xb2\0\xb0\0\xaf\0\xa5\0\x18\0\xb1\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0S\0&\0\xac\0\xac\0&\0&\0\xae\0\xad\0\xab\0\xab\0U\0\xa5\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\xa5\0\xa5\0&\0\xa5\0\xc1\0\xc0\0\xbf\0S\0S\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\xbe\0\xbd\0\xbc\0\xb9\0S\0\xb9\0S\0S\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\xbb\0\xb9\0\xb9\0\xb9\0\xc2\0\xc3\0\xba\0\xc4\0\xc5\0U\0\xc6\0W\0W\0W\0W\0W\0W\0W\0W\0\x1b\0\x1b\0\xc7\0\xc8\0\xc9\0\xca\0\xc0\0\xd7\0\xd6\0S\0Y\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0X\0S\0S\0S\0S\0S\0S\0S\0S\0V\0S\0S\0\xd5\0\xd4\0\xd1\0\xd1\0S\0\xd1\0S\0Y\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0X\0S\0S\0S\0S\0S\0S\0S\0S\0V\0S\0S\0<\0\xd3\0\xd1\0<\0<\0<\0\xd1\0\xd2\0<\0<\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0\xf1\0\x1e\x01\x1c\x01<\0\x1d\x017\x016\x01\xf0\0<\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\x005\x014\x018\x013\x01,\0+\0*\x009\x017\x012\x017\x006\x015\x014\x01*\x017\0*\x01*\x01)\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0*\x01*\x01S\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0i\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0!\x016\0L\x01K\x01h\x01i\x016\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0j\x01g\x01f\x01\x18\0S\0k\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0h\x01g\x01f\x01\\\x01\x18\0\\\x01\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\\\x01;\0:\x009\x003\x01e\x01;\0:\x009\0S\x002\x01d\x01\\\x01e\x01\\\x018\0a\0\x82\x01a\0d\x018\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0\x9e\x01\x9d\x01\x1a\x01\x9c\x01\x9d\x01\x9f\x01\x9c\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\x91\x01\x19\x01\x9b\x01\x9a\x01S\0\x91\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x9b\x01\x9a\x01\x91\x01h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0D\x01\x91\x01\x91\x01C\x01\xa8\x01\"\x01\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0S\0\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\0\0\0\0\0\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0\x99\x01\0\0\0\0\0\0\0\0\0\0\x98\x01f\0f\0f\0f\0f\0f\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0S\0\0\0f\0f\0f\0f\0f\0f\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0_\0\x0f\x01\x0f\x01\x0f\x01\x0f\x01\x0f\x01\x0f\x01\x0f\x01\x0f\x01\x1b\x01U\0\0\0W\0W\0W\0W\0W\0W\0W\0W\0^\0^\0\x99\x01\0\0\0\0\0\0\0\0\0\0\x98\x01_\0_\0_\0_\0`\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0_\0\0\0_\0_\0_\0_\0`\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0S\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff\0\0\0\0\0\0\0\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0S\0S\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0S\0\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Z\0Z\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0S\0\0\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0Z\0Z\0[\0[\0[\0[\0[\0[\0[\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\0\0\0\0\0\0\0\0[\0\0\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\0\0\0\0\0\0\0\0[\0\0\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0]\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\0\0\0\0\0\0\0\0]\0\0\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\0\0\0\0\0\0\0\0]\0\0\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0_\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0U\0\0\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_\0_\0_\0_\0`\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0_\0\0\0_\0_\0_\0_\0`\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0_\0\0\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0\0\0\0\0a\0\0\0a\0\0\0\0\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\0\0\0\0\0\0\0\0_\0\0\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\0\0\0\0\0\0\0\0c\0\0\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\0\0\0\0\0\0\0\0c\0\0\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0e\0\0\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0e\0\0\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0g\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0f\0f\0f\0f\0f\0f\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\0\0\0\0\0\0\0\0g\0\0\0f\0f\0f\0f\0f\0f\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\0\0\0\0\0\0\0\0g\0\0\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0S\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\0S\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\0\0\0\0\0\0\0\0S\0\0\0S\0S\0S\0S\0T\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0j\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\0\0\0\0\0\0\0\0j\0\0\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\0\0\0\0\0\0\0\0\0\0I\x01H\x01\0\0\0\0\0\0\0\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\0\0\0\0\0\0\0\0j\0\0\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\xa5\0\xa6\0\0\0\xa5\0\xa5\0\0\0\0\0\0\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\xa5\0\0\0\0\0\0\0\0\0\xa5\0\0\0\x9e\0\0\0\x98\0\0\0\x89\0\x9e\0\x93\0\x92\0\x9f\0\x88\0\x90\0\x9d\0\x9a\0\xa0\0\x9c\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x8f\0\x91\0\x8d\0\x8b\0\x8c\0\x8e\0\xa5\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x97\0J\x01\x96\0\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x99\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x95\0\x8a\0\x94\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01\0\0\0\0\xa4\0\xa3\0\xa2\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xa1\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\x87\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0}\x01\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xf2\0\x98\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe0\0\0\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xa5\0\0\0\0\0\xa5\0\xa5\0\0\0\0\0\0\0\0\0\xe0\0\0\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\x9b\0\x9b\0\0\0\0\0\xa5\0\0\0\0\0\0\0\0\0\xd9\0\xe4\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xe3\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xe1\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xe4\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xe3\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xe1\0\xd9\0\xd9\0\xd1\0\0\0\xf9\0\xd1\0\xd1\0\xb9\0\0\0\0\0\xb9\0\xb9\0\xb9\0\0\0\0\0\xb9\0\xb9\0*\x01\0\0\0\0*\x01*\x01\0\0\0\0\0\0\xd1\0\0\0\0\0\xfb\0\0\0\xb9\0\0\0\0\0\xfb\0\0\0\xb9\0\0\0\0\0\0\0\xcc\0*\x01\x9c\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\xd1\0\0\0\0\0\xd1\0\xd1\0\xb4\0\0\0\0\0\0\0\0\0\xb4\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\xb9\0\0\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xfa\0\0\0\xcc\0\0\0\x9c\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\xb3\0r\x01\0\0\0\0q\x01\xb3\0\0\0\0\0\0\0\xb9\0|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01\0\0\x80\x01\xd1\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xaa\0\xa9\0\xa8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\0\0\xa7\0\0\0\0\0\0\0\0\0o\x01\xd9\0\xd9\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xda\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0n\x01\0\0\0\0\0\0\xd0\0\xcf\0\xce\0\0\0\0\0\xb8\0\xb7\0\xb6\0\0\0\0\0\xb8\0\xb7\0\xb6\0\0\0\xcd\x001\x010\x01/\x01\0\0\xb5\0\0\0\0\0\0\0\0\0\xb5\0\0\0\0\0\0\0\0\0.\x01\0\0\0\0\xf9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd0\0\xcf\0\xce\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\xcd\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0p\x01\0\0\0\0\0\0\0\0\xdc\0\0\0\xdc\0\0\0\0\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xdf\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\0\0\0\0\0\0\0\0\xdf\0\0\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xde\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\0\0\0\0\0\0\0\0\xde\0\0\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\0\0\0\0\0\0\0\0\xde\0\0\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xdf\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\0\0\0\0\0\0\0\0\xdf\0\0\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xea\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe0\0\0\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe9\0\xe9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xea\0\xea\0\xea\0\xea\0\xeb\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\xea\0\0\0\xea\0\xea\0\xea\0\xea\0\xeb\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe5\0\xe5\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\0\0\0\0\0\0\0\0\xd9\0\0\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xe6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe5\0\xe5\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\0\0\0\0\0\0\0\0\xe6\0\0\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\0\0\0\0\0\0\0\0\xe6\0\0\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe8\0\xe8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\0\0\0\0\0\0\0\0\xe8\0\0\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\0\0\0\0\0\0\0\0\xe8\0\0\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xea\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xe0\0\0\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xea\0\xea\0\xea\0\xea\0\xeb\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\xea\0\0\0\xea\0\xea\0\xea\0\xea\0\xeb\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\xea\0\0\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\0\0\0\0\xdc\0\0\0\xdc\0\0\0\0\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\0\0\0\0\0\0\0\0\xea\0\0\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xed\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\0\0\0\0\0\0\0\0\xed\0\0\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\0\0\0\0\0\0\0\0\xed\0\0\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xef\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\0\0\0\0\0\0\0\0\xef\0\0\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\0\0\0\0\0\0\0\0\xef\0\0\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xf3\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\xf4\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0*\x01,\x01\0\0*\x01*\x01\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0*\x01\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xf5\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xff\0\0\0\0\0\xfe\0\x98\0\0\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\0\0\0\0\0\0\0\0\0\0\0\0\b\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01*\x01*\x01*\x01*\x01*\x01*\x01*\x01*\x01*\x01*\x01*\x01\0\0\0\0\0\0=\x01\0\0\0\0<\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x001\x010\x01/\x01\0\0\0\0\0\0\0\0\n\x01\0\0\0\0\0\0\0\0\0\0\x06\x01.\x01\0\0\0\0\x05\x01*\x01\0\0\0\0\0\0?\x01\0\0\0\0\x04\x01\0\0\0\0\0\0\x03\x01\0\0\x02\x01\0\x01\x01\x01\0\0\t\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0>\x01@\x01\0\0\0\0\0\0\0\0\0\0\0\0\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\0\0\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\0\0\0\0\\\x01\0\0\x10\x01\\\x01\\\x01\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\0\0\0\0\0\0\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\0\0\0\0\0\0\\\x01\0\0\0\0\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\0\0\r\x01\r\x01\r\x01\r\x01\r\x01\r\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\0\0\xa2\x01\0\0\x0b\x01\xa3\x01\0\0\0\0\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\0\0\0\0\0\0\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\0\0\0\0\0\0\0\0\0\0\xa5\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\0\0\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01*\x01,\x01A\x01*\x01+\x01\0\0\0\0\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\0\0\0\0\0\0\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\xa4\x01*\x01\0\0\0\0\xa6\x01\0\0\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01%\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x14\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\0\0\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\\\x01\0\0\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\x91\x01\0\0\0\0\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01E\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c\x01b\x01a\x01\\\x01\0\0\0\0\0\0\0\0\0\0\x16\x01\0\0\0\0\0\0\0\0`\x01\x91\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01\0\0\0\0\0\0\0\0E\x01\0\0E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01\0\0~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01\0\0\0\0\0\0\0\0\0\0\xa7\x01\0\0~\x01~\x01~\x01~\x01~\x01~\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)\x01(\x01'\x01E\x01~\x01~\x01~\x01~\x01~\x01~\x01\0\0\0\0\0\0\0\0&\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0-\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01\0\0\0\0\0\0\0\0E\x01\0\0E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01\\\x01^\x01\0\0\\\x01]\x01\\\x01^\x01\0\0\\\x01\\\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\\\x01\0\0O\x01\0\0P\x01\\\x01\0\0O\x01\0\0\0\0\0\0\0\0\0\0\0\0R\x01W\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0S\x01\0\0V\x01Q\x01U\x01\0\0\0\0P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\0\0\0\0\0\0\0\0P\x01\0\0P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01T\x01P\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0P\x01\0\0\0\0P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\0\0\0\0\0\0\0\0P\x01\0\0P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\0\0w\x01\0\0\0\0v\x01\0\0\0\0\0\0\x91\x01\0\0\0\0\x91\x01\x91\x01\0\0[\x01Z\x01Y\x01\0\0\0\0c\x01b\x01a\x01{\x01z\x01\0\0y\x01\0\0\0\0X\x01u\x01y\x01\x91\x01\0\0`\x01\0\0z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01_\x01\0\0\0\0\0\0\0\0\0\0y\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01\0\0\0\0\0\0\0\0z\x01\0\0z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01\x81\x01\0\0\0\0\0\0y\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\0\0\0\0\0\0\0\0\x81\x01\0\0\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\0\0\0\0~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01\0\0\x7f\x01\0\0\0\0\0\0\0\0\0\0~\x01~\x01~\x01~\x01~\x01~\x01\0\0\0\0\x97\x01\x96\x01\x95\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x94\x01\0\0\0\0\0\0\x83\x01\0\0\0\0\0\0\0\0x\x01~\x01~\x01~\x01~\x01~\x01~\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\0\0\x82\x01\0\0\0\0\0\0\0\0\0\0\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\0\0\0\0\0\0\0\0\x83\x01\0\0\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x84\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\0\0\x82\x01\0\0\0\0\0\0\0\0\0\0\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\0\0\0\0\0\0\0\0\x84\x01\0\0\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x85\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\0\0\x82\x01\0\0\0\0\0\0\0\0\0\0\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\0\0\0\0\0\0\0\0\x85\x01\0\0\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x86\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\0\0\x82\x01\0\0\0\0\0\0\0\0\0\0\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\0\0\0\0\0\0\0\0\x86\x01\0\0\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x87\x01\x91\x01\x93\x01\0\0\x91\x01\x91\x01\0\0\0\0\0\0\0\0\0\0\0\0\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\0\0\x82\x01\x91\x01\0\0\0\0\0\0\0\0\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\0\0\0\0\0\0\0\0\x87\x01\0\0\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x88\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\0\0\x82\x01\0\0\0\0\0\0\0\0\0\0\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\0\0\0\0\0\0\0\0\x88\x01\0\0\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x88\x01\x91\x01\x93\x01\0\0\x91\x01\x92\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x91\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8c\x01\0\0\0\0\0\0\0\0\x97\x01\x96\x01\x95\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x94\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8b\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x90\x01\x8f\x01\x8e\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x8d\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\xff\xff",
  lex_check = "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\xfe\0\0\0\0\0<\x01C\x01q\x01v\x01\xa3\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\0\x05\0\x06\0\x07\0\b\0\b\0\t\0\t\0\n\0\x0b\0\x0b\0\f\0\r\0\x19\0\x1f\0#\0$\0$\0\x06\0*\0\x1a\0\x07\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0 \0!\0%\0\r\0-\0 \0!\0,\0%\0+\0+\0.\0/\0,\x001\x006\x007\x009\0;\0 \0!\0:\0:\0=\0;\0>\0?\0A\0\"\0)\x000\x000\x000\x000\x000\x000\x000\x000\x000\x000\x000\x002\0\f\x008\0@\0@\0@\0@\0@\0@\0@\0@\0@\0@\0@\0B\0D\0E\0F\0G\0H\0I\0J\0K\0L\0M\0\0\0\0\0\0\0\x18\0N\0k\0s\0u\0w\0z\0z\x000\0|\0\x8b\0\0\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0@\0\x9f\0\xa1\0\xa2\0\xa3\0\xa3\0\0\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\xa0\0\xa7\0\xa8\0\xab\0\x18\0\xa0\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x1b\0&\0\xa4\0\xaa\0&\0&\0\xa9\0\xa9\0\xa4\0\xaa\0\x1b\0\xac\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\xad\0\xaf\0&\0\xb0\0\xb3\0\xb4\0\xb5\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\xb6\0\xb7\0\xb7\0\xba\0\x1b\0\xbb\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1c\0\xb8\0\xbc\0\xbe\0\xbf\0\xc1\0\xc2\0\xb8\0\xc3\0\xc4\0\x1c\0\xc5\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\xc6\0\xc7\0\xc8\0\xc9\0\xca\0\xcd\0\xce\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\xcf\0\xcf\0\xd2\0\xd3\0\x1c\0\xd4\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\x005\0\xd0\0\xd6\x005\x005\0<\0\xd7\0\xd0\0<\0<\0a\0a\0a\0a\0a\0a\0a\0a\0a\0a\0\xf0\0\x1c\x01\x19\x015\0\x19\x01&\x01'\x01\x9a\0<\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0(\x01(\x01%\x01)\x01&\0&\0&\0%\x01.\x01)\x015\0/\x010\x010\x012\x01<\x003\x014\x01&\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\x006\x017\x01S\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0X\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0\x1f\x015\0I\x01I\x01Y\x01`\x01<\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0W\x01Z\x01Z\x01m\0S\0W\x01S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0S\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0a\x01b\x01b\x01d\x01m\0e\x01m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0m\0f\x015\x005\x005\x001\x01[\x01<\0<\0<\0T\x001\x01[\x01h\x01c\x01i\x015\0T\0\x88\x01T\0c\x01<\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0\x8c\x01\x8d\x01\x17\x01\x8e\x01\x94\x01\x8c\x01\x95\x01T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0\x98\x01\x17\x01\x8f\x01\x8f\x01T\0\x99\x01T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0U\0\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x07\x01\x96\x01\x96\x01\x9a\x01U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0@\x01\x9c\x01\x9d\x01@\x01\xa5\x01\x1f\x01\xff\xffU\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0\xff\xff\xff\xff\xff\xff\xff\xffU\0\xff\xffU\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0V\0\b\x01\b\x01\b\x01\b\x01\b\x01\b\x01\b\x01\b\x01\xff\xff\xff\xff\xff\xffV\0V\0V\0V\0V\0V\0V\0V\0V\0V\0\x90\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x90\x01V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0\xff\xff\xff\xff\xff\xff\xff\xffV\0\xff\xffV\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0W\0\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x0e\x01\x17\x01W\0\xff\xffW\0W\0W\0W\0W\0W\0W\0W\0W\0W\0\x97\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x97\x01W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0\xff\xff\xff\xff\xff\xff\xff\xffW\0\xff\xffW\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0W\0X\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff@\x01\xff\xff\xff\xff\xff\xff\xff\xffX\0X\0X\0X\0X\0X\0X\0X\0X\0X\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffX\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0\xff\xff\xff\xff\xff\xff\xff\xffX\0\xff\xffX\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0X\0Y\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffY\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffY\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0\xff\xff\xff\xff\xff\xff\xff\xffY\0\xff\xffY\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Y\0Z\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffZ\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffZ\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0\xff\xff\xff\xff\xff\xff\xff\xffZ\0\xff\xffZ\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0Z\0[\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\xff\xff\xff\xff\xff\xff\xff\xff[\0\xff\xff[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0[\0\\\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\xff\xff\xff\xff\xff\xff\xff\xff\\\0\xff\xff\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0]\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0\xff\xff\xff\xff\xff\xff\xff\xff]\0\xff\xff]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0]\0^\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff^\0\xff\xff^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0\xff\xff\xff\xff\xff\xff\xff\xff^\0\xff\xff^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0_\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0\xff\xff\xff\xff\xff\xff\xff\xff_\0\xff\xff_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0_\0`\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff`\0\xff\xff`\0\xff\xff\xff\xff`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0\xff\xff\xff\xff\xff\xff\xff\xff`\0\xff\xff`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffb\0b\0b\0b\0b\0b\0b\0b\0b\0b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffb\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0\xff\xff\xff\xff\xff\xff\xff\xffb\0\xff\xffb\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0c\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffc\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffc\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0\xff\xff\xff\xff\xff\xff\xff\xffc\0\xff\xffc\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0c\0d\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffd\0d\0d\0d\0d\0d\0d\0d\0d\0d\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffd\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0\xff\xff\xff\xff\xff\xff\xff\xffd\0\xff\xffd\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0e\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffe\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffe\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\xff\xff\xff\xff\xff\xff\xff\xffe\0\xff\xffe\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0f\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfff\0f\0f\0f\0f\0f\0f\0f\0f\0f\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfff\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0\xff\xff\xff\xff\xff\xff\xff\xfff\0\xff\xfff\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0g\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffg\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffg\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0\xff\xff\xff\xff\xff\xff\xff\xffg\0\xff\xffg\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0g\0h\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffh\0h\0h\0h\0h\0h\0h\0h\0h\0h\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffh\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0\xff\xff\xff\xff\xff\xff\xff\xffh\0\xff\xffh\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0i\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffi\0i\0i\0i\0i\0i\0i\0i\0i\0i\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffi\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0\xff\xff\xff\xff\xff\xff\xff\xffi\0\xff\xffi\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0j\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffF\x01F\x01\xff\xff\xff\xff\xff\xff\xff\xffj\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffj\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\xff\xff\xff\xff\xff\xff\xff\xffj\0\xff\xffj\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0j\0\x85\0\x85\0\xff\xff\x85\0\x85\0\xff\xff\xff\xff\xff\xff\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xae\0\xff\xff\xff\xff\xff\xff\xff\xff\x85\0\xff\xff\x85\0\xff\xff\x85\0\xff\xff\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\xae\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0F\x01\x85\0\xff\xff\x85\0\xff\xff\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x98\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\xff\xff\xff\xff\xff\xff\xff\xff\x98\0\xff\xff\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0\x98\0{\x01{\x01{\x01{\x01{\x01{\x01{\x01{\x01{\x01{\x01\xff\xff\xff\xff\x85\0\x85\0\x85\0\x99\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x85\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x85\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\xff\xff\xff\xff{\x01\xff\xff\x99\0\xff\xff\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x99\0\x9b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x9b\0\xff\xff\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\xff\xff\xff\xff\xff\xff\xff\xff\x9b\0\xff\xff\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9c\0\xa5\0\xff\xff\xff\xff\xa5\0\xa5\0\xff\xff\xff\xff\xff\xff\xff\xff\x9c\0\xff\xff\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\xff\xff\xff\xff\xa5\0\xff\xff\xff\xff\xff\xff\xff\xff\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\xff\xff\xff\xff\xff\xff\xff\xff\x9c\0\xff\xff\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9d\0\xff\xff\xf7\0\x9d\0\x9d\0\xb2\0\xff\xff\xff\xff\xb2\0\xb2\0\xb9\0\xff\xff\xff\xff\xb9\0\xb9\0*\x01\xff\xff\xff\xff*\x01*\x01\xff\xff\xff\xff\xff\xff\x9d\0\xff\xff\xff\xff\xf7\0\xff\xff\xb2\0\xff\xff\xff\xff\xf7\0\xff\xff\xb9\0\xff\xff\xff\xff\xff\xff\x9d\0*\x01\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\xd1\0\xff\xff\xff\xff\xd1\0\xd1\0\xb2\0\xff\xff\xff\xff\xff\xff\xff\xff\xb9\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xff\xff\xd1\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xf7\0\xff\xff\xd1\0\xff\xff\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xb2\0l\x01\xff\xff\xff\xffl\x01\xb9\0\xff\xff\xff\xff\xff\xff\xbd\0|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01|\x01\xff\xff|\x01\xd5\0\xd8\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xa5\0\xa5\0\xa5\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xff\xff\xa5\0\xff\xff\xff\xff\xff\xff\xff\xffl\x01\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xff\xff\xff\xff\xff\xff\xff\xff\xd8\0\xff\xff\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xff\xff\xff\xff\xff\xff\xff\xffl\x01\xff\xff\xff\xff\xff\xff\x9d\0\x9d\0\x9d\0\xff\xff\xff\xff\xb2\0\xb2\0\xb2\0\xff\xff\xff\xff\xb9\0\xb9\0\xb9\0\xff\xff\x9d\0*\x01*\x01*\x01\xff\xff\xb2\0\xff\xff\xff\xff\xff\xff\xff\xff\xb9\0\xff\xff\xff\xff\xff\xff\xff\xff*\x01\xff\xff\xff\xff\xf7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xd9\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xd1\0\xd1\0\xd1\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xff\xff\xd1\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xff\xff\xff\xff\xff\xff\xff\xff\xd9\0\xff\xff\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xd9\0\xda\0\xff\xffl\x01\xff\xff\xff\xff\xff\xff\xff\xff\xda\0\xff\xff\xda\0\xff\xff\xff\xff\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xff\xff\xff\xff\xff\xff\xff\xff\xda\0\xff\xff\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xdb\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xff\xff\xff\xff\xff\xff\xff\xff\xdb\0\xff\xff\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdd\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xff\xff\xff\xff\xff\xff\xff\xff\xdd\0\xff\xff\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xde\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xff\xff\xff\xff\xff\xff\xff\xff\xde\0\xff\xff\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xde\0\xdf\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xff\xff\xff\xff\xff\xff\xff\xff\xdf\0\xff\xff\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xdf\0\xe0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xff\xff\xff\xff\xff\xff\xff\xff\xe0\0\xff\xff\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe1\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xff\xff\xff\xff\xff\xff\xff\xff\xe1\0\xff\xff\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe2\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe2\0\xff\xff\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xff\xff\xff\xff\xff\xff\xff\xff\xe2\0\xff\xff\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe3\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xff\xff\xff\xff\xff\xff\xff\xff\xe3\0\xff\xff\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe4\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xff\xff\xff\xff\xff\xff\xff\xff\xe4\0\xff\xff\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe4\0\xe5\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xff\xff\xff\xff\xff\xff\xff\xff\xe5\0\xff\xff\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe5\0\xe6\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xff\xff\xff\xff\xff\xff\xff\xff\xe6\0\xff\xff\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe6\0\xe7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xff\xff\xff\xff\xff\xff\xff\xff\xe7\0\xff\xff\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe8\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xff\xff\xff\xff\xff\xff\xff\xff\xe8\0\xff\xff\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe8\0\xe9\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe9\0\xff\xff\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xff\xff\xff\xff\xff\xff\xff\xff\xe9\0\xff\xff\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xea\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xff\xff\xff\xff\xff\xff\xff\xff\xea\0\xff\xff\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xea\0\xeb\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xeb\0\xff\xff\xeb\0\xff\xff\xff\xff\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xff\xff\xff\xff\xff\xff\xff\xff\xeb\0\xff\xff\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xec\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xff\xff\xff\xff\xff\xff\xff\xff\xec\0\xff\xff\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xed\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xff\xff\xff\xff\xff\xff\xff\xff\xed\0\xff\xff\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xed\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xee\0\xff\xff\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xef\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xff\xff\xff\xff\xff\xff\xff\xff\xef\0\xff\xff\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xef\0\xf2\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xff\xff\xff\xff\xff\xff\xff\xff\xf2\0\xff\xff\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf2\0\xf3\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xff\xff\xff\xff\xff\xff\xff\xff\xf3\0\xff\xff\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf3\0\xf4\0+\x01+\x01\xff\xff+\x01+\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xff\xff\xff\xff+\x01\xff\xff\xff\xff\xff\xff\xff\xff\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xff\xff\xff\xff\xff\xff\xff\xff\xf4\0\xff\xff\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf4\0\xf5\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xfc\0\xff\xff\xff\xff\xfc\0\xf5\0\xff\xff\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xf5\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfc\0\xfc\0\xfc\0\xfc\0\xfc\0\xfc\0\xfc\0\xfc\x005\x015\x015\x015\x015\x015\x015\x015\x015\x015\x015\x01\xff\xff\xff\xff\xff\xff:\x01\xff\xff\xff\xff:\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff+\x01+\x01+\x01\xff\xff\xff\xff\xff\xff\xff\xff\xfc\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfc\0+\x01\xff\xff\xff\xff\xfc\x005\x01\xff\xff\xff\xff\xff\xff:\x01\xff\xff\xff\xff\xfc\0\xff\xff\xff\xff\xff\xff\xfc\0\xff\xff\xfc\0\xfc\0\xfc\0\xff\xff\xfc\0\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff:\x01:\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\xff\xff\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\xff\xff\xff\xff\\\x01\xff\xff\0\x01\\\x01\\\x01\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\xff\xff\xff\xff\xff\xff\t\x01\t\x01\t\x01\t\x01\t\x01\t\x01\xff\xff\xff\xff\xff\xff\\\x01\xff\xff\xff\xff\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\xff\xff\f\x01\f\x01\f\x01\f\x01\f\x01\f\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\xff\xff\xa0\x01\xff\xff\xfc\0\xa0\x01\xff\xff\xff\xff\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\xff\xff\xff\xff\xff\xff\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\x10\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xa0\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\xff\xff\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x11\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01#\x01#\x01:\x01#\x01#\x01\xff\xff\xff\xff\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\xff\xff\xff\xff\xff\xff\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\x12\x01\xa0\x01#\x01\xff\xff\xff\xff\xa0\x01\xff\xff\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01#\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x13\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\xff\xffg\x01g\x01g\x01g\x01g\x01g\x01g\x01g\x01g\x01g\x01g\x01\xff\xff\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\x9b\x01\xff\xff\xff\xff\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01\x15\x01?\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\\\x01\\\x01\\\x01g\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x15\x01\xff\xff\xff\xff\xff\xff\xff\xff\\\x01\x9b\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01\xff\xff\xff\xff\xff\xff\xff\xff?\x01\xff\xff?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01?\x01\xff\xff}\x01}\x01}\x01}\x01}\x01}\x01}\x01}\x01}\x01}\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xa0\x01\xff\xff}\x01}\x01}\x01}\x01}\x01}\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff#\x01#\x01#\x01E\x01}\x01}\x01}\x01}\x01}\x01}\x01\xff\xff\xff\xff\xff\xff\xff\xff#\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff#\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01\xff\xff\xff\xff\xff\xff\xff\xffE\x01\xff\xffE\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01E\x01M\x01M\x01\xff\xffM\x01M\x01]\x01]\x01\xff\xff]\x01]\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffM\x01\xff\xffM\x01\xff\xffM\x01]\x01\xff\xffM\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffM\x01M\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffM\x01\xff\xffM\x01M\x01M\x01\xff\xff\xff\xffM\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01\xff\xff\xff\xff\xff\xff\xff\xffM\x01\xff\xffM\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01M\x01P\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffP\x01\xff\xff\xff\xffP\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffP\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\xff\xff\xff\xff\xff\xff\xff\xffP\x01\xff\xffP\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01P\x01\xff\xffs\x01\xff\xff\xff\xffs\x01\xff\xff\xff\xff\xff\xff\x91\x01\xff\xff\xff\xff\x91\x01\x91\x01\xff\xffM\x01M\x01M\x01\xff\xff\xff\xff]\x01]\x01]\x01u\x01u\x01\xff\xffs\x01\xff\xff\xff\xffM\x01s\x01s\x01\x91\x01\xff\xff]\x01\xff\xffu\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01M\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffs\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01\xff\xff\xff\xff\xff\xff\xff\xffu\x01\xff\xffu\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01u\x01z\x01\xff\xff\xff\xff\xff\xffs\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffz\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffz\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01\xff\xff\xff\xff\xff\xff\xff\xffz\x01\xff\xffz\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01z\x01\xff\xff\xff\xff~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01~\x01\xff\xff~\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff~\x01~\x01~\x01~\x01~\x01~\x01\xff\xff\xff\xff\x91\x01\x91\x01\x91\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x91\x01\xff\xff\xff\xff\xff\xff\x81\x01\xff\xff\xff\xff\xff\xff\xff\xffs\x01~\x01~\x01~\x01~\x01~\x01~\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\xff\xff\x81\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\xff\xff\xff\xff\xff\xff\xff\xff\x81\x01\xff\xff\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x81\x01\x83\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\xff\xff\x83\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\xff\xff\xff\xff\xff\xff\xff\xff\x83\x01\xff\xff\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x83\x01\x84\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\xff\xff\x84\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\xff\xff\xff\xff\xff\xff\xff\xff\x84\x01\xff\xff\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x84\x01\x85\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\xff\xff\x85\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\xff\xff\xff\xff\xff\xff\xff\xff\x85\x01\xff\xff\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x85\x01\x86\x01\x92\x01\x92\x01\xff\xff\x92\x01\x92\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\xff\xff\x86\x01\x92\x01\xff\xff\xff\xff\xff\xff\xff\xff\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\xff\xff\xff\xff\xff\xff\xff\xff\x86\x01\xff\xff\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x86\x01\x87\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\xff\xff\x87\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\xff\xff\xff\xff\xff\xff\xff\xff\x87\x01\xff\xff\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x87\x01\x89\x01\x89\x01\xff\xff\x89\x01\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\x92\x01\x92\x01\x92\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x92\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01\x89\x01\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x89\x01",
  lex_base_code = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\x16\0\"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x02\0\0\0\0\0\0\0\x01\0\f\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0,\x006\0_\0B\0v\0L\0N\0\0\0\x81\0\0\0\x98\0\0\0\xa2\0\xac\0\xb6\0\0\0\xc0\0\0\0\xca\0\0\0\xe1\0\xeb\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x04\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0e\x01\x1a\x01&\x01W\x01\0\0\0\0\x01\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x07\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\x0b\0\r\0\x0f\0\xe5\0\x1a\0\b\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0H\x01\0\0\0\0\0\0\0\0y\x01\r\0\x1c\0\x10\0\x1a\x01\x1d\0E\0\x83\x01\0\0\x8d\x01\x9a\x01\xa4\x01\xae\x01\0\0\0\0\xb8\x01\xc2\x01\xdb\x01\xe5\x01\x89\0\x8b\0\0\0\xf9\x01\0\0\x03\x02\0\0\r\x02\x17\x02\0\0!\x02\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_backtrk_code = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\f\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x0f\0\x0f\0\0\0\x0f\0\0\0\x0f\0\x0f\0\0\0#\0\0\0&\0)\0)\0)\0\0\0)\0)\0\0\0,\0\0\0/\0\0\0\0\0,\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0W\0W\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0h\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0W\0k\0k\0s\0\0\0s\0v\0v\0W\0k\0~\0k\0k\0&\0\x8f\0/\0\x94\0\x99\0\x99\0\x99\0\x99\0\x99\0\x9e\0\xa1\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_default_code = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_trans_code = "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\t\0\t\0\t\0\t\0e\0\0\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\t\0\0\0\t\0\0\0\0\0\0\0\0\0e\0\0\0e\0\t\0e\0\0\0\0\0\0\0\0\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\0\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\0\0\x04\0\x04\0\x04\0\x04\0\x04\0\x04\0\x04\0\x04\0\x01\0\x01\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\0\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x18\0\x01\0\x01\0 \0 \0 \0 \0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0\t\0e\0\t\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0e\0e\x002\x002\x002\0\0\0\t\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0e\x002\0\t\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x1d\0\x8c\0\x8c\0\x8c\0\x8c\0\0\0\0\0\t\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x01\0e\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\x002\0\0\0\0\0\0\0\0\0\0\0\0\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x01\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\x12\0\0\0\0\0\0\0\0\0\0\0\0\0\x15\0\x15\0\x15\0\x15\0\x15\0\x15\x002\0\0\0\0\0M\0M\0M\0M\0M\0M\0M\0M\0M\0M\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0\0\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0M\0\0\0`\0`\0`\0`\0`\0`\0`\0`\0R\0R\x002\0\0\0\0\x002\x002\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0e\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x002\0M\0M\0M\0M\0M\0M\0M\0M\0M\0M\x002\0\0\0\0\x002\x002\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0\0\0\0\0\0\0e\0\0\0\0\0\0\0\0\x002\x002\x002\x002\x002\x002\x002\x002\x002\x002\x002\x002\0\0\0\0\0\0\0\0\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0\0\0\0\x002\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0R\0R\0R\0R\0R\0R\0R\0R\0R\0R\0{\0{\0{\0{\0{\0{\0{\0{\0{\0{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0{\0{\0{\0{\0{\0{\0R\0\0\0\x81\0\x81\0\x81\0\x81\0\x81\0\x81\0\x81\0\x81\0\x86\0\x86\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0\0\0\0\0\0\0\0\0\0\0\0\0{\0{\0{\0{\0{\0{\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0\x89\0R\0\0\0\x86\0\x86\0\x86\0\x86\0\x86\0\x86\0\x86\0\x86\0\x86\0\x86\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0p\0{\0{\0{\0{\0{\0{\0{\0{\0{\0{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0{\0{\0{\0{\0{\0{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0{\0{\0{\0{\0{\0{\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0",
  lex_check_code = "\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff5\0\xff\xff<\x005\x005\0<\0<\0\xb2\0\xff\xff\xb9\0\xb2\0\xb2\0\xb9\0\xb9\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff5\0\xff\xff<\0\xff\xff\xff\xff\xff\xff\xff\xff\xb2\0\xff\xff\xb9\0!\0\xa0\0\xff\xff\xff\xff\xff\xff\xff\xff\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1a\0\x1b\0\xff\xff\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1b\0\x1c\0\xff\xff\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0\x1c\0T\0T\0T\0T\0T\0T\0T\0T\0T\0T\0U\0U\0U\0U\0U\0U\0U\0U\0U\0U\0W\0\xff\xffW\0W\0W\0W\0W\0W\0W\0W\0W\0W\0Y\0Y\0Z\0Z\0>\0@\0@\0@\0@\0@\0@\0@\0@\0@\0@\0@\0A\0\xbb\0=\0V\0V\0V\0V\0V\0V\0V\0V\0V\0V\0\xba\0\xbe\0\xd2\0\xd3\0\xd6\0\xff\xff?\0V\0V\0V\0V\0V\0V\0X\0X\0X\0X\0X\0X\0X\0X\0\xbc\0\xd4\0@\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\\\0\xe4\0\xe4\0\xe5\0\xe5\0\xff\xff\xff\xffB\0V\0V\0V\0V\0V\0V\0^\0\xbf\0^\0^\0^\0^\0^\0^\0^\0^\0^\0^\0`\0`\0`\0`\0`\0`\0`\0`\0`\0`\0a\0a\0a\0a\0a\0a\0a\0a\0a\0a\0b\0b\0b\0b\0b\0b\0b\0b\0b\0b\0d\0d\0d\0d\0d\0d\0d\0d\0d\0d\0f\0f\0f\0f\0f\0f\0f\0f\0f\0f\0\xd7\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfff\0f\0f\0f\0f\0f\0h\0h\0h\0h\0h\0h\0h\0h\0h\0h\0i\0i\0i\0i\0i\0i\0i\0i\0i\0i\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfff\0f\0f\0f\0f\0f\0\x85\0\xff\xff\xff\xff\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x85\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9a\0\x9b\0\xff\xff\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9b\0\x9c\0\xff\xff\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9c\0\x9d\0\xff\xff\xff\xff\x9d\0\x9d\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xbd\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\x9d\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xcc\0\xd1\0\xff\xff\xff\xff\xd1\0\xd1\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\x9d\0\xff\xff\xff\xff\xff\xff\xbd\0\xff\xff\xff\xff\xff\xff\xff\xff\xd1\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xd5\0\xff\xff\xff\xff\xff\xff\xff\xff\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd1\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xd8\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xda\0\xff\xff\xff\xff\xd5\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdb\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdc\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xdd\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe0\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe2\0\xff\xff\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe2\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xe3\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe1\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe7\0\xe9\0\xff\xff\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xe9\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xeb\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xec\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xee\0\xee\0\xee\0\xee\0\xee\0\xee\0\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
  lex_code = "\xff\x01\xff\xff\x03\xff\x01\xff\xff\x02\xff\xff\0\x02\xff\0\x01\xff\x06\xff\xff\x07\xff\xff\x01\xff\x03\xff\xff\x05\xff\xff\x04\xff\xff\0\x04\xff\0\x05\xff\0\x03\xff\0\x06\xff\0\x07\xff\x11\xff\x10\xff\x0e\xff\r\xff\f\xff\x0b\xff\n\xff\t\xff\b\xff\x07\xff\x06\xff\x05\xff\x04\xff\xff\x13\xff\x12\xff\xff\x12\xff\x13\xff\xff\x03\x11\x02\x12\x01\x0f\0\x10\xff\x16\xff\x13\xff\xff\x14\xff\xff\0\x14\xff\x01\x13\0\x0e\xff\x15\xff\xff\0\r\xff\x01\x15\0\f\xff\x19\xff\xff\0\t\xff\x13\xff\x16\xff\xff\x13\xff\xff\x18\xff\xff\x17\xff\xff\x01\x17\0\x04\xff\x01\x18\0\x06\xff\x01\x16\0\b\xff\0\x0b\xff\x01\x19\0\n\xff"
};

function token(env, lexbuf) do
  lexbuf.lex_mem = Caml_array.caml_make_vect(8, -1);
  env_1 = env;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 0;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.new_engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          Lexing.new_line(lexbuf_1);
          return token(env_1, lexbuf_1); end end 
       if ___conditional___ == 1 then do
          env_2 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return token(env_2, lexbuf_1); end end 
       if ___conditional___ == 2 then do
          unicode_fix_cols(lexbuf_1);
          return token(env_1, lexbuf_1); end end 
       if ___conditional___ == 3 then do
          start = from_lb(env_1.lex_source, lexbuf_1);
          buf = __Buffer.create(127);
          match = comment(env_1, buf, lexbuf_1);
          env_3 = save_comment(match[1], start, match[2], buf, true);
          return token(env_3, lexbuf_1); end end 
       if ___conditional___ == 4 then do
          sp = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 2 | 0, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          escape_type = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          pattern = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          if (env_1.lex_enable_comment_syntax) then do
            env_4;
            if (env_1.lex_in_comment_syntax) then do
              loc = from_lb(env_1.lex_source, lexbuf_1);
              env_4 = unexpected_error(env_1, loc, pattern);
            end else do
              env_4 = env_1;
            end end 
            env_5 = in_comment_syntax(true, env_4);
            if (escape_type == ":") then do
              return --[[ tuple ]]{
                      env_5,
                      --[[ T_COLON ]]77
                    };
            end else do
              return token(env_5, lexbuf_1);
            end end 
          end else do
            start_1 = from_lb(env_1.lex_source, lexbuf_1);
            buf_1 = __Buffer.create(127);
            __Buffer.add_string(buf_1, sp);
            __Buffer.add_string(buf_1, escape_type);
            match_1 = comment(env_1, buf_1, lexbuf_1);
            env_6 = save_comment(match_1[1], start_1, match_1[2], buf_1, true);
            return token(env_6, lexbuf_1);
          end end  end end 
       if ___conditional___ == 5 then do
          if (env_1.lex_in_comment_syntax) then do
            env_7 = in_comment_syntax(false, env_1);
            return token(env_7, lexbuf_1);
          end else do
            yyback(1, lexbuf_1);
            return --[[ tuple ]]{
                    env_1,
                    --[[ T_MULT ]]97
                  };
          end end  end end 
       if ___conditional___ == 6 then do
          start_2 = from_lb(env_1.lex_source, lexbuf_1);
          buf_2 = __Buffer.create(127);
          match_2 = line_comment(env_1, buf_2, lexbuf_1);
          env_8 = save_comment(match_2[1], start_2, match_2[2], buf_2, false);
          return token(env_8, lexbuf_1); end end 
       if ___conditional___ == 7 then do
          if (lexbuf_1.lex_start_pos == 0) then do
            match_3 = line_comment(env_1, __Buffer.create(127), lexbuf_1);
            return token(match_3[1], lexbuf_1);
          end else do
            return --[[ tuple ]]{
                    env_1,
                    --[[ T_ERROR ]]104
                  };
          end end  end end 
       if ___conditional___ == 8 then do
          quote = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          start_3 = from_lb(env_1.lex_source, lexbuf_1);
          buf_3 = __Buffer.create(127);
          raw = __Buffer.create(127);
          __Buffer.add_char(raw, quote);
          match_4 = string_quote(env_1, quote, buf_3, raw, false, lexbuf_1);
          return --[[ tuple ]]{
                  match_4[1],
                  --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                        btwn(start_3, match_4[2]),
                        __Buffer.contents(buf_3),
                        __Buffer.contents(raw),
                        match_4[3]
                      }})
                }; end end 
       if ___conditional___ == 9 then do
          cooked = __Buffer.create(127);
          raw_1 = __Buffer.create(127);
          literal = __Buffer.create(127);
          __Buffer.add_string(literal, Lexing.lexeme(lexbuf_1));
          start_4 = from_lb(env_1.lex_source, lexbuf_1);
          match_5 = template_part(env_1, start_4, cooked, raw_1, literal, lexbuf_1);
          return --[[ tuple ]]{
                  match_5[1],
                  --[[ T_TEMPLATE_PART ]]Block.__(2, {--[[ tuple ]]{
                        match_5[2],
                        {
                          cooked = __Buffer.contents(cooked),
                          raw = __Buffer.contents(raw_1),
                          literal = __Buffer.contents(literal)
                        },
                        match_5[3]
                      }})
                }; end end 
       if ___conditional___ == 10 then do
          w = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w, --[[ T_NUMBER ]]Block.__(0, {--[[ BINARY ]]0})); end end 
       if ___conditional___ == 11 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NUMBER ]]Block.__(0, {--[[ BINARY ]]0})
                }; end end 
       if ___conditional___ == 12 then do
          w_1 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_1, --[[ T_NUMBER ]]Block.__(0, {--[[ OCTAL ]]2})); end end 
       if ___conditional___ == 13 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NUMBER ]]Block.__(0, {--[[ OCTAL ]]2})
                }; end end 
       if ___conditional___ == 14 then do
          w_2 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_2, --[[ T_NUMBER ]]Block.__(0, {--[[ LEGACY_OCTAL ]]1})); end end 
       if ___conditional___ == 15 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NUMBER ]]Block.__(0, {--[[ LEGACY_OCTAL ]]1})
                }; end end 
       if ___conditional___ == 16
       or ___conditional___ == 18
       or ___conditional___ == 20
       or ___conditional___ == 17
       or ___conditional___ == 19
       or ___conditional___ == 21 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NUMBER ]]Block.__(0, {--[[ NORMAL ]]3})
                }; end end 
       if ___conditional___ == 22 then do
          word = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          unicode_fix_cols(lexbuf_1);
          xpcall(function() do
            return --[[ tuple ]]{
                    env_1,
                    Hashtbl.find(keywords, word)
                  };
          end end,function(exn) do
            if (exn == Caml_builtin_exceptions.not_found) then do
              return --[[ tuple ]]{
                      env_1,
                      --[[ T_IDENTIFIER ]]0
                    };
            end else do
              error(exn)
            end end 
          end end) end end 
       if ___conditional___ == 23 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LCURLY ]]1
                }; end end 
       if ___conditional___ == 24 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RCURLY ]]2
                }; end end 
       if ___conditional___ == 25 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LPAREN ]]3
                }; end end 
       if ___conditional___ == 26 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RPAREN ]]4
                }; end end 
       if ___conditional___ == 27 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LBRACKET ]]5
                }; end end 
       if ___conditional___ == 28 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RBRACKET ]]6
                }; end end 
       if ___conditional___ == 29 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ELLIPSIS ]]11
                }; end end 
       if ___conditional___ == 30 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PERIOD ]]9
                }; end end 
       if ___conditional___ == 31 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_SEMICOLON ]]7
                }; end end 
       if ___conditional___ == 32 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_COMMA ]]8
                }; end end 
       if ___conditional___ == 33 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_COLON ]]77
                }; end end 
       if ___conditional___ == 34 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PLING ]]76
                }; end end 
       if ___conditional___ == 35 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_AND ]]79
                }; end end 
       if ___conditional___ == 36 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_OR ]]78
                }; end end 
       if ___conditional___ == 37 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_STRICT_EQUAL ]]85
                }; end end 
       if ___conditional___ == 38 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_STRICT_NOT_EQUAL ]]86
                }; end end 
       if ___conditional___ == 39 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LESS_THAN_EQUAL ]]87
                }; end end 
       if ___conditional___ == 40 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_GREATER_THAN_EQUAL ]]88
                }; end end 
       if ___conditional___ == 41 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_EQUAL ]]83
                }; end end 
       if ___conditional___ == 42 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NOT_EQUAL ]]84
                }; end end 
       if ___conditional___ == 43 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_INCR ]]102
                }; end end 
       if ___conditional___ == 44 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_DECR ]]103
                }; end end 
       if ___conditional___ == 45 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LSHIFT_ASSIGN ]]65
                }; end end 
       if ___conditional___ == 46 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LSHIFT ]]91
                }; end end 
       if ___conditional___ == 47 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RSHIFT_ASSIGN ]]64
                }; end end 
       if ___conditional___ == 48 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RSHIFT3_ASSIGN ]]63
                }; end end 
       if ___conditional___ == 49 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RSHIFT3 ]]93
                }; end end 
       if ___conditional___ == 50 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RSHIFT ]]92
                }; end end 
       if ___conditional___ == 51 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PLUS_ASSIGN ]]74
                }; end end 
       if ___conditional___ == 52 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MINUS_ASSIGN ]]73
                }; end end 
       if ___conditional___ == 53 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MULT_ASSIGN ]]71
                }; end end 
       if ___conditional___ == 54 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_EXP_ASSIGN ]]72
                }; end end 
       if ___conditional___ == 55 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MOD_ASSIGN ]]69
                }; end end 
       if ___conditional___ == 56 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_AND_ASSIGN ]]68
                }; end end 
       if ___conditional___ == 57 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_OR_ASSIGN ]]67
                }; end end 
       if ___conditional___ == 58 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_XOR_ASSIGN ]]66
                }; end end 
       if ___conditional___ == 59 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LESS_THAN ]]89
                }; end end 
       if ___conditional___ == 60 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_GREATER_THAN ]]90
                }; end end 
       if ___conditional___ == 61 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PLUS ]]94
                }; end end 
       if ___conditional___ == 62 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MINUS ]]95
                }; end end 
       if ___conditional___ == 63 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MULT ]]97
                }; end end 
       if ___conditional___ == 64 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_EXP ]]98
                }; end end 
       if ___conditional___ == 65 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MOD ]]99
                }; end end 
       if ___conditional___ == 66 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_OR ]]80
                }; end end 
       if ___conditional___ == 67 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_AND ]]82
                }; end end 
       if ___conditional___ == 68 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_XOR ]]81
                }; end end 
       if ___conditional___ == 69 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_NOT ]]100
                }; end end 
       if ___conditional___ == 70 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_NOT ]]101
                }; end end 
       if ___conditional___ == 71 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ASSIGN ]]75
                }; end end 
       if ___conditional___ == 72 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ARROW ]]10
                }; end end 
       if ___conditional___ == 73 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_DIV_ASSIGN ]]70
                }; end end 
       if ___conditional___ == 74 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_DIV ]]96
                }; end end 
       if ___conditional___ == 75 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_AT ]]12
                }; end end 
       if ___conditional___ == 76 then do
          env_9;
          if (env_1.lex_in_comment_syntax) then do
            loc_1 = from_lb(env_1.lex_source, lexbuf_1);
            env_9 = lex_error(env_1, loc_1, --[[ UnexpectedEOS ]]4);
          end else do
            env_9 = env_1;
          end end 
          return --[[ tuple ]]{
                  env_9,
                  --[[ T_EOF ]]105
                }; end end 
       if ___conditional___ == 77 then do
          env_10 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_10,
                  --[[ T_ERROR ]]104
                }; end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
    w_3 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
    return illegal_number(env_1, lexbuf_1, w_3, --[[ T_NUMBER ]]Block.__(0, {--[[ NORMAL ]]3}));
  end;
end end

function regexp_body(env, buf, lexbuf) do
  env_1 = env;
  buf_1 = buf;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 314;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          loc = from_lb(env_1.lex_source, lexbuf_1);
          env_2 = lex_error(env_1, loc, --[[ UnterminatedRegExp ]]13);
          return --[[ tuple ]]{
                  env_2,
                  ""
                }; end end 
       if ___conditional___ == 1 then do
          loc_1 = from_lb(env_1.lex_source, lexbuf_1);
          env_3 = lex_error(env_1, loc_1, --[[ UnterminatedRegExp ]]13);
          return --[[ tuple ]]{
                  env_3,
                  ""
                }; end end 
       if ___conditional___ == 2 then do
          s = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_start_pos + 2 | 0);
          __Buffer.add_string(buf_1, s);
          return regexp_body(env_1, buf_1, lexbuf_1); end end 
       if ___conditional___ == 3 then do
          flags = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 1 | 0, lexbuf_1.lex_curr_pos);
          return --[[ tuple ]]{
                  env_1,
                  flags
                }; end end 
       if ___conditional___ == 4 then do
          return --[[ tuple ]]{
                  env_1,
                  ""
                }; end end 
       if ___conditional___ == 5 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c);
          env_4 = regexp_class(env_1, buf_1, lexbuf_1);
          return regexp_body(env_4, buf_1, lexbuf_1); end end 
       if ___conditional___ == 6 then do
          loc_2 = from_lb(env_1.lex_source, lexbuf_1);
          env_5 = lex_error(env_1, loc_2, --[[ UnterminatedRegExp ]]13);
          return --[[ tuple ]]{
                  env_5,
                  ""
                }; end end 
       if ___conditional___ == 7 then do
          c_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c_1);
          return regexp_body(env_1, buf_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function regexp_class(env, buf, lexbuf) do
  env_1 = env;
  buf_1 = buf;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 326;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return env_1; end end 
       if ___conditional___ == 1
       or ___conditional___ == 2
       or ___conditional___ == 3 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c);
          return env_1; end end 
       if ___conditional___ == 4 then do
          c_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c_1);
          return regexp_class(env_1, buf_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
    s = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_start_pos + 2 | 0);
    __Buffer.add_string(buf_1, s);
    return regexp_class(env_1, buf_1, lexbuf_1);
  end;
end end

function line_comment(env, buf, lexbuf) do
  env_1 = env;
  buf_1 = buf;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 287;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return --[[ tuple ]]{
                  env_1,
                  from_lb(env_1.lex_source, lexbuf_1)
                }; end end 
       if ___conditional___ == 1 then do
          match = from_lb(env_1.lex_source, lexbuf_1);
          match_1 = match._end;
          Lexing.new_line(lexbuf_1);
          _end_line = match_1.line;
          _end_column = match_1.column - 1 | 0;
          _end_offset = match_1.offset - 1 | 0;
          _end = {
            line = _end_line,
            column = _end_column,
            offset = _end_offset
          };
          return --[[ tuple ]]{
                  env_1,
                  {
                    source = match.source,
                    start = match.start,
                    _end = _end
                  }
                }; end end 
       if ___conditional___ == 2 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c);
          return line_comment(env_1, buf_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function comment(env, buf, lexbuf) do
  env_1 = env;
  buf_1 = buf;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 279;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          env_2 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_2,
                  from_lb(env_2.lex_source, lexbuf_1)
                }; end end 
       if ___conditional___ == 1 then do
          Lexing.new_line(lexbuf_1);
          __Buffer.add_char(buf_1, --[[ "\n" ]]10);
          return comment(env_1, buf_1, lexbuf_1); end end 
       if ___conditional___ == 2 then do
          loc = from_lb(env_1.lex_source, lexbuf_1);
          env_3 = env_1.lex_in_comment_syntax and unexpected_error_w_suggest(env_1, loc, "]--", "]--") or env_1;
          return --[[ tuple ]]{
                  env_3,
                  loc
                }; end end 
       if ___conditional___ == 3 then do
          if (env_1.lex_in_comment_syntax) then do
            return --[[ tuple ]]{
                    env_1,
                    from_lb(env_1.lex_source, lexbuf_1)
                  };
          end else do
            __Buffer.add_string(buf_1, "*-/");
            return comment(env_1, buf_1, lexbuf_1);
          end end  end end 
       if ___conditional___ == 4 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c);
          return comment(env_1, buf_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function template_part(env, start, cooked, raw, literal, lexbuf) do
  env_1 = env;
  start_1 = start;
  cooked_1 = cooked;
  raw_1 = raw;
  literal_1 = literal;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 416;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          env_2 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_2,
                  btwn(start_1, from_lb(env_2.lex_source, lexbuf_1)),
                  true
                }; end end 
       if ___conditional___ == 1 then do
          __Buffer.add_char(literal_1, --[[ "`" ]]96);
          return --[[ tuple ]]{
                  env_1,
                  btwn(start_1, from_lb(env_1.lex_source, lexbuf_1)),
                  true
                }; end end 
       if ___conditional___ == 2 then do
          __Buffer.add_string(literal_1, "${");
          return --[[ tuple ]]{
                  env_1,
                  btwn(start_1, from_lb(env_1.lex_source, lexbuf_1)),
                  false
                }; end end 
       if ___conditional___ == 3 then do
          __Buffer.add_char(raw_1, --[[ "\\" ]]92);
          __Buffer.add_char(literal_1, --[[ "\\" ]]92);
          match = string_escape(env_1, cooked_1, lexbuf_1);
          str = Lexing.lexeme(lexbuf_1);
          __Buffer.add_string(raw_1, str);
          __Buffer.add_string(literal_1, str);
          return template_part(match[1], start_1, cooked_1, raw_1, literal_1, lexbuf_1); end end 
       if ___conditional___ == 4 then do
          lf = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_start_pos + 2 | 0);
          __Buffer.add_string(raw_1, lf);
          __Buffer.add_string(literal_1, lf);
          __Buffer.add_string(cooked_1, "\n");
          Lexing.new_line(lexbuf_1);
          return template_part(env_1, start_1, cooked_1, raw_1, literal_1, lexbuf_1); end end 
       if ___conditional___ == 5 then do
          lf_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, lf_1);
          __Buffer.add_char(literal_1, lf_1);
          __Buffer.add_char(cooked_1, --[[ "\n" ]]10);
          Lexing.new_line(lexbuf_1);
          return template_part(env_1, start_1, cooked_1, raw_1, literal_1, lexbuf_1); end end 
       if ___conditional___ == 6 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, c);
          __Buffer.add_char(literal_1, c);
          __Buffer.add_char(cooked_1, c);
          return template_part(env_1, start_1, cooked_1, raw_1, literal_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function string_quote(env, q, buf, raw, octal, lexbuf) do
  env_1 = env;
  q_1 = q;
  buf_1 = buf;
  raw_1 = raw;
  octal_1 = octal;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 247;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          q_prime = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, q_prime);
          if (q_1 == q_prime) then do
            return --[[ tuple ]]{
                    env_1,
                    from_lb(env_1.lex_source, lexbuf_1),
                    octal_1
                  };
          end else do
            __Buffer.add_char(buf_1, q_prime);
            return string_quote(env_1, q_1, buf_1, raw_1, octal_1, lexbuf_1);
          end end  end end 
       if ___conditional___ == 1 then do
          e = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, e);
          match = string_escape(env_1, buf_1, lexbuf_1);
          octal_2 = match[2] or octal_1;
          __Buffer.add_string(raw_1, Lexing.lexeme(lexbuf_1));
          return string_quote(match[1], q_1, buf_1, raw_1, octal_2, lexbuf_1); end end 
       if ___conditional___ == 2 then do
          x = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, x);
          env_2 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          __Buffer.add_string(buf_1, x);
          return --[[ tuple ]]{
                  env_2,
                  from_lb(env_2.lex_source, lexbuf_1),
                  octal_1
                }; end end 
       if ___conditional___ == 3 then do
          x_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, x_1);
          __Buffer.add_char(buf_1, x_1);
          return string_quote(env_1, q_1, buf_1, raw_1, octal_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function __ocaml_lex_template_tail_rec(_env, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    env = _env;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          Lexing.new_line(lexbuf);
          ___ocaml_lex_state = 393;
          ::continue:: ; end end 
       if ___conditional___ == 1 then do
          unicode_fix_cols(lexbuf);
          ___ocaml_lex_state = 393;
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          start = from_lb(env.lex_source, lexbuf);
          buf = __Buffer.create(127);
          match = line_comment(env, buf, lexbuf);
          env_1 = save_comment(match[1], start, match[2], buf, true);
          ___ocaml_lex_state = 393;
          _env = env_1;
          ::continue:: ; end end 
       if ___conditional___ == 3 then do
          start_1 = from_lb(env.lex_source, lexbuf);
          buf_1 = __Buffer.create(127);
          match_1 = comment(env, buf_1, lexbuf);
          env_2 = save_comment(match_1[1], start_1, match_1[2], buf_1, true);
          ___ocaml_lex_state = 393;
          _env = env_2;
          ::continue:: ; end end 
       if ___conditional___ == 4 then do
          start_2 = from_lb(env.lex_source, lexbuf);
          cooked = __Buffer.create(127);
          raw = __Buffer.create(127);
          literal = __Buffer.create(127);
          __Buffer.add_string(literal, "}");
          match_2 = template_part(env, start_2, cooked, raw, literal, lexbuf);
          return --[[ tuple ]]{
                  match_2[1],
                  --[[ T_TEMPLATE_PART ]]Block.__(2, {--[[ tuple ]]{
                        match_2[2],
                        {
                          cooked = __Buffer.contents(cooked),
                          raw = __Buffer.contents(raw),
                          literal = __Buffer.contents(literal)
                        },
                        match_2[3]
                      }})
                }; end end 
       if ___conditional___ == 5 then do
          env_3 = lex_error(env, from_lb(env.lex_source, lexbuf), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_3,
                  --[[ T_TEMPLATE_PART ]]Block.__(2, {--[[ tuple ]]{
                        from_lb(env_3.lex_source, lexbuf),
                        {
                          cooked = "",
                          raw = "",
                          literal = ""
                        },
                        true
                      }})
                }; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function __ocaml_lex_jsx_tag_rec(_env, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    env = _env;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_EOF ]]105
                }; end end 
       if ___conditional___ == 1 then do
          Lexing.new_line(lexbuf);
          ___ocaml_lex_state = 333;
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          unicode_fix_cols(lexbuf);
          ___ocaml_lex_state = 333;
          ::continue:: ; end end 
       if ___conditional___ == 3 then do
          start = from_lb(env.lex_source, lexbuf);
          buf = __Buffer.create(127);
          match = line_comment(env, buf, lexbuf);
          env_1 = save_comment(match[1], start, match[2], buf, true);
          ___ocaml_lex_state = 333;
          _env = env_1;
          ::continue:: ; end end 
       if ___conditional___ == 4 then do
          start_1 = from_lb(env.lex_source, lexbuf);
          buf_1 = __Buffer.create(127);
          match_1 = comment(env, buf_1, lexbuf);
          env_2 = save_comment(match_1[1], start_1, match_1[2], buf_1, true);
          ___ocaml_lex_state = 333;
          _env = env_2;
          ::continue:: ; end end 
       if ___conditional___ == 5 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_LESS_THAN ]]89
                }; end end 
       if ___conditional___ == 6 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_DIV ]]96
                }; end end 
       if ___conditional___ == 7 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_GREATER_THAN ]]90
                }; end end 
       if ___conditional___ == 8 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_LCURLY ]]1
                }; end end 
       if ___conditional___ == 9 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_COLON ]]77
                }; end end 
       if ___conditional___ == 10 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_PERIOD ]]9
                }; end end 
       if ___conditional___ == 11 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_ASSIGN ]]75
                }; end end 
       if ___conditional___ == 12 then do
          unicode_fix_cols(lexbuf);
          return --[[ tuple ]]{
                  env,
                  --[[ T_JSX_IDENTIFIER ]]106
                }; end end 
       if ___conditional___ == 13 then do
          quote = Caml_bytes.get(lexbuf.lex_buffer, lexbuf.lex_start_pos);
          start_2 = from_lb(env.lex_source, lexbuf);
          buf_2 = __Buffer.create(127);
          raw = __Buffer.create(127);
          __Buffer.add_char(raw, quote);
          mode = quote == --[[ "'" ]]39 and --[[ JSX_SINGLE_QUOTED_TEXT ]]0 or --[[ JSX_DOUBLE_QUOTED_TEXT ]]1;
          match_2 = jsx_text(env, mode, buf_2, raw, lexbuf);
          __Buffer.add_char(raw, quote);
          value = __Buffer.contents(buf_2);
          raw_1 = __Buffer.contents(raw);
          return --[[ tuple ]]{
                  match_2[1],
                  --[[ T_JSX_TEXT ]]Block.__(4, {--[[ tuple ]]{
                        btwn(start_2, match_2[2]),
                        value,
                        raw_1
                      }})
                }; end end 
       if ___conditional___ == 14 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_ERROR ]]104
                }; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function jsx_text(env, mode, buf, raw, lexbuf) do
  env_1 = env;
  mode_1 = mode;
  buf_1 = buf;
  raw_1 = raw;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 371;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          local ___conditional___=(mode_1);
          do
             if ___conditional___ == 0--[[ JSX_SINGLE_QUOTED_TEXT ]] then do
                if (c == 39) then do
                  return --[[ tuple ]]{
                          env_1,
                          from_lb(env_1.lex_source, lexbuf_1)
                        };
                end
                 end  end else 
             if ___conditional___ == 1--[[ JSX_DOUBLE_QUOTED_TEXT ]] then do
                if (c == 34) then do
                  return --[[ tuple ]]{
                          env_1,
                          from_lb(env_1.lex_source, lexbuf_1)
                        };
                end
                 end  end else 
             if ___conditional___ == 2--[[ JSX_CHILD_TEXT ]] then do
                exit = 0;
                if (not (c ~= 60 and c ~= 123)) then do
                  exit = 2;
                end
                 end 
                if (exit == 2) then do
                  back(lexbuf_1);
                  return --[[ tuple ]]{
                          env_1,
                          from_lb(env_1.lex_source, lexbuf_1)
                        };
                end
                 end  end else 
             end end end end end end
            
          end
          __Buffer.add_char(raw_1, c);
          __Buffer.add_char(buf_1, c);
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
       if ___conditional___ == 1 then do
          env_2 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_2,
                  from_lb(env_2.lex_source, lexbuf_1)
                }; end end 
       if ___conditional___ == 2 then do
          lt = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, lt);
          __Buffer.add_string(buf_1, lt);
          Lexing.new_line(lexbuf_1);
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
       if ___conditional___ == 3 then do
          n = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 3 | 0, lexbuf_1.lex_curr_pos - 1 | 0);
          s = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, s);
          code = Caml_format.caml_int_of_string("0x" .. n);
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code));
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
       if ___conditional___ == 4 then do
          n_1 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 2 | 0, lexbuf_1.lex_curr_pos - 1 | 0);
          s_1 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, s_1);
          code_1 = Caml_format.caml_int_of_string(n_1);
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code_1));
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
       if ___conditional___ == 5 then do
          entity = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 1 | 0, lexbuf_1.lex_curr_pos - 1 | 0);
          s_2 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, s_2);
          code_2;
          local ___conditional___=(entity);
          do
             if ___conditional___ == "'int'" then do
                code_2 = 8747; end else 
             if ___conditional___ == "AElig" then do
                code_2 = 198; end else 
             if ___conditional___ == "Aacute" then do
                code_2 = 193; end else 
             if ___conditional___ == "Acirc" then do
                code_2 = 194; end else 
             if ___conditional___ == "Agrave" then do
                code_2 = 192; end else 
             if ___conditional___ == "Alpha" then do
                code_2 = 913; end else 
             if ___conditional___ == "Aring" then do
                code_2 = 197; end else 
             if ___conditional___ == "Atilde" then do
                code_2 = 195; end else 
             if ___conditional___ == "Auml" then do
                code_2 = 196; end else 
             if ___conditional___ == "Beta" then do
                code_2 = 914; end else 
             if ___conditional___ == "Ccedil" then do
                code_2 = 199; end else 
             if ___conditional___ == "Chi" then do
                code_2 = 935; end else 
             if ___conditional___ == "Dagger" then do
                code_2 = 8225; end else 
             if ___conditional___ == "Delta" then do
                code_2 = 916; end else 
             if ___conditional___ == "ETH" then do
                code_2 = 208; end else 
             if ___conditional___ == "Eacute" then do
                code_2 = 201; end else 
             if ___conditional___ == "Ecirc" then do
                code_2 = 202; end else 
             if ___conditional___ == "Egrave" then do
                code_2 = 200; end else 
             if ___conditional___ == "Epsilon" then do
                code_2 = 917; end else 
             if ___conditional___ == "Eta" then do
                code_2 = 919; end else 
             if ___conditional___ == "Euml" then do
                code_2 = 203; end else 
             if ___conditional___ == "Gamma" then do
                code_2 = 915; end else 
             if ___conditional___ == "Iacute" then do
                code_2 = 205; end else 
             if ___conditional___ == "Icirc" then do
                code_2 = 206; end else 
             if ___conditional___ == "Igrave" then do
                code_2 = 204; end else 
             if ___conditional___ == "Iota" then do
                code_2 = 921; end else 
             if ___conditional___ == "Iuml" then do
                code_2 = 207; end else 
             if ___conditional___ == "Kappa" then do
                code_2 = 922; end else 
             if ___conditional___ == "Lambda" then do
                code_2 = 923; end else 
             if ___conditional___ == "Mu" then do
                code_2 = 924; end else 
             if ___conditional___ == "Ntilde" then do
                code_2 = 209; end else 
             if ___conditional___ == "Nu" then do
                code_2 = 925; end else 
             if ___conditional___ == "OElig" then do
                code_2 = 338; end else 
             if ___conditional___ == "Oacute" then do
                code_2 = 211; end else 
             if ___conditional___ == "Ocirc" then do
                code_2 = 212; end else 
             if ___conditional___ == "Ograve" then do
                code_2 = 210; end else 
             if ___conditional___ == "Omega" then do
                code_2 = 937; end else 
             if ___conditional___ == "Omicron" then do
                code_2 = 927; end else 
             if ___conditional___ == "Oslash" then do
                code_2 = 216; end else 
             if ___conditional___ == "Otilde" then do
                code_2 = 213; end else 
             if ___conditional___ == "Ouml" then do
                code_2 = 214; end else 
             if ___conditional___ == "Phi" then do
                code_2 = 934; end else 
             if ___conditional___ == "Pi" then do
                code_2 = 928; end else 
             if ___conditional___ == "Prime" then do
                code_2 = 8243; end else 
             if ___conditional___ == "Psi" then do
                code_2 = 936; end else 
             if ___conditional___ == "Rho" then do
                code_2 = 929; end else 
             if ___conditional___ == "Scaron" then do
                code_2 = 352; end else 
             if ___conditional___ == "Sigma" then do
                code_2 = 931; end else 
             if ___conditional___ == "THORN" then do
                code_2 = 222; end else 
             if ___conditional___ == "Tau" then do
                code_2 = 932; end else 
             if ___conditional___ == "Theta" then do
                code_2 = 920; end else 
             if ___conditional___ == "Uacute" then do
                code_2 = 218; end else 
             if ___conditional___ == "Ucirc" then do
                code_2 = 219; end else 
             if ___conditional___ == "Ugrave" then do
                code_2 = 217; end else 
             if ___conditional___ == "Upsilon" then do
                code_2 = 933; end else 
             if ___conditional___ == "Uuml" then do
                code_2 = 220; end else 
             if ___conditional___ == "Xi" then do
                code_2 = 926; end else 
             if ___conditional___ == "Yacute" then do
                code_2 = 221; end else 
             if ___conditional___ == "Yuml" then do
                code_2 = 376; end else 
             if ___conditional___ == "Zeta" then do
                code_2 = 918; end else 
             if ___conditional___ == "aacute" then do
                code_2 = 225; end else 
             if ___conditional___ == "acirc" then do
                code_2 = 226; end else 
             if ___conditional___ == "acute" then do
                code_2 = 180; end else 
             if ___conditional___ == "aelig" then do
                code_2 = 230; end else 
             if ___conditional___ == "agrave" then do
                code_2 = 224; end else 
             if ___conditional___ == "alefsym" then do
                code_2 = 8501; end else 
             if ___conditional___ == "alpha" then do
                code_2 = 945; end else 
             if ___conditional___ == "amp" then do
                code_2 = 38; end else 
             if ___conditional___ == "and" then do
                code_2 = 8743; end else 
             if ___conditional___ == "ang" then do
                code_2 = 8736; end else 
             if ___conditional___ == "apos" then do
                code_2 = 39; end else 
             if ___conditional___ == "aring" then do
                code_2 = 229; end else 
             if ___conditional___ == "asymp" then do
                code_2 = 8776; end else 
             if ___conditional___ == "atilde" then do
                code_2 = 227; end else 
             if ___conditional___ == "auml" then do
                code_2 = 228; end else 
             if ___conditional___ == "bdquo" then do
                code_2 = 8222; end else 
             if ___conditional___ == "beta" then do
                code_2 = 946; end else 
             if ___conditional___ == "brvbar" then do
                code_2 = 166; end else 
             if ___conditional___ == "bull" then do
                code_2 = 8226; end else 
             if ___conditional___ == "cap" then do
                code_2 = 8745; end else 
             if ___conditional___ == "ccedil" then do
                code_2 = 231; end else 
             if ___conditional___ == "cedil" then do
                code_2 = 184; end else 
             if ___conditional___ == "cent" then do
                code_2 = 162; end else 
             if ___conditional___ == "chi" then do
                code_2 = 967; end else 
             if ___conditional___ == "circ" then do
                code_2 = 710; end else 
             if ___conditional___ == "clubs" then do
                code_2 = 9827; end else 
             if ___conditional___ == "cong" then do
                code_2 = 8773; end else 
             if ___conditional___ == "copy" then do
                code_2 = 169; end else 
             if ___conditional___ == "crarr" then do
                code_2 = 8629; end else 
             if ___conditional___ == "cup" then do
                code_2 = 8746; end else 
             if ___conditional___ == "curren" then do
                code_2 = 164; end else 
             if ___conditional___ == "dArr" then do
                code_2 = 8659; end else 
             if ___conditional___ == "dagger" then do
                code_2 = 8224; end else 
             if ___conditional___ == "darr" then do
                code_2 = 8595; end else 
             if ___conditional___ == "deg" then do
                code_2 = 176; end else 
             if ___conditional___ == "delta" then do
                code_2 = 948; end else 
             if ___conditional___ == "diams" then do
                code_2 = 9830; end else 
             if ___conditional___ == "divide" then do
                code_2 = 247; end else 
             if ___conditional___ == "eacute" then do
                code_2 = 233; end else 
             if ___conditional___ == "ecirc" then do
                code_2 = 234; end else 
             if ___conditional___ == "egrave" then do
                code_2 = 232; end else 
             if ___conditional___ == "empty" then do
                code_2 = 8709; end else 
             if ___conditional___ == "emsp" then do
                code_2 = 8195; end else 
             if ___conditional___ == "ensp" then do
                code_2 = 8194; end else 
             if ___conditional___ == "epsilon" then do
                code_2 = 949; end else 
             if ___conditional___ == "equiv" then do
                code_2 = 8801; end else 
             if ___conditional___ == "eta" then do
                code_2 = 951; end else 
             if ___conditional___ == "eth" then do
                code_2 = 240; end else 
             if ___conditional___ == "euml" then do
                code_2 = 235; end else 
             if ___conditional___ == "euro" then do
                code_2 = 8364; end else 
             if ___conditional___ == "exist" then do
                code_2 = 8707; end else 
             if ___conditional___ == "fnof" then do
                code_2 = 402; end else 
             if ___conditional___ == "forall" then do
                code_2 = 8704; end else 
             if ___conditional___ == "frac12" then do
                code_2 = 189; end else 
             if ___conditional___ == "frac14" then do
                code_2 = 188; end else 
             if ___conditional___ == "frac34" then do
                code_2 = 190; end else 
             if ___conditional___ == "frasl" then do
                code_2 = 8260; end else 
             if ___conditional___ == "gamma" then do
                code_2 = 947; end else 
             if ___conditional___ == "ge" then do
                code_2 = 8805; end else 
             if ___conditional___ == "gt" then do
                code_2 = 62; end else 
             if ___conditional___ == "hArr" then do
                code_2 = 8660; end else 
             if ___conditional___ == "harr" then do
                code_2 = 8596; end else 
             if ___conditional___ == "hearts" then do
                code_2 = 9829; end else 
             if ___conditional___ == "hellip" then do
                code_2 = 8230; end else 
             if ___conditional___ == "iacute" then do
                code_2 = 237; end else 
             if ___conditional___ == "icirc" then do
                code_2 = 238; end else 
             if ___conditional___ == "iexcl" then do
                code_2 = 161; end else 
             if ___conditional___ == "igrave" then do
                code_2 = 236; end else 
             if ___conditional___ == "image" then do
                code_2 = 8465; end else 
             if ___conditional___ == "infin" then do
                code_2 = 8734; end else 
             if ___conditional___ == "iota" then do
                code_2 = 953; end else 
             if ___conditional___ == "iquest" then do
                code_2 = 191; end else 
             if ___conditional___ == "isin" then do
                code_2 = 8712; end else 
             if ___conditional___ == "iuml" then do
                code_2 = 239; end else 
             if ___conditional___ == "kappa" then do
                code_2 = 954; end else 
             if ___conditional___ == "lArr" then do
                code_2 = 8656; end else 
             if ___conditional___ == "lambda" then do
                code_2 = 955; end else 
             if ___conditional___ == "lang" then do
                code_2 = 10216; end else 
             if ___conditional___ == "laquo" then do
                code_2 = 171; end else 
             if ___conditional___ == "larr" then do
                code_2 = 8592; end else 
             if ___conditional___ == "lceil" then do
                code_2 = 8968; end else 
             if ___conditional___ == "ldquo" then do
                code_2 = 8220; end else 
             if ___conditional___ == "le" then do
                code_2 = 8804; end else 
             if ___conditional___ == "lfloor" then do
                code_2 = 8970; end else 
             if ___conditional___ == "lowast" then do
                code_2 = 8727; end else 
             if ___conditional___ == "loz" then do
                code_2 = 9674; end else 
             if ___conditional___ == "lrm" then do
                code_2 = 8206; end else 
             if ___conditional___ == "lsaquo" then do
                code_2 = 8249; end else 
             if ___conditional___ == "lsquo" then do
                code_2 = 8216; end else 
             if ___conditional___ == "lt" then do
                code_2 = 60; end else 
             if ___conditional___ == "macr" then do
                code_2 = 175; end else 
             if ___conditional___ == "mdash" then do
                code_2 = 8212; end else 
             if ___conditional___ == "micro" then do
                code_2 = 181; end else 
             if ___conditional___ == "middot" then do
                code_2 = 183; end else 
             if ___conditional___ == "minus" then do
                code_2 = 8722; end else 
             if ___conditional___ == "mu" then do
                code_2 = 956; end else 
             if ___conditional___ == "nabla" then do
                code_2 = 8711; end else 
             if ___conditional___ == "nbsp" then do
                code_2 = 160; end else 
             if ___conditional___ == "ndash" then do
                code_2 = 8211; end else 
             if ___conditional___ == "ne" then do
                code_2 = 8800; end else 
             if ___conditional___ == "ni" then do
                code_2 = 8715; end else 
             if ___conditional___ == "not" then do
                code_2 = 172; end else 
             if ___conditional___ == "notin" then do
                code_2 = 8713; end else 
             if ___conditional___ == "nsub" then do
                code_2 = 8836; end else 
             if ___conditional___ == "ntilde" then do
                code_2 = 241; end else 
             if ___conditional___ == "nu" then do
                code_2 = 957; end else 
             if ___conditional___ == "oacute" then do
                code_2 = 243; end else 
             if ___conditional___ == "ocirc" then do
                code_2 = 244; end else 
             if ___conditional___ == "oelig" then do
                code_2 = 339; end else 
             if ___conditional___ == "ograve" then do
                code_2 = 242; end else 
             if ___conditional___ == "oline" then do
                code_2 = 8254; end else 
             if ___conditional___ == "omega" then do
                code_2 = 969; end else 
             if ___conditional___ == "omicron" then do
                code_2 = 959; end else 
             if ___conditional___ == "oplus" then do
                code_2 = 8853; end else 
             if ___conditional___ == "or" then do
                code_2 = 8744; end else 
             if ___conditional___ == "ordf" then do
                code_2 = 170; end else 
             if ___conditional___ == "ordm" then do
                code_2 = 186; end else 
             if ___conditional___ == "oslash" then do
                code_2 = 248; end else 
             if ___conditional___ == "otilde" then do
                code_2 = 245; end else 
             if ___conditional___ == "otimes" then do
                code_2 = 8855; end else 
             if ___conditional___ == "ouml" then do
                code_2 = 246; end else 
             if ___conditional___ == "para" then do
                code_2 = 182; end else 
             if ___conditional___ == "part" then do
                code_2 = 8706; end else 
             if ___conditional___ == "permil" then do
                code_2 = 8240; end else 
             if ___conditional___ == "perp" then do
                code_2 = 8869; end else 
             if ___conditional___ == "phi" then do
                code_2 = 966; end else 
             if ___conditional___ == "pi" then do
                code_2 = 960; end else 
             if ___conditional___ == "piv" then do
                code_2 = 982; end else 
             if ___conditional___ == "plusmn" then do
                code_2 = 177; end else 
             if ___conditional___ == "pound" then do
                code_2 = 163; end else 
             if ___conditional___ == "prime" then do
                code_2 = 8242; end else 
             if ___conditional___ == "prod" then do
                code_2 = 8719; end else 
             if ___conditional___ == "prop" then do
                code_2 = 8733; end else 
             if ___conditional___ == "psi" then do
                code_2 = 968; end else 
             if ___conditional___ == "quot" then do
                code_2 = 34; end else 
             if ___conditional___ == "rArr" then do
                code_2 = 8658; end else 
             if ___conditional___ == "radic" then do
                code_2 = 8730; end else 
             if ___conditional___ == "rang" then do
                code_2 = 10217; end else 
             if ___conditional___ == "raquo" then do
                code_2 = 187; end else 
             if ___conditional___ == "rarr" then do
                code_2 = 8594; end else 
             if ___conditional___ == "rceil" then do
                code_2 = 8969; end else 
             if ___conditional___ == "rdquo" then do
                code_2 = 8221; end else 
             if ___conditional___ == "real" then do
                code_2 = 8476; end else 
             if ___conditional___ == "reg" then do
                code_2 = 174; end else 
             if ___conditional___ == "rfloor" then do
                code_2 = 8971; end else 
             if ___conditional___ == "rho" then do
                code_2 = 961; end else 
             if ___conditional___ == "rlm" then do
                code_2 = 8207; end else 
             if ___conditional___ == "rsaquo" then do
                code_2 = 8250; end else 
             if ___conditional___ == "rsquo" then do
                code_2 = 8217; end else 
             if ___conditional___ == "sbquo" then do
                code_2 = 8218; end else 
             if ___conditional___ == "scaron" then do
                code_2 = 353; end else 
             if ___conditional___ == "sdot" then do
                code_2 = 8901; end else 
             if ___conditional___ == "sect" then do
                code_2 = 167; end else 
             if ___conditional___ == "shy" then do
                code_2 = 173; end else 
             if ___conditional___ == "sigma" then do
                code_2 = 963; end else 
             if ___conditional___ == "sigmaf" then do
                code_2 = 962; end else 
             if ___conditional___ == "sim" then do
                code_2 = 8764; end else 
             if ___conditional___ == "spades" then do
                code_2 = 9824; end else 
             if ___conditional___ == "sub" then do
                code_2 = 8834; end else 
             if ___conditional___ == "sube" then do
                code_2 = 8838; end else 
             if ___conditional___ == "sum" then do
                code_2 = 8721; end else 
             if ___conditional___ == "sup" then do
                code_2 = 8835; end else 
             if ___conditional___ == "sup1" then do
                code_2 = 185; end else 
             if ___conditional___ == "sup2" then do
                code_2 = 178; end else 
             if ___conditional___ == "sup3" then do
                code_2 = 179; end else 
             if ___conditional___ == "supe" then do
                code_2 = 8839; end else 
             if ___conditional___ == "szlig" then do
                code_2 = 223; end else 
             if ___conditional___ == "tau" then do
                code_2 = 964; end else 
             if ___conditional___ == "there4" then do
                code_2 = 8756; end else 
             if ___conditional___ == "theta" then do
                code_2 = 952; end else 
             if ___conditional___ == "thetasym" then do
                code_2 = 977; end else 
             if ___conditional___ == "thinsp" then do
                code_2 = 8201; end else 
             if ___conditional___ == "thorn" then do
                code_2 = 254; end else 
             if ___conditional___ == "tilde" then do
                code_2 = 732; end else 
             if ___conditional___ == "times" then do
                code_2 = 215; end else 
             if ___conditional___ == "trade" then do
                code_2 = 8482; end else 
             if ___conditional___ == "uArr" then do
                code_2 = 8657; end else 
             if ___conditional___ == "uacute" then do
                code_2 = 250; end else 
             if ___conditional___ == "uarr" then do
                code_2 = 8593; end else 
             if ___conditional___ == "ucirc" then do
                code_2 = 251; end else 
             if ___conditional___ == "ugrave" then do
                code_2 = 249; end else 
             if ___conditional___ == "uml" then do
                code_2 = 168; end else 
             if ___conditional___ == "upsih" then do
                code_2 = 978; end else 
             if ___conditional___ == "upsilon" then do
                code_2 = 965; end else 
             if ___conditional___ == "uuml" then do
                code_2 = 252; end else 
             if ___conditional___ == "weierp" then do
                code_2 = 8472; end else 
             if ___conditional___ == "xi" then do
                code_2 = 958; end else 
             if ___conditional___ == "yacute" then do
                code_2 = 253; end else 
             if ___conditional___ == "yen" then do
                code_2 = 165; end else 
             if ___conditional___ == "yuml" then do
                code_2 = 255; end else 
             if ___conditional___ == "zeta" then do
                code_2 = 950; end else 
             if ___conditional___ == "zwj" then do
                code_2 = 8205; end else 
             if ___conditional___ == "zwnj" then do
                code_2 = 8204; end else 
             end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end
            code_2 = nil;
              
          end
          if (code_2 ~= nil) then do
            List.iter((function(param) do
                    return __Buffer.add_char(buf_1, param);
                  end end), utf16to8(code_2));
          end else do
            __Buffer.add_string(buf_1, "&" .. (entity .. ";"));
          end end 
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
       if ___conditional___ == 6 then do
          c_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, c_1);
          __Buffer.add_char(buf_1, c_1);
          return jsx_text(env_1, mode_1, buf_1, raw_1, lexbuf_1); end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function type_token(env, lexbuf) do
  lexbuf.lex_mem = Caml_array.caml_make_vect(26, -1);
  Caml_array.caml_array_set(lexbuf.lex_mem, 17, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 16, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 15, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 14, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 13, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 12, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 11, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 10, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 9, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 8, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 7, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 6, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 5, lexbuf.lex_curr_pos);
  Caml_array.caml_array_set(lexbuf.lex_mem, 4, lexbuf.lex_curr_pos);
  env_1 = env;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 133;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.new_engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          Lexing.new_line(lexbuf_1);
          return type_token(env_1, lexbuf_1); end end 
       if ___conditional___ == 1 then do
          unicode_fix_cols(lexbuf_1);
          return type_token(env_1, lexbuf_1); end end 
       if ___conditional___ == 2 then do
          start = from_lb(env_1.lex_source, lexbuf_1);
          buf = __Buffer.create(127);
          match = comment(env_1, buf, lexbuf_1);
          env_2 = save_comment(match[1], start, match[2], buf, true);
          return type_token(env_2, lexbuf_1); end end 
       if ___conditional___ == 3 then do
          sp = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 2 | 0, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          escape_type = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          pattern = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          if (env_1.lex_enable_comment_syntax) then do
            env_3;
            if (env_1.lex_in_comment_syntax) then do
              loc = from_lb(env_1.lex_source, lexbuf_1);
              env_3 = unexpected_error(env_1, loc, pattern);
            end else do
              env_3 = env_1;
            end end 
            env_4 = in_comment_syntax(true, env_3);
            if (escape_type == ":") then do
              return --[[ tuple ]]{
                      env_4,
                      --[[ T_COLON ]]77
                    };
            end else do
              return type_token(env_4, lexbuf_1);
            end end 
          end else do
            start_1 = from_lb(env_1.lex_source, lexbuf_1);
            buf_1 = __Buffer.create(127);
            __Buffer.add_string(buf_1, sp);
            __Buffer.add_string(buf_1, escape_type);
            match_1 = comment(env_1, buf_1, lexbuf_1);
            env_5 = save_comment(match_1[1], start_1, match_1[2], buf_1, true);
            return type_token(env_5, lexbuf_1);
          end end  end end 
       if ___conditional___ == 4 then do
          if (env_1.lex_in_comment_syntax) then do
            env_6 = in_comment_syntax(false, env_1);
            return type_token(env_6, lexbuf_1);
          end else do
            yyback(1, lexbuf_1);
            return --[[ tuple ]]{
                    env_1,
                    --[[ T_MULT ]]97
                  };
          end end  end end 
       if ___conditional___ == 5 then do
          start_2 = from_lb(env_1.lex_source, lexbuf_1);
          buf_2 = __Buffer.create(127);
          match_2 = line_comment(env_1, buf_2, lexbuf_1);
          env_7 = save_comment(match_2[1], start_2, match_2[2], buf_2, true);
          return type_token(env_7, lexbuf_1); end end 
       if ___conditional___ == 6 then do
          quote = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          start_3 = from_lb(env_1.lex_source, lexbuf_1);
          buf_3 = __Buffer.create(127);
          raw = __Buffer.create(127);
          __Buffer.add_char(raw, quote);
          match_3 = string_quote(env_1, quote, buf_3, raw, false, lexbuf_1);
          return --[[ tuple ]]{
                  match_3[1],
                  --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                        btwn(start_3, match_3[2]),
                        __Buffer.contents(buf_3),
                        __Buffer.contents(raw),
                        match_3[3]
                      }})
                }; end end 
       if ___conditional___ == 7 then do
          neg = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w, mk_num_singleton(--[[ BINARY ]]0, num, neg)); end end 
       if ___conditional___ == 8 then do
          neg_1 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_1 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return --[[ tuple ]]{
                  env_1,
                  mk_num_singleton(--[[ BINARY ]]0, num_1, neg_1)
                }; end end 
       if ___conditional___ == 9 then do
          neg_2 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_2 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w_1 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_1, mk_num_singleton(--[[ OCTAL ]]2, num_2, neg_2)); end end 
       if ___conditional___ == 10 then do
          neg_3 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_3 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return --[[ tuple ]]{
                  env_1,
                  mk_num_singleton(--[[ OCTAL ]]2, num_3, neg_3)
                }; end end 
       if ___conditional___ == 11 then do
          neg_4 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_4 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w_2 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_2, mk_num_singleton(--[[ LEGACY_OCTAL ]]1, num_4, neg_4)); end end 
       if ___conditional___ == 12 then do
          neg_5 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_5 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return --[[ tuple ]]{
                  env_1,
                  mk_num_singleton(--[[ LEGACY_OCTAL ]]1, num_5, neg_5)
                }; end end 
       if ___conditional___ == 13 then do
          neg_6 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_6 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w_3 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          match_4;
          xpcall(function() do
            match_4 = --[[ tuple ]]{
              env_1,
              mk_num_singleton(--[[ NORMAL ]]3, num_6, neg_6)
            };
          end end,function(exn) do
            if (Sys.win32) then do
              loc_1 = from_lb(env_1.lex_source, lexbuf_1);
              env_8 = lex_error(env_1, loc_1, --[[ WindowsFloatOfString ]]59);
              match_4 = --[[ tuple ]]{
                env_8,
                --[[ T_NUMBER_SINGLETON_TYPE ]]Block.__(5, {
                    --[[ NORMAL ]]3,
                    789.0
                  })
              };
            end else do
              error(exn)
            end end 
          end end)
          return illegal_number(match_4[1], lexbuf_1, w_3, match_4[2]); end end 
       if ___conditional___ == 14 then do
          neg_7 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_7 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          xpcall(function() do
            return --[[ tuple ]]{
                    env_1,
                    mk_num_singleton(--[[ NORMAL ]]3, num_7, neg_7)
                  };
          end end,function(exn_1) do
            if (Sys.win32) then do
              loc_2 = from_lb(env_1.lex_source, lexbuf_1);
              env_9 = lex_error(env_1, loc_2, --[[ WindowsFloatOfString ]]59);
              return --[[ tuple ]]{
                      env_9,
                      --[[ T_NUMBER_SINGLETON_TYPE ]]Block.__(5, {
                          --[[ NORMAL ]]3,
                          789.0
                        })
                    };
            end else do
              error(exn_1)
            end end 
          end end) end end 
       if ___conditional___ == 15 then do
          neg_8 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_8 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w_4 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_4, mk_num_singleton(--[[ NORMAL ]]3, num_8, neg_8)); end end 
       if ___conditional___ == 16 then do
          neg_9 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_9 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), lexbuf_1.lex_curr_pos);
          return --[[ tuple ]]{
                  env_1,
                  mk_num_singleton(--[[ NORMAL ]]3, num_9, neg_9)
                }; end end 
       if ___conditional___ == 17 then do
          neg_10 = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_10 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 0), Caml_array.caml_array_get(lexbuf_1.lex_mem, 1));
          w_5 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), lexbuf_1.lex_curr_pos);
          return illegal_number(env_1, lexbuf_1, w_5, mk_num_singleton(--[[ NORMAL ]]3, num_10, neg_10)); end end 
       if ___conditional___ == 18 then do
          neg_11 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 1), Caml_array.caml_array_get(lexbuf_1.lex_mem, 0));
          num_11 = Lexing.sub_lexeme(lexbuf_1, Caml_array.caml_array_get(lexbuf_1.lex_mem, 3), Caml_array.caml_array_get(lexbuf_1.lex_mem, 2));
          return --[[ tuple ]]{
                  env_1,
                  mk_num_singleton(--[[ NORMAL ]]3, num_11, neg_11)
                }; end end 
       if ___conditional___ == 19 then do
          word = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          unicode_fix_cols(lexbuf_1);
          xpcall(function() do
            return --[[ tuple ]]{
                    env_1,
                    Hashtbl.find(type_keywords, word)
                  };
          end end,function(exn_2) do
            if (exn_2 == Caml_builtin_exceptions.not_found) then do
              return --[[ tuple ]]{
                      env_1,
                      --[[ T_IDENTIFIER ]]0
                    };
            end else do
              error(exn_2)
            end end 
          end end) end end 
       if ___conditional___ == 22 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LCURLY ]]1
                }; end end 
       if ___conditional___ == 23 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RCURLY ]]2
                }; end end 
       if ___conditional___ == 24 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LPAREN ]]3
                }; end end 
       if ___conditional___ == 25 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RPAREN ]]4
                }; end end 
       if ___conditional___ == 26 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ELLIPSIS ]]11
                }; end end 
       if ___conditional___ == 27 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PERIOD ]]9
                }; end end 
       if ___conditional___ == 28 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_SEMICOLON ]]7
                }; end end 
       if ___conditional___ == 29 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_COMMA ]]8
                }; end end 
       if ___conditional___ == 20
       or ___conditional___ == 32 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LBRACKET ]]5
                }; end end 
       if ___conditional___ == 21
       or ___conditional___ == 33 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_RBRACKET ]]6
                }; end end 
       if ___conditional___ == 34 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LESS_THAN ]]89
                }; end end 
       if ___conditional___ == 35 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_GREATER_THAN ]]90
                }; end end 
       if ___conditional___ == 31
       or ___conditional___ == 37 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PLING ]]76
                }; end end 
       if ___conditional___ == 38 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MULT ]]97
                }; end end 
       if ___conditional___ == 30
       or ___conditional___ == 39 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_COLON ]]77
                }; end end 
       if ___conditional___ == 40 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_OR ]]80
                }; end end 
       if ___conditional___ == 41 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_BIT_AND ]]82
                }; end end 
       if ___conditional___ == 42 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_TYPEOF ]]44
                }; end end 
       if ___conditional___ == 43 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ARROW ]]10
                }; end end 
       if ___conditional___ == 36
       or ___conditional___ == 44 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ASSIGN ]]75
                }; end end 
       if ___conditional___ == 45 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_PLUS ]]94
                }; end end 
       if ___conditional___ == 46 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_MINUS ]]95
                }; end end 
       if ___conditional___ == 47 then do
          env_10;
          if (env_1.lex_in_comment_syntax) then do
            loc_3 = from_lb(env_1.lex_source, lexbuf_1);
            env_10 = lex_error(env_1, loc_3, --[[ UnexpectedEOS ]]4);
          end else do
            env_10 = env_1;
          end end 
          return --[[ tuple ]]{
                  env_10,
                  --[[ T_EOF ]]105
                }; end end 
       if ___conditional___ == 48 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_ERROR ]]104
                }; end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function string_escape(env, buf, lexbuf) do
  env_1 = env;
  buf_1 = buf;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 252;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 1 then do
          __Buffer.add_string(buf_1, "\\");
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 2 then do
          a = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 1 | 0);
          b = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 2 | 0);
          code = (hexa_to_int(a) << 4) + hexa_to_int(b) | 0;
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 3 then do
          a_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          b_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 1 | 0);
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 2 | 0);
          code_1 = ((oct_to_int(a_1) << 6) + (oct_to_int(b_1) << 3) | 0) + oct_to_int(c) | 0;
          if (code_1 < 256) then do
            List.iter((function(param) do
                    return __Buffer.add_char(buf_1, param);
                  end end), utf16to8(code_1));
          end else do
            code_2 = (oct_to_int(a_1) << 3) + oct_to_int(b_1) | 0;
            List.iter((function(param) do
                    return __Buffer.add_char(buf_1, param);
                  end end), utf16to8(code_2));
            __Buffer.add_char(buf_1, c);
          end end 
          return --[[ tuple ]]{
                  env_1,
                  true
                }; end end 
       if ___conditional___ == 4 then do
          a_2 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          b_2 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 1 | 0);
          code_3 = (oct_to_int(a_2) << 3) + oct_to_int(b_2) | 0;
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code_3));
          return --[[ tuple ]]{
                  env_1,
                  true
                }; end end 
       if ___conditional___ == 5 then do
          __Buffer.add_char(buf_1, Char.chr(0));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 6 then do
          __Buffer.add_char(buf_1, Char.chr(8));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 7 then do
          __Buffer.add_char(buf_1, Char.chr(12));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 8 then do
          __Buffer.add_char(buf_1, Char.chr(10));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 9 then do
          __Buffer.add_char(buf_1, Char.chr(13));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 10 then do
          __Buffer.add_char(buf_1, Char.chr(9));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 11 then do
          __Buffer.add_char(buf_1, Char.chr(11));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 12 then do
          a_3 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          code_4 = oct_to_int(a_3);
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code_4));
          return --[[ tuple ]]{
                  env_1,
                  true
                }; end end 
       if ___conditional___ == 13 then do
          a_4 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 1 | 0);
          b_3 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 2 | 0);
          c_1 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 3 | 0);
          d = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos + 4 | 0);
          code_5 = (((hexa_to_int(a_4) << 12) + (hexa_to_int(b_3) << 8) | 0) + (hexa_to_int(c_1) << 4) | 0) + hexa_to_int(d) | 0;
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code_5));
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 14 then do
          hex_code = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos + 2 | 0, lexbuf_1.lex_curr_pos - 1 | 0);
          code_6 = Caml_format.caml_int_of_string("0x" .. hex_code);
          env_2 = code_6 > 1114111 and lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"})) or env_1;
          List.iter((function(param) do
                  return __Buffer.add_char(buf_1, param);
                end end), utf16to8(code_6));
          return --[[ tuple ]]{
                  env_2,
                  false
                }; end end 
       if ___conditional___ == 15 then do
          c_2 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          env_3 = lex_error(env_1, from_lb(env_1.lex_source, lexbuf_1), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          __Buffer.add_char(buf_1, c_2);
          return --[[ tuple ]]{
                  env_3,
                  false
                }; end end 
       if ___conditional___ == 16 then do
          Lexing.new_line(lexbuf_1);
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
       if ___conditional___ == 17 then do
          c_3 = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(buf_1, c_3);
          return --[[ tuple ]]{
                  env_1,
                  false
                }; end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function __ocaml_lex_regexp_rec(_env, lexbuf, ___ocaml_lex_state) do
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    env = _env;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          return --[[ tuple ]]{
                  env,
                  --[[ T_EOF ]]105
                }; end end 
       if ___conditional___ == 1 then do
          Lexing.new_line(lexbuf);
          ___ocaml_lex_state = 291;
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          unicode_fix_cols(lexbuf);
          ___ocaml_lex_state = 291;
          ::continue:: ; end end 
       if ___conditional___ == 3 then do
          start = from_lb(env.lex_source, lexbuf);
          buf = __Buffer.create(127);
          match = line_comment(env, buf, lexbuf);
          env_1 = save_comment(match[1], start, match[2], buf, true);
          ___ocaml_lex_state = 291;
          _env = env_1;
          ::continue:: ; end end 
       if ___conditional___ == 4 then do
          start_1 = from_lb(env.lex_source, lexbuf);
          buf_1 = __Buffer.create(127);
          match_1 = comment(env, buf_1, lexbuf);
          env_2 = save_comment(match_1[1], start_1, match_1[2], buf_1, true);
          ___ocaml_lex_state = 291;
          _env = env_2;
          ::continue:: ; end end 
       if ___conditional___ == 5 then do
          start_2 = from_lb(env.lex_source, lexbuf);
          buf_2 = __Buffer.create(127);
          match_2 = regexp_body(env, buf_2, lexbuf);
          env_3 = match_2[1];
          end_ = from_lb(env_3.lex_source, lexbuf);
          loc = btwn(start_2, end_);
          return --[[ tuple ]]{
                  env_3,
                  --[[ T_REGEXP ]]Block.__(3, {--[[ tuple ]]{
                        loc,
                        __Buffer.contents(buf_2),
                        match_2[2]
                      }})
                }; end end 
       if ___conditional___ == 6 then do
          env_4 = lex_error(env, from_lb(env.lex_source, lexbuf), --[[ UnexpectedToken ]]Block.__(1, {"ILLEGAL"}));
          return --[[ tuple ]]{
                  env_4,
                  --[[ T_ERROR ]]104
                }; end end 
      Curry._1(lexbuf.refill_buff, lexbuf);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function jsx_child(env, start, buf, raw, lexbuf) do
  env_1 = env;
  start_1 = start;
  buf_1 = buf;
  raw_1 = raw;
  lexbuf_1 = lexbuf;
  ___ocaml_lex_state = 364;
  while(true) do
    __ocaml_lex_state = ___ocaml_lex_state;
    __ocaml_lex_state_1 = Lexing.engine(__ocaml_lex_tables, __ocaml_lex_state, lexbuf_1);
    local ___conditional___=(__ocaml_lex_state_1);
    do
       if ___conditional___ == 0 then do
          lt = Lexing.sub_lexeme(lexbuf_1, lexbuf_1.lex_start_pos, lexbuf_1.lex_curr_pos);
          __Buffer.add_string(raw_1, lt);
          __Buffer.add_string(buf_1, lt);
          Lexing.new_line(lexbuf_1);
          match = jsx_text(env_1, --[[ JSX_CHILD_TEXT ]]2, buf_1, raw_1, lexbuf_1);
          value = __Buffer.contents(buf_1);
          raw_2 = __Buffer.contents(raw_1);
          return --[[ tuple ]]{
                  match[1],
                  --[[ T_JSX_TEXT ]]Block.__(4, {--[[ tuple ]]{
                        btwn(start_1, match[2]),
                        value,
                        raw_2
                      }})
                }; end end 
       if ___conditional___ == 1 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_EOF ]]105
                }; end end 
       if ___conditional___ == 2 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LESS_THAN ]]89
                }; end end 
       if ___conditional___ == 3 then do
          return --[[ tuple ]]{
                  env_1,
                  --[[ T_LCURLY ]]1
                }; end end 
       if ___conditional___ == 4 then do
          c = Caml_bytes.get(lexbuf_1.lex_buffer, lexbuf_1.lex_start_pos);
          __Buffer.add_char(raw_1, c);
          __Buffer.add_char(buf_1, c);
          match_1 = jsx_text(env_1, --[[ JSX_CHILD_TEXT ]]2, buf_1, raw_1, lexbuf_1);
          value_1 = __Buffer.contents(buf_1);
          raw_3 = __Buffer.contents(raw_1);
          return --[[ tuple ]]{
                  match_1[1],
                  --[[ T_JSX_TEXT ]]Block.__(4, {--[[ tuple ]]{
                        btwn(start_1, match_1[2]),
                        value_1,
                        raw_3
                      }})
                }; end end 
      Curry._1(lexbuf_1.refill_buff, lexbuf_1);
        ___ocaml_lex_state = __ocaml_lex_state_1;
        ::continue:: ;
        
    end
  end;
end end

function regexp(env) do
  return get_result_and_clear_state(__ocaml_lex_regexp_rec(env, env.lex_lb, 291));
end end

function jsx_child_1(env) do
  start = from_curr_lb(env.lex_source, env.lex_lb);
  buf = __Buffer.create(127);
  raw = __Buffer.create(127);
  match = jsx_child(env, start, buf, raw, env.lex_lb);
  return get_result_and_clear_state(--[[ tuple ]]{
              match[1],
              match[2]
            });
end end

function jsx_tag(env) do
  return get_result_and_clear_state(__ocaml_lex_jsx_tag_rec(env, env.lex_lb, 333));
end end

function template_tail(env) do
  return get_result_and_clear_state(__ocaml_lex_template_tail_rec(env, env.lex_lb, 393));
end end

function type_token_1(env) do
  return get_result_and_clear_state(type_token(env, env.lex_lb));
end end

function token_1(env) do
  return get_result_and_clear_state(token(env, env.lex_lb));
end end

function height(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]v,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height(ll) >= height(lr)) then do
        return create(ll, lv, create(lr, v, r));
      end else if (lr) then do
        return create(create(ll, lv, lr[--[[ l ]]1]), lr[--[[ v ]]2], create(lr[--[[ r ]]3], v, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height(rr) >= height(rl)) then do
        return create(create(l, v, rl), rv, rr);
      end else if (rl) then do
        return create(create(l, v, rl[--[[ l ]]1]), rl[--[[ v ]]2], create(rl[--[[ r ]]3], rv, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]v,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add(x, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      ll = add(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal(ll, v, r);
      end end 
    end else do
      rr = add(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function mem(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function create_1(lex_env, mode) do
  lexbuf = lex_env.lex_lb;
  lexbuf_1 = {
    refill_buff = lexbuf.refill_buff,
    lex_buffer = lexbuf.lex_buffer,
    lex_buffer_len = lexbuf.lex_buffer_len,
    lex_abs_pos = lexbuf.lex_abs_pos,
    lex_start_pos = lexbuf.lex_start_pos,
    lex_curr_pos = lexbuf.lex_curr_pos,
    lex_last_pos = lexbuf.lex_last_pos,
    lex_last_action = lexbuf.lex_last_action,
    lex_eof_reached = lexbuf.lex_eof_reached,
    lex_mem = lexbuf.lex_mem,
    lex_start_p = lexbuf.lex_start_p,
    lex_curr_p = lexbuf.lex_curr_p
  };
  lex_env_1 = with_lexbuf(lexbuf_1, lex_env);
  return {
          la_results = {},
          la_num_lexed = 0,
          la_lex_mode = mode,
          la_lex_env = lex_env_1
        };
end end

function next_power_of_two(n) do
  _i = 1;
  while(true) do
    i = _i;
    if (i >= n) then do
      return i;
    end else do
      _i = (i << 1);
      ::continue:: ;
    end end 
  end;
end end

function grow(t, n) do
  if (#t.la_results < n) then do
    new_size = next_power_of_two(n);
    filler = function(i) do
      if (i < #t.la_results) then do
        return Caml_array.caml_array_get(t.la_results, i);
      end
       end 
    end end;
    new_arr = __Array.init(new_size, filler);
    t.la_results = new_arr;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function lex(t) do
  lex_env = t.la_lex_env;
  match = t.la_lex_mode;
  match_1;
  local ___conditional___=(match);
  do
     if ___conditional___ == 1--[[ TYPE ]] then do
        match_1 = type_token_1(lex_env); end else 
     if ___conditional___ == 2--[[ JSX_TAG ]] then do
        match_1 = jsx_tag(lex_env); end else 
     if ___conditional___ == 3--[[ JSX_CHILD ]] then do
        match_1 = jsx_child_1(lex_env); end else 
     if ___conditional___ == 4--[[ TEMPLATE ]] then do
        match_1 = template_tail(lex_env); end else 
     if ___conditional___ == 5--[[ REGEXP ]] then do
        match_1 = regexp(lex_env); end else 
     if ___conditional___ == 0--[[ NORMAL ]]
     or ___conditional___ == 6--[[ PREDICATE ]] then do
        match_1 = token_1(lex_env); end else 
     end end end end end end end end end end end end
    
  end
  lex_env_1 = match_1[1];
  lexbuf = lex_env_1.lex_lb;
  lexbuf_1 = {
    refill_buff = lexbuf.refill_buff,
    lex_buffer = lexbuf.lex_buffer,
    lex_buffer_len = lexbuf.lex_buffer_len,
    lex_abs_pos = lexbuf.lex_abs_pos,
    lex_start_pos = lexbuf.lex_start_pos,
    lex_curr_pos = lexbuf.lex_curr_pos,
    lex_last_pos = lexbuf.lex_last_pos,
    lex_last_action = lexbuf.lex_last_action,
    lex_eof_reached = lexbuf.lex_eof_reached,
    lex_mem = lexbuf.lex_mem,
    lex_start_p = lexbuf.lex_start_p,
    lex_curr_p = lexbuf.lex_curr_p
  };
  cloned_env = with_lexbuf(lexbuf_1, lex_env_1);
  t.la_lex_env = lex_env_1;
  Caml_array.caml_array_set(t.la_results, t.la_num_lexed, --[[ tuple ]]{
        cloned_env,
        match_1[2]
      });
  t.la_num_lexed = t.la_num_lexed + 1 | 0;
  return --[[ () ]]0;
end end

function lex_until(t, i) do
  grow(t, i + 1 | 0);
  while(t.la_num_lexed <= i) do
    lex(t);
  end;
  return --[[ () ]]0;
end end

default_parse_options = {
  esproposal_class_instance_fields = false,
  esproposal_class_static_fields = false,
  esproposal_decorators = false,
  esproposal_export_star_as = false,
  types = true,
  use_strict = false
};

function init_env(token_sinkOpt, parse_optionsOpt, source, content) do
  token_sink = token_sinkOpt ~= nil and Caml_option.valFromOption(token_sinkOpt) or nil;
  parse_options = parse_optionsOpt ~= nil and Caml_option.valFromOption(parse_optionsOpt) or nil;
  lb = Lexing.from_string(content);
  if (source ~= nil) then do
    match = source;
    if (type(match) ~= "number") then do
      init = lb.lex_curr_p;
      lb.lex_curr_p = {
        pos_fname = match[1],
        pos_lnum = init.pos_lnum,
        pos_bol = init.pos_bol,
        pos_cnum = init.pos_cnum
      };
    end
     end 
  end
   end 
  parse_options_1 = parse_options ~= nil and parse_options or default_parse_options;
  enable_types_in_comments = parse_options_1.types;
  lex_env = new_lex_env(source, lb, enable_types_in_comments);
  return {
          errors = {
            contents = --[[ [] ]]0
          },
          comments = {
            contents = --[[ [] ]]0
          },
          labels = --[[ Empty ]]0,
          exports = {
            contents = --[[ Empty ]]0
          },
          last_loc = {
            contents = nil
          },
          in_strict_mode = parse_options_1.use_strict,
          in_export = false,
          in_loop = false,
          in_switch = false,
          in_function = false,
          no_in = false,
          no_call = false,
          no_let = false,
          allow_yield = true,
          allow_await = false,
          error_callback = nil,
          lex_mode_stack = {
            contents = --[[ :: ]]{
              --[[ NORMAL ]]0,
              --[[ [] ]]0
            }
          },
          lex_env = {
            contents = lex_env
          },
          lookahead = {
            contents = create_1(lex_env, --[[ NORMAL ]]0)
          },
          token_sink = {
            contents = token_sink
          },
          parse_options = parse_options_1,
          source = source
        };
end end

function error_at(env, param) do
  e = param[2];
  env.errors.contents = --[[ :: ]]{
    --[[ tuple ]]{
      param[1],
      e
    },
    env.errors.contents
  };
  match = env.error_callback;
  if (match ~= nil) then do
    return Curry._2(match, env, e);
  end else do
    return --[[ () ]]0;
  end end 
end end

function comment_list(env) do
  return (function(param) do
      return List.iter((function(c) do
                    env.comments.contents = --[[ :: ]]{
                      c,
                      env.comments.contents
                    };
                    return --[[ () ]]0;
                  end end), param);
    end end);
end end

function record_export(env, param) do
  export_name = param[2];
  __exports = env.__exports.contents;
  if (mem(export_name, __exports)) then do
    return error_at(env, --[[ tuple ]]{
                param[1],
                --[[ DuplicateExport ]]Block.__(7, {export_name})
              });
  end else do
    env.__exports.contents = add(export_name, env.__exports.contents);
    return --[[ () ]]0;
  end end 
end end

function lookahead(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  if (i >= 2) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "parser_env.ml",
        288,
        2
      }
    })
  end
   end 
  t = env.lookahead.contents;
  i_1 = i;
  lex_until(t, i_1);
  match = Caml_array.caml_array_get(t.la_results, i_1);
  if (match ~= nil) then do
    return match[2];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Lookahead.peek failed"
    })
  end end 
end end

function with_strict(in_strict_mode, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.in_strict_mode = in_strict_mode;
  return newrecord;
end end

function with_in_function(in_function, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.in_function = in_function;
  return newrecord;
end end

function with_allow_yield(allow_yield, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.allow_yield = allow_yield;
  return newrecord;
end end

function with_no_let(no_let, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.no_let = no_let;
  return newrecord;
end end

function with_in_loop(in_loop, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.in_loop = in_loop;
  return newrecord;
end end

function with_no_in(no_in, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.no_in = no_in;
  return newrecord;
end end

function with_in_switch(in_switch, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.in_switch = in_switch;
  return newrecord;
end end

function with_in_export(in_export, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.in_export = in_export;
  return newrecord;
end end

function with_no_call(no_call, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.no_call = no_call;
  return newrecord;
end end

function with_error_callback(error_callback, env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.error_callback = error_callback;
  return newrecord;
end end

function error_list(env) do
  return (function(param) do
      return List.iter((function(param) do
                    return error_at(env, param);
                  end end), param);
    end end);
end end

function without_error_callback(env) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.error_callback = nil;
  return newrecord;
end end

function add_label(env, label) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.labels = add(label, env.labels);
  return newrecord;
end end

function enter_function(env, async, generator) do
  newrecord = Caml_obj.caml_obj_dup(env);
  newrecord.allow_await = async;
  newrecord.allow_yield = generator;
  newrecord.in_function = true;
  newrecord.in_switch = false;
  newrecord.in_loop = false;
  newrecord.labels = --[[ Empty ]]0;
  return newrecord;
end end

function is_future_reserved(param) do
  if (param == "enum") then do
    return true;
  end else do
    return false;
  end end 
end end

function is_strict_reserved(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == "implements"
     or ___conditional___ == "interface"
     or ___conditional___ == "package"
     or ___conditional___ == "private"
     or ___conditional___ == "protected"
     or ___conditional___ == "public"
     or ___conditional___ == "static"
     or ___conditional___ == "yield" then do
        return true; end end 
    return false;
      
  end
end end

function is_restricted(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ == "arguments"
     or ___conditional___ == "eval" then do
        return true; end end 
    return false;
      
  end
end end

function token_2(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  return lookahead(i, env).lex_token;
end end

function value(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  return lookahead(i, env).lex_value;
end end

function loc(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  return lookahead(i, env).lex_loc;
end end

function errors(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  return lookahead(i, env).lex_errors;
end end

function comments(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  return lookahead(i, env).lex_comments;
end end

function lex_env(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  t = env.lookahead.contents;
  i_1 = i;
  lex_until(t, i_1);
  match = Caml_array.caml_array_get(t.la_results, i_1);
  if (match ~= nil) then do
    return match[1];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Lookahead.peek failed"
    })
  end end 
end end

function is_line_terminator(env) do
  match = env.last_loc.contents;
  if (match ~= nil) then do
    return loc(nil, env).start.line > match.start.line;
  end else do
    return false;
  end end 
end end

function is_implicit_semicolon(env) do
  match = token_2(nil, env);
  if (type(match) == "number") then do
    switcher = match - 3 | 0;
    if (switcher > 101 or switcher < 0) then do
      if ((switcher + 1 >>> 0) > 103) then do
        return is_line_terminator(env);
      end else do
        return true;
      end end 
    end else if (switcher ~= 4) then do
      return is_line_terminator(env);
    end else do
      return false;
    end end  end 
  end else do
    return is_line_terminator(env);
  end end 
end end

function semicolon_loc(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  if (token_2(i, env) == --[[ T_SEMICOLON ]]7) then do
    return loc(i, env);
  end
   end 
end end

function is_identifier(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  name = value(i, env);
  match = token_2(i, env);
  if (is_strict_reserved(name) or is_restricted(name) or is_future_reserved(name)) then do
    return true;
  end else if (type(match) == "number") then do
    switcher = match - 1 | 0;
    if (switcher > 56 or switcher < 0) then do
      return switcher < 62;
    end else do
      return switcher == 25;
    end end 
  end else do
    return false;
  end end  end 
end end

function is_function(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  if (token_2(i, env) == --[[ T_FUNCTION ]]13) then do
    return true;
  end else if (token_2(i, env) == --[[ T_ASYNC ]]61) then do
    return token_2(i + 1 | 0, env) == --[[ T_FUNCTION ]]13;
  end else do
    return false;
  end end  end 
end end

function is_class(iOpt, env) do
  i = iOpt ~= nil and iOpt or 0;
  match = token_2(i, env);
  if (type(match) == "number") then do
    if (match ~= 12) then do
      return match == 38;
    end else do
      return true;
    end end 
  end else do
    return false;
  end end 
end end

function error_1(env, e) do
  loc_1 = loc(nil, env);
  return error_at(env, --[[ tuple ]]{
              loc_1,
              e
            });
end end

function get_unexpected_error(param) do
  tmp = param[1];
  if (type(tmp) == "number") then do
    local ___conditional___=(tmp);
    do
       if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
          return --[[ UnexpectedIdentifier ]]2; end end 
       if ___conditional___ == 105--[[ T_EOF ]] then do
          return --[[ UnexpectedEOS ]]4; end end 
      
    end
  end else do
    local ___conditional___=(tmp.tag | 0);
    do
       if ___conditional___ == 0--[[ T_NUMBER ]] then do
          return --[[ UnexpectedNumber ]]0; end end 
       if ___conditional___ == 1--[[ T_STRING ]]
       or ___conditional___ == 4--[[ T_JSX_TEXT ]] then do
          return --[[ UnexpectedString ]]1; end end 
      
    end
  end end 
  word = param[2];
  if (is_future_reserved(word)) then do
    return --[[ UnexpectedReserved ]]3;
  end else if (is_strict_reserved(word)) then do
    return --[[ StrictReservedWord ]]39;
  end else do
    return --[[ UnexpectedToken ]]Block.__(1, {word});
  end end  end 
end end

function error_unexpected(env) do
  error_list(env)(errors(nil, env));
  return error_1(env, get_unexpected_error(--[[ tuple ]]{
                  token_2(nil, env),
                  value(nil, env)
                }));
end end

function error_on_decorators(env) do
  return (function(param) do
      return List.iter((function(decorator) do
                    return error_at(env, --[[ tuple ]]{
                                decorator[1],
                                --[[ UnsupportedDecorator ]]57
                              });
                  end end), param);
    end end);
end end

function strict_error(env, e) do
  if (env.in_strict_mode) then do
    return error_1(env, e);
  end else do
    return 0;
  end end 
end end

function strict_error_at(env, param) do
  if (env.in_strict_mode) then do
    return error_at(env, --[[ tuple ]]{
                param[1],
                param[2]
              });
  end else do
    return 0;
  end end 
end end

function token_3(env) do
  match = env.token_sink.contents;
  if (match ~= nil) then do
    token_loc = loc(nil, env);
    token_4 = token_2(nil, env);
    token_value = value(nil, env);
    Curry._1(match, {
          token_loc = token_loc,
          token = token_4,
          token_context = List.hd(env.lex_mode_stack.contents),
          token_value = token_value
        });
  end
   end 
  env.lex_env.contents = lex_env(nil, env);
  error_list(env)(errors(nil, env));
  comment_list(env)(comments(nil, env));
  env.last_loc.contents = loc(nil, env);
  t = env.lookahead.contents;
  lex_until(t, 0);
  if (t.la_num_lexed > 1) then do
    __Array.blit(t.la_results, 1, t.la_results, 0, t.la_num_lexed - 1 | 0);
  end
   end 
  Caml_array.caml_array_set(t.la_results, t.la_num_lexed - 1 | 0, nil);
  t.la_num_lexed = t.la_num_lexed - 1 | 0;
  return --[[ () ]]0;
end end

function push_lex_mode(env, mode) do
  env.lex_mode_stack.contents = --[[ :: ]]{
    mode,
    env.lex_mode_stack.contents
  };
  env.lookahead.contents = create_1(env.lex_env.contents, List.hd(env.lex_mode_stack.contents));
  return --[[ () ]]0;
end end

function pop_lex_mode(env) do
  match = env.lex_mode_stack.contents;
  new_stack;
  if (match) then do
    new_stack = match[2];
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Popping lex mode from empty stack"
    })
  end end 
  env.lex_mode_stack.contents = new_stack;
  env.lookahead.contents = create_1(env.lex_env.contents, List.hd(env.lex_mode_stack.contents));
  return --[[ () ]]0;
end end

function double_pop_lex_mode(env) do
  match = env.lex_mode_stack.contents;
  new_stack;
  if (match) then do
    match_1 = match[2];
    if (match_1) then do
      new_stack = match_1[2];
    end else do
      error({
        Caml_builtin_exceptions.failure,
        "Popping lex mode from empty stack"
      })
    end end 
  end else do
    error({
      Caml_builtin_exceptions.failure,
      "Popping lex mode from empty stack"
    })
  end end 
  env.lex_mode_stack.contents = new_stack;
  env.lookahead.contents = create_1(env.lex_env.contents, List.hd(env.lex_mode_stack.contents));
  return --[[ () ]]0;
end end

function semicolon(env) do
  if (is_implicit_semicolon(env)) then do
    return 0;
  end else if (token_2(nil, env) == --[[ T_SEMICOLON ]]7) then do
    return token_3(env);
  end else do
    return error_unexpected(env);
  end end  end 
end end

function token_4(env, t) do
  if (Caml_obj.caml_notequal(token_2(nil, env), t)) then do
    error_unexpected(env);
  end
   end 
  return token_3(env);
end end

function maybe(env, t) do
  if (Caml_obj.caml_equal(token_2(nil, env), t)) then do
    token_3(env);
    return true;
  end else do
    return false;
  end end 
end end

function contextual(env, str) do
  if (value(nil, env) ~= str) then do
    error_unexpected(env);
  end
   end 
  return token_3(env);
end end

Rollback = Caml_exceptions.create("Flow_parser_reg_test.Parser_env.Try.Rollback");

function save_state(env) do
  match = env.token_sink.contents;
  token_buffer;
  if (match ~= nil) then do
    buffer = {
      length = 0,
      first = --[[ Nil ]]0,
      last = --[[ Nil ]]0
    };
    env.token_sink.contents = (function(token_data) do
        return Queue.add(token_data, buffer);
      end end);
    token_buffer = --[[ tuple ]]{
      match,
      buffer
    };
  end else do
    token_buffer = nil;
  end end 
  return {
          saved_errors = env.errors.contents,
          saved_comments = env.comments.contents,
          saved_last_loc = env.last_loc.contents,
          saved_lex_mode_stack = env.lex_mode_stack.contents,
          saved_lex_env = env.lex_env.contents,
          token_buffer = token_buffer
        };
end end

function reset_token_sink(flush, env, token_buffer_info) do
  if (token_buffer_info ~= nil) then do
    match = token_buffer_info;
    orig_token_sink = match[1];
    env.token_sink.contents = orig_token_sink;
    if (flush) then do
      return Queue.iter(orig_token_sink, match[2]);
    end else do
      return 0;
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function to_parse(env, parse) do
  saved_state = save_state(env);
  xpcall(function() do
    env_1 = env;
    saved_state_1 = saved_state;
    result = Curry._1(parse, env);
    reset_token_sink(true, env_1, saved_state_1.token_buffer);
    return --[[ ParsedSuccessfully ]]{result};
  end end,function(exn) do
    if (exn == Rollback) then do
      env_2 = env;
      saved_state_2 = saved_state;
      reset_token_sink(false, env_2, saved_state_2.token_buffer);
      env_2.errors.contents = saved_state_2.saved_errors;
      env_2.comments.contents = saved_state_2.saved_comments;
      env_2.last_loc.contents = saved_state_2.saved_last_loc;
      env_2.lex_mode_stack.contents = saved_state_2.saved_lex_mode_stack;
      env_2.lex_env.contents = saved_state_2.saved_lex_env;
      env_2.lookahead.contents = create_1(env_2.lex_env.contents, List.hd(env_2.lex_mode_stack.contents));
      return --[[ FailedToParse ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

Parser_env_Peek = {
  token = token_2,
  value = value,
  loc = loc,
  errors = errors,
  comments = comments,
  is_line_terminator = is_line_terminator,
  is_implicit_semicolon = is_implicit_semicolon,
  semicolon_loc = semicolon_loc,
  is_identifier = is_identifier,
  is_function = is_function,
  is_class = is_class
};

Parser_env_Try = {
  Rollback = Rollback,
  to_parse = to_parse
};

function height_1(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create_2(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]v,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal_1(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height_1(ll) >= height_1(lr)) then do
        return create_2(ll, lv, create_2(lr, v, r));
      end else if (lr) then do
        return create_2(create_2(ll, lv, lr[--[[ l ]]1]), lr[--[[ v ]]2], create_2(lr[--[[ r ]]3], v, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height_1(rr) >= height_1(rl)) then do
        return create_2(create_2(l, v, rl), rv, rr);
      end else if (rl) then do
        return create_2(create_2(l, v, rl[--[[ l ]]1]), rl[--[[ v ]]2], create_2(rl[--[[ r ]]3], rv, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]v,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add_1(x, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      ll = add_1(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal_1(ll, v, r);
      end end 
    end else do
      rr = add_1(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal_1(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function mem_1(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function height_2(param) do
  if (param) then do
    return param[--[[ h ]]5];
  end else do
    return 0;
  end end 
end end

function create_3(l, x, d, r) do
  hl = height_2(l);
  hr = height_2(r);
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]x,
          --[[ d ]]d,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal_2(l, x, d, r) do
  hl = l and l[--[[ h ]]5] or 0;
  hr = r and r[--[[ h ]]5] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]4];
      ld = l[--[[ d ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height_2(ll) >= height_2(lr)) then do
        return create_3(ll, lv, ld, create_3(lr, x, d, r));
      end else if (lr) then do
        return create_3(create_3(ll, lv, ld, lr[--[[ l ]]1]), lr[--[[ v ]]2], lr[--[[ d ]]3], create_3(lr[--[[ r ]]4], x, d, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]4];
      rd = r[--[[ d ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height_2(rr) >= height_2(rl)) then do
        return create_3(create_3(l, x, d, rl), rv, rd, rr);
      end else if (rl) then do
        return create_3(create_3(l, x, d, rl[--[[ l ]]1]), rl[--[[ v ]]2], rl[--[[ d ]]3], create_3(rl[--[[ r ]]4], rv, rd, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Map.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Map.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]x,
            --[[ d ]]d,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add_2(x, data, m) do
  if (m) then do
    r = m[--[[ r ]]4];
    d = m[--[[ d ]]3];
    v = m[--[[ v ]]2];
    l = m[--[[ l ]]1];
    c = Caml_primitive.caml_string_compare(x, v);
    if (c == 0) then do
      if (d == data) then do
        return m;
      end else do
        return --[[ Node ]]{
                --[[ l ]]l,
                --[[ v ]]x,
                --[[ d ]]data,
                --[[ r ]]r,
                --[[ h ]]m[--[[ h ]]5]
              };
      end end 
    end else if (c < 0) then do
      ll = add_2(x, data, l);
      if (l == ll) then do
        return m;
      end else do
        return bal_2(ll, v, d, r);
      end end 
    end else do
      rr = add_2(x, data, r);
      if (r == rr) then do
        return m;
      end else do
        return bal_2(l, v, d, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ d ]]data,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function find(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = Caml_primitive.caml_string_compare(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return param[--[[ d ]]3];
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]4];
        ::continue:: ;
      end end 
    end else do
      error(Caml_builtin_exceptions.not_found)
    end end 
  end;
end end

function compare_1(param, param_1) do
  loc = compare(param[1], param_1[1]);
  if (loc == 0) then do
    return Caml_obj.caml_compare(param[2], param_1[2]);
  end else do
    return loc;
  end end 
end end

function height_3(param) do
  if (param) then do
    return param[--[[ h ]]4];
  end else do
    return 0;
  end end 
end end

function create_4(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  return --[[ Node ]]{
          --[[ l ]]l,
          --[[ v ]]v,
          --[[ r ]]r,
          --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
        };
end end

function bal_3(l, v, r) do
  hl = l and l[--[[ h ]]4] or 0;
  hr = r and r[--[[ h ]]4] or 0;
  if (hl > (hr + 2 | 0)) then do
    if (l) then do
      lr = l[--[[ r ]]3];
      lv = l[--[[ v ]]2];
      ll = l[--[[ l ]]1];
      if (height_3(ll) >= height_3(lr)) then do
        return create_4(ll, lv, create_4(lr, v, r));
      end else if (lr) then do
        return create_4(create_4(ll, lv, lr[--[[ l ]]1]), lr[--[[ v ]]2], create_4(lr[--[[ r ]]3], v, r));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else if (hr > (hl + 2 | 0)) then do
    if (r) then do
      rr = r[--[[ r ]]3];
      rv = r[--[[ v ]]2];
      rl = r[--[[ l ]]1];
      if (height_3(rr) >= height_3(rl)) then do
        return create_4(create_4(l, v, rl), rv, rr);
      end else if (rl) then do
        return create_4(create_4(l, v, rl[--[[ l ]]1]), rl[--[[ v ]]2], create_4(rl[--[[ r ]]3], rv, rr));
      end else do
        error({
          Caml_builtin_exceptions.invalid_argument,
          "Set.bal"
        })
      end end  end 
    end else do
      error({
        Caml_builtin_exceptions.invalid_argument,
        "Set.bal"
      })
    end end 
  end else do
    return --[[ Node ]]{
            --[[ l ]]l,
            --[[ v ]]v,
            --[[ r ]]r,
            --[[ h ]]hl >= hr and hl + 1 | 0 or hr + 1 | 0
          };
  end end  end 
end end

function add_3(x, t) do
  if (t) then do
    r = t[--[[ r ]]3];
    v = t[--[[ v ]]2];
    l = t[--[[ l ]]1];
    c = compare_1(x, v);
    if (c == 0) then do
      return t;
    end else if (c < 0) then do
      ll = add_3(x, l);
      if (l == ll) then do
        return t;
      end else do
        return bal_3(ll, v, r);
      end end 
    end else do
      rr = add_3(x, r);
      if (r == rr) then do
        return t;
      end else do
        return bal_3(l, v, rr);
      end end 
    end end  end 
  end else do
    return --[[ Node ]]{
            --[[ l : Empty ]]0,
            --[[ v ]]x,
            --[[ r : Empty ]]0,
            --[[ h ]]1
          };
  end end 
end end

function mem_2(x, _param) do
  while(true) do
    param = _param;
    if (param) then do
      c = compare_1(x, param[--[[ v ]]2]);
      if (c == 0) then do
        return true;
      end else do
        _param = c < 0 and param[--[[ l ]]1] or param[--[[ r ]]3];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function filter_duplicate_errors(errs) do
  errs_1 = List.rev(errs);
  match = List.fold_left((function(param, err) do
          deduped = param[2];
          set = param[1];
          if (mem_2(err, set)) then do
            return --[[ tuple ]]{
                    set,
                    deduped
                  };
          end else do
            return --[[ tuple ]]{
                    add_3(err, set),
                    --[[ :: ]]{
                      err,
                      deduped
                    }
                  };
          end end 
        end end), --[[ tuple ]]{
        --[[ Empty ]]0,
        --[[ [] ]]0
      }, errs_1);
  return List.rev(match[2]);
end end

function with_loc(fn, env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  result = Curry._1(fn, env);
  match = env.last_loc.contents;
  end_loc = match ~= nil and match or (error_1(env, --[[ Assertion ]]Block.__(0, {"did not consume any tokens"})), Curry._2(Parser_env_Peek.loc, nil, env));
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          result
        };
end end

Parse = Caml_module.init_mod(--[[ tuple ]]{
      "parser_flow.ml",
      95,
      6
    }, --[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Function ]]0,
            "program"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list_item"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list_with_directives"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "module_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "expression"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "assignment"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "object_initializer"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "array_initializer"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier_or_reserved_keyword"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier_with_type"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "block_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "function_block_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "jsx_element"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "pattern"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "pattern_from_expr"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "object_key"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "class_declaration"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "class_expression"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "is_assignable_lhs"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "predicate"
          }
        }}));

function intersection(env) do
  maybe(env, --[[ T_BIT_AND ]]82);
  left = prefix(env);
  return Curry._2(intersection_with, env, left);
end end

function generic(env) do
  return Curry._2(raw_generic_with_identifier, env, Curry._2(Parse.identifier, nil, env));
end end

function primary(env) do
  loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_5 = Curry._2(Parser_env_Peek.token, nil, env);
  exit = 0;
  if (type(token_5) == "number") then do
    local ___conditional___=(token_5);
    do
       if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
          match = generic(env);
          return --[[ tuple ]]{
                  match[1],
                  --[[ Generic ]]Block.__(4, {match[2]})
                }; end end 
       if ___conditional___ == 1--[[ T_LCURLY ]] then do
          match_1 = Curry._2(_object, nil, env);
          return --[[ tuple ]]{
                  match_1[1],
                  --[[ Object ]]Block.__(2, {match_1[2]})
                }; end end 
       if ___conditional___ == 3--[[ T_LPAREN ]] then do
          env_1 = env;
          start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
          match_2 = param_list_or_type(env_1);
          if (match_2.tag) then do
            return match_2[1];
          end else do
            match_3 = match_2[1];
            token_4(env_1, --[[ T_ARROW ]]10);
            returnType = union(env_1);
            end_loc = returnType[1];
            return --[[ tuple ]]{
                    btwn(start_loc, end_loc),
                    --[[ Function ]]Block.__(1, {{
                          params = match_3[2],
                          returnType = returnType,
                          rest = match_3[1],
                          typeParameters = nil
                        }})
                  };
          end end  end end 
       if ___conditional___ == 5--[[ T_LBRACKET ]] then do
          env_2 = env;
          start_loc_1 = Curry._2(Parser_env_Peek.loc, nil, env_2);
          token_4(env_2, --[[ T_LBRACKET ]]5);
          tl = types(env_2, --[[ [] ]]0);
          end_loc_1 = Curry._2(Parser_env_Peek.loc, nil, env_2);
          token_4(env_2, --[[ T_RBRACKET ]]6);
          return --[[ tuple ]]{
                  btwn(start_loc_1, end_loc_1),
                  --[[ Tuple ]]Block.__(8, {tl})
                }; end end 
       if ___conditional___ == 28--[[ T_FALSE ]]
       or ___conditional___ == 29--[[ T_TRUE ]] then do
          exit = 2; end else 
       if ___conditional___ == 44--[[ T_TYPEOF ]] then do
          start_loc_2 = Curry._2(Parser_env_Peek.loc, nil, env);
          token_4(env, --[[ T_TYPEOF ]]44);
          t = primary(env);
          return --[[ tuple ]]{
                  btwn(start_loc_2, t[1]),
                  --[[ Typeof ]]Block.__(7, {t})
                }; end end end end 
       if ___conditional___ == 89--[[ T_LESS_THAN ]] then do
          env_3 = env;
          start_loc_3 = Curry._2(Parser_env_Peek.loc, nil, env_3);
          typeParameters = Curry._2(type_parameter_declaration, false, env_3);
          match_4 = function_param_list(env_3);
          token_4(env_3, --[[ T_ARROW ]]10);
          returnType_1 = union(env_3);
          end_loc_2 = returnType_1[1];
          return --[[ tuple ]]{
                  btwn(start_loc_3, end_loc_2),
                  --[[ Function ]]Block.__(1, {{
                        params = match_4[2],
                        returnType = returnType_1,
                        rest = match_4[1],
                        typeParameters = typeParameters
                      }})
                }; end end 
       if ___conditional___ == 97--[[ T_MULT ]] then do
          token_4(env, --[[ T_MULT ]]97);
          return --[[ tuple ]]{
                  loc,
                  --[[ Exists ]]6
                }; end end 
      exit = 1;
        
    end
  end else do
    local ___conditional___=(token_5.tag | 0);
    do
       if ___conditional___ == 1--[[ T_STRING ]] then do
          match_5 = token_5[1];
          octal = match_5[4];
          raw = match_5[3];
          value = match_5[2];
          loc_1 = match_5[1];
          if (octal) then do
            strict_error(env, --[[ StrictOctalLiteral ]]31);
          end
           end 
          token_4(env, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                    loc_1,
                    value,
                    raw,
                    octal
                  }}));
          return --[[ tuple ]]{
                  loc_1,
                  --[[ StringLiteral ]]Block.__(9, {{
                        value = value,
                        raw = raw
                      }})
                }; end end 
       if ___conditional___ == 5--[[ T_NUMBER_SINGLETON_TYPE ]] then do
          value_1 = token_5[2];
          number_type = token_5[1];
          raw_1 = Curry._2(Parser_env_Peek.value, nil, env);
          token_4(env, --[[ T_NUMBER_SINGLETON_TYPE ]]Block.__(5, {
                  number_type,
                  value_1
                }));
          if (number_type == --[[ LEGACY_OCTAL ]]1) then do
            strict_error(env, --[[ StrictOctalLiteral ]]31);
          end
           end 
          return --[[ tuple ]]{
                  loc,
                  --[[ NumberLiteral ]]Block.__(10, {{
                        value = value_1,
                        raw = raw_1
                      }})
                }; end end 
      exit = 1;
        
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        match_6 = primitive(token_5);
        if (match_6 ~= nil) then do
          token_4(env, token_5);
          return --[[ tuple ]]{
                  loc,
                  match_6
                };
        end else do
          error_unexpected(env);
          return --[[ tuple ]]{
                  loc,
                  --[[ Any ]]0
                };
        end end  end end 
     if ___conditional___ == 2 then do
        raw_2 = Curry._2(Parser_env_Peek.value, nil, env);
        token_4(env, token_5);
        value_2 = token_5 == --[[ T_TRUE ]]29;
        return --[[ tuple ]]{
                loc,
                --[[ BooleanLiteral ]]Block.__(11, {{
                      value = value_2,
                      raw = raw_2
                    }})
              }; end end 
    
  end
end end

function primitive(param) do
  if (type(param) == "number") then do
    if (param ~= 27) then do
      if (param >= 107) then do
        local ___conditional___=(param - 107 | 0);
        do
           if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
              return --[[ Any ]]0; end end 
           if ___conditional___ == 1--[[ T_LCURLY ]] then do
              return --[[ Boolean ]]5; end end 
           if ___conditional___ == 2--[[ T_RCURLY ]] then do
              return --[[ Number ]]3; end end 
           if ___conditional___ == 3--[[ T_LPAREN ]] then do
              return --[[ String ]]4; end end 
           if ___conditional___ == 4--[[ T_RPAREN ]] then do
              return --[[ Void ]]1; end end 
          
        end
      end else do
        return ;
      end end 
    end else do
      return --[[ Null ]]2;
    end end 
  end
   end 
end end

function function_param_or_generic_type(env) do
  id = Curry._2(Parse.identifier, nil, env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and (match == 77 or match == 76)) then do
    param = function_param_with_id(env, id);
    maybe(env, --[[ T_COMMA ]]8);
    return --[[ ParamList ]]Block.__(0, {Curry._2(function_param_list_without_parens, env, --[[ :: ]]{
                    param,
                    --[[ [] ]]0
                  })});
  end
   end 
  return --[[ Type ]]Block.__(1, {Curry._2(union_with, env, Curry._2(intersection_with, env, postfix_with(env, generic_type_with_identifier(env, id))))});
end end

function union(env) do
  maybe(env, --[[ T_BIT_OR ]]80);
  left = intersection(env);
  return Curry._2(union_with, env, left);
end end

function function_param_with_id(env, name) do
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
  end
   end 
  optional = maybe(env, --[[ T_PLING ]]76);
  token_4(env, --[[ T_COLON ]]77);
  typeAnnotation = union(env);
  return --[[ tuple ]]{
          btwn(name[1], typeAnnotation[1]),
          {
            name = name,
            typeAnnotation = typeAnnotation,
            optional = optional
          }
        };
end end

function generic_type_with_identifier(env, id) do
  match = Curry._2(raw_generic_with_identifier, env, id);
  return --[[ tuple ]]{
          match[1],
          --[[ Generic ]]Block.__(4, {match[2]})
        };
end end

function postfix_with(env, _t) do
  while(true) do
    t = _t;
    if (not Curry._1(Parser_env_Peek.is_line_terminator, env) and maybe(env, --[[ T_LBRACKET ]]5)) then do
      end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RBRACKET ]]6);
      loc = btwn(t[1], end_loc);
      t_001 = --[[ Array ]]Block.__(3, {t});
      t_1 = --[[ tuple ]]{
        loc,
        t_001
      };
      _t = t_1;
      ::continue:: ;
    end else do
      return t;
    end end 
  end;
end end

function function_param_list(env) do
  token_4(env, --[[ T_LPAREN ]]3);
  ret = Curry._2(function_param_list_without_parens, env, --[[ [] ]]0);
  token_4(env, --[[ T_RPAREN ]]4);
  return ret;
end end

function prefix(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and match == 76) then do
    loc = Curry._2(Parser_env_Peek.loc, nil, env);
    token_4(env, --[[ T_PLING ]]76);
    t = prefix(env);
    return --[[ tuple ]]{
            btwn(loc, t[1]),
            --[[ Nullable ]]Block.__(0, {t})
          };
  end else do
    env_1 = env;
    t_1 = primary(env_1);
    return postfix_with(env_1, t_1);
  end end 
end end

function rev_nonempty_acc(acc) do
  end_loc;
  if (acc) then do
    end_loc = acc[1][1];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "parser_flow.ml",
        127,
        13
      }
    })
  end end 
  acc_1 = List.rev(acc);
  start_loc;
  if (acc_1) then do
    start_loc = acc_1[1][1];
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "parser_flow.ml",
        131,
        13
      }
    })
  end end 
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          acc_1
        };
end end

function param_list_or_type(env) do
  token_4(env, --[[ T_LPAREN ]]3);
  token_5 = Curry._2(Parser_env_Peek.token, nil, env);
  ret;
  exit = 0;
  if (type(token_5) == "number") then do
    if (token_5 ~= 105) then do
      if (token_5 >= 12) then do
        exit = 1;
      end else do
        local ___conditional___=(token_5);
        do
           if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
              ret = function_param_or_generic_type(env); end else 
           if ___conditional___ == 4--[[ T_RPAREN ]] then do
              ret = --[[ ParamList ]]Block.__(0, {--[[ tuple ]]{
                    nil,
                    --[[ [] ]]0
                  }}); end else 
           if ___conditional___ == 1--[[ T_LCURLY ]]
           or ___conditional___ == 2--[[ T_RCURLY ]]
           or ___conditional___ == 3--[[ T_LPAREN ]]
           or ___conditional___ == 5--[[ T_LBRACKET ]]
           or ___conditional___ == 6--[[ T_RBRACKET ]]
           or ___conditional___ == 7--[[ T_SEMICOLON ]]
           or ___conditional___ == 8--[[ T_COMMA ]]
           or ___conditional___ == 9--[[ T_PERIOD ]]
           or ___conditional___ == 10--[[ T_ARROW ]] then do
              exit = 1; end else 
           if ___conditional___ == 11--[[ T_ELLIPSIS ]] then do
              ret = --[[ ParamList ]]Block.__(0, {Curry._2(function_param_list_without_parens, env, --[[ [] ]]0)}); end else 
           end end end end end end end end
          
        end
      end end 
    end else do
      ret = --[[ ParamList ]]Block.__(0, {Curry._2(function_param_list_without_parens, env, --[[ [] ]]0)});
    end end 
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    match = primitive(token_5);
    if (match ~= nil) then do
      match_1 = Curry._2(Parser_env_Peek.token, 1, env);
      if (type(match_1) == "number" and (match_1 == 77 or match_1 == 76)) then do
        match_2 = Curry._1(Parse.identifier_or_reserved_keyword, env);
        name = match_2[1];
        if (not env.parse_options.types) then do
          error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
        end
         end 
        optional = maybe(env, --[[ T_PLING ]]76);
        token_4(env, --[[ T_COLON ]]77);
        typeAnnotation = union(env);
        if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RPAREN ]]4) then do
          token_4(env, --[[ T_COMMA ]]8);
        end
         end 
        param_000 = btwn(name[1], typeAnnotation[1]);
        param_001 = {
          name = name,
          typeAnnotation = typeAnnotation,
          optional = optional
        };
        param = --[[ tuple ]]{
          param_000,
          param_001
        };
        ret = --[[ ParamList ]]Block.__(0, {Curry._2(function_param_list_without_parens, env, --[[ :: ]]{
                  param,
                  --[[ [] ]]0
                })});
      end else do
        ret = --[[ Type ]]Block.__(1, {union(env)});
      end end 
    end else do
      ret = --[[ Type ]]Block.__(1, {union(env)});
    end end 
  end
   end 
  token_4(env, --[[ T_RPAREN ]]4);
  return ret;
end end

function union_with(env, left) do
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_BIT_OR ]]80) then do
    env_1 = env;
    _acc = --[[ :: ]]{
      left,
      --[[ [] ]]0
    };
    while(true) do
      acc = _acc;
      match = Curry._2(Parser_env_Peek.token, nil, env_1);
      if (type(match) == "number" and match == 80) then do
        token_4(env_1, --[[ T_BIT_OR ]]80);
        _acc = --[[ :: ]]{
          intersection(env_1),
          acc
        };
        ::continue:: ;
      end
       end 
      match_1 = rev_nonempty_acc(acc);
      return --[[ tuple ]]{
              match_1[1],
              --[[ Union ]]Block.__(5, {match_1[2]})
            };
    end;
  end else do
    return left;
  end end 
end end

function methodish(env, start_loc) do
  typeParameters = Curry._2(type_parameter_declaration, false, env);
  match = function_param_list(env);
  token_4(env, --[[ T_COLON ]]77);
  returnType = union(env);
  loc = btwn(start_loc, returnType[1]);
  return --[[ tuple ]]{
          loc,
          {
            params = match[2],
            returnType = returnType,
            rest = match[1],
            typeParameters = typeParameters
          }
        };
end end

function method_property(env, start_loc, __static, key) do
  value = methodish(env, start_loc);
  value_000 = value[1];
  value_001 = --[[ Function ]]Block.__(1, {value[2]});
  value_1 = --[[ tuple ]]{
    value_000,
    value_001
  };
  return --[[ tuple ]]{
          value_001,
          {
            key = key,
            value = value_1,
            optional = false,
            static = __static,
            _method = true
          }
        };
end end

function call_property(env, start_loc, __static) do
  value = methodish(env, Curry._2(Parser_env_Peek.loc, nil, env));
  return --[[ tuple ]]{
          btwn(start_loc, value[1]),
          {
            value = value,
            static = __static
          }
        };
end end

function property(env, start_loc, __static, key) do
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
  end
   end 
  optional = maybe(env, --[[ T_PLING ]]76);
  token_4(env, --[[ T_COLON ]]77);
  value = union(env);
  return --[[ tuple ]]{
          btwn(start_loc, value[1]),
          {
            key = key,
            value = value,
            optional = optional,
            static = __static,
            _method = false
          }
        };
end end

function indexer_property(env, start_loc, __static) do
  token_4(env, --[[ T_LBRACKET ]]5);
  match = Curry._1(Parse.identifier_or_reserved_keyword, env);
  token_4(env, --[[ T_COLON ]]77);
  key = union(env);
  token_4(env, --[[ T_RBRACKET ]]6);
  token_4(env, --[[ T_COLON ]]77);
  value = union(env);
  return --[[ tuple ]]{
          btwn(start_loc, value[1]),
          {
            id = match[1],
            key = key,
            value = value,
            static = __static
          }
        };
end end

function semicolon_1(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match >= 7) then do
      if (match >= 9) then do
        return error_unexpected(env);
      end else do
        return token_3(env);
      end end 
    end else if (match ~= 2) then do
      return error_unexpected(env);
    end else do
      return --[[ () ]]0;
    end end  end 
  end else do
    return error_unexpected(env);
  end end 
end end

function properties(allow_static, env, _param) do
  while(true) do
    param = _param;
    callProperties = param[3];
    indexers = param[2];
    acc = param[1];
    start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    __static = allow_static and maybe(env, --[[ T_STATIC ]]40);
    match = Curry._2(Parser_env_Peek.token, nil, env);
    exit = 0;
    if (type(match) == "number") then do
      if (match ~= 89) then do
        if (match ~= 105) then do
          if (match >= 6) then do
            exit = 1;
          end else do
            local ___conditional___=(match);
            do
               if ___conditional___ == 2--[[ T_RCURLY ]] then do
                  exit = 2; end else 
               if ___conditional___ == 3--[[ T_LPAREN ]] then do
                  exit = 3; end else 
               if ___conditional___ == 0--[[ T_IDENTIFIER ]]
               or ___conditional___ == 1--[[ T_LCURLY ]]
               or ___conditional___ == 4--[[ T_RPAREN ]] then do
                  exit = 1; end else 
               if ___conditional___ == 5--[[ T_LBRACKET ]] then do
                  indexer = indexer_property(env, start_loc, __static);
                  semicolon_1(env);
                  _param = --[[ tuple ]]{
                    acc,
                    --[[ :: ]]{
                      indexer,
                      indexers
                    },
                    callProperties
                  };
                  ::continue:: ; end end end end end end end end 
              
            end
          end end 
        end else do
          exit = 2;
        end end 
      end else do
        exit = 3;
      end end 
    end else do
      exit = 1;
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ == 1 then do
          match_1 = Curry._2(Parser_env_Peek.token, nil, env);
          match_2;
          exit_1 = 0;
          if (__static and type(match_1) == "number" and match_1 == 77) then do
            strict_error_at(env, --[[ tuple ]]{
                  start_loc,
                  --[[ StrictReservedWord ]]39
                });
            static_key_001 = --[[ Identifier ]]Block.__(1, {--[[ tuple ]]{
                  start_loc,
                  {
                    name = "static",
                    typeAnnotation = nil,
                    optional = false
                  }
                }});
            static_key = --[[ tuple ]]{
              start_loc,
              static_key_001
            };
            match_2 = --[[ tuple ]]{
              false,
              static_key
            };
          end else do
            exit_1 = 4;
          end end 
          if (exit_1 == 4) then do
            push_lex_mode(env, --[[ NORMAL ]]0);
            key = Curry._1(Parse.object_key, env);
            pop_lex_mode(env);
            match_2 = --[[ tuple ]]{
              __static,
              key
            };
          end
           end 
          key_1 = match_2[2][2];
          __static_1 = match_2[1];
          match_3 = Curry._2(Parser_env_Peek.token, nil, env);
          property_1 = type(match_3) == "number" and not (match_3 ~= 3 and match_3 ~= 89) and method_property(env, start_loc, __static_1, key_1) or property(env, start_loc, __static_1, key_1);
          semicolon_1(env);
          _param = --[[ tuple ]]{
            --[[ :: ]]{
              property_1,
              acc
            },
            indexers,
            callProperties
          };
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          return --[[ tuple ]]{
                  List.rev(acc),
                  List.rev(indexers),
                  List.rev(callProperties)
                }; end end 
       if ___conditional___ == 3 then do
          call_prop = call_property(env, start_loc, __static);
          semicolon_1(env);
          _param = --[[ tuple ]]{
            acc,
            indexers,
            --[[ :: ]]{
              call_prop,
              callProperties
            }
          };
          ::continue:: ; end end 
      
    end
  end;
end end

function _object(allow_staticOpt, env) do
  allow_static = allow_staticOpt ~= nil and allow_staticOpt or false;
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  match = properties(allow_static, env, --[[ tuple ]]{
        --[[ [] ]]0,
        --[[ [] ]]0,
        --[[ [] ]]0
      });
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            properties = match[1],
            indexers = match[2],
            callProperties = match[3]
          }
        };
end end

function types(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 6 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    acc_000 = union(env);
    acc_1 = --[[ :: ]]{
      acc_000,
      acc
    };
    if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RBRACKET ]]6) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _acc = acc_1;
    ::continue:: ;
  end;
end end

function param(env) do
  match = Curry._1(Parse.identifier_or_reserved_keyword, env);
  return function_param_with_id(env, match[1]);
end end

function function_param_list_without_parens(env) do
  return (function(param_1) do
      env_1 = env;
      _acc = param_1;
      while(true) do
        acc = _acc;
        t = Curry._2(Parser_env_Peek.token, nil, env_1);
        exit = 0;
        if (type(t) == "number") then do
          switcher = t - 4 | 0;
          exit = switcher > 7 or switcher < 0 and (
              switcher ~= 101 and 1 or 2
            ) or (
              switcher > 6 or switcher < 1 and 2 or 1
            );
        end else do
          exit = 1;
        end end 
        local ___conditional___=(exit);
        do
           if ___conditional___ == 1 then do
              acc_000 = param(env_1);
              acc_1 = --[[ :: ]]{
                acc_000,
                acc
              };
              if (Curry._2(Parser_env_Peek.token, nil, env_1) ~= --[[ T_RPAREN ]]4) then do
                token_4(env_1, --[[ T_COMMA ]]8);
              end
               end 
              _acc = acc_1;
              ::continue:: ; end end 
           if ___conditional___ == 2 then do
              rest = t == --[[ T_ELLIPSIS ]]11 and (token_4(env_1, --[[ T_ELLIPSIS ]]11), param(env_1)) or nil;
              return --[[ tuple ]]{
                      rest,
                      List.rev(acc)
                    }; end end 
          
        end
      end;
    end end);
end end

function params(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 90 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    acc_000 = union(env);
    acc_1 = --[[ :: ]]{
      acc_000,
      acc
    };
    if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_GREATER_THAN ]]90) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _acc = acc_1;
    ::continue:: ;
  end;
end end

function type_parameter_instantiation(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LESS_THAN ]]89) then do
    token_4(env, --[[ T_LESS_THAN ]]89);
    params_1 = params(env, --[[ [] ]]0);
    loc = btwn(start_loc, Curry._2(Parser_env_Peek.loc, nil, env));
    token_4(env, --[[ T_GREATER_THAN ]]90);
    return --[[ tuple ]]{
            loc,
            {
              params = params_1
            }
          };
  end
   end 
end end

function intersection_with(env, left) do
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_BIT_AND ]]82) then do
    env_1 = env;
    _acc = --[[ :: ]]{
      left,
      --[[ [] ]]0
    };
    while(true) do
      acc = _acc;
      match = Curry._2(Parser_env_Peek.token, nil, env_1);
      if (type(match) == "number" and match == 82) then do
        token_4(env_1, --[[ T_BIT_AND ]]82);
        _acc = --[[ :: ]]{
          prefix(env_1),
          acc
        };
        ::continue:: ;
      end
       end 
      match_1 = rev_nonempty_acc(acc);
      return --[[ tuple ]]{
              match_1[1],
              --[[ Intersection ]]Block.__(6, {match_1[2]})
            };
    end;
  end else do
    return left;
  end end 
end end

function params_1(env, allow_default, _require_default, _acc) do
  while(true) do
    acc = _acc;
    require_default = _require_default;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    variance = type(match) == "number" and (
        match ~= 94 and (
            match ~= 95 and nil or (token_3(env), --[[ Minus ]]1)
          ) or (token_3(env), --[[ Plus ]]0)
      ) or nil;
    match_1 = Curry._2(Parse.identifier_with_type, env, --[[ StrictParamName ]]28);
    id = match_1[2];
    loc = match_1[1];
    match_2 = Curry._2(Parser_env_Peek.token, nil, env);
    match_3;
    if (allow_default) then do
      exit = 0;
      if (type(match_2) == "number" and match_2 == 75) then do
        token_3(env);
        match_3 = --[[ tuple ]]{
          union(env),
          true
        };
      end else do
        exit = 1;
      end end 
      if (exit == 1) then do
        if (require_default) then do
          error_at(env, --[[ tuple ]]{
                loc,
                --[[ MissingTypeParamDefault ]]58
              });
        end
         end 
        match_3 = --[[ tuple ]]{
          nil,
          require_default
        };
      end
       end 
    end else do
      match_3 = --[[ tuple ]]{
        nil,
        false
      };
    end end 
    param_001 = {
      name = id.name,
      bound = id.typeAnnotation,
      variance = variance,
      default = match_3[1]
    };
    param = --[[ tuple ]]{
      loc,
      param_001
    };
    acc_1 = --[[ :: ]]{
      param,
      acc
    };
    match_4 = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match_4) == "number" and not (match_4 ~= 90 and match_4 ~= 105)) then do
      return List.rev(acc_1);
    end
     end 
    token_4(env, --[[ T_COMMA ]]8);
    if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_GREATER_THAN ]]90) then do
      return List.rev(acc_1);
    end else do
      _acc = acc_1;
      _require_default = match_3[2];
      ::continue:: ;
    end end 
  end;
end end

function type_parameter_declaration(allow_default, env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LESS_THAN ]]89) then do
    if (not env.parse_options.types) then do
      error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
    end
     end 
    token_4(env, --[[ T_LESS_THAN ]]89);
    params_2 = params_1(env, allow_default, false, --[[ [] ]]0);
    loc = btwn(start_loc, Curry._2(Parser_env_Peek.loc, nil, env));
    token_4(env, --[[ T_GREATER_THAN ]]90);
    return --[[ tuple ]]{
            loc,
            {
              params = params_2
            }
          };
  end
   end 
end end

function identifier(env, _param) do
  while(true) do
    param = _param;
    qualification = param[2];
    q_loc = param[1];
    if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_PERIOD ]]9) then do
      token_4(env, --[[ T_PERIOD ]]9);
      id = Curry._2(Parse.identifier, nil, env);
      loc = btwn(q_loc, id[1]);
      qualification_1 = --[[ Qualified ]]Block.__(1, {--[[ tuple ]]{
            loc,
            {
              qualification = qualification,
              id = id
            }
          }});
      _param = --[[ tuple ]]{
        loc,
        qualification_1
      };
      ::continue:: ;
    end else do
      return --[[ tuple ]]{
              q_loc,
              qualification
            };
    end end 
  end;
end end

function raw_generic_with_identifier(env, id) do
  id_000 = id[1];
  id_001 = --[[ Unqualified ]]Block.__(0, {id});
  id_1 = --[[ tuple ]]{
    id_000,
    id_001
  };
  match = identifier(env, id_1);
  id_loc = match[1];
  typeParameters = Curry._1(type_parameter_instantiation, env);
  loc = typeParameters ~= nil and btwn(id_loc, typeParameters[1]) or id_loc;
  return --[[ tuple ]]{
          loc,
          {
            id = match[2],
            typeParameters = typeParameters
          }
        };
end end

_type = union;

function annotation(env) do
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
  end
   end 
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_COLON ]]77);
  typeAnnotation = union(env);
  match = env.last_loc.contents;
  end_loc;
  if (match ~= nil) then do
    end_loc = match;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "parser_flow.ml",
        121,
        16
      }
    })
  end end 
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          typeAnnotation
        };
end end

function annotation_opt(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and match == 77) then do
    return annotation(env);
  end
   end 
end end

function wrap(f, env) do
  env_1 = with_strict(true, env);
  push_lex_mode(env_1, --[[ TYPE ]]1);
  ret = Curry._1(f, env_1);
  pop_lex_mode(env_1);
  return ret;
end end

partial_arg = Curry._1(type_parameter_declaration, true);

function type_parameter_declaration_with_defaults(param) do
  return wrap(partial_arg, param);
end end

partial_arg_1 = Curry._1(type_parameter_declaration, false);

function type_parameter_declaration_1(param) do
  return wrap(partial_arg_1, param);
end end

function _object_1(allow_staticOpt, env) do
  allow_static = allow_staticOpt ~= nil and allow_staticOpt or false;
  return wrap(Curry._1(_object, allow_static), env);
end end

function pattern(check_env, _param) do
  while(true) do
    param = _param;
    p = param[2];
    local ___conditional___=(p.tag | 0);
    do
       if ___conditional___ == 0--[[ Object ]] then do
          check_env_1 = check_env;
          o = p[1];
          return List.fold_left(object_property, check_env_1, o.properties); end end 
       if ___conditional___ == 1--[[ Array ]] then do
          check_env_2 = check_env;
          arr = p[1];
          return List.fold_left(array_element, check_env_2, arr.elements); end end 
       if ___conditional___ == 2--[[ Assignment ]] then do
          _param = p[1].left;
          ::continue:: ; end end 
       if ___conditional___ == 3--[[ Identifier ]] then do
          param_1 = check_env;
          id = p[1];
          name = id[2].name;
          param_names = param_1[2];
          env = param_1[1];
          if (mem_1(name, param_names)) then do
            error_at(env, --[[ tuple ]]{
                  id[1],
                  --[[ StrictParamDupe ]]29
                });
          end
           end 
          match = identifier_no_dupe_check(--[[ tuple ]]{
                env,
                param_names
              }, id);
          return --[[ tuple ]]{
                  match[1],
                  add_1(name, match[2])
                }; end end 
       if ___conditional___ == 4--[[ Expression ]] then do
          error_at(check_env[1], --[[ tuple ]]{
                param[1],
                --[[ ExpectedPatternFoundExpression ]]18
              });
          return check_env; end end 
      
    end
  end;
end end

function object_property(check_env, param) do
  if (param.tag) then do
    return pattern(check_env, param[1][2].argument);
  end else do
    property = param[1][2];
    match = property.key;
    check_env_1;
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 1--[[ Identifier ]] then do
          check_env_1 = identifier_no_dupe_check(check_env, match[1]); end else 
       if ___conditional___ == 0--[[ Literal ]]
       or ___conditional___ == 2--[[ Computed ]] then do
          check_env_1 = check_env; end else 
       end end end end
      
    end
    return pattern(check_env_1, property.pattern);
  end end 
end end

function array_element(check_env, param) do
  if (param ~= nil) then do
    match = param;
    if (match.tag) then do
      return pattern(check_env, match[1][2].argument);
    end else do
      return pattern(check_env, match[1]);
    end end 
  end else do
    return check_env;
  end end 
end end

function identifier_no_dupe_check(param, param_1) do
  name = param_1[2].name;
  loc = param_1[1];
  env = param[1];
  if (is_restricted(name)) then do
    strict_error_at(env, --[[ tuple ]]{
          loc,
          --[[ StrictParamName ]]28
        });
  end
   end 
  if (is_future_reserved(name) or is_strict_reserved(name)) then do
    strict_error_at(env, --[[ tuple ]]{
          loc,
          --[[ StrictReservedWord ]]39
        });
  end
   end 
  return --[[ tuple ]]{
          env,
          param[2]
        };
end end

function strict_post_check(env, strict, simple, id, params) do
  if (strict or not simple) then do
    env_1 = strict and with_strict(not env.in_strict_mode, env) or env;
    if (id ~= nil) then do
      match = id;
      name = match[2].name;
      loc = match[1];
      if (is_restricted(name)) then do
        strict_error_at(env_1, --[[ tuple ]]{
              loc,
              --[[ StrictFunctionName ]]30
            });
      end
       end 
      if (is_future_reserved(name) or is_strict_reserved(name)) then do
        strict_error_at(env_1, --[[ tuple ]]{
              loc,
              --[[ StrictReservedWord ]]39
            });
      end
       end 
    end
     end 
    List.fold_left(pattern, --[[ tuple ]]{
          env_1,
          --[[ Empty ]]0
        }, params);
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function param_1(env) do
  id = Curry._2(Parse.pattern, env, --[[ StrictParamName ]]28);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ASSIGN ]]75) then do
    token_4(env, --[[ T_ASSIGN ]]75);
    __default = Curry._1(Parse.assignment, env);
    return --[[ tuple ]]{
            id,
            __default
          };
  end else do
    return --[[ tuple ]]{
            id,
            nil
          };
  end end 
end end

function param_list(env, _param) do
  while(true) do
    param_2 = _param;
    has_default = param_2[3];
    defaults = param_2[2];
    params = param_2[1];
    t = Curry._2(Parser_env_Peek.token, nil, env);
    exit = 0;
    if (type(t) == "number") then do
      switcher = t - 4 | 0;
      exit = switcher > 7 or switcher < 0 and (
          switcher ~= 101 and 1 or 2
        ) or (
          switcher > 6 or switcher < 1 and 2 or 1
        );
    end else do
      exit = 1;
    end end 
    local ___conditional___=(exit);
    do
       if ___conditional___ == 1 then do
          match = param_1(env);
          __default = match[2];
          has_default_1 = has_default or __default ~= nil;
          if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RPAREN ]]4) then do
            token_4(env, --[[ T_COMMA ]]8);
          end
           end 
          _param = --[[ tuple ]]{
            --[[ :: ]]{
              match[1],
              params
            },
            --[[ :: ]]{
              __default,
              defaults
            },
            has_default_1
          };
          ::continue:: ; end end 
       if ___conditional___ == 2 then do
          rest = t == --[[ T_ELLIPSIS ]]11 and (token_4(env, --[[ T_ELLIPSIS ]]11), Curry._2(Parse.identifier_with_type, env, --[[ StrictParamName ]]28)) or nil;
          if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RPAREN ]]4) then do
            error_1(env, --[[ ParameterAfterRestParameter ]]47);
          end
           end 
          return --[[ tuple ]]{
                  List.rev(params),
                  has_default and List.rev(defaults) or --[[ [] ]]0,
                  rest
                }; end end 
      
    end
  end;
end end

function function_params(env) do
  token_4(env, --[[ T_LPAREN ]]3);
  match = param_list(env, --[[ tuple ]]{
        --[[ [] ]]0,
        --[[ [] ]]0,
        false
      });
  token_4(env, --[[ T_RPAREN ]]4);
  return --[[ tuple ]]{
          match[1],
          match[2],
          match[3]
        };
end end

function function_body(env, async, generator) do
  env_1 = enter_function(env, async, generator);
  match = Curry._1(Parse.function_block_body, env_1);
  loc = match[1];
  return --[[ tuple ]]{
          loc,
          --[[ BodyBlock ]]Block.__(0, {--[[ tuple ]]{
                loc,
                match[2]
              }}),
          match[3]
        };
end end

function generator(env, is_async) do
  match = maybe(env, --[[ T_MULT ]]97);
  if (is_async and match) then do
    error_1(env, --[[ AsyncGenerator ]]48);
    return true;
  end else do
    return match;
  end end 
end end

function is_simple_param(param) do
  if (param[2].tag == --[[ Identifier ]]3) then do
    return true;
  end else do
    return false;
  end end 
end end

function is_simple_function_params(params, defaults, rest) do
  if (defaults == --[[ [] ]]0 and rest == nil) then do
    return List.for_all(is_simple_param, params);
  end else do
    return false;
  end end 
end end

function _function(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  async = maybe(env, --[[ T_ASYNC ]]61);
  token_4(env, --[[ T_FUNCTION ]]13);
  generator_1 = generator(env, async);
  match = env.in_export;
  match_1 = Curry._2(Parser_env_Peek.token, nil, env);
  match_2;
  exit = 0;
  if (match and type(match_1) == "number") then do
    if (match_1 ~= 3) then do
      if (match_1 ~= 89) then do
        exit = 1;
      end else do
        typeParams = Curry._1(type_parameter_declaration_1, env);
        id = Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LPAREN ]]3 and nil or Curry._2(Parse.identifier, --[[ StrictFunctionName ]]30, env);
        match_2 = --[[ tuple ]]{
          typeParams,
          id
        };
      end end 
    end else do
      match_2 = --[[ tuple ]]{
        nil,
        nil
      };
    end end 
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    id_1 = Curry._2(Parse.identifier, --[[ StrictFunctionName ]]30, env);
    match_2 = --[[ tuple ]]{
      Curry._1(type_parameter_declaration_1, env),
      id_1
    };
  end
   end 
  id_2 = match_2[2];
  match_3 = function_params(env);
  rest = match_3[3];
  defaults = match_3[2];
  params = match_3[1];
  returnType = wrap(annotation_opt, env);
  predicate = Curry._1(Parse.predicate, env);
  match_4 = function_body(env, async, generator_1);
  body = match_4[2];
  simple = is_simple_function_params(params, defaults, rest);
  strict_post_check(env, match_4[3], simple, id_2, params);
  match_5;
  match_5 = body.tag and --[[ tuple ]]{
      body[1][1],
      true
    } or --[[ tuple ]]{
      body[1][1],
      false
    };
  return --[[ tuple ]]{
          btwn(start_loc, match_5[1]),
          --[[ FunctionDeclaration ]]Block.__(18, {{
                id = id_2,
                params = params,
                defaults = defaults,
                rest = rest,
                body = body,
                async = async,
                generator = generator_1,
                predicate = predicate,
                expression = match_5[2],
                returnType = returnType,
                typeParameters = match_2[1]
              }})
        };
end end

function variable_declaration(env) do
  id = Curry._2(Parse.pattern, env, --[[ StrictVarName ]]27);
  match;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ASSIGN ]]75) then do
    token_4(env, --[[ T_ASSIGN ]]75);
    match = --[[ tuple ]]{
      Curry._1(Parse.assignment, env),
      --[[ [] ]]0
    };
  end else do
    match = id[2].tag == --[[ Identifier ]]3 and --[[ tuple ]]{
        nil,
        --[[ [] ]]0
      } or --[[ tuple ]]{
        nil,
        --[[ :: ]]{
          --[[ tuple ]]{
            id[1],
            --[[ NoUninitializedDestructuring ]]43
          },
          --[[ [] ]]0
        }
      };
  end end 
  init = match[1];
  end_loc = init ~= nil and init[1] or id[1];
  return --[[ tuple ]]{
          --[[ tuple ]]{
            btwn(id[1], end_loc),
            {
              id = id,
              init = init
            }
          },
          match[2]
        };
end end

function helper(env, _decls, _errs) do
  while(true) do
    errs = _errs;
    decls = _decls;
    match = variable_declaration(env);
    decl = match[1];
    decls_1 = --[[ :: ]]{
      decl,
      decls
    };
    errs_1 = Pervasives._at(match[2], errs);
    if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COMMA ]]8) then do
      token_4(env, --[[ T_COMMA ]]8);
      _errs = errs_1;
      _decls = decls_1;
      ::continue:: ;
    end else do
      end_loc = decl[1];
      declarations = List.rev(decls_1);
      start_loc = decl[1];
      return --[[ tuple ]]{
              btwn(start_loc, end_loc),
              declarations,
              List.rev(errs_1)
            };
    end end 
  end;
end end

function declarations(token_5, kind, env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, token_5);
  match = helper(env, --[[ [] ]]0, --[[ [] ]]0);
  return --[[ tuple ]]{
          --[[ tuple ]]{
            btwn(start_loc, match[1]),
            {
              declarations = match[2],
              kind = kind
            }
          },
          match[3]
        };
end end

function __const(env) do
  env_1 = with_no_let(true, env);
  match = declarations(--[[ T_CONST ]]25, --[[ Const ]]2, env_1);
  match_1 = match[1];
  variable = match_1[2];
  errs = List.fold_left((function(errs, decl) do
          if (decl[2].init ~= nil) then do
            return errs;
          end else do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      decl[1],
                      --[[ NoUninitializedConst ]]42
                    },
                    errs
                  };
          end end 
        end end), match[2], variable.declarations);
  return --[[ tuple ]]{
          --[[ tuple ]]{
            match_1[1],
            variable
          },
          List.rev(errs)
        };
end end

function _let(env) do
  env_1 = with_no_let(true, env);
  return declarations(--[[ T_LET ]]26, --[[ Let ]]1, env_1);
end end

function variable(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  match_1;
  if (type(match) == "number") then do
    local ___conditional___=(match);
    do
       if ___conditional___ == 22--[[ T_VAR ]] then do
          match_1 = declarations(--[[ T_VAR ]]22, --[[ Var ]]0, env); end else 
       if ___conditional___ == 23--[[ T_WHILE ]]
       or ___conditional___ == 24--[[ T_WITH ]] then do
          error_unexpected(env);
          match_1 = declarations(--[[ T_VAR ]]22, --[[ Var ]]0, env); end else 
       if ___conditional___ == 25--[[ T_CONST ]] then do
          match_1 = __const(env); end else 
       if ___conditional___ == 26--[[ T_LET ]] then do
          match_1 = _let(env); end else 
       end end end end end end end end
      error_unexpected(env);
        match_1 = declarations(--[[ T_VAR ]]22, --[[ Var ]]0, env);
        
    end
  end else do
    error_unexpected(env);
    match_1 = declarations(--[[ T_VAR ]]22, --[[ Var ]]0, env);
  end end 
  match_2 = match_1[1];
  return --[[ tuple ]]{
          --[[ tuple ]]{
            btwn(start_loc, match_2[1]),
            --[[ VariableDeclaration ]]Block.__(19, {match_2[2]})
          },
          match_1[2]
        };
end end

function is_tighter(a, b) do
  a_prec;
  a_prec = a.tag and a[1] - 1 | 0 or a[1];
  return a_prec >= b[1];
end end

function is_lhs(param) do
  tmp = param[2];
  if (type(tmp) == "number") then do
    return false;
  end else do
    local ___conditional___=(tmp.tag | 0);
    do
       if ___conditional___ == 13--[[ Member ]]
       or ___conditional___ == 18--[[ Identifier ]] then do
          return true; end end 
      return false;
        
    end
  end end 
end end

function is_assignable_lhs(param) do
  tmp = param[2];
  if (type(tmp) == "number") then do
    return false;
  end else do
    local ___conditional___=(tmp.tag | 0);
    do
       if ___conditional___ == 0--[[ Array ]]
       or ___conditional___ == 1--[[ Object ]]
       or ___conditional___ == 13--[[ Member ]]
       or ___conditional___ == 18--[[ Identifier ]] then do
          return true; end end 
      return false;
        
    end
  end end 
end end

function assignment_op(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  op;
  if (type(match) == "number") then do
    local ___conditional___=(match);
    do
       if ___conditional___ == 63--[[ T_RSHIFT3_ASSIGN ]] then do
          op = --[[ RShift3Assign ]]9; end else 
       if ___conditional___ == 64--[[ T_RSHIFT_ASSIGN ]] then do
          op = --[[ RShiftAssign ]]8; end else 
       if ___conditional___ == 65--[[ T_LSHIFT_ASSIGN ]] then do
          op = --[[ LShiftAssign ]]7; end else 
       if ___conditional___ == 66--[[ T_BIT_XOR_ASSIGN ]] then do
          op = --[[ BitXorAssign ]]11; end else 
       if ___conditional___ == 67--[[ T_BIT_OR_ASSIGN ]] then do
          op = --[[ BitOrAssign ]]10; end else 
       if ___conditional___ == 68--[[ T_BIT_AND_ASSIGN ]] then do
          op = --[[ BitAndAssign ]]12; end else 
       if ___conditional___ == 69--[[ T_MOD_ASSIGN ]] then do
          op = --[[ ModAssign ]]6; end else 
       if ___conditional___ == 70--[[ T_DIV_ASSIGN ]] then do
          op = --[[ DivAssign ]]5; end else 
       if ___conditional___ == 71--[[ T_MULT_ASSIGN ]] then do
          op = --[[ MultAssign ]]3; end else 
       if ___conditional___ == 72--[[ T_EXP_ASSIGN ]] then do
          op = --[[ ExpAssign ]]4; end else 
       if ___conditional___ == 73--[[ T_MINUS_ASSIGN ]] then do
          op = --[[ MinusAssign ]]2; end else 
       if ___conditional___ == 74--[[ T_PLUS_ASSIGN ]] then do
          op = --[[ PlusAssign ]]1; end else 
       if ___conditional___ == 75--[[ T_ASSIGN ]] then do
          op = --[[ Assign ]]0; end else 
       end end end end end end end end end end end end end end end end end end end end end end end end end end
      op = nil;
        
    end
  end else do
    op = nil;
  end end 
  if (op ~= nil) then do
    token_3(env);
  end
   end 
  return op;
end end

function conditional(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  expr = Curry._1(logical, env);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_PLING ]]76) then do
    token_4(env, --[[ T_PLING ]]76);
    env_prime = with_no_in(false, env);
    consequent = Curry._1(assignment, env_prime);
    token_4(env, --[[ T_COLON ]]77);
    match = with_loc(assignment, env);
    loc = btwn(start_loc, match[1]);
    return --[[ tuple ]]{
            loc,
            --[[ Conditional ]]Block.__(10, {{
                  test = expr,
                  consequent = consequent,
                  alternate = match[2]
                }})
          };
  end else do
    return expr;
  end end 
end end

function peek_unary_op(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match >= 46) then do
      if (match >= 94) then do
        if (match >= 102) then do
          return ;
        end else do
          local ___conditional___=(match - 94 | 0);
          do
             if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
                return --[[ Plus ]]1; end end 
             if ___conditional___ == 1--[[ T_LCURLY ]] then do
                return --[[ Minus ]]0; end end 
             if ___conditional___ == 2--[[ T_RCURLY ]]
             or ___conditional___ == 3--[[ T_LPAREN ]]
             or ___conditional___ == 4--[[ T_RPAREN ]]
             or ___conditional___ == 5--[[ T_LBRACKET ]] then do
                return ; end end 
             if ___conditional___ == 6--[[ T_RBRACKET ]] then do
                return --[[ Not ]]2; end end 
             if ___conditional___ == 7--[[ T_SEMICOLON ]] then do
                return --[[ BitNot ]]3; end end 
            
          end
        end end 
      end else if (match ~= 62 or not env.allow_await) then do
        return ;
      end else do
        return --[[ Await ]]7;
      end end  end 
    end else if (match >= 43) then do
      local ___conditional___=(match - 43 | 0);
      do
         if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
            return --[[ Delete ]]6; end end 
         if ___conditional___ == 1--[[ T_LCURLY ]] then do
            return --[[ Typeof ]]4; end end 
         if ___conditional___ == 2--[[ T_RCURLY ]] then do
            return --[[ Void ]]5; end end 
        
      end
    end else do
      return ;
    end end  end 
  end
   end 
end end

function unary(env) do
  begin_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  op = peek_unary_op(env);
  if (op ~= nil) then do
    operator = op;
    token_3(env);
    argument = unary(env);
    loc = btwn(begin_loc, argument[1]);
    if (operator == 6) then do
      tmp = argument[2];
      if (type(tmp) ~= "number" and tmp.tag == --[[ Identifier ]]18) then do
        strict_error_at(env, --[[ tuple ]]{
              loc,
              --[[ StrictDelete ]]32
            });
      end
       end 
    end
     end 
    return --[[ tuple ]]{
            loc,
            --[[ Unary ]]Block.__(5, {{
                  operator = operator,
                  prefix = true,
                  argument = argument
                }})
          };
  end else do
    match = Curry._2(Parser_env_Peek.token, nil, env);
    op_1 = type(match) == "number" and (
        match ~= 102 and (
            match ~= 103 and nil or --[[ Decrement ]]1
          ) or --[[ Increment ]]0
      ) or nil;
    if (op_1 ~= nil) then do
      token_3(env);
      argument_1 = unary(env);
      if (not is_lhs(argument_1)) then do
        error_at(env, --[[ tuple ]]{
              argument_1[1],
              --[[ InvalidLHSInAssignment ]]14
            });
      end
       end 
      match_1 = argument_1[2];
      if (type(match_1) ~= "number" and match_1.tag == --[[ Identifier ]]18 and is_restricted(match_1[1][2].name)) then do
        strict_error(env, --[[ StrictLHSPrefix ]]38);
      end
       end 
      return --[[ tuple ]]{
              btwn(begin_loc, argument_1[1]),
              --[[ Update ]]Block.__(8, {{
                    operator = op_1,
                    argument = argument_1,
                    prefix = true
                  }})
            };
    end else do
      env_1 = env;
      argument_2 = left_hand_side(env_1);
      if (Curry._1(Parser_env_Peek.is_line_terminator, env_1)) then do
        return argument_2;
      end else do
        match_2 = Curry._2(Parser_env_Peek.token, nil, env_1);
        op_2 = type(match_2) == "number" and (
            match_2 ~= 102 and (
                match_2 ~= 103 and nil or --[[ Decrement ]]1
              ) or --[[ Increment ]]0
          ) or nil;
        if (op_2 ~= nil) then do
          if (not is_lhs(argument_2)) then do
            error_at(env_1, --[[ tuple ]]{
                  argument_2[1],
                  --[[ InvalidLHSInAssignment ]]14
                });
          end
           end 
          match_3 = argument_2[2];
          if (type(match_3) ~= "number" and match_3.tag == --[[ Identifier ]]18 and is_restricted(match_3[1][2].name)) then do
            strict_error(env_1, --[[ StrictLHSPostfix ]]37);
          end
           end 
          end_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
          token_3(env_1);
          return --[[ tuple ]]{
                  btwn(argument_2[1], end_loc),
                  --[[ Update ]]Block.__(8, {{
                        operator = op_2,
                        argument = argument_2,
                        prefix = false
                      }})
                };
        end else do
          return argument_2;
        end end 
      end end 
    end end 
  end end 
end end

function left_hand_side(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  expr;
  exit = 0;
  if (type(match) == "number" and match == 42) then do
    expr = _new(env, (function(new_expr, _args) do
            return new_expr;
          end end));
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    expr = Curry._2(Parser_env_Peek.is_function, nil, env) and _function_1(env) or primary_1(env);
  end
   end 
  expr_1 = member(env, expr);
  match_1 = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match_1) == "number") then do
    if (match_1 == --[[ T_LPAREN ]]3) then do
      return call(env, expr_1);
    end else do
      return expr_1;
    end end 
  end else if (match_1.tag == --[[ T_TEMPLATE_PART ]]2) then do
    return member(env, tagged_template(env, expr_1, match_1[1]));
  end else do
    return expr_1;
  end end  end 
end end

function call(env, _left) do
  while(true) do
    left = _left;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number") then do
      local ___conditional___=(match);
      do
         if ___conditional___ == 3--[[ T_LPAREN ]] then do
            if (env.no_call) then do
              return left;
            end else do
              match_1 = Curry._1(__arguments, env);
              _left = --[[ tuple ]]{
                btwn(left[1], match_1[1]),
                --[[ Call ]]Block.__(12, {{
                      callee = left,
                      arguments = match_1[2]
                    }})
              };
              ::continue:: ;
            end end  end end 
         if ___conditional___ == 5--[[ T_LBRACKET ]] then do
            token_4(env, --[[ T_LBRACKET ]]5);
            expr = Curry._1(Parse.expression, env);
            last_loc = Curry._2(Parser_env_Peek.loc, nil, env);
            loc = btwn(left[1], last_loc);
            token_4(env, --[[ T_RBRACKET ]]6);
            _left = --[[ tuple ]]{
              loc,
              --[[ Member ]]Block.__(13, {{
                    _object = left,
                    property = --[[ PropertyExpression ]]Block.__(1, {expr}),
                    computed = true
                  }})
            };
            ::continue:: ; end end 
         if ___conditional___ == 9--[[ T_PERIOD ]] then do
            token_4(env, --[[ T_PERIOD ]]9);
            match_2 = identifier_or_reserved_keyword(env);
            id = match_2[1];
            _left = --[[ tuple ]]{
              btwn(left[1], id[1]),
              --[[ Member ]]Block.__(13, {{
                    _object = left,
                    property = --[[ PropertyIdentifier ]]Block.__(0, {id}),
                    computed = false
                  }})
            };
            ::continue:: ; end end 
        return left;
          
      end
    end else if (match.tag == --[[ T_TEMPLATE_PART ]]2) then do
      return tagged_template(env, left, match[1]);
    end else do
      return left;
    end end  end 
  end;
end end

function _new(env, _finish_fn) do
  while(true) do
    finish_fn = _finish_fn;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 42) then do
      start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_NEW ]]42);
      finish_fn_prime = (function(finish_fn,start_loc)do
      return function finish_fn_prime(callee, args) do
        match;
        if (args ~= nil) then do
          match_1 = args;
          match = --[[ tuple ]]{
            match_1[1],
            match_1[2]
          };
        end else do
          match = --[[ tuple ]]{
            callee[1],
            --[[ [] ]]0
          };
        end end 
        callee_prime_000 = btwn(start_loc, match[1]);
        callee_prime_001 = --[[ New ]]Block.__(11, {{
              callee = callee,
              arguments = match[2]
            }});
        callee_prime = --[[ tuple ]]{
          callee_prime_000,
          callee_prime_001
        };
        return Curry._2(finish_fn, callee_prime, nil);
      end end
      end end)(finish_fn,start_loc);
      _finish_fn = finish_fn_prime;
      ::continue:: ;
    end
     end 
    Curry._2(Parser_env_Peek.token, nil, env);
    expr = Curry._2(Parser_env_Peek.is_function, nil, env) and _function_1(env) or primary_1(env);
    callee = member(with_no_call(true, env), expr);
    match_1 = Curry._2(Parser_env_Peek.token, nil, env);
    callee_1;
    callee_1 = type(match_1) == "number" or match_1.tag ~= --[[ T_TEMPLATE_PART ]]2 and callee or tagged_template(env, callee, match_1[1]);
    match_2 = Curry._2(Parser_env_Peek.token, nil, env);
    args = type(match_2) == "number" and match_2 == 3 and Curry._1(__arguments, env) or nil;
    return Curry._2(finish_fn, callee_1, args);
  end;
end end

function member(env, left) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match ~= 5) then do
      if (match ~= 9) then do
        return left;
      end else do
        token_4(env, --[[ T_PERIOD ]]9);
        match_1 = identifier_or_reserved_keyword(env);
        id = match_1[1];
        return call(env, --[[ tuple ]]{
                    btwn(left[1], id[1]),
                    --[[ Member ]]Block.__(13, {{
                          _object = left,
                          property = --[[ PropertyIdentifier ]]Block.__(0, {id}),
                          computed = false
                        }})
                  });
      end end 
    end else do
      token_4(env, --[[ T_LBRACKET ]]5);
      expr = Curry._1(Parse.expression, with_no_call(false, env));
      last_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RBRACKET ]]6);
      return call(env, --[[ tuple ]]{
                  btwn(left[1], last_loc),
                  --[[ Member ]]Block.__(13, {{
                        _object = left,
                        property = --[[ PropertyExpression ]]Block.__(1, {expr}),
                        computed = true
                      }})
                });
    end end 
  end else do
    return left;
  end end 
end end

function _function_1(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  async = maybe(env, --[[ T_ASYNC ]]61);
  token_4(env, --[[ T_FUNCTION ]]13);
  generator_1 = generator(env, async);
  match;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LPAREN ]]3) then do
    match = --[[ tuple ]]{
      nil,
      nil
    };
  end else do
    match_1 = Curry._2(Parser_env_Peek.token, nil, env);
    id = type(match_1) == "number" and match_1 == 89 and nil or Curry._2(Parse.identifier, --[[ StrictFunctionName ]]30, env);
    match = --[[ tuple ]]{
      id,
      Curry._1(type_parameter_declaration_1, env)
    };
  end end 
  id_1 = match[1];
  match_2 = function_params(env);
  rest = match_2[3];
  defaults = match_2[2];
  params = match_2[1];
  returnType = wrap(annotation_opt, env);
  predicate = Curry._1(Parse.predicate, env);
  match_3 = function_body(env, async, generator_1);
  body = match_3[2];
  simple = is_simple_function_params(params, defaults, rest);
  strict_post_check(env, match_3[3], simple, id_1, params);
  expression;
  expression = body.tag and true or false;
  return --[[ tuple ]]{
          btwn(start_loc, match_3[1]),
          --[[ Function ]]Block.__(2, {{
                id = id_1,
                params = params,
                defaults = defaults,
                rest = rest,
                body = body,
                async = async,
                generator = generator_1,
                predicate = predicate,
                expression = expression,
                returnType = returnType,
                typeParameters = match[2]
              }})
        };
end end

function number(env, number_type) do
  value = Curry._2(Parser_env_Peek.value, nil, env);
  value_1;
  if (number_type ~= 0) then do
    local ___conditional___=(number_type - 1 | 0);
    do
       if ___conditional___ == 0--[[ BINARY ]] then do
          strict_error(env, --[[ StrictOctalLiteral ]]31);
          value_1 = Caml_format.caml_int_of_string("0o" .. value); end else 
       if ___conditional___ == 1--[[ LEGACY_OCTAL ]] then do
          value_1 = Caml_format.caml_int_of_string(value); end else 
       if ___conditional___ == 2--[[ OCTAL ]] then do
          xpcall(function() do
            value_1 = float_of_string(value);
          end end,function(exn) do
            if (Sys.win32) then do
              error_1(env, --[[ WindowsFloatOfString ]]59);
              value_1 = 789.0;
            end else do
              error(exn)
            end end 
          end end) end else 
       end end end end end end
      
    end
  end else do
    value_1 = Caml_format.caml_int_of_string(value);
  end end 
  token_4(env, --[[ T_NUMBER ]]Block.__(0, {number_type}));
  return value_1;
end end

function primary_1(env) do
  loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_5 = Curry._2(Parser_env_Peek.token, nil, env);
  exit = 0;
  if (type(token_5) == "number") then do
    local ___conditional___=(token_5);
    do
       if ___conditional___ == 1--[[ T_LCURLY ]] then do
          env_1 = env;
          match = Curry._1(Parse.object_initializer, env_1);
          return --[[ tuple ]]{
                  match[1],
                  --[[ Object ]]Block.__(1, {match[2]})
                }; end end 
       if ___conditional___ == 3--[[ T_LPAREN ]] then do
          env_2 = env;
          token_4(env_2, --[[ T_LPAREN ]]3);
          expression = Curry._1(assignment, env_2);
          match_1 = Curry._2(Parser_env_Peek.token, nil, env_2);
          ret;
          if (type(match_1) == "number") then do
            if (match_1 ~= 8) then do
              if (match_1 ~= 77) then do
                ret = expression;
              end else do
                typeAnnotation = wrap(annotation, env_2);
                ret = --[[ tuple ]]{
                  btwn(expression[1], typeAnnotation[1]),
                  --[[ TypeCast ]]Block.__(24, {{
                        expression = expression,
                        typeAnnotation = typeAnnotation
                      }})
                };
              end end 
            end else do
              ret = sequence(env_2, --[[ :: ]]{
                    expression,
                    --[[ [] ]]0
                  });
            end end 
          end else do
            ret = expression;
          end end 
          token_4(env_2, --[[ T_RPAREN ]]4);
          return ret; end end 
       if ___conditional___ == 5--[[ T_LBRACKET ]] then do
          match_2 = Curry._1(array_initializer, env);
          return --[[ tuple ]]{
                  match_2[1],
                  --[[ Array ]]Block.__(0, {match_2[2]})
                }; end end 
       if ___conditional___ == 19--[[ T_THIS ]] then do
          token_4(env, --[[ T_THIS ]]19);
          return --[[ tuple ]]{
                  loc,
                  --[[ This ]]0
                }; end end 
       if ___conditional___ == 27--[[ T_NULL ]] then do
          raw = Curry._2(Parser_env_Peek.value, nil, env);
          token_4(env, --[[ T_NULL ]]27);
          return --[[ tuple ]]{
                  loc,
                  --[[ Literal ]]Block.__(19, {{
                        value = --[[ Null ]]0,
                        raw = raw
                      }})
                }; end end 
       if ___conditional___ == 28--[[ T_FALSE ]]
       or ___conditional___ == 29--[[ T_TRUE ]] then do
          exit = 2; end else 
       if ___conditional___ == 38--[[ T_CLASS ]] then do
          return Curry._1(Parse.class_expression, env); end end end end 
       if ___conditional___ == 49--[[ T_SUPER ]] then do
          loc_1 = Curry._2(Parser_env_Peek.loc, nil, env);
          token_4(env, --[[ T_SUPER ]]49);
          id_001 = {
            name = "super",
            typeAnnotation = nil,
            optional = false
          };
          id = --[[ tuple ]]{
            loc_1,
            id_001
          };
          return --[[ tuple ]]{
                  loc_1,
                  --[[ Identifier ]]Block.__(18, {id})
                }; end end 
       if ___conditional___ == 89--[[ T_LESS_THAN ]] then do
          match_3 = Curry._1(Parse.jsx_element, env);
          return --[[ tuple ]]{
                  match_3[1],
                  --[[ JSXElement ]]Block.__(22, {match_3[2]})
                }; end end 
       if ___conditional___ == 70--[[ T_DIV_ASSIGN ]]
       or ___conditional___ == 96--[[ T_DIV ]] then do
          env_3 = env;
          push_lex_mode(env_3, --[[ REGEXP ]]5);
          loc_2 = Curry._2(Parser_env_Peek.loc, nil, env_3);
          match_4 = Curry._2(Parser_env_Peek.token, nil, env_3);
          match_5;
          if (type(match_4) == "number") then do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "parser_flow.ml",
                1699,
                15
              }
            })
          end else if (match_4.tag == --[[ T_REGEXP ]]3) then do
            match_6 = match_4[1];
            raw_1 = Curry._2(Parser_env_Peek.value, nil, env_3);
            token_3(env_3);
            match_5 = --[[ tuple ]]{
              raw_1,
              match_6[2],
              match_6[3]
            };
          end else do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "parser_flow.ml",
                1699,
                15
              }
            })
          end end  end 
          raw_flags = match_5[3];
          pop_lex_mode(env_3);
          filtered_flags = __Buffer.create(#raw_flags);
          __String.iter((function(c) do
                  if (c >= 110) then do
                    if (c ~= 121) then do
                      return --[[ () ]]0;
                    end else do
                      return __Buffer.add_char(filtered_flags, c);
                    end end 
                  end else if (c >= 103) then do
                    local ___conditional___=(c - 103 | 0);
                    do
                       if ___conditional___ == 1
                       or ___conditional___ == 3
                       or ___conditional___ == 4
                       or ___conditional___ == 5 then do
                          return --[[ () ]]0; end end 
                       if ___conditional___ == 0
                       or ___conditional___ == 2
                       or ___conditional___ == 6 then do
                          return __Buffer.add_char(filtered_flags, c); end end 
                      
                    end
                  end else do
                    return --[[ () ]]0;
                  end end  end 
                end end), raw_flags);
          flags = __Buffer.contents(filtered_flags);
          if (flags ~= raw_flags) then do
            error_1(env_3, --[[ InvalidRegExpFlags ]]Block.__(3, {raw_flags}));
          end
           end 
          value = --[[ RegExp ]]Block.__(3, {{
                pattern = match_5[2],
                flags = flags
              }});
          return --[[ tuple ]]{
                  loc_2,
                  --[[ Literal ]]Block.__(19, {{
                        value = value,
                        raw = match_5[1]
                      }})
                }; end end 
      exit = 1;
        
    end
  end else do
    local ___conditional___=(token_5.tag | 0);
    do
       if ___conditional___ == 0--[[ T_NUMBER ]] then do
          raw_2 = Curry._2(Parser_env_Peek.value, nil, env);
          value_1 = --[[ Number ]]Block.__(2, {number(env, token_5[1])});
          return --[[ tuple ]]{
                  loc,
                  --[[ Literal ]]Block.__(19, {{
                        value = value_1,
                        raw = raw_2
                      }})
                }; end end 
       if ___conditional___ == 1--[[ T_STRING ]] then do
          match_7 = token_5[1];
          octal = match_7[4];
          raw_3 = match_7[3];
          value_2 = match_7[2];
          loc_3 = match_7[1];
          if (octal) then do
            strict_error(env, --[[ StrictOctalLiteral ]]31);
          end
           end 
          token_4(env, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                    loc_3,
                    value_2,
                    raw_3,
                    octal
                  }}));
          value_3 = --[[ String ]]Block.__(0, {value_2});
          return --[[ tuple ]]{
                  loc_3,
                  --[[ Literal ]]Block.__(19, {{
                        value = value_3,
                        raw = raw_3
                      }})
                }; end end 
       if ___conditional___ == 2--[[ T_TEMPLATE_PART ]] then do
          match_8 = Curry._2(template_literal, env, token_5[1]);
          return --[[ tuple ]]{
                  match_8[1],
                  --[[ TemplateLiteral ]]Block.__(20, {match_8[2]})
                }; end end 
      exit = 1;
        
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        if (Curry._2(Parser_env_Peek.is_identifier, nil, env)) then do
          id_1 = Curry._2(Parse.identifier, nil, env);
          return --[[ tuple ]]{
                  id_1[1],
                  --[[ Identifier ]]Block.__(18, {id_1})
                };
        end else do
          error_unexpected(env);
          if (token_5 == --[[ T_ERROR ]]104) then do
            token_3(env);
          end
           end 
          return --[[ tuple ]]{
                  loc,
                  --[[ Literal ]]Block.__(19, {{
                        value = --[[ Null ]]0,
                        raw = "null"
                      }})
                };
        end end  end end 
     if ___conditional___ == 2 then do
        raw_4 = Curry._2(Parser_env_Peek.value, nil, env);
        token_4(env, token_5);
        value_4 = --[[ Boolean ]]Block.__(1, {token_5 == --[[ T_TRUE ]]29});
        return --[[ tuple ]]{
                loc,
                --[[ Literal ]]Block.__(19, {{
                      value = value_4,
                      raw = raw_4
                    }})
              }; end end 
    
  end
end end

function tagged_template(env, tag, part) do
  quasi = Curry._2(template_literal, env, part);
  return --[[ tuple ]]{
          btwn(tag[1], quasi[1]),
          --[[ TaggedTemplate ]]Block.__(21, {{
                tag = tag,
                quasi = quasi
              }})
        };
end end

function sequence(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 8) then do
      token_4(env, --[[ T_COMMA ]]8);
      expr = Curry._1(assignment, env);
      _acc = --[[ :: ]]{
        expr,
        acc
      };
      ::continue:: ;
    end
     end 
    last_loc = acc and acc[1][1] or none;
    expressions = List.rev(acc);
    first_loc = expressions and expressions[1][1] or none;
    return --[[ tuple ]]{
            btwn(first_loc, last_loc),
            --[[ Sequence ]]Block.__(4, {{
                  expressions = expressions
                }})
          };
  end;
end end

function identifier_or_reserved_keyword(env) do
  lex_token = Curry._2(Parser_env_Peek.token, nil, env);
  lex_value = Curry._2(Parser_env_Peek.value, nil, env);
  lex_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  exit = 0;
  if (type(lex_token) == "number") then do
    if (lex_token >= 58) then do
      if (lex_token >= 62) then do
        exit = 1;
      end else do
        return --[[ tuple ]]{
                Curry._2(Parse.identifier, nil, env),
                nil
              };
      end end 
    end else if (lex_token ~= 0) then do
      exit = 1;
    end else do
      return --[[ tuple ]]{
              Curry._2(Parse.identifier, nil, env),
              nil
            };
    end end  end 
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    err;
    exit_1 = 0;
    if (type(lex_token) == "number") then do
      switcher = lex_token - 58 | 0;
      if (switcher > 48 or switcher < 0) then do
        if (switcher >= -45) then do
          exit_1 = 2;
        end else do
          error_unexpected(env);
          err = nil;
        end end 
      end else if (switcher ~= 4) then do
        error_unexpected(env);
        err = nil;
      end else do
        exit_1 = 2;
      end end  end 
    end else do
      error_unexpected(env);
      err = nil;
    end end 
    if (exit_1 == 2) then do
      err = --[[ tuple ]]{
        lex_loc,
        get_unexpected_error(--[[ tuple ]]{
              lex_token,
              lex_value
            })
      };
    end
     end 
    token_3(env);
    return --[[ tuple ]]{
            --[[ tuple ]]{
              lex_loc,
              {
                name = lex_value,
                typeAnnotation = nil,
                optional = false
              }
            },
            err
          };
  end
   end 
end end

function assignment_but_not_arrow_function(env) do
  expr = conditional(env);
  match = assignment_op(env);
  if (match ~= nil) then do
    if (not is_assignable_lhs(expr)) then do
      error_at(env, --[[ tuple ]]{
            expr[1],
            --[[ InvalidLHSInAssignment ]]14
          });
    end
     end 
    match_1 = expr[2];
    if (type(match_1) ~= "number" and match_1.tag == --[[ Identifier ]]18 and is_restricted(match_1[1][2].name)) then do
      strict_error_at(env, --[[ tuple ]]{
            expr[1],
            --[[ StrictLHSAssignment ]]36
          });
    end
     end 
    left = Curry._2(Parse.pattern_from_expr, env, expr);
    right = Curry._1(assignment, env);
    loc = btwn(left[1], right[1]);
    return --[[ tuple ]]{
            loc,
            --[[ Assignment ]]Block.__(7, {{
                  operator = match,
                  left = left,
                  right = right
                }})
          };
  end else do
    return expr;
  end end 
end end

function error_callback(param, param_1) do
  error(Parser_env_Try.Rollback)
end end

function try_assignment_but_not_arrow_function(env) do
  env_1 = with_error_callback(error_callback, env);
  ret = assignment_but_not_arrow_function(env_1);
  match = Curry._2(Parser_env_Peek.token, nil, env_1);
  if (type(match) == "number") then do
    if (match ~= 10) then do
      if (match == 77) then do
        error(Parser_env_Try.Rollback)
      end
       end 
    end else do
      error(Parser_env_Try.Rollback)
    end end 
  end
   end 
  if (Curry._2(Parser_env_Peek.is_identifier, nil, env_1)) then do
    if (Curry._2(Parser_env_Peek.value, nil, env_1) == "checks") then do
      error(Parser_env_Try.Rollback)
    end
     end 
    match_1 = ret[2];
    if (type(match_1) == "number" or not (match_1.tag == --[[ Identifier ]]18 and match_1[1][2].name == "async")) then do
      return ret;
    end else do
      if (not Curry._1(Parser_env_Peek.is_line_terminator, env_1)) then do
        error(Parser_env_Try.Rollback)
      end
       end 
      return ret;
    end end 
  end else do
    return ret;
  end end 
end end

function assignment(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  match_1 = Curry._2(Parser_env_Peek.is_identifier, nil, env);
  exit = 0;
  if (type(match) == "number") then do
    switcher = match - 4 | 0;
    if (switcher > 84 or switcher < 0) then do
      if ((switcher + 1 >>> 0) > 86) then do
        exit = 2;
      end
       end 
    end else if (switcher ~= 52 or not env.allow_yield) then do
      exit = 2;
    end else do
      env_1 = env;
      start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
      token_4(env_1, --[[ T_YIELD ]]56);
      if (not env_1.allow_yield) then do
        error_1(env_1, --[[ IllegalYield ]]24);
      end
       end 
      delegate = maybe(env_1, --[[ T_MULT ]]97);
      has_argument = not (Curry._2(Parser_env_Peek.token, nil, env_1) == --[[ T_SEMICOLON ]]7 or Curry._1(Parser_env_Peek.is_implicit_semicolon, env_1));
      argument = delegate or has_argument and Curry._1(assignment, env_1) or nil;
      end_loc;
      if (argument ~= nil) then do
        end_loc = argument[1];
      end else do
        match_2 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
        end_loc_1 = match_2 ~= nil and match_2 or start_loc;
        semicolon(env_1);
        end_loc = end_loc_1;
      end end 
      return --[[ tuple ]]{
              btwn(start_loc, end_loc),
              --[[ Yield ]]Block.__(14, {{
                    argument = argument,
                    delegate = delegate
                  }})
            };
    end end  end 
  end else do
    exit = 2;
  end end 
  if (exit == 2 and not match_1) then do
    return assignment_but_not_arrow_function(env);
  end
   end 
  match_3 = Curry._2(Parser_env_Try.to_parse, env, try_assignment_but_not_arrow_function);
  if (match_3) then do
    return match_3[1];
  end else do
    match_4 = Curry._2(Parser_env_Try.to_parse, env, try_arrow_function);
    if (match_4) then do
      return match_4[1];
    end else do
      return assignment_but_not_arrow_function(env);
    end end 
  end end 
end end

function make_logical(left, right, operator, loc) do
  return --[[ tuple ]]{
          loc,
          --[[ Logical ]]Block.__(9, {{
                operator = operator,
                left = left,
                right = right
              }})
        };
end end

function logical_and(env, _left, _lloc) do
  while(true) do
    lloc = _lloc;
    left = _left;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 79) then do
      token_4(env, --[[ T_AND ]]79);
      match_1 = with_loc(binary, env);
      loc = btwn(lloc, match_1[1]);
      _lloc = loc;
      _left = make_logical(left, match_1[2], --[[ And ]]1, loc);
      ::continue:: ;
    end else do
      return --[[ tuple ]]{
              lloc,
              left
            };
    end end 
  end;
end end

function logical_or(env, _left, _lloc) do
  while(true) do
    lloc = _lloc;
    left = _left;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 78) then do
      token_4(env, --[[ T_OR ]]78);
      match_1 = with_loc(binary, env);
      match_2 = logical_and(env, match_1[2], match_1[1]);
      loc = btwn(lloc, match_2[1]);
      _lloc = loc;
      _left = make_logical(left, match_2[2], --[[ Or ]]0, loc);
      ::continue:: ;
    end else do
      return --[[ tuple ]]{
              lloc,
              left
            };
    end end 
  end;
end end

function logical(env) do
  match = with_loc(binary, env);
  match_1 = logical_and(env, match[2], match[1]);
  return logical_or(env, match_1[2], match_1[1])[2];
end end

function binary_op(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  ret;
  if (type(match) == "number") then do
    switcher = match - 15 | 0;
    if (switcher == 0 or switcher == 1) then do
      ret = switcher ~= 0 and --[[ tuple ]]{
          --[[ Instanceof ]]21,
          --[[ Left_assoc ]]Block.__(0, {6})
        } or (
          env.no_in and nil or --[[ tuple ]]{
              --[[ In ]]20,
              --[[ Left_assoc ]]Block.__(0, {6})
            }
        );
    end else if (switcher >= 65) then do
      local ___conditional___=(switcher - 65 | 0);
      do
         if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
            ret = --[[ tuple ]]{
              --[[ BitOr ]]17,
              --[[ Left_assoc ]]Block.__(0, {2})
            }; end else 
         if ___conditional___ == 1--[[ T_LCURLY ]] then do
            ret = --[[ tuple ]]{
              --[[ Xor ]]18,
              --[[ Left_assoc ]]Block.__(0, {3})
            }; end else 
         if ___conditional___ == 2--[[ T_RCURLY ]] then do
            ret = --[[ tuple ]]{
              --[[ BitAnd ]]19,
              --[[ Left_assoc ]]Block.__(0, {4})
            }; end else 
         if ___conditional___ == 3--[[ T_LPAREN ]] then do
            ret = --[[ tuple ]]{
              --[[ Equal ]]0,
              --[[ Left_assoc ]]Block.__(0, {5})
            }; end else 
         if ___conditional___ == 4--[[ T_RPAREN ]] then do
            ret = --[[ tuple ]]{
              --[[ NotEqual ]]1,
              --[[ Left_assoc ]]Block.__(0, {5})
            }; end else 
         if ___conditional___ == 5--[[ T_LBRACKET ]] then do
            ret = --[[ tuple ]]{
              --[[ StrictEqual ]]2,
              --[[ Left_assoc ]]Block.__(0, {5})
            }; end else 
         if ___conditional___ == 6--[[ T_RBRACKET ]] then do
            ret = --[[ tuple ]]{
              --[[ StrictNotEqual ]]3,
              --[[ Left_assoc ]]Block.__(0, {5})
            }; end else 
         if ___conditional___ == 7--[[ T_SEMICOLON ]] then do
            ret = --[[ tuple ]]{
              --[[ LessThanEqual ]]5,
              --[[ Left_assoc ]]Block.__(0, {6})
            }; end else 
         if ___conditional___ == 8--[[ T_COMMA ]] then do
            ret = --[[ tuple ]]{
              --[[ GreaterThanEqual ]]7,
              --[[ Left_assoc ]]Block.__(0, {6})
            }; end else 
         if ___conditional___ == 9--[[ T_PERIOD ]] then do
            ret = --[[ tuple ]]{
              --[[ LessThan ]]4,
              --[[ Left_assoc ]]Block.__(0, {6})
            }; end else 
         if ___conditional___ == 10--[[ T_ARROW ]] then do
            ret = --[[ tuple ]]{
              --[[ GreaterThan ]]6,
              --[[ Left_assoc ]]Block.__(0, {6})
            }; end else 
         if ___conditional___ == 11--[[ T_ELLIPSIS ]] then do
            ret = --[[ tuple ]]{
              --[[ LShift ]]8,
              --[[ Left_assoc ]]Block.__(0, {7})
            }; end else 
         if ___conditional___ == 12--[[ T_AT ]] then do
            ret = --[[ tuple ]]{
              --[[ RShift ]]9,
              --[[ Left_assoc ]]Block.__(0, {7})
            }; end else 
         if ___conditional___ == 13--[[ T_FUNCTION ]] then do
            ret = --[[ tuple ]]{
              --[[ RShift3 ]]10,
              --[[ Left_assoc ]]Block.__(0, {7})
            }; end else 
         if ___conditional___ == 14--[[ T_IF ]] then do
            ret = --[[ tuple ]]{
              --[[ Plus ]]11,
              --[[ Left_assoc ]]Block.__(0, {8})
            }; end else 
         if ___conditional___ == 15--[[ T_IN ]] then do
            ret = --[[ tuple ]]{
              --[[ Minus ]]12,
              --[[ Left_assoc ]]Block.__(0, {8})
            }; end else 
         if ___conditional___ == 16--[[ T_INSTANCEOF ]] then do
            ret = --[[ tuple ]]{
              --[[ Div ]]15,
              --[[ Left_assoc ]]Block.__(0, {9})
            }; end else 
         if ___conditional___ == 17--[[ T_RETURN ]] then do
            ret = --[[ tuple ]]{
              --[[ Mult ]]13,
              --[[ Left_assoc ]]Block.__(0, {9})
            }; end else 
         if ___conditional___ == 18--[[ T_SWITCH ]] then do
            ret = --[[ tuple ]]{
              --[[ Exp ]]14,
              --[[ Right_assoc ]]Block.__(1, {10})
            }; end else 
         if ___conditional___ == 19--[[ T_THIS ]] then do
            ret = --[[ tuple ]]{
              --[[ Mod ]]16,
              --[[ Left_assoc ]]Block.__(0, {9})
            }; end else 
         if ___conditional___ == 20--[[ T_THROW ]]
         or ___conditional___ == 21--[[ T_TRY ]]
         or ___conditional___ == 22--[[ T_VAR ]]
         or ___conditional___ == 23--[[ T_WHILE ]]
         or ___conditional___ == 24--[[ T_WITH ]]
         or ___conditional___ == 25--[[ T_CONST ]]
         or ___conditional___ == 26--[[ T_LET ]]
         or ___conditional___ == 27--[[ T_NULL ]]
         or ___conditional___ == 28--[[ T_FALSE ]]
         or ___conditional___ == 29--[[ T_TRUE ]]
         or ___conditional___ == 30--[[ T_BREAK ]]
         or ___conditional___ == 31--[[ T_CASE ]] then do
            ret = nil; end else 
         end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end
        
      end
    end else do
      ret = nil;
    end end  end 
  end else do
    ret = nil;
  end end 
  if (ret ~= nil) then do
    token_3(env);
  end
   end 
  return ret;
end end

function make_binary(left, right, operator, loc) do
  return --[[ tuple ]]{
          loc,
          --[[ Binary ]]Block.__(6, {{
                operator = operator,
                left = left,
                right = right
              }})
        };
end end

function add_to_stack(_right, _param, _rloc, _stack) do
  while(true) do
    param = _param;
    stack = _stack;
    rloc = _rloc;
    right = _right;
    rpri = param[2];
    rop = param[1];
    if (stack) then do
      match = stack[1];
      match_1 = match[2];
      if (is_tighter(match_1[2], rpri)) then do
        loc = btwn(match[3], rloc);
        right_1 = make_binary(match[1], right, match_1[1], loc);
        _stack = stack[2];
        _rloc = loc;
        _param = --[[ tuple ]]{
          rop,
          rpri
        };
        _right = right_1;
        ::continue:: ;
      end
       end 
    end
     end 
    return --[[ :: ]]{
            --[[ tuple ]]{
              right,
              --[[ tuple ]]{
                rop,
                rpri
              },
              rloc
            },
            stack
          };
  end;
end end

function binary(env) do
  env_1 = env;
  _stack = --[[ [] ]]0;
  while(true) do
    stack = _stack;
    start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
    is_unary = peek_unary_op(env_1) ~= nil;
    right = unary(with_no_in(false, env_1));
    match = env_1.last_loc.contents;
    end_loc = match ~= nil and match or right[1];
    right_loc = btwn(start_loc, end_loc);
    if (Curry._2(Parser_env_Peek.token, nil, env_1) == --[[ T_LESS_THAN ]]89) then do
      tmp = right[2];
      if (type(tmp) ~= "number" and tmp.tag == --[[ JSXElement ]]22) then do
        error_1(env_1, --[[ AdjacentJSXElements ]]46);
      end
       end 
    end
     end 
    match_1 = binary_op(env_1);
    if (match_1 ~= nil) then do
      match_2 = match_1;
      rop = match_2[1];
      if (is_unary and rop == --[[ Exp ]]14) then do
        error_at(env_1, --[[ tuple ]]{
              right_loc,
              --[[ InvalidLHSInExponentiation ]]15
            });
      end
       end 
      _stack = add_to_stack(right, --[[ tuple ]]{
            rop,
            match_2[2]
          }, right_loc, stack);
      ::continue:: ;
    end else do
      _right = right;
      _rloc = right_loc;
      _param = stack;
      while(true) do
        param = _param;
        rloc = _rloc;
        right_1 = _right;
        if (param) then do
          match_3 = param[1];
          loc = btwn(match_3[3], rloc);
          _param = param[2];
          _rloc = loc;
          _right = make_binary(match_3[1], right_1, match_3[2][1], loc);
          ::continue:: ;
        end else do
          return right_1;
        end end 
      end;
    end end 
  end;
end end

function argument(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and match == 11) then do
    start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    token_4(env, --[[ T_ELLIPSIS ]]11);
    argument_1 = Curry._1(assignment, env);
    loc = btwn(start_loc, argument_1[1]);
    return --[[ Spread ]]Block.__(1, {--[[ tuple ]]{
                loc,
                {
                  argument = argument_1
                }
              }});
  end else do
    return --[[ Expression ]]Block.__(0, {Curry._1(assignment, env)});
  end end 
end end

function arguments_prime(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 4 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    acc_000 = argument(env);
    acc_1 = --[[ :: ]]{
      acc_000,
      acc
    };
    if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RPAREN ]]4) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _acc = acc_1;
    ::continue:: ;
  end;
end end

function __arguments(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LPAREN ]]3);
  args = arguments_prime(env, --[[ [] ]]0);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RPAREN ]]4);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          args
        };
end end

function template_parts(env, _quasis, _expressions) do
  while(true) do
    expressions = _expressions;
    quasis = _quasis;
    expr = Curry._1(Parse.expression, env);
    expressions_1 = --[[ :: ]]{
      expr,
      expressions
    };
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 2) then do
      push_lex_mode(env, --[[ TEMPLATE ]]4);
      match_1 = Curry._2(Parser_env_Peek.token, nil, env);
      match_2;
      if (type(match_1) == "number") then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "parser_flow.ml",
            1602,
            19
          }
        })
      end else if (match_1.tag == --[[ T_TEMPLATE_PART ]]2) then do
        match_3 = match_1[1];
        tail = match_3[3];
        match_4 = match_3[2];
        token_3(env);
        match_2 = --[[ tuple ]]{
          match_3[1],
          {
            value = {
              raw = match_4.raw,
              cooked = match_4.cooked
            },
            tail = tail
          },
          tail
        };
      end else do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "parser_flow.ml",
            1602,
            19
          }
        })
      end end  end 
      loc = match_2[1];
      pop_lex_mode(env);
      quasis_000 = --[[ tuple ]]{
        loc,
        match_2[2]
      };
      quasis_1 = --[[ :: ]]{
        quasis_000,
        quasis
      };
      if (match_2[3]) then do
        return --[[ tuple ]]{
                loc,
                List.rev(quasis_1),
                List.rev(expressions_1)
              };
      end else do
        _expressions = expressions_1;
        _quasis = quasis_1;
        ::continue:: ;
      end end 
    end
     end 
    error_unexpected(env);
    imaginary_quasi_000 = expr[1];
    imaginary_quasi_001 = {
      value = {
        raw = "",
        cooked = ""
      },
      tail = true
    };
    imaginary_quasi = --[[ tuple ]]{
      imaginary_quasi_000,
      imaginary_quasi_001
    };
    return --[[ tuple ]]{
            expr[1],
            List.rev(--[[ :: ]]{
                  imaginary_quasi,
                  quasis
                }),
            List.rev(expressions_1)
          };
  end;
end end

function template_literal(env, part) do
  is_tail = part[3];
  match = part[2];
  start_loc = part[1];
  token_4(env, --[[ T_TEMPLATE_PART ]]Block.__(2, {part}));
  head_001 = {
    value = {
      raw = match.raw,
      cooked = match.cooked
    },
    tail = is_tail
  };
  head = --[[ tuple ]]{
    start_loc,
    head_001
  };
  match_1 = is_tail and --[[ tuple ]]{
      start_loc,
      --[[ :: ]]{
        head,
        --[[ [] ]]0
      },
      --[[ [] ]]0
    } or template_parts(env, --[[ :: ]]{
          head,
          --[[ [] ]]0
        }, --[[ [] ]]0);
  loc = btwn(start_loc, match_1[1]);
  return --[[ tuple ]]{
          loc,
          {
            quasis = match_1[2],
            expressions = match_1[3]
          }
        };
end end

function elements(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number") then do
      if (match ~= 105) then do
        if (match < 12) then do
          local ___conditional___=(match);
          do
             if ___conditional___ == 6--[[ T_RBRACKET ]] then do
                return List.rev(acc); end end 
             if ___conditional___ == 8--[[ T_COMMA ]] then do
                token_4(env, --[[ T_COMMA ]]8);
                _acc = --[[ :: ]]{
                  nil,
                  acc
                };
                ::continue:: ; end end 
             if ___conditional___ == 0--[[ T_IDENTIFIER ]]
             or ___conditional___ == 1--[[ T_LCURLY ]]
             or ___conditional___ == 2--[[ T_RCURLY ]]
             or ___conditional___ == 3--[[ T_LPAREN ]]
             or ___conditional___ == 4--[[ T_RPAREN ]]
             or ___conditional___ == 5--[[ T_LBRACKET ]]
             or ___conditional___ == 7--[[ T_SEMICOLON ]]
             or ___conditional___ == 9--[[ T_PERIOD ]]
             or ___conditional___ == 10--[[ T_ARROW ]]
             or ___conditional___ == 11--[[ T_ELLIPSIS ]] then do
                start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
                token_4(env, --[[ T_ELLIPSIS ]]11);
                argument = Curry._1(assignment, env);
                loc = btwn(start_loc, argument[1]);
                elem = --[[ Spread ]]Block.__(1, {--[[ tuple ]]{
                      loc,
                      {
                        argument = argument
                      }
                    }});
                _acc = --[[ :: ]]{
                  elem,
                  acc
                };
                ::continue:: ; end end 
            
          end
        end
         end 
      end else do
        return List.rev(acc);
      end end 
    end
     end 
    elem_1 = --[[ Expression ]]Block.__(0, {Curry._1(assignment, env)});
    if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RBRACKET ]]6) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _acc = --[[ :: ]]{
      elem_1,
      acc
    };
    ::continue:: ;
  end;
end end

function array_initializer(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LBRACKET ]]5);
  elements_1 = elements(env, --[[ [] ]]0);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RBRACKET ]]6);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            elements = elements_1
          }
        };
end end

function error_callback_1(param, param_1) do
  if (type(param_1) == "number") then do
    switcher = param_1 - 28 | 0;
    if (switcher > 16 or switcher < 0) then do
      if (switcher ~= 19) then do
        error(Parser_env_Try.Rollback)
      end else do
        return --[[ () ]]0;
      end end 
    end else if (switcher > 15 or switcher < 1) then do
      return --[[ () ]]0;
    end else do
      error(Parser_env_Try.Rollback)
    end end  end 
  end else do
    error(Parser_env_Try.Rollback)
  end end 
end end

function try_arrow_function(env) do
  env_1 = with_error_callback(error_callback_1, env);
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
  async = Curry._2(Parser_env_Peek.token, 1, env_1) ~= --[[ T_ARROW ]]10 and maybe(env_1, --[[ T_ASYNC ]]61);
  typeParameters = Curry._1(type_parameter_declaration_1, env_1);
  match;
  if (Curry._2(Parser_env_Peek.is_identifier, nil, env_1) and typeParameters == nil) then do
    id = Curry._2(Parse.identifier, --[[ StrictParamName ]]28, env_1);
    param_000 = id[1];
    param_001 = --[[ Identifier ]]Block.__(3, {id});
    param = --[[ tuple ]]{
      param_000,
      param_001
    };
    match = --[[ tuple ]]{
      --[[ :: ]]{
        param,
        --[[ [] ]]0
      },
      --[[ [] ]]0,
      nil,
      nil
    };
  end else do
    match_1 = function_params(env_1);
    match = --[[ tuple ]]{
      match_1[1],
      match_1[2],
      match_1[3],
      wrap(annotation_opt, env_1)
    };
  end end 
  rest = match[3];
  defaults = match[2];
  params = match[1];
  predicate = Curry._1(Parse.predicate, env_1);
  env_2 = params == --[[ [] ]]0 or rest ~= nil and without_error_callback(env_1) or env_1;
  if (Curry._1(Parser_env_Peek.is_line_terminator, env_2) and Curry._2(Parser_env_Peek.token, nil, env_2) == --[[ T_ARROW ]]10) then do
    error_1(env_2, --[[ NewlineBeforeArrow ]]44);
  end
   end 
  token_4(env_2, --[[ T_ARROW ]]10);
  env_3 = without_error_callback(env_2);
  match_2 = with_loc((function(param) do
          env = param;
          async_1 = async;
          generator = false;
          env_1 = with_in_function(true, env);
          match = Curry._2(Parser_env_Peek.token, nil, env_1);
          if (type(match) == "number" and match == 1) then do
            match_1 = function_body(env_1, async_1, generator);
            return --[[ tuple ]]{
                    match_1[2],
                    match_1[3]
                  };
          end
           end 
          env_2 = enter_function(env_1, async_1, generator);
          expr = Curry._1(Parse.assignment, env_2);
          return --[[ tuple ]]{
                  --[[ BodyExpression ]]Block.__(1, {expr}),
                  env_2.in_strict_mode
                };
        end end), env_3);
  match_3 = match_2[2];
  body = match_3[1];
  simple = is_simple_function_params(params, defaults, rest);
  strict_post_check(env_3, match_3[2], simple, nil, params);
  expression;
  expression = body.tag and true or false;
  loc = btwn(start_loc, match_2[1]);
  return --[[ tuple ]]{
          loc,
          --[[ ArrowFunction ]]Block.__(3, {{
                id = nil,
                params = params,
                defaults = defaults,
                rest = rest,
                body = body,
                async = async,
                generator = false,
                predicate = predicate,
                expression = expression,
                returnType = match[4],
                typeParameters = typeParameters
              }})
        };
end end

function decorator_list_helper(env, _decorators) do
  while(true) do
    decorators = _decorators;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 12) then do
      token_3(env);
      _decorators = --[[ :: ]]{
        left_hand_side(env),
        decorators
      };
      ::continue:: ;
    end else do
      return decorators;
    end end 
  end;
end end

function decorator_list(env) do
  if (env.parse_options.esproposal_decorators) then do
    return List.rev(decorator_list_helper(env, --[[ [] ]]0));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function key(env) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match == --[[ T_LBRACKET ]]5) then do
      start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_LBRACKET ]]5);
      expr = Curry._1(Parse.assignment, with_no_in(false, env));
      end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RBRACKET ]]6);
      return --[[ tuple ]]{
              btwn(start_loc, end_loc),
              --[[ Computed ]]Block.__(2, {expr})
            };
    end
     end 
  end else do
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 0--[[ T_NUMBER ]] then do
          raw = Curry._2(Parser_env_Peek.value, nil, env);
          loc = Curry._2(Parser_env_Peek.loc, nil, env);
          value = number(env, match[1]);
          value_1 = --[[ Number ]]Block.__(2, {value});
          return --[[ tuple ]]{
                  loc,
                  --[[ Literal ]]Block.__(0, {--[[ tuple ]]{
                        loc,
                        {
                          value = value_1,
                          raw = raw
                        }
                      }})
                }; end end 
       if ___conditional___ == 1--[[ T_STRING ]] then do
          match_1 = match[1];
          octal = match_1[4];
          raw_1 = match_1[3];
          value_2 = match_1[2];
          loc_1 = match_1[1];
          if (octal) then do
            strict_error(env, --[[ StrictOctalLiteral ]]31);
          end
           end 
          token_4(env, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                    loc_1,
                    value_2,
                    raw_1,
                    octal
                  }}));
          value_3 = --[[ String ]]Block.__(0, {value_2});
          return --[[ tuple ]]{
                  loc_1,
                  --[[ Literal ]]Block.__(0, {--[[ tuple ]]{
                        loc_1,
                        {
                          value = value_3,
                          raw = raw_1
                        }
                      }})
                }; end end 
      
    end
  end end 
  match_2 = identifier_or_reserved_keyword(env);
  id = match_2[1];
  return --[[ tuple ]]{
          id[1],
          --[[ Identifier ]]Block.__(1, {id})
        };
end end

function _method(env, kind) do
  generator_1 = generator(env, false);
  match = key(env);
  typeParameters = kind ~= 0 and nil or Curry._1(type_parameter_declaration_1, env);
  token_4(env, --[[ T_LPAREN ]]3);
  params;
  local ___conditional___=(kind);
  do
     if ___conditional___ == 0--[[ Init ]] then do
        error({
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "parser_flow.ml",
            1954,
            16
          }
        }) end end 
     if ___conditional___ == 1--[[ Get ]] then do
        params = --[[ [] ]]0; end else 
     if ___conditional___ == 2--[[ Set ]] then do
        param = Curry._2(Parse.identifier_with_type, env, --[[ StrictParamName ]]28);
        params = --[[ :: ]]{
          --[[ tuple ]]{
            param[1],
            --[[ Identifier ]]Block.__(3, {param})
          },
          --[[ [] ]]0
        }; end else 
     end end end end
    
  end
  token_4(env, --[[ T_RPAREN ]]4);
  returnType = wrap(annotation_opt, env);
  match_1 = function_body(env, false, generator_1);
  body = match_1[2];
  simple = is_simple_function_params(params, --[[ [] ]]0, nil);
  strict_post_check(env, match_1[3], simple, nil, params);
  match_2;
  match_2 = body.tag and --[[ tuple ]]{
      body[1][1],
      true
    } or --[[ tuple ]]{
      body[1][1],
      false
    };
  value_000 = match_2[1];
  value_001 = {
    id = nil,
    params = params,
    defaults = --[[ [] ]]0,
    rest = nil,
    body = body,
    async = false,
    generator = generator_1,
    predicate = nil,
    expression = match_2[2],
    returnType = returnType,
    typeParameters = typeParameters
  };
  value = --[[ tuple ]]{
    value_000,
    value_001
  };
  return --[[ tuple ]]{
          match[2],
          value
        };
end end

function property_1(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ELLIPSIS ]]11) then do
    token_4(env, --[[ T_ELLIPSIS ]]11);
    argument = Curry._1(Parse.assignment, env);
    return --[[ SpreadProperty ]]Block.__(1, {--[[ tuple ]]{
                btwn(start_loc, argument[1]),
                {
                  argument = argument
                }
              }});
  end else do
    async = Curry._2(Parser_env_Peek.is_identifier, 1, env) and maybe(env, --[[ T_ASYNC ]]61);
    match = generator(env, async);
    match_1 = key(env);
    tmp;
    exit = 0;
    if (async or match) then do
      exit = 1;
    end else do
      key_1 = match_1[2];
      local ___conditional___=(key_1.tag | 0);
      do
         if ___conditional___ == 1--[[ Identifier ]] then do
            local ___conditional___=(key_1[1][2].name);
            do
               if ___conditional___ == "get" then do
                  match_2 = Curry._2(Parser_env_Peek.token, nil, env);
                  if (type(match_2) == "number") then do
                    switcher = match_2 - 3 | 0;
                    tmp = switcher > 74 or switcher < 0 and (
                        switcher ~= 86 and get(env, start_loc) or init(env, start_loc, key_1, false, false)
                      ) or (
                        switcher > 73 or switcher < 1 and init(env, start_loc, key_1, false, false) or get(env, start_loc)
                      );
                  end else do
                    tmp = get(env, start_loc);
                  end end  end else 
               if ___conditional___ == "set" then do
                  match_3 = Curry._2(Parser_env_Peek.token, nil, env);
                  if (type(match_3) == "number") then do
                    switcher_1 = match_3 - 3 | 0;
                    tmp = switcher_1 > 74 or switcher_1 < 0 and (
                        switcher_1 ~= 86 and set(env, start_loc) or init(env, start_loc, key_1, false, false)
                      ) or (
                        switcher_1 > 73 or switcher_1 < 1 and init(env, start_loc, key_1, false, false) or set(env, start_loc)
                      );
                  end else do
                    tmp = set(env, start_loc);
                  end end  end else 
               end end end end
              exit = 1;
                
            end end else 
         if ___conditional___ == 0--[[ Literal ]]
         or ___conditional___ == 2--[[ Computed ]] then do
            exit = 1; end else 
         end end end end
        
      end
    end end 
    if (exit == 1) then do
      tmp = init(env, start_loc, match_1[2], async, match);
    end
     end 
    return --[[ Property ]]Block.__(0, {tmp});
  end end 
end end

function get(env, start_loc) do
  match = _method(env, --[[ Get ]]1);
  match_1 = match[2];
  end_loc = match_1[1];
  value_001 = --[[ Function ]]Block.__(2, {match_1[2]});
  value = --[[ tuple ]]{
    end_loc,
    value_001
  };
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            key = match[1],
            value = value,
            kind = --[[ Get ]]1,
            _method = false,
            shorthand = false
          }
        };
end end

function set(env, start_loc) do
  match = _method(env, --[[ Set ]]2);
  match_1 = match[2];
  end_loc = match_1[1];
  value_001 = --[[ Function ]]Block.__(2, {match_1[2]});
  value = --[[ tuple ]]{
    end_loc,
    value_001
  };
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            key = match[1],
            value = value,
            kind = --[[ Set ]]2,
            _method = false,
            shorthand = false
          }
        };
end end

function init(env, start_loc, key, async, generator) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  match_1;
  exit = 0;
  if (type(match) == "number") then do
    if (match ~= 89) then do
      if (match >= 9) then do
        exit = 1;
      end else do
        local ___conditional___=(match);
        do
           if ___conditional___ == 3--[[ T_LPAREN ]] then do
              exit = 3; end else 
           if ___conditional___ == 0--[[ T_IDENTIFIER ]]
           or ___conditional___ == 1--[[ T_LCURLY ]]
           or ___conditional___ == 4--[[ T_RPAREN ]]
           or ___conditional___ == 5--[[ T_LBRACKET ]]
           or ___conditional___ == 6--[[ T_RBRACKET ]]
           or ___conditional___ == 7--[[ T_SEMICOLON ]] then do
              exit = 1; end else 
           if ___conditional___ == 2--[[ T_RCURLY ]]
           or ___conditional___ == 8--[[ T_COMMA ]] then do
              exit = 2; end else 
           end end end end end end
          
        end
      end end 
    end else do
      exit = 3;
    end end 
  end else do
    exit = 1;
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        token_4(env, --[[ T_COLON ]]77);
        match_1 = --[[ tuple ]]{
          Curry._1(Parse.assignment, env),
          false,
          false
        }; end else 
     if ___conditional___ == 2 then do
        tmp;
        local ___conditional___=(key.tag | 0);
        do
           if ___conditional___ == 0--[[ Literal ]] then do
              lit = key[1];
              tmp = --[[ tuple ]]{
                lit[1],
                --[[ Literal ]]Block.__(19, {lit[2]})
              }; end else 
           if ___conditional___ == 1--[[ Identifier ]] then do
              id = key[1];
              tmp = --[[ tuple ]]{
                id[1],
                --[[ Identifier ]]Block.__(18, {id})
              }; end else 
           if ___conditional___ == 2--[[ Computed ]] then do
              tmp = key[1]; end else 
           end end end end end end
          
        end
        match_1 = --[[ tuple ]]{
          tmp,
          true,
          false
        }; end else 
     if ___conditional___ == 3 then do
        typeParameters = Curry._1(type_parameter_declaration_1, env);
        match_2 = function_params(env);
        rest = match_2[3];
        defaults = match_2[2];
        params = match_2[1];
        returnType = wrap(annotation_opt, env);
        match_3 = function_body(env, async, generator);
        body = match_3[2];
        simple = is_simple_function_params(params, defaults, rest);
        strict_post_check(env, match_3[3], simple, nil, params);
        match_4;
        match_4 = body.tag and --[[ tuple ]]{
            body[1][1],
            true
          } or --[[ tuple ]]{
            body[1][1],
            false
          };
        value_000 = match_4[1];
        value_001 = --[[ Function ]]Block.__(2, {{
              id = nil,
              params = params,
              defaults = defaults,
              rest = rest,
              body = body,
              async = async,
              generator = generator,
              predicate = nil,
              expression = match_4[2],
              returnType = returnType,
              typeParameters = typeParameters
            }});
        value = --[[ tuple ]]{
          value_000,
          value_001
        };
        match_1 = --[[ tuple ]]{
          value,
          false,
          true
        }; end else 
     end end end end end end
    
  end
  value_1 = match_1[1];
  return --[[ tuple ]]{
          btwn(start_loc, value_1[1]),
          {
            key = key,
            value = value_1,
            kind = --[[ Init ]]0,
            _method = match_1[3],
            shorthand = match_1[2]
          }
        };
end end

function check_property(env, prop_map, prop) do
  if (prop.tag) then do
    return prop_map;
  end else do
    match = prop[1];
    prop_1 = match[2];
    prop_loc = match[1];
    exit = 0;
    local ___conditional___=(prop_1.key.tag | 0);
    do
       if ___conditional___ == 0--[[ Literal ]]
       or ___conditional___ == 1--[[ Identifier ]] then do
          exit = 1; end else 
       if ___conditional___ == 2--[[ Computed ]] then do
          return prop_map; end end end end 
      
    end
    if (exit == 1) then do
      match_1 = prop_1.key;
      key;
      local ___conditional___=(match_1.tag | 0);
      do
         if ___conditional___ == 0--[[ Literal ]] then do
            match_2 = match_1[1][2].value;
            if (type(match_2) == "number") then do
              key = "nil";
            end else do
              local ___conditional___=(match_2.tag | 0);
              do
                 if ___conditional___ == 0--[[ String ]] then do
                    key = match_2[1]; end else 
                 if ___conditional___ == 1--[[ Boolean ]] then do
                    b = match_2[1];
                    key = b and "true" or "false"; end else 
                 if ___conditional___ == 2--[[ Number ]] then do
                    key = Pervasives.string_of_float(match_2[1]); end else 
                 if ___conditional___ == 3--[[ RegExp ]] then do
                    error({
                      Caml_builtin_exceptions.failure,
                      "RegExp cannot be property key"
                    }) end end end end end end end end 
                
              end
            end end  end else 
         if ___conditional___ == 1--[[ Identifier ]] then do
            key = match_1[1][2].name; end else 
         if ___conditional___ == 2--[[ Computed ]] then do
            error({
              Caml_builtin_exceptions.assert_failure,
              --[[ tuple ]]{
                "parser_flow.ml",
                2103,
                30
              }
            }) end end end end end end 
        
      end
      prev_kinds;
      xpcall(function() do
        prev_kinds = find(key, prop_map);
      end end,function(exn) do
        if (exn == Caml_builtin_exceptions.not_found) then do
          prev_kinds = --[[ Empty ]]0;
        end else do
          error(exn)
        end end 
      end end)
      match_3 = prop_1.kind;
      kind_string;
      local ___conditional___=(match_3);
      do
         if ___conditional___ == 0--[[ Init ]] then do
            kind_string = "Init"; end else 
         if ___conditional___ == 1--[[ Get ]] then do
            kind_string = "Get"; end else 
         if ___conditional___ == 2--[[ Set ]] then do
            kind_string = "Set"; end else 
         end end end end end end
        
      end
      exit_1 = 0;
      local ___conditional___=(kind_string);
      do
         if ___conditional___ == "Init" then do
            if (mem_1("Init", prev_kinds)) then do
              strict_error_at(env, --[[ tuple ]]{
                    prop_loc,
                    --[[ StrictDuplicateProperty ]]33
                  });
            end else if (mem_1("Set", prev_kinds) or mem_1("Get", prev_kinds)) then do
              error_at(env, --[[ tuple ]]{
                    prop_loc,
                    --[[ AccessorDataProperty ]]34
                  });
            end
             end  end  end else 
         if ___conditional___ == "Get"
         or ___conditional___ == "Set" then do
            exit_1 = 2; end else 
         end end end end
        
      end
      if (exit_1 == 2) then do
        if (mem_1("Init", prev_kinds)) then do
          error_at(env, --[[ tuple ]]{
                prop_loc,
                --[[ AccessorDataProperty ]]34
              });
        end else if (mem_1(kind_string, prev_kinds)) then do
          error_at(env, --[[ tuple ]]{
                prop_loc,
                --[[ AccessorGetSet ]]35
              });
        end
         end  end 
      end
       end 
      kinds = add_1(kind_string, prev_kinds);
      return add_2(key, kinds, prop_map);
    end
     end 
  end end 
end end

function properties_1(env, _param) do
  while(true) do
    param = _param;
    acc = param[2];
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    prop = property_1(env);
    prop_map = check_property(env, param[1], prop);
    if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RCURLY ]]2) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _param = --[[ tuple ]]{
      prop_map,
      --[[ :: ]]{
        prop,
        acc
      }
    };
    ::continue:: ;
  end;
end end

function _initializer(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  props = properties_1(env, --[[ tuple ]]{
        --[[ Empty ]]0,
        --[[ [] ]]0
      });
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            properties = props
          }
        };
end end

function class_implements(env, _acc) do
  while(true) do
    acc = _acc;
    id = Curry._2(Parse.identifier, nil, env);
    typeParameters = wrap(type_parameter_instantiation, env);
    loc = typeParameters ~= nil and btwn(id[1], typeParameters[1]) or id[1];
    implement_001 = {
      id = id,
      typeParameters = typeParameters
    };
    implement = --[[ tuple ]]{
      loc,
      implement_001
    };
    acc_1 = --[[ :: ]]{
      implement,
      acc
    };
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 8) then do
      token_4(env, --[[ T_COMMA ]]8);
      _acc = acc_1;
      ::continue:: ;
    end else do
      return List.rev(acc_1);
    end end 
  end;
end end

function init_1(env, start_loc, decorators, key, async, generator, __static) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  exit = 0;
  if (type(match) == "number") then do
    switcher = match - 75 | 0;
    if (switcher > 2 or switcher < 0) then do
      if (switcher == -68) then do
        exit = 2;
      end
       end 
    end else if (switcher ~= 1) then do
      exit = 2;
    end
     end  end 
  end
   end 
  if (exit == 2 and not async and not generator) then do
    typeAnnotation = wrap(annotation_opt, env);
    options = env.parse_options;
    value = Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ASSIGN ]]75 and (__static and options.esproposal_class_static_fields or not __static and options.esproposal_class_instance_fields) and (token_4(env, --[[ T_ASSIGN ]]75), Curry._1(Parse.expression, env)) or nil;
    end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    if (not maybe(env, --[[ T_SEMICOLON ]]7)) then do
      if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LBRACKET ]]5 or Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_LPAREN ]]3) then do
        error_unexpected(env);
      end
       end 
    end
     end 
    loc = btwn(start_loc, end_loc);
    return --[[ Property ]]Block.__(1, {--[[ tuple ]]{
                loc,
                {
                  key = key,
                  value = value,
                  typeAnnotation = typeAnnotation,
                  static = __static
                }
              }});
  end
   end 
  typeParameters = Curry._1(type_parameter_declaration_1, env);
  match_1 = function_params(env);
  rest = match_1[3];
  defaults = match_1[2];
  params = match_1[1];
  returnType = wrap(annotation_opt, env);
  match_2 = function_body(env, async, generator);
  body = match_2[2];
  simple = is_simple_function_params(params, defaults, rest);
  strict_post_check(env, match_2[3], simple, nil, params);
  match_3;
  match_3 = body.tag and --[[ tuple ]]{
      body[1][1],
      true
    } or --[[ tuple ]]{
      body[1][1],
      false
    };
  end_loc_1 = match_3[1];
  value_001 = {
    id = nil,
    params = params,
    defaults = defaults,
    rest = rest,
    body = body,
    async = async,
    generator = generator,
    predicate = nil,
    expression = match_3[2],
    returnType = returnType,
    typeParameters = typeParameters
  };
  value_1 = --[[ tuple ]]{
    end_loc_1,
    value_001
  };
  kind;
  local ___conditional___=(key.tag | 0);
  do
     if ___conditional___ == 0--[[ Literal ]] then do
        match_4 = key[1][2].value;
        kind = type(match_4) == "number" or match_4.tag or match_4[1] ~= "constructor" and --[[ Method ]]1 or --[[ Constructor ]]0; end else 
     if ___conditional___ == 1--[[ Identifier ]] then do
        kind = key[1][2].name == "constructor" and --[[ Constructor ]]0 or --[[ Method ]]1; end else 
     if ___conditional___ == 2--[[ Computed ]] then do
        kind = --[[ Method ]]1; end else 
     end end end end end end
    
  end
  return --[[ Method ]]Block.__(0, {--[[ tuple ]]{
              btwn(start_loc, end_loc_1),
              {
                kind = kind,
                key = key,
                value = value_1,
                static = __static,
                decorators = decorators
              }
            }});
end end

function class_element(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  decorators = decorator_list(env);
  __static = maybe(env, --[[ T_STATIC ]]40);
  async = Curry._2(Parser_env_Peek.token, 1, env) ~= --[[ T_LPAREN ]]3 and Curry._2(Parser_env_Peek.token, 1, env) ~= --[[ T_COLON ]]77 and maybe(env, --[[ T_ASYNC ]]61);
  generator_1 = generator(env, async);
  match = key(env);
  if (not async and not generator_1) then do
    key_1 = match[2];
    local ___conditional___=(key_1.tag | 0);
    do
       if ___conditional___ == 1--[[ Identifier ]] then do
          local ___conditional___=(key_1[1][2].name);
          do
             if ___conditional___ == "get" then do
                match_1 = Curry._2(Parser_env_Peek.token, nil, env);
                exit = 0;
                exit = type(match_1) == "number" and (
                    match_1 >= 75 and (
                        match_1 >= 78 and (
                            match_1 ~= 89 and 2 or 3
                          ) or (
                            match_1 ~= 76 and 3 or 2
                          )
                      ) or (
                        match_1 ~= 3 and match_1 ~= 7 and 2 or 3
                      )
                  ) or 2;
                local ___conditional___=(exit);
                do
                   if ___conditional___ == 2 then do
                      env_1 = env;
                      start_loc_1 = start_loc;
                      decorators_1 = decorators;
                      __static_1 = __static;
                      match_2 = _method(env_1, --[[ Get ]]1);
                      value = match_2[2];
                      return --[[ Method ]]Block.__(0, {--[[ tuple ]]{
                                  btwn(start_loc_1, value[1]),
                                  {
                                    kind = --[[ Get ]]2,
                                    key = match_2[1],
                                    value = value,
                                    static = __static_1,
                                    decorators = decorators_1
                                  }
                                }}); end end 
                   if ___conditional___ == 3 then do
                      return init_1(env, start_loc, decorators, key_1, async, generator_1, __static); end end 
                  
                end end else 
             if ___conditional___ == "set" then do
                match_3 = Curry._2(Parser_env_Peek.token, nil, env);
                exit_1 = 0;
                exit_1 = type(match_3) == "number" and (
                    match_3 >= 75 and (
                        match_3 >= 78 and (
                            match_3 ~= 89 and 2 or 3
                          ) or (
                            match_3 ~= 76 and 3 or 2
                          )
                      ) or (
                        match_3 ~= 3 and match_3 ~= 7 and 2 or 3
                      )
                  ) or 2;
                local ___conditional___=(exit_1);
                do
                   if ___conditional___ == 2 then do
                      env_2 = env;
                      start_loc_2 = start_loc;
                      decorators_2 = decorators;
                      __static_2 = __static;
                      match_4 = _method(env_2, --[[ Set ]]2);
                      value_1 = match_4[2];
                      return --[[ Method ]]Block.__(0, {--[[ tuple ]]{
                                  btwn(start_loc_2, value_1[1]),
                                  {
                                    kind = --[[ Set ]]3,
                                    key = match_4[1],
                                    value = value_1,
                                    static = __static_2,
                                    decorators = decorators_2
                                  }
                                }}); end end 
                   if ___conditional___ == 3 then do
                      return init_1(env, start_loc, decorators, key_1, async, generator_1, __static); end end 
                  
                end end else 
             end end end end
            
          end end else 
       if ___conditional___ == 0--[[ Literal ]]
       or ___conditional___ == 2--[[ Computed ]]
       end end end
      
    end
  end
   end 
  return init_1(env, start_loc, decorators, match[2], async, generator_1, __static);
end end

function elements_1(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number") then do
      switcher = match - 3 | 0;
      if (switcher > 101 or switcher < 0) then do
        if ((switcher + 1 >>> 0) <= 103) then do
          return List.rev(acc);
        end
         end 
      end else if (switcher == 4) then do
        token_4(env, --[[ T_SEMICOLON ]]7);
        ::continue:: ;
      end
       end  end 
    end
     end 
    _acc = --[[ :: ]]{
      Curry._1(class_element, env),
      acc
    };
    ::continue:: ;
  end;
end end

function class_body(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  body = elements_1(env, --[[ [] ]]0);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            body = body
          }
        };
end end

function _class(env) do
  match;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_EXTENDS ]]39) then do
    token_4(env, --[[ T_EXTENDS ]]39);
    superClass = left_hand_side(with_allow_yield(false, env));
    superTypeParameters = wrap(type_parameter_instantiation, env);
    match = --[[ tuple ]]{
      superClass,
      superTypeParameters
    };
  end else do
    match = --[[ tuple ]]{
      nil,
      nil
    };
  end end 
  __implements;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_IMPLEMENTS ]]50) then do
    if (not env.parse_options.types) then do
      error_1(env, --[[ UnexpectedTypeInterface ]]10);
    end
     end 
    token_4(env, --[[ T_IMPLEMENTS ]]50);
    __implements = class_implements(env, --[[ [] ]]0);
  end else do
    __implements = --[[ [] ]]0;
  end end 
  body = Curry._1(class_body, env);
  return --[[ tuple ]]{
          body,
          match[1],
          match[2],
          __implements
        };
end end

function class_declaration(env, decorators) do
  env_1 = with_strict(true, env);
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
  decorators_1 = Pervasives._at(decorators, decorator_list(env_1));
  token_4(env_1, --[[ T_CLASS ]]38);
  tmp_env = with_no_let(true, env_1);
  match = env_1.in_export;
  match_1 = Curry._2(Parser_env_Peek.is_identifier, nil, tmp_env);
  id = match and not match_1 and nil or Curry._2(Parse.identifier, nil, tmp_env);
  typeParameters = Curry._1(type_parameter_declaration_with_defaults, env_1);
  match_2 = _class(env_1);
  body = match_2[1];
  loc = btwn(start_loc, body[1]);
  return --[[ tuple ]]{
          loc,
          --[[ ClassDeclaration ]]Block.__(20, {{
                id = id,
                body = body,
                superClass = match_2[2],
                typeParameters = typeParameters,
                superTypeParameters = match_2[3],
                implements = match_2[4],
                classDecorators = decorators_1
              }})
        };
end end

function class_expression(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  decorators = decorator_list(env);
  token_4(env, --[[ T_CLASS ]]38);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  match_1;
  exit = 0;
  if (type(match) == "number") then do
    switcher = match - 1 | 0;
    if (switcher > 38 or switcher < 0) then do
      if (switcher ~= 88) then do
        exit = 1;
      end else do
        match_1 = --[[ tuple ]]{
          nil,
          nil
        };
      end end 
    end else if (switcher > 37 or switcher < 1) then do
      match_1 = --[[ tuple ]]{
        nil,
        nil
      };
    end else do
      exit = 1;
    end end  end 
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    id = Curry._2(Parse.identifier, nil, env);
    typeParameters = Curry._1(type_parameter_declaration_with_defaults, env);
    match_1 = --[[ tuple ]]{
      id,
      typeParameters
    };
  end
   end 
  match_2 = _class(env);
  body = match_2[1];
  loc = btwn(start_loc, body[1]);
  return --[[ tuple ]]{
          loc,
          --[[ Class ]]Block.__(23, {{
                id = match_1[1],
                body = body,
                superClass = match_2[2],
                typeParameters = match_1[2],
                superTypeParameters = match_2[3],
                implements = match_2[4],
                classDecorators = decorators
              }})
        };
end end

function export_source(env) do
  contextual(env, "from");
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) ~= "number" and match.tag == --[[ T_STRING ]]1) then do
    match_1 = match[1];
    octal = match_1[4];
    raw = match_1[3];
    value = match_1[2];
    loc = match_1[1];
    if (octal) then do
      strict_error(env, --[[ StrictOctalLiteral ]]31);
    end
     end 
    token_4(env, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
              loc,
              value,
              raw,
              octal
            }}));
    value_1 = --[[ String ]]Block.__(0, {value});
    return --[[ tuple ]]{
            loc,
            {
              value = value_1,
              raw = raw
            }
          };
  end
   end 
  raw_1 = Curry._2(Parser_env_Peek.value, nil, env);
  value_2 = --[[ String ]]Block.__(0, {raw_1});
  ret_000 = Curry._2(Parser_env_Peek.loc, nil, env);
  ret_001 = {
    value = value_2,
    raw = raw_1
  };
  ret = --[[ tuple ]]{
    ret_000,
    ret_001
  };
  error_unexpected(env);
  return ret;
end end

function expression(env) do
  expression_1 = Curry._1(Parse.expression, env);
  match = Curry._2(Parser_env_Peek.semicolon_loc, nil, env);
  end_loc = match ~= nil and match or expression_1[1];
  semicolon(env);
  return --[[ tuple ]]{
          btwn(expression_1[1], end_loc),
          --[[ Expression ]]Block.__(1, {{
                expression = expression_1
              }})
        };
end end

function declare_function(env, start_loc) do
  token_4(env, --[[ T_FUNCTION ]]13);
  id = Curry._2(Parse.identifier, nil, env);
  start_sig_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  typeParameters = Curry._1(type_parameter_declaration_1, env);
  match = wrap(function_param_list, env);
  token_4(env, --[[ T_COLON ]]77);
  returnType = wrap(_type, env);
  end_loc = returnType[1];
  loc = btwn(start_sig_loc, end_loc);
  value_001 = --[[ Function ]]Block.__(1, {{
        params = match[2],
        returnType = returnType,
        rest = match[1],
        typeParameters = typeParameters
      }});
  value = --[[ tuple ]]{
    loc,
    value_001
  };
  typeAnnotation = --[[ tuple ]]{
    loc,
    value
  };
  init = id[2];
  id_000 = btwn(id[1], end_loc);
  id_001 = {
    name = init.name,
    typeAnnotation = typeAnnotation,
    optional = init.optional
  };
  id_1 = --[[ tuple ]]{
    id_000,
    id_001
  };
  match_1 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env);
  end_loc_1 = match_1 ~= nil and match_1 or end_loc;
  predicate = Curry._1(Parse.predicate, env);
  semicolon(env);
  loc_1 = btwn(start_loc, end_loc_1);
  return --[[ tuple ]]{
          loc_1,
          {
            id = id_1,
            predicate = predicate
          }
        };
end end

function export_specifiers_and_errs(env, _specifiers, _errs) do
  while(true) do
    errs = _errs;
    specifiers = _specifiers;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
      return --[[ tuple ]]{
              List.rev(specifiers),
              List.rev(errs)
            };
    end
     end 
    match_1 = Curry._1(Parse.identifier_or_reserved_keyword, env);
    id = match_1[1];
    match_2;
    if (Curry._2(Parser_env_Peek.value, nil, env) == "as") then do
      contextual(env, "as");
      match_3 = Curry._1(Parse.identifier_or_reserved_keyword, env);
      name = match_3[1];
      record_export(env, --[[ tuple ]]{
            name[1],
            extract_ident_name(name)
          });
      match_2 = --[[ tuple ]]{
        name,
        nil,
        name[1]
      };
    end else do
      loc = id[1];
      record_export(env, --[[ tuple ]]{
            loc,
            extract_ident_name(id)
          });
      match_2 = --[[ tuple ]]{
        nil,
        match_1[2],
        loc
      };
    end end 
    err = match_2[2];
    loc_1 = btwn(id[1], match_2[3]);
    specifier_001 = {
      id = id,
      name = match_2[1]
    };
    specifier = --[[ tuple ]]{
      loc_1,
      specifier_001
    };
    if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COMMA ]]8) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    errs_1 = err ~= nil and --[[ :: ]]{
        err,
        errs
      } or errs;
    _errs = errs_1;
    _specifiers = --[[ :: ]]{
      specifier,
      specifiers
    };
    ::continue:: ;
  end;
end end

function type_alias_helper(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeAlias ]]5);
  end
   end 
  token_4(env, --[[ T_TYPE ]]59);
  push_lex_mode(env, --[[ TYPE ]]1);
  id = Curry._2(Parse.identifier, nil, env);
  typeParameters = Curry._1(type_parameter_declaration_with_defaults, env);
  token_4(env, --[[ T_ASSIGN ]]75);
  right = wrap(_type, env);
  match = Curry._2(Parser_env_Peek.semicolon_loc, nil, env);
  end_loc = match ~= nil and match or right[1];
  semicolon(env);
  pop_lex_mode(env);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            id = id,
            typeParameters = typeParameters,
            right = right
          }
        };
end end

function declare_var(env, start_loc) do
  token_4(env, --[[ T_VAR ]]22);
  id = Curry._2(Parse.identifier_with_type, env, --[[ StrictVarName ]]27);
  match = Curry._2(Parser_env_Peek.semicolon_loc, nil, env);
  end_loc = match ~= nil and match or id[1];
  loc = btwn(start_loc, end_loc);
  semicolon(env);
  return --[[ tuple ]]{
          loc,
          {
            id = id
          }
        };
end end

function __interface(env) do
  if (Curry._2(Parser_env_Peek.is_identifier, 1, env)) then do
    match = Curry._1(interface_helper, env);
    return --[[ tuple ]]{
            match[1],
            --[[ InterfaceDeclaration ]]Block.__(21, {match[2]})
          };
  end else do
    return expression(env);
  end end 
end end

function declare_export_declaration(allow_export_typeOpt, env) do
  allow_export_type = allow_export_typeOpt ~= nil and allow_export_typeOpt or false;
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeDeclaration ]]7);
  end
   end 
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_DECLARE ]]58);
  env_1 = with_in_export(true, with_strict(true, env));
  token_4(env_1, --[[ T_EXPORT ]]47);
  match = Curry._2(Parser_env_Peek.token, nil, env_1);
  exit = 0;
  if (type(match) == "number") then do
    if (match >= 52) then do
      if (match ~= 59) then do
        if (match ~= 97) then do
          exit = 1;
        end else do
          loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
          token_4(env_1, --[[ T_MULT ]]97);
          parse_export_star_as = env_1.parse_options.esproposal_export_star_as;
          local_name = Curry._2(Parser_env_Peek.value, nil, env_1) == "as" and (contextual(env_1, "as"), parse_export_star_as and Curry._2(Parse.identifier, nil, env_1) or (error_1(env_1, --[[ UnexpectedTypeDeclaration ]]7), nil)) or nil;
          specifiers = --[[ ExportBatchSpecifier ]]Block.__(1, {
              loc,
              local_name
            });
          source = export_source(env_1);
          match_1 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
          end_loc = match_1 ~= nil and match_1 or source[1];
          source_1 = source;
          semicolon(env_1);
          return --[[ tuple ]]{
                  btwn(start_loc, end_loc),
                  --[[ DeclareExportDeclaration ]]Block.__(27, {{
                        default = false,
                        declaration = nil,
                        specifiers = specifiers,
                        source = source_1
                      }})
                };
        end end 
      end else if (allow_export_type) then do
        match_2 = type_alias_helper(env_1);
        alias_loc = match_2[1];
        loc_1 = btwn(start_loc, alias_loc);
        return --[[ tuple ]]{
                loc_1,
                --[[ DeclareExportDeclaration ]]Block.__(27, {{
                      default = false,
                      declaration = --[[ NamedType ]]Block.__(4, {--[[ tuple ]]{
                            alias_loc,
                            match_2[2]
                          }}),
                      specifiers = nil,
                      source = nil
                    }})
              };
      end else do
        exit = 1;
      end end  end 
    end else if (match >= 39) then do
      if (match >= 51 and allow_export_type) then do
        match_3 = Curry._1(interface_helper, env_1);
        iface_loc = match_3[1];
        loc_2 = btwn(start_loc, iface_loc);
        return --[[ tuple ]]{
                loc_2,
                --[[ DeclareExportDeclaration ]]Block.__(27, {{
                      default = false,
                      declaration = --[[ Interface ]]Block.__(5, {--[[ tuple ]]{
                            iface_loc,
                            match_3[2]
                          }}),
                      specifiers = nil,
                      source = nil
                    }})
              };
      end else do
        exit = 1;
      end end 
    end else if (match >= 13) then do
      local ___conditional___=(match - 13 | 0);
      do
         if ___conditional___ == 21--[[ T_TRY ]] then do
            token_4(env_1, --[[ T_DEFAULT ]]34);
            match_4 = Curry._2(Parser_env_Peek.token, nil, env_1);
            match_5;
            exit_1 = 0;
            if (type(match_4) == "number") then do
              if (match_4 ~= 13) then do
                if (match_4 ~= 38) then do
                  exit_1 = 3;
                end else do
                  _class = Curry._2(declare_class, env_1, start_loc);
                  match_5 = --[[ tuple ]]{
                    _class[1],
                    --[[ Class ]]Block.__(2, {_class})
                  };
                end end 
              end else do
                fn = declare_function(env_1, start_loc);
                match_5 = --[[ tuple ]]{
                  fn[1],
                  --[[ Function ]]Block.__(1, {fn})
                };
              end end 
            end else do
              exit_1 = 3;
            end end 
            if (exit_1 == 3) then do
              _type_1 = wrap(_type, env_1);
              match_6 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
              end_loc_1 = match_6 ~= nil and match_6 or _type_1[1];
              semicolon(env_1);
              match_5 = --[[ tuple ]]{
                end_loc_1,
                --[[ DefaultType ]]Block.__(3, {_type_1})
              };
            end
             end 
            return --[[ tuple ]]{
                    btwn(start_loc, match_5[1]),
                    --[[ DeclareExportDeclaration ]]Block.__(27, {{
                          default = true,
                          declaration = match_5[2],
                          specifiers = nil,
                          source = nil
                        }})
                  }; end end 
         if ___conditional___ == 1--[[ T_LCURLY ]]
         or ___conditional___ == 2--[[ T_RCURLY ]]
         or ___conditional___ == 3--[[ T_LPAREN ]]
         or ___conditional___ == 4--[[ T_RPAREN ]]
         or ___conditional___ == 5--[[ T_LBRACKET ]]
         or ___conditional___ == 6--[[ T_RBRACKET ]]
         or ___conditional___ == 7--[[ T_SEMICOLON ]]
         or ___conditional___ == 8--[[ T_COMMA ]]
         or ___conditional___ == 10--[[ T_ARROW ]]
         or ___conditional___ == 11--[[ T_ELLIPSIS ]]
         or ___conditional___ == 14--[[ T_IF ]]
         or ___conditional___ == 15--[[ T_IN ]]
         or ___conditional___ == 16--[[ T_INSTANCEOF ]]
         or ___conditional___ == 17--[[ T_RETURN ]]
         or ___conditional___ == 18--[[ T_SWITCH ]]
         or ___conditional___ == 19--[[ T_THIS ]]
         or ___conditional___ == 20--[[ T_THROW ]]
         or ___conditional___ == 22--[[ T_VAR ]]
         or ___conditional___ == 23--[[ T_WHILE ]]
         or ___conditional___ == 24--[[ T_WITH ]] then do
            exit = 1; end else 
         if ___conditional___ == 0--[[ T_IDENTIFIER ]]
         or ___conditional___ == 9--[[ T_PERIOD ]]
         or ___conditional___ == 12--[[ T_AT ]]
         or ___conditional___ == 13--[[ T_FUNCTION ]]
         or ___conditional___ == 25--[[ T_CONST ]] then do
            exit = 2; end else 
         end end end end
        
      end
    end else do
      exit = 1;
    end end  end  end 
  end else do
    exit = 1;
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        match_7 = Curry._2(Parser_env_Peek.token, nil, env_1);
        if (type(match_7) == "number") then do
          if (match_7 ~= 51) then do
            if (match_7 ~= 59) then do
              
            end else do
              error_1(env_1, --[[ DeclareExportType ]]52);
            end end 
          end else do
            error_1(env_1, --[[ DeclareExportInterface ]]53);
          end end 
        end
         end 
        token_4(env_1, --[[ T_LCURLY ]]1);
        match_8 = export_specifiers_and_errs(env_1, --[[ [] ]]0, --[[ [] ]]0);
        specifiers_1 = --[[ ExportSpecifiers ]]Block.__(0, {match_8[1]});
        end_loc_2 = Curry._2(Parser_env_Peek.loc, nil, env_1);
        token_4(env_1, --[[ T_RCURLY ]]2);
        source_2 = Curry._2(Parser_env_Peek.value, nil, env_1) == "from" and export_source(env_1) or (List.iter((function(param) do
                    return error_at(env_1, param);
                  end end), match_8[2]), nil);
        match_9 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
        end_loc_3 = match_9 ~= nil and match_9 or (
            source_2 ~= nil and source_2[1] or end_loc_2
          );
        semicolon(env_1);
        return --[[ tuple ]]{
                btwn(start_loc, end_loc_3),
                --[[ DeclareExportDeclaration ]]Block.__(27, {{
                      default = false,
                      declaration = nil,
                      specifiers = specifiers_1,
                      source = source_2
                    }})
              }; end end 
     if ___conditional___ == 2 then do
        token_5 = Curry._2(Parser_env_Peek.token, nil, env_1);
        match_10;
        exit_2 = 0;
        if (type(token_5) == "number") then do
          if (token_5 >= 23) then do
            if (token_5 >= 27) then do
              if (token_5 ~= 38) then do
                exit_2 = 3;
              end else do
                _class_1 = Curry._2(declare_class, env_1, start_loc);
                match_10 = --[[ tuple ]]{
                  _class_1[1],
                  --[[ Class ]]Block.__(2, {_class_1})
                };
              end end 
            end else do
              exit_2 = token_5 >= 25 and 4 or 3;
            end end 
          end else if (token_5 ~= 13) then do
            exit_2 = token_5 >= 22 and 4 or 3;
          end else do
            fn_1 = declare_function(env_1, start_loc);
            match_10 = --[[ tuple ]]{
              fn_1[1],
              --[[ Function ]]Block.__(1, {fn_1})
            };
          end end  end 
        end else do
          exit_2 = 3;
        end end 
        local ___conditional___=(exit_2);
        do
           if ___conditional___ == 3 then do
              error({
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]]{
                  "parser_flow.ml",
                  3480,
                  17
                }
              }) end end 
           if ___conditional___ == 4 then do
              if (type(token_5) == "number") then do
                if (token_5 ~= 25) then do
                  if (token_5 ~= 26) then do
                    
                  end else do
                    error_1(env_1, --[[ DeclareExportLet ]]50);
                  end end 
                end else do
                  error_1(env_1, --[[ DeclareExportConst ]]51);
                end end 
              end
               end 
              __var = declare_var(env_1, start_loc);
              match_10 = --[[ tuple ]]{
                __var[1],
                --[[ Variable ]]Block.__(0, {__var})
              }; end else 
           end end
          
        end
        return --[[ tuple ]]{
                btwn(start_loc, match_10[1]),
                --[[ DeclareExportDeclaration ]]Block.__(27, {{
                      default = false,
                      declaration = match_10[2],
                      specifiers = nil,
                      source = nil
                    }})
              }; end end 
    
  end
end end

function declare_function_statement(env, start_loc) do
  match = declare_function(env, start_loc);
  return --[[ tuple ]]{
          match[1],
          --[[ DeclareFunction ]]Block.__(23, {match[2]})
        };
end end

function type_alias(env) do
  if (Curry._2(Parser_env_Peek.is_identifier, 1, env)) then do
    match = type_alias_helper(env);
    return --[[ tuple ]]{
            match[1],
            --[[ TypeAlias ]]Block.__(7, {match[2]})
          };
  end else do
    return Curry._1(Parse.statement, env);
  end end 
end end

function declare_var_statement(env, start_loc) do
  match = declare_var(env, start_loc);
  return --[[ tuple ]]{
          match[1],
          --[[ DeclareVariable ]]Block.__(22, {match[2]})
        };
end end

function declare(in_moduleOpt, env) do
  in_module = in_moduleOpt ~= nil and in_moduleOpt or false;
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeDeclaration ]]7);
  end
   end 
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  match = Curry._2(Parser_env_Peek.token, 1, env);
  if (type(match) == "number") then do
    if (match >= 22) then do
      if (match >= 38) then do
        if (match < 62) then do
          local ___conditional___=(match - 38 | 0);
          do
             if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
                token_4(env, --[[ T_DECLARE ]]58);
                env_1 = env;
                start_loc_1 = start_loc;
                match_1 = Curry._2(declare_class, env_1, start_loc_1);
                return --[[ tuple ]]{
                        match_1[1],
                        --[[ DeclareClass ]]Block.__(24, {match_1[2]})
                      }; end end 
             if ___conditional___ == 9--[[ T_PERIOD ]] then do
                if (in_module) then do
                  return declare_export_declaration(in_module, env);
                end
                 end  end else 
             if ___conditional___ == 13--[[ T_FUNCTION ]] then do
                token_4(env, --[[ T_DECLARE ]]58);
                return __interface(env); end end end end 
             if ___conditional___ == 21--[[ T_TRY ]] then do
                token_4(env, --[[ T_DECLARE ]]58);
                return type_alias(env); end end 
             if ___conditional___ == 1--[[ T_LCURLY ]]
             or ___conditional___ == 2--[[ T_RCURLY ]]
             or ___conditional___ == 3--[[ T_LPAREN ]]
             or ___conditional___ == 4--[[ T_RPAREN ]]
             or ___conditional___ == 5--[[ T_LBRACKET ]]
             or ___conditional___ == 6--[[ T_RBRACKET ]]
             or ___conditional___ == 7--[[ T_SEMICOLON ]]
             or ___conditional___ == 8--[[ T_COMMA ]]
             or ___conditional___ == 10--[[ T_ARROW ]]
             or ___conditional___ == 11--[[ T_ELLIPSIS ]]
             or ___conditional___ == 12--[[ T_AT ]]
             or ___conditional___ == 14--[[ T_IF ]]
             or ___conditional___ == 15--[[ T_IN ]]
             or ___conditional___ == 16--[[ T_INSTANCEOF ]]
             or ___conditional___ == 17--[[ T_RETURN ]]
             or ___conditional___ == 18--[[ T_SWITCH ]]
             or ___conditional___ == 19--[[ T_THIS ]]
             or ___conditional___ == 20--[[ T_THROW ]]
             or ___conditional___ == 22--[[ T_VAR ]]
             or ___conditional___ == 23--[[ T_WHILE ]] then do
                token_4(env, --[[ T_DECLARE ]]58);
                error_1(env, --[[ DeclareAsync ]]49);
                token_4(env, --[[ T_ASYNC ]]61);
                return declare_function_statement(env, start_loc); end end 
            
          end
        end
         end 
      end else if (match < 23) then do
        token_4(env, --[[ T_DECLARE ]]58);
        return declare_var_statement(env, start_loc);
      end
       end  end 
    end else if (match ~= 13) then do
      if (match == 0 and Curry._2(Parser_env_Peek.value, 1, env) == "module") then do
        token_4(env, --[[ T_DECLARE ]]58);
        contextual(env, "module");
        if (in_module or Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_PERIOD ]]9) then do
          env_2 = env;
          start_loc_2 = start_loc;
          token_4(env_2, --[[ T_PERIOD ]]9);
          contextual(env_2, "exports");
          type_annot = wrap(annotation, env_2);
          match_2 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_2);
          end_loc = match_2 ~= nil and match_2 or type_annot[1];
          semicolon(env_2);
          loc = btwn(start_loc_2, end_loc);
          return --[[ tuple ]]{
                  loc,
                  --[[ DeclareModuleExports ]]Block.__(26, {type_annot})
                };
        end else do
          env_3 = env;
          start_loc_3 = start_loc;
          match_3 = Curry._2(Parser_env_Peek.token, nil, env_3);
          id;
          if (type(match_3) == "number" or match_3.tag ~= --[[ T_STRING ]]1) then do
            id = --[[ Identifier ]]Block.__(0, {Curry._2(Parse.identifier, nil, env_3)});
          end else do
            match_4 = match_3[1];
            octal = match_4[4];
            raw = match_4[3];
            value = match_4[2];
            loc_1 = match_4[1];
            if (octal) then do
              strict_error(env_3, --[[ StrictOctalLiteral ]]31);
            end
             end 
            token_4(env_3, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                      loc_1,
                      value,
                      raw,
                      octal
                    }}));
            value_1 = --[[ String ]]Block.__(0, {value});
            id = --[[ Literal ]]Block.__(1, {--[[ tuple ]]{
                  loc_1,
                  {
                    value = value_1,
                    raw = raw
                  }
                }});
          end end 
          body_start_loc = Curry._2(Parser_env_Peek.loc, nil, env_3);
          token_4(env_3, --[[ T_LCURLY ]]1);
          match_5 = module_items(env_3, nil, --[[ [] ]]0);
          module_kind = match_5[1];
          token_4(env_3, --[[ T_RCURLY ]]2);
          body_end_loc = Curry._2(Parser_env_Peek.loc, nil, env_3);
          body_loc = btwn(body_start_loc, body_end_loc);
          body_001 = {
            body = match_5[2]
          };
          body = --[[ tuple ]]{
            body_loc,
            body_001
          };
          loc_2 = btwn(start_loc_3, body_loc);
          kind = module_kind ~= nil and module_kind or --[[ CommonJS ]]Block.__(0, {loc_2});
          return --[[ tuple ]]{
                  loc_2,
                  --[[ DeclareModule ]]Block.__(25, {{
                        id = id,
                        body = body,
                        kind = kind
                      }})
                };
        end end 
      end
       end 
    end else do
      token_4(env, --[[ T_DECLARE ]]58);
      return declare_function_statement(env, start_loc);
    end end  end 
  end
   end 
  if (in_module) then do
    token_4(env, --[[ T_DECLARE ]]58);
    return declare_var_statement(env, start_loc);
  end else do
    return Curry._1(Parse.statement, env);
  end end 
end end

function extract_ident_name(param) do
  return param[2].name;
end end

function supers(env, _acc) do
  while(true) do
    acc = _acc;
    __super = wrap(generic, env);
    acc_1 = --[[ :: ]]{
      __super,
      acc
    };
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 8) then do
      token_4(env, --[[ T_COMMA ]]8);
      _acc = acc_1;
      ::continue:: ;
    end else do
      return List.rev(acc_1);
    end end 
  end;
end end

function interface_helper(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (not env.parse_options.types) then do
    error_1(env, --[[ UnexpectedTypeInterface ]]10);
  end
   end 
  token_4(env, --[[ T_INTERFACE ]]51);
  id = Curry._2(Parse.identifier, nil, env);
  typeParameters = Curry._1(type_parameter_declaration_with_defaults, env);
  __extends = Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_EXTENDS ]]39 and (token_4(env, --[[ T_EXTENDS ]]39), supers(env, --[[ [] ]]0)) or --[[ [] ]]0;
  body = _object_1(true, env);
  loc = btwn(start_loc, body[1]);
  return --[[ tuple ]]{
          loc,
          {
            id = id,
            typeParameters = typeParameters,
            body = body,
            extends = __extends,
            mixins = --[[ [] ]]0
          }
        };
end end

function supers_1(env, _acc) do
  while(true) do
    acc = _acc;
    __super = wrap(generic, env);
    acc_1 = --[[ :: ]]{
      __super,
      acc
    };
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 8) then do
      token_4(env, --[[ T_COMMA ]]8);
      _acc = acc_1;
      ::continue:: ;
    end else do
      return List.rev(acc_1);
    end end 
  end;
end end

function declare_class(env, start_loc) do
  env_1 = with_strict(true, env);
  token_4(env_1, --[[ T_CLASS ]]38);
  id = Curry._2(Parse.identifier, nil, env_1);
  typeParameters = Curry._1(type_parameter_declaration_with_defaults, env_1);
  __extends = Curry._2(Parser_env_Peek.token, nil, env_1) == --[[ T_EXTENDS ]]39 and (token_4(env_1, --[[ T_EXTENDS ]]39), supers_1(env_1, --[[ [] ]]0)) or --[[ [] ]]0;
  mixins = Curry._2(Parser_env_Peek.value, nil, env_1) == "mixins" and (contextual(env_1, "mixins"), supers_1(env_1, --[[ [] ]]0)) or --[[ [] ]]0;
  body = _object_1(true, env_1);
  loc = btwn(start_loc, body[1]);
  return --[[ tuple ]]{
          loc,
          {
            id = id,
            typeParameters = typeParameters,
            body = body,
            extends = __extends,
            mixins = mixins
          }
        };
end end

function module_items(env, _module_kind, _acc) do
  while(true) do
    acc = _acc;
    module_kind = _module_kind;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
      return --[[ tuple ]]{
              module_kind,
              List.rev(acc)
            };
    end
     end 
    stmt = declare(true, env);
    stmt_1 = stmt[2];
    loc = stmt[1];
    module_kind_1;
    if (module_kind ~= nil) then do
      if (module_kind.tag) then do
        if (type(stmt_1) == "number" or stmt_1.tag ~= --[[ DeclareModuleExports ]]26) then do
          module_kind_1 = module_kind;
        end else do
          error_1(env, --[[ AmbiguousDeclareModuleKind ]]61);
          module_kind_1 = module_kind;
        end end 
      end else if (type(stmt_1) == "number") then do
        module_kind_1 = module_kind;
      end else do
        local ___conditional___=(stmt_1.tag | 0);
        do
           if ___conditional___ == 26--[[ DeclareModuleExports ]] then do
              error_1(env, --[[ DuplicateDeclareModuleExports ]]60);
              module_kind_1 = module_kind; end else 
           if ___conditional___ == 27--[[ DeclareExportDeclaration ]] then do
              declaration = stmt_1[1].declaration;
              if (declaration ~= nil) then do
                local ___conditional___=(declaration.tag | 0);
                do
                   if ___conditional___ == 4--[[ NamedType ]]
                   or ___conditional___ == 5--[[ Interface ]]
                   end
                  error_1(env, --[[ AmbiguousDeclareModuleKind ]]61);
                    
                end
              end else do
                error_1(env, --[[ AmbiguousDeclareModuleKind ]]61);
              end end 
              module_kind_1 = module_kind; end else 
           end end end end
          module_kind_1 = module_kind;
            
        end
      end end  end 
    end else if (type(stmt_1) == "number") then do
      module_kind_1 = module_kind;
    end else do
      local ___conditional___=(stmt_1.tag | 0);
      do
         if ___conditional___ == 26--[[ DeclareModuleExports ]] then do
            module_kind_1 = --[[ CommonJS ]]Block.__(0, {loc}); end else 
         if ___conditional___ == 27--[[ DeclareExportDeclaration ]] then do
            declaration_1 = stmt_1[1].declaration;
            if (declaration_1 ~= nil) then do
              local ___conditional___=(declaration_1.tag | 0);
              do
                 if ___conditional___ == 4--[[ NamedType ]]
                 or ___conditional___ == 5--[[ Interface ]] then do
                    module_kind_1 = module_kind; end else 
                 end end
                module_kind_1 = --[[ ES ]]Block.__(1, {loc});
                  
              end
            end else do
              module_kind_1 = --[[ ES ]]Block.__(1, {loc});
            end end  end else 
         end end end end
        module_kind_1 = module_kind;
          
      end
    end end  end 
    _acc = --[[ :: ]]{
      stmt,
      acc
    };
    _module_kind = module_kind_1;
    ::continue:: ;
  end;
end end

function fold(acc, _param) do
  while(true) do
    param = _param;
    match = param[2];
    local ___conditional___=(match.tag | 0);
    do
       if ___conditional___ == 0--[[ Object ]] then do
          return List.fold_left((function(acc, prop) do
                        if (prop.tag) then do
                          return fold(acc, prop[1][2].argument);
                        end else do
                          return fold(acc, prop[1][2].pattern);
                        end end 
                      end end), acc, match[1].properties); end end 
       if ___conditional___ == 1--[[ Array ]] then do
          return List.fold_left((function(acc, elem) do
                        if (elem ~= nil) then do
                          match = elem;
                          if (match.tag) then do
                            return fold(acc, match[1][2].argument);
                          end else do
                            return fold(acc, match[1]);
                          end end 
                        end else do
                          return acc;
                        end end 
                      end end), acc, match[1].elements); end end 
       if ___conditional___ == 2--[[ Assignment ]] then do
          _param = match[1].left;
          ::continue:: ; end end 
       if ___conditional___ == 3--[[ Identifier ]] then do
          match_1 = match[1];
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    match_1[1],
                    match_1[2].name
                  },
                  acc
                }; end end 
       if ___conditional___ == 4--[[ Expression ]] then do
          error({
            Caml_builtin_exceptions.failure,
            "Parser error: No such thing as an expression pattern!"
          }) end end 
      
    end
  end;
end end

function assert_can_be_forin_or_forof(env, err, param) do
  if (param ~= nil) then do
    match = param;
    if (match.tag) then do
      match_1 = match[1];
      loc = match_1[1];
      if (Curry._1(Parse.is_assignable_lhs, --[[ tuple ]]{
              loc,
              match_1[2]
            })) then do
        return 0;
      end else do
        return error_at(env, --[[ tuple ]]{
                    loc,
                    err
                  });
      end end 
    end else do
      match_2 = match[1];
      declarations = match_2[2].declarations;
      if (declarations and declarations[1][2].init == nil and not declarations[2]) then do
        return --[[ () ]]0;
      end
       end 
      return error_at(env, --[[ tuple ]]{
                  match_2[1],
                  err
                });
    end end 
  end else do
    return error_1(env, err);
  end end 
end end

function _if(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_IF ]]14);
  token_4(env, --[[ T_LPAREN ]]3);
  test = Curry._1(Parse.expression, env);
  token_4(env, --[[ T_RPAREN ]]4);
  Curry._2(Parser_env_Peek.token, nil, env);
  consequent = Curry._2(Parser_env_Peek.is_function, nil, env) and (strict_error(env, --[[ StrictFunctionStatement ]]45), _function(env)) or Curry._1(Parse.statement, env);
  alternate = Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ELSE ]]41 and (token_4(env, --[[ T_ELSE ]]41), Curry._1(Parse.statement, env)) or nil;
  end_loc = alternate ~= nil and alternate[1] or consequent[1];
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          --[[ If ]]Block.__(2, {{
                test = test,
                consequent = consequent,
                alternate = alternate
              }})
        };
end end

function case_list(env, _param) do
  while(true) do
    param = _param;
    acc = param[2];
    seen_default = param[1];
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    match_1 = Curry._2(Parser_env_Peek.token, nil, env);
    test;
    if (type(match_1) == "number" and match_1 == 34) then do
      if (seen_default) then do
        error_1(env, --[[ MultipleDefaultsInSwitch ]]19);
      end
       end 
      token_4(env, --[[ T_DEFAULT ]]34);
      test = nil;
    end else do
      token_4(env, --[[ T_CASE ]]31);
      test = Curry._1(Parse.expression, env);
    end end 
    seen_default_1 = seen_default or test == nil;
    end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    token_4(env, --[[ T_COLON ]]77);
    term_fn = function(param) do
      if (type(param) == "number") then do
        switcher = param - 2 | 0;
        if (switcher > 29 or switcher < 0) then do
          return switcher == 32;
        end else do
          return switcher > 28 or switcher < 1;
        end end 
      end else do
        return false;
      end end 
    end end;
    consequent = Curry._2(Parse.statement_list, term_fn, with_in_switch(true, env));
    match_2 = List.rev(consequent);
    end_loc_1 = match_2 and match_2[1][1] or end_loc;
    acc_000 = --[[ tuple ]]{
      btwn(start_loc, end_loc_1),
      {
        test = test,
        consequent = consequent
      }
    };
    acc_1 = --[[ :: ]]{
      acc_000,
      acc
    };
    _param = --[[ tuple ]]{
      seen_default_1,
      acc_1
    };
    ::continue:: ;
  end;
end end

function var_or_const(env) do
  match = variable(env);
  match_1 = match[1];
  start_loc = match_1[1];
  match_2 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env);
  end_loc = match_2 ~= nil and match_2 or start_loc;
  semicolon(env);
  List.iter((function(param) do
          return error_at(env, param);
        end end), match[2]);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          match_1[2]
        };
end end

function source(env) do
  contextual(env, "from");
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) ~= "number" and match.tag == --[[ T_STRING ]]1) then do
    match_1 = match[1];
    octal = match_1[4];
    raw = match_1[3];
    value = match_1[2];
    loc = match_1[1];
    if (octal) then do
      strict_error(env, --[[ StrictOctalLiteral ]]31);
    end
     end 
    token_4(env, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
              loc,
              value,
              raw,
              octal
            }}));
    value_1 = --[[ String ]]Block.__(0, {value});
    return --[[ tuple ]]{
            loc,
            {
              value = value_1,
              raw = raw
            }
          };
  end
   end 
  raw_1 = Curry._2(Parser_env_Peek.value, nil, env);
  value_2 = --[[ String ]]Block.__(0, {raw_1});
  ret_000 = Curry._2(Parser_env_Peek.loc, nil, env);
  ret_001 = {
    value = value_2,
    raw = raw_1
  };
  ret = --[[ tuple ]]{
    ret_000,
    ret_001
  };
  error_unexpected(env);
  return ret;
end end

function specifier_list(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
      return List.rev(acc);
    end
     end 
    match_1 = Curry._1(Parse.identifier_or_reserved_keyword, env);
    err = match_1[2];
    remote = match_1[1];
    specifier;
    if (Curry._2(Parser_env_Peek.value, nil, env) == "as") then do
      contextual(env, "as");
      local = Curry._2(Parse.identifier, nil, env);
      specifier = --[[ ImportNamedSpecifier ]]Block.__(0, {{
            local = local,
            remote = remote
          }});
    end else do
      if (err ~= nil) then do
        error_at(env, err);
      end
       end 
      specifier = --[[ ImportNamedSpecifier ]]Block.__(0, {{
            local = nil,
            remote = remote
          }});
    end end 
    if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COMMA ]]8) then do
      token_4(env, --[[ T_COMMA ]]8);
    end
     end 
    _acc = --[[ :: ]]{
      specifier,
      acc
    };
    ::continue:: ;
  end;
end end

function named_or_namespace_specifier(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and match == 97) then do
    token_4(env, --[[ T_MULT ]]97);
    contextual(env, "as");
    id = Curry._2(Parse.identifier, nil, env);
    return --[[ :: ]]{
            --[[ ImportNamespaceSpecifier ]]Block.__(2, {--[[ tuple ]]{
                  btwn(start_loc, id[1]),
                  id
                }}),
            --[[ [] ]]0
          };
  end
   end 
  token_4(env, --[[ T_LCURLY ]]1);
  specifiers = specifier_list(env, --[[ [] ]]0);
  token_4(env, --[[ T_RCURLY ]]2);
  return specifiers;
end end

function from_expr(env, param) do
  expr = param[2];
  loc = param[1];
  if (type(expr) ~= "number") then do
    local ___conditional___=(expr.tag | 0);
    do
       if ___conditional___ == 0--[[ Array ]] then do
          env_1 = env;
          param_1 = --[[ tuple ]]{
            loc,
            expr[1]
          };
          elements = List.map((function(param) do
                  env_2 = env_1;
                  param_1 = param;
                  if (param_1 ~= nil) then do
                    match = param_1;
                    if (match.tag) then do
                      match_1 = match[1];
                      argument = Curry._2(Parse.pattern_from_expr, env_2, match_1[2].argument);
                      return --[[ Spread ]]Block.__(1, {--[[ tuple ]]{
                                  match_1[1],
                                  {
                                    argument = argument
                                  }
                                }});
                    end else do
                      match_2 = match[1];
                      return --[[ Element ]]Block.__(0, {Curry._2(Parse.pattern_from_expr, env_2, --[[ tuple ]]{
                                      match_2[1],
                                      match_2[2]
                                    })});
                    end end 
                  end
                   end 
                end end), param_1[2].elements);
          return --[[ tuple ]]{
                  param_1[1],
                  --[[ Array ]]Block.__(1, {{
                        elements = elements,
                        typeAnnotation = nil
                      }})
                }; end end 
       if ___conditional___ == 1--[[ Object ]] then do
          env_2 = env;
          param_2 = --[[ tuple ]]{
            loc,
            expr[1]
          };
          properties = List.map((function(param) do
                  env_3 = env_2;
                  prop = param;
                  if (prop.tag) then do
                    match = prop[1];
                    argument = Curry._2(Parse.pattern_from_expr, env_3, match[2].argument);
                    return --[[ SpreadProperty ]]Block.__(1, {--[[ tuple ]]{
                                match[1],
                                {
                                  argument = argument
                                }
                              }});
                  end else do
                    match_1 = prop[1];
                    match_2 = match_1[2];
                    key = match_2.key;
                    key_1;
                    local ___conditional___=(key.tag | 0);
                    do
                       if ___conditional___ == 0--[[ Literal ]] then do
                          key_1 = --[[ Literal ]]Block.__(0, {key[1]}); end else 
                       if ___conditional___ == 1--[[ Identifier ]] then do
                          key_1 = --[[ Identifier ]]Block.__(1, {key[1]}); end else 
                       if ___conditional___ == 2--[[ Computed ]] then do
                          key_1 = --[[ Computed ]]Block.__(2, {key[1]}); end else 
                       end end end end end end
                      
                    end
                    pattern = Curry._2(Parse.pattern_from_expr, env_3, match_2.value);
                    return --[[ Property ]]Block.__(0, {--[[ tuple ]]{
                                match_1[1],
                                {
                                  key = key_1,
                                  pattern = pattern,
                                  shorthand = match_2.shorthand
                                }
                              }});
                  end end 
                end end), param_2[2].properties);
          return --[[ tuple ]]{
                  param_2[1],
                  --[[ Object ]]Block.__(0, {{
                        properties = properties,
                        typeAnnotation = nil
                      }})
                }; end end 
       if ___conditional___ == 7--[[ Assignment ]] then do
          match = expr[1];
          if (match.operator == 0) then do
            return --[[ tuple ]]{
                    loc,
                    --[[ Assignment ]]Block.__(2, {{
                          left = match.left,
                          right = match.right
                        }})
                  };
          end
           end  end else 
       if ___conditional___ == 18--[[ Identifier ]] then do
          return --[[ tuple ]]{
                  loc,
                  --[[ Identifier ]]Block.__(3, {expr[1]})
                }; end end end end 
      
    end
  end
   end 
  return --[[ tuple ]]{
          loc,
          --[[ Expression ]]Block.__(4, {--[[ tuple ]]{
                loc,
                expr
              }})
        };
end end

function _object_2(restricted_error) do
  property = function(env) do
    start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
    if (maybe(env, --[[ T_ELLIPSIS ]]11)) then do
      argument = pattern_1(env, restricted_error);
      loc = btwn(start_loc, argument[1]);
      return --[[ SpreadProperty ]]Block.__(1, {--[[ tuple ]]{
                  loc,
                  {
                    argument = argument
                  }
                }});
    end else do
      match = Curry._1(Parse.object_key, env);
      match_1 = match[2];
      key;
      local ___conditional___=(match_1.tag | 0);
      do
         if ___conditional___ == 0--[[ Literal ]] then do
            key = --[[ Literal ]]Block.__(0, {match_1[1]}); end else 
         if ___conditional___ == 1--[[ Identifier ]] then do
            key = --[[ Identifier ]]Block.__(1, {match_1[1]}); end else 
         if ___conditional___ == 2--[[ Computed ]] then do
            key = --[[ Computed ]]Block.__(2, {match_1[1]}); end else 
         end end end end end end
        
      end
      match_2 = Curry._2(Parser_env_Peek.token, nil, env);
      prop;
      exit = 0;
      if (type(match_2) == "number" and match_2 == 77) then do
        token_4(env, --[[ T_COLON ]]77);
        prop = --[[ tuple ]]{
          pattern_1(env, restricted_error),
          false
        };
      end else do
        exit = 1;
      end end 
      if (exit == 1) then do
        local ___conditional___=(key.tag | 0);
        do
           if ___conditional___ == 1--[[ Identifier ]] then do
              id = key[1];
              pattern_000 = id[1];
              pattern_001 = --[[ Identifier ]]Block.__(3, {id});
              pattern_2 = --[[ tuple ]]{
                pattern_000,
                pattern_001
              };
              prop = --[[ tuple ]]{
                pattern_2,
                true
              }; end else 
           if ___conditional___ == 0--[[ Literal ]]
           or ___conditional___ == 2--[[ Computed ]] then do
              error_unexpected(env);
              prop = nil; end else 
           end end end end
          
        end
      end
       end 
      if (prop ~= nil) then do
        match_3 = prop;
        pattern_3 = match_3[1];
        match_4 = Curry._2(Parser_env_Peek.token, nil, env);
        pattern_4;
        if (type(match_4) == "number" and match_4 == 75) then do
          token_4(env, --[[ T_ASSIGN ]]75);
          __default = Curry._1(Parse.assignment, env);
          loc_1 = btwn(pattern_3[1], __default[1]);
          pattern_4 = --[[ tuple ]]{
            loc_1,
            --[[ Assignment ]]Block.__(2, {{
                  left = pattern_3,
                  right = __default
                }})
          };
        end else do
          pattern_4 = pattern_3;
        end end 
        loc_2 = btwn(start_loc, pattern_4[1]);
        return --[[ Property ]]Block.__(0, {--[[ tuple ]]{
                    loc_2,
                    {
                      key = key,
                      pattern = pattern_4,
                      shorthand = match_3[2]
                    }
                  }});
      end else do
        return ;
      end end 
    end end 
  end end;
  properties = function(env, _acc) do
    while(true) do
      acc = _acc;
      match = Curry._2(Parser_env_Peek.token, nil, env);
      if (type(match) == "number" and not (match ~= 2 and match ~= 105)) then do
        return List.rev(acc);
      end
       end 
      match_1 = property(env);
      if (match_1 ~= nil) then do
        if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RCURLY ]]2) then do
          token_4(env, --[[ T_COMMA ]]8);
        end
         end 
        _acc = --[[ :: ]]{
          match_1,
          acc
        };
        ::continue:: ;
      end else do
        ::continue:: ;
      end end 
    end;
  end end;
  return (function(env) do
      start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_LCURLY ]]1);
      properties_1 = properties(env, --[[ [] ]]0);
      end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RCURLY ]]2);
      match;
      if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COLON ]]77) then do
        typeAnnotation = wrap(annotation, env);
        match = --[[ tuple ]]{
          typeAnnotation[1],
          typeAnnotation
        };
      end else do
        match = --[[ tuple ]]{
          end_loc,
          nil
        };
      end end 
      return --[[ tuple ]]{
              btwn(start_loc, match[1]),
              --[[ Object ]]Block.__(0, {{
                    properties = properties_1,
                    typeAnnotation = match[2]
                  }})
            };
    end end);
end end

function _array(restricted_error) do
  elements = function(env, _acc) do
    while(true) do
      acc = _acc;
      match = Curry._2(Parser_env_Peek.token, nil, env);
      if (type(match) == "number") then do
        if (match ~= 105) then do
          if (match < 12) then do
            local ___conditional___=(match);
            do
               if ___conditional___ == 6--[[ T_RBRACKET ]] then do
                  return List.rev(acc); end end 
               if ___conditional___ == 8--[[ T_COMMA ]] then do
                  token_4(env, --[[ T_COMMA ]]8);
                  _acc = --[[ :: ]]{
                    nil,
                    acc
                  };
                  ::continue:: ; end end 
               if ___conditional___ == 0--[[ T_IDENTIFIER ]]
               or ___conditional___ == 1--[[ T_LCURLY ]]
               or ___conditional___ == 2--[[ T_RCURLY ]]
               or ___conditional___ == 3--[[ T_LPAREN ]]
               or ___conditional___ == 4--[[ T_RPAREN ]]
               or ___conditional___ == 5--[[ T_LBRACKET ]]
               or ___conditional___ == 7--[[ T_SEMICOLON ]]
               or ___conditional___ == 9--[[ T_PERIOD ]]
               or ___conditional___ == 10--[[ T_ARROW ]]
               or ___conditional___ == 11--[[ T_ELLIPSIS ]] then do
                  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
                  token_4(env, --[[ T_ELLIPSIS ]]11);
                  argument = pattern_1(env, restricted_error);
                  loc = btwn(start_loc, argument[1]);
                  element = --[[ Spread ]]Block.__(1, {--[[ tuple ]]{
                        loc,
                        {
                          argument = argument
                        }
                      }});
                  _acc = --[[ :: ]]{
                    element,
                    acc
                  };
                  ::continue:: ; end end 
              
            end
          end
           end 
        end else do
          return List.rev(acc);
        end end 
      end
       end 
      pattern_2 = pattern_1(env, restricted_error);
      match_1 = Curry._2(Parser_env_Peek.token, nil, env);
      pattern_3;
      if (type(match_1) == "number" and match_1 == 75) then do
        token_4(env, --[[ T_ASSIGN ]]75);
        __default = Curry._1(Parse.expression, env);
        loc_1 = btwn(pattern_2[1], __default[1]);
        pattern_3 = --[[ tuple ]]{
          loc_1,
          --[[ Assignment ]]Block.__(2, {{
                left = pattern_2,
                right = __default
              }})
        };
      end else do
        pattern_3 = pattern_2;
      end end 
      element_1 = --[[ Element ]]Block.__(0, {pattern_3});
      if (Curry._2(Parser_env_Peek.token, nil, env) ~= --[[ T_RBRACKET ]]6) then do
        token_4(env, --[[ T_COMMA ]]8);
      end
       end 
      _acc = --[[ :: ]]{
        element_1,
        acc
      };
      ::continue:: ;
    end;
  end end;
  return (function(env) do
      start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_LBRACKET ]]5);
      elements_1 = elements(env, --[[ [] ]]0);
      end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RBRACKET ]]6);
      match;
      if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COLON ]]77) then do
        typeAnnotation = wrap(annotation, env);
        match = --[[ tuple ]]{
          typeAnnotation[1],
          typeAnnotation
        };
      end else do
        match = --[[ tuple ]]{
          end_loc,
          nil
        };
      end end 
      return --[[ tuple ]]{
              btwn(start_loc, match[1]),
              --[[ Array ]]Block.__(1, {{
                    elements = elements_1,
                    typeAnnotation = match[2]
                  }})
            };
    end end);
end end

function pattern_1(env, restricted_error) do
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match ~= 1) then do
      if (match == 5) then do
        return _array(restricted_error)(env);
      end
       end 
    end else do
      return _object_2(restricted_error)(env);
    end end 
  end
   end 
  id = Curry._2(Parse.identifier_with_type, env, restricted_error);
  return --[[ tuple ]]{
          id[1],
          --[[ Identifier ]]Block.__(3, {id})
        };
end end

function spread_attribute(env) do
  push_lex_mode(env, --[[ NORMAL ]]0);
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  token_4(env, --[[ T_ELLIPSIS ]]11);
  argument = Curry._1(assignment, env);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  pop_lex_mode(env);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            argument = argument
          }
        };
end end

function expression_container(env) do
  push_lex_mode(env, --[[ NORMAL ]]0);
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  expression;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_RCURLY ]]2) then do
    empty_loc = btwn_exclusive(start_loc, Curry._2(Parser_env_Peek.loc, nil, env));
    expression = --[[ EmptyExpression ]]Block.__(1, {empty_loc});
  end else do
    expression = --[[ Expression ]]Block.__(0, {Curry._1(Parse.expression, env)});
  end end 
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  pop_lex_mode(env);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            expression = expression
          }
        };
end end

function identifier_1(env) do
  loc = Curry._2(Parser_env_Peek.loc, nil, env);
  name = Curry._2(Parser_env_Peek.value, nil, env);
  token_4(env, --[[ T_JSX_IDENTIFIER ]]106);
  return --[[ tuple ]]{
          loc,
          {
            name = name
          }
        };
end end

function member_expression(env, _member) do
  while(true) do
    member = _member;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number" and match == 9) then do
      _object = --[[ MemberExpression ]]Block.__(1, {member});
      token_4(env, --[[ T_PERIOD ]]9);
      property = identifier_1(env);
      loc = btwn(member[1], property[1]);
      member_001 = {
        _object = _object,
        property = property
      };
      member_1 = --[[ tuple ]]{
        loc,
        member_001
      };
      _member = member_1;
      ::continue:: ;
    end else do
      return member;
    end end 
  end;
end end

function name(env) do
  name_1 = identifier_1(env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match ~= 9) then do
      if (match ~= 77) then do
        return --[[ Identifier ]]Block.__(0, {name_1});
      end else do
        token_4(env, --[[ T_COLON ]]77);
        name_2 = identifier_1(env);
        loc = btwn(name_1[1], name_2[1]);
        return --[[ NamespacedName ]]Block.__(1, {--[[ tuple ]]{
                    loc,
                    {
                      namespace = name_1,
                      name = name_2
                    }
                  }});
      end end 
    end else do
      _object = --[[ Identifier ]]Block.__(0, {name_1});
      token_4(env, --[[ T_PERIOD ]]9);
      property = identifier_1(env);
      loc_1 = btwn(name_1[1], property[1]);
      member_001 = {
        _object = _object,
        property = property
      };
      member = --[[ tuple ]]{
        loc_1,
        member_001
      };
      return --[[ MemberExpression ]]Block.__(2, {member_expression(env, member)});
    end end 
  end else do
    return --[[ Identifier ]]Block.__(0, {name_1});
  end end 
end end

function attribute(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  name = identifier_1(env);
  match;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COLON ]]77) then do
    token_4(env, --[[ T_COLON ]]77);
    name_1 = identifier_1(env);
    loc = btwn(name[1], name_1[1]);
    match = --[[ tuple ]]{
      loc,
      --[[ NamespacedName ]]Block.__(1, {--[[ tuple ]]{
            loc,
            {
              namespace = name,
              name = name_1
            }
          }})
    };
  end else do
    match = --[[ tuple ]]{
      name[1],
      --[[ Identifier ]]Block.__(0, {name})
    };
  end end 
  match_1;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_ASSIGN ]]75) then do
    token_4(env, --[[ T_ASSIGN ]]75);
    token_5 = Curry._2(Parser_env_Peek.token, nil, env);
    exit = 0;
    if (type(token_5) == "number") then do
      if (token_5 == --[[ T_LCURLY ]]1) then do
        match_2 = expression_container(env);
        expression_container_1 = match_2[2];
        loc_1 = match_2[1];
        match_3 = expression_container_1.expression;
        if (match_3.tag) then do
          error_1(env, --[[ JSXAttributeValueEmptyExpression ]]40);
        end
         end 
        match_1 = --[[ tuple ]]{
          loc_1,
          --[[ ExpressionContainer ]]Block.__(1, {
              loc_1,
              expression_container_1
            })
        };
      end else do
        exit = 1;
      end end 
    end else if (token_5.tag == --[[ T_JSX_TEXT ]]4) then do
      match_4 = token_5[1];
      loc_2 = match_4[1];
      token_4(env, token_5);
      value = --[[ String ]]Block.__(0, {match_4[2]});
      match_1 = --[[ tuple ]]{
        loc_2,
        --[[ Literal ]]Block.__(0, {
            loc_2,
            {
              value = value,
              raw = match_4[3]
            }
          })
      };
    end else do
      exit = 1;
    end end  end 
    if (exit == 1) then do
      error_1(env, --[[ InvalidJSXAttributeValue ]]41);
      loc_3 = Curry._2(Parser_env_Peek.loc, nil, env);
      match_1 = --[[ tuple ]]{
        loc_3,
        --[[ Literal ]]Block.__(0, {
            loc_3,
            {
              value = --[[ String ]]Block.__(0, {""}),
              raw = ""
            }
          })
      };
    end
     end 
  end else do
    match_1 = --[[ tuple ]]{
      match[1],
      nil
    };
  end end 
  return --[[ tuple ]]{
          btwn(start_loc, match_1[1]),
          {
            name = match[2],
            value = match_1[2]
          }
        };
end end

function attributes(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number") then do
      if (match >= 91) then do
        if (not (match ~= 96 and match ~= 105)) then do
          return List.rev(acc);
        end
         end 
      end else if (match ~= 1) then do
        if (match >= 90) then do
          return List.rev(acc);
        end
         end 
      end else do
        attribute_1 = --[[ SpreadAttribute ]]Block.__(1, {spread_attribute(env)});
        _acc = --[[ :: ]]{
          attribute_1,
          acc
        };
        ::continue:: ;
      end end  end 
    end
     end 
    attribute_2 = --[[ Attribute ]]Block.__(0, {attribute(env)});
    _acc = --[[ :: ]]{
      attribute_2,
      acc
    };
    ::continue:: ;
  end;
end end

function opening_element_without_lt(env, start_loc) do
  name_1 = name(env);
  attributes_1 = attributes(env, --[[ [] ]]0);
  selfClosing = Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_DIV ]]96;
  if (selfClosing) then do
    token_4(env, --[[ T_DIV ]]96);
  end
   end 
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_GREATER_THAN ]]90);
  pop_lex_mode(env);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            name = name_1,
            selfClosing = selfClosing,
            attributes = attributes_1
          }
        };
end end

function closing_element_without_lt(env, start_loc) do
  token_4(env, --[[ T_DIV ]]96);
  name_1 = name(env);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_GREATER_THAN ]]90);
  double_pop_lex_mode(env);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            name = name_1
          }
        };
end end

function child(env) do
  token_5 = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(token_5) == "number") then do
    if (token_5 == --[[ T_LCURLY ]]1) then do
      expression_container_1 = expression_container(env);
      return --[[ tuple ]]{
              expression_container_1[1],
              --[[ ExpressionContainer ]]Block.__(1, {expression_container_1[2]})
            };
    end
     end 
  end else if (token_5.tag == --[[ T_JSX_TEXT ]]4) then do
    match = token_5[1];
    token_4(env, token_5);
    return --[[ tuple ]]{
            match[1],
            --[[ Text ]]Block.__(2, {{
                  value = match[2],
                  raw = match[3]
                }})
          };
  end
   end  end 
  element_1 = element(env);
  return --[[ tuple ]]{
          element_1[1],
          --[[ Element ]]Block.__(0, {element_1[2]})
        };
end end

function element(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  push_lex_mode(env, --[[ JSX_TAG ]]2);
  token_4(env, --[[ T_LESS_THAN ]]89);
  return Curry._2(element_without_lt, env, start_loc);
end end

function element_or_closing(env) do
  push_lex_mode(env, --[[ JSX_TAG ]]2);
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LESS_THAN ]]89);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and not (match ~= 96 and match ~= 105)) then do
    return --[[ Closing ]]Block.__(0, {closing_element_without_lt(env, start_loc)});
  end else do
    return --[[ ChildElement ]]Block.__(1, {Curry._2(element_without_lt, env, start_loc)});
  end end 
end end

function children_and_closing(env, _acc) do
  while(true) do
    acc = _acc;
    match = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(match) == "number") then do
      if (match ~= 89) then do
        if (match ~= 105) then do
          _acc = --[[ :: ]]{
            child(env),
            acc
          };
          ::continue:: ;
        end else do
          error_unexpected(env);
          return --[[ tuple ]]{
                  List.rev(acc),
                  nil
                };
        end end 
      end else do
        match_1 = element_or_closing(env);
        if (match_1.tag) then do
          element = match_1[1];
          element_000 = element[1];
          element_001 = --[[ Element ]]Block.__(0, {element[2]});
          element_1 = --[[ tuple ]]{
            element_000,
            element_001
          };
          _acc = --[[ :: ]]{
            element_1,
            acc
          };
          ::continue:: ;
        end else do
          return --[[ tuple ]]{
                  List.rev(acc),
                  match_1[1]
                };
        end end 
      end end 
    end else do
      _acc = --[[ :: ]]{
        child(env),
        acc
      };
      ::continue:: ;
    end end 
  end;
end end

function normalize(name) do
  local ___conditional___=(name.tag | 0);
  do
     if ___conditional___ == 0--[[ Identifier ]] then do
        return name[1][2].name; end end 
     if ___conditional___ == 1--[[ NamespacedName ]] then do
        match = name[1][2];
        return match.namespace[2].name .. (":" .. match.name[2].name); end end 
     if ___conditional___ == 2--[[ MemberExpression ]] then do
        match_1 = name[1][2];
        _object = match_1._object;
        _object_1;
        _object_1 = _object.tag and normalize(--[[ MemberExpression ]]Block.__(2, {_object[1]})) or _object[1][2].name;
        return _object_1 .. ("." .. match_1.property[2].name); end end 
    
  end
end end

function element_without_lt(env, start_loc) do
  openingElement = opening_element_without_lt(env, start_loc);
  match = openingElement[2].selfClosing and --[[ tuple ]]{
      --[[ [] ]]0,
      nil
    } or (push_lex_mode(env, --[[ JSX_CHILD ]]3), children_and_closing(env, --[[ [] ]]0));
  closingElement = match[2];
  end_loc;
  if (closingElement ~= nil) then do
    match_1 = closingElement;
    opening_name = normalize(openingElement[2].name);
    if (normalize(match_1[2].name) ~= opening_name) then do
      error_1(env, --[[ ExpectedJSXClosingTag ]]Block.__(6, {opening_name}));
    end
     end 
    end_loc = match_1[1];
  end else do
    end_loc = openingElement[1];
  end end 
  return --[[ tuple ]]{
          btwn(openingElement[1], end_loc),
          {
            openingElement = openingElement,
            closingElement = closingElement,
            children = match[1]
          }
        };
end end

function statement_list_item(decoratorsOpt, env) do
  decorators = decoratorsOpt ~= nil and decoratorsOpt or --[[ [] ]]0;
  if (not Curry._2(Parser_env_Peek.is_class, nil, env)) then do
    error_on_decorators(env)(decorators);
  end
   end 
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    if (match ~= 25) then do
      if (match == 26) then do
        env_1 = env;
        start_loc = Curry._2(Parser_env_Peek.loc, nil, env_1);
        token_4(env_1, --[[ T_LET ]]26);
        if (Curry._2(Parser_env_Peek.token, nil, env_1) == --[[ T_LPAREN ]]3) then do
          token_4(env_1, --[[ T_LPAREN ]]3);
          match_1 = helper(with_no_let(true, env_1), --[[ [] ]]0, --[[ [] ]]0);
          head = List.map((function(param) do
                  match = param[2];
                  return {
                          id = match.id,
                          init = match.init
                        };
                end end), match_1[2]);
          token_4(env_1, --[[ T_RPAREN ]]4);
          body = Curry._1(Parse.statement, env_1);
          match_2 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
          end_loc = match_2 ~= nil and match_2 or match_1[1];
          semicolon(env_1);
          List.iter((function(param) do
                  return error_at(env_1, param);
                end end), match_1[3]);
          return --[[ tuple ]]{
                  btwn(start_loc, end_loc),
                  --[[ Let ]]Block.__(17, {{
                        head = head,
                        body = body
                      }})
                };
        end else do
          match_3 = helper(with_no_let(true, env_1), --[[ [] ]]0, --[[ [] ]]0);
          declaration = --[[ VariableDeclaration ]]Block.__(19, {{
                declarations = match_3[2],
                kind = --[[ Let ]]1
              }});
          match_4 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_1);
          end_loc_1 = match_4 ~= nil and match_4 or match_3[1];
          semicolon(env_1);
          List.iter((function(param) do
                  return error_at(env_1, param);
                end end), match_3[3]);
          return --[[ tuple ]]{
                  btwn(start_loc, end_loc_1),
                  declaration
                };
        end end 
      end
       end 
    end else do
      return var_or_const(env);
    end end 
  end
   end 
  if (Curry._2(Parser_env_Peek.is_function, nil, env)) then do
    return _function(env);
  end else if (Curry._2(Parser_env_Peek.is_class, nil, env)) then do
    return class_declaration_1(env, decorators);
  end else if (type(match) == "number") then do
    local ___conditional___=(match);
    do
       if ___conditional___ == 51--[[ T_INTERFACE ]] then do
          return __interface(env); end end 
       if ___conditional___ == 52--[[ T_PACKAGE ]]
       or ___conditional___ == 53--[[ T_PRIVATE ]]
       or ___conditional___ == 54--[[ T_PROTECTED ]]
       or ___conditional___ == 55--[[ T_PUBLIC ]]
       or ___conditional___ == 56--[[ T_YIELD ]]
       or ___conditional___ == 57--[[ T_DEBUGGER ]] then do
          return statement(env); end end 
       if ___conditional___ == 58--[[ T_DECLARE ]] then do
          return declare(nil, env); end end 
       if ___conditional___ == 59--[[ T_TYPE ]] then do
          return type_alias(env); end end 
      return statement(env);
        
    end
  end else do
    return statement(env);
  end end  end  end 
end end

function module_item(env) do
  decorators = decorator_list(env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number") then do
    local ___conditional___=(match);
    do
       if ___conditional___ == 47--[[ T_EXPORT ]] then do
          env_1 = env;
          decorators_1 = decorators;
          env_2 = with_in_export(true, with_strict(true, env_1));
          start_loc = Curry._2(Parser_env_Peek.loc, nil, env_2);
          token_4(env_2, --[[ T_EXPORT ]]47);
          match_1 = Curry._2(Parser_env_Peek.token, nil, env_2);
          exit = 0;
          if (type(match_1) == "number") then do
            if (match_1 >= 51) then do
              if (match_1 ~= 97) then do
                if (match_1 >= 62) then do
                  exit = 1;
                end else do
                  local ___conditional___=(match_1 - 51 | 0);
                  do
                     if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
                        if (not env_2.parse_options.types) then do
                          error_1(env_2, --[[ UnexpectedTypeExport ]]9);
                        end
                         end 
                        __interface_1 = __interface(env_2);
                        match_2 = __interface_1[2];
                        if (type(match_2) == "number") then do
                          error({
                            Caml_builtin_exceptions.failure,
                            "Internal Flow Error! Parsed `export interface` into something other than an interface declaration!"
                          })
                        end else if (match_2.tag == --[[ InterfaceDeclaration ]]21) then do
                          record_export(env_2, --[[ tuple ]]{
                                __interface_1[1],
                                extract_ident_name(match_2[1].id)
                              });
                        end else do
                          error({
                            Caml_builtin_exceptions.failure,
                            "Internal Flow Error! Parsed `export interface` into something other than an interface declaration!"
                          })
                        end end  end 
                        end_loc = __interface_1[1];
                        return --[[ tuple ]]{
                                btwn(start_loc, end_loc),
                                --[[ ExportDeclaration ]]Block.__(28, {{
                                      default = false,
                                      declaration = --[[ Declaration ]]Block.__(0, {__interface_1}),
                                      specifiers = nil,
                                      source = nil,
                                      exportKind = --[[ ExportType ]]0
                                    }})
                              }; end end 
                     if ___conditional___ == 8--[[ T_COMMA ]] then do
                        if (Curry._2(Parser_env_Peek.token, 1, env_2) ~= --[[ T_LCURLY ]]1) then do
                          if (not env_2.parse_options.types) then do
                            error_1(env_2, --[[ UnexpectedTypeExport ]]9);
                          end
                           end 
                          type_alias_1 = type_alias(env_2);
                          match_3 = type_alias_1[2];
                          if (type(match_3) == "number") then do
                            error({
                              Caml_builtin_exceptions.failure,
                              "Internal Flow Error! Parsed `export type` into something other than a type alias!"
                            })
                          end else if (match_3.tag == --[[ TypeAlias ]]7) then do
                            record_export(env_2, --[[ tuple ]]{
                                  type_alias_1[1],
                                  extract_ident_name(match_3[1].id)
                                });
                          end else do
                            error({
                              Caml_builtin_exceptions.failure,
                              "Internal Flow Error! Parsed `export type` into something other than a type alias!"
                            })
                          end end  end 
                          end_loc_1 = type_alias_1[1];
                          return --[[ tuple ]]{
                                  btwn(start_loc, end_loc_1),
                                  --[[ ExportDeclaration ]]Block.__(28, {{
                                        default = false,
                                        declaration = --[[ Declaration ]]Block.__(0, {type_alias_1}),
                                        specifiers = nil,
                                        source = nil,
                                        exportKind = --[[ ExportType ]]0
                                      }})
                                };
                        end else do
                          exit = 1;
                        end end  end else 
                     if ___conditional___ == 1--[[ T_LCURLY ]]
                     or ___conditional___ == 2--[[ T_RCURLY ]]
                     or ___conditional___ == 3--[[ T_LPAREN ]]
                     or ___conditional___ == 4--[[ T_RPAREN ]]
                     or ___conditional___ == 5--[[ T_LBRACKET ]]
                     or ___conditional___ == 6--[[ T_RBRACKET ]]
                     or ___conditional___ == 7--[[ T_SEMICOLON ]]
                     or ___conditional___ == 9--[[ T_PERIOD ]] then do
                        exit = 1; end else 
                     if ___conditional___ == 10--[[ T_ARROW ]] then do
                        exit = 2; end else 
                     end end end end end end
                    
                  end
                end end 
              end else do
                loc = Curry._2(Parser_env_Peek.loc, nil, env_2);
                token_4(env_2, --[[ T_MULT ]]97);
                parse_export_star_as = env_2.parse_options.esproposal_export_star_as;
                local_name = Curry._2(Parser_env_Peek.value, nil, env_2) == "as" and (contextual(env_2, "as"), parse_export_star_as and Curry._2(Parse.identifier, nil, env_2) or (error_1(env_2, --[[ UnexpectedTypeDeclaration ]]7), nil)) or nil;
                specifiers = --[[ ExportBatchSpecifier ]]Block.__(1, {
                    loc,
                    local_name
                  });
                source_1 = export_source(env_2);
                match_4 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_2);
                end_loc_2 = match_4 ~= nil and match_4 or source_1[1];
                source_2 = source_1;
                semicolon(env_2);
                return --[[ tuple ]]{
                        btwn(start_loc, end_loc_2),
                        --[[ ExportDeclaration ]]Block.__(28, {{
                              default = false,
                              declaration = nil,
                              specifiers = specifiers,
                              source = source_2,
                              exportKind = --[[ ExportValue ]]1
                            }})
                      };
              end end 
            end else do
              local ___conditional___=(match_1);
              do
                 if ___conditional___ == 34--[[ T_DEFAULT ]] then do
                    token_4(env_2, --[[ T_DEFAULT ]]34);
                    record_export(env_2, --[[ tuple ]]{
                          btwn(start_loc, Curry._2(Parser_env_Peek.loc, nil, env_2)),
                          "default"
                        });
                    match_5 = Curry._2(Parser_env_Peek.token, nil, env_2);
                    match_6;
                    exit_1 = 0;
                    if (type(match_5) == "number" and match_5 == 13) then do
                      fn = _function(env_2);
                      match_6 = --[[ tuple ]]{
                        fn[1],
                        --[[ Declaration ]]Block.__(0, {fn})
                      };
                    end else do
                      exit_1 = 3;
                    end end 
                    if (exit_1 == 3) then do
                      if (Curry._2(Parser_env_Peek.is_class, nil, env_2)) then do
                        _class = class_declaration(env_2, decorators_1);
                        match_6 = --[[ tuple ]]{
                          _class[1],
                          --[[ Declaration ]]Block.__(0, {_class})
                        };
                      end else do
                        expr = Curry._1(Parse.assignment, env_2);
                        match_7 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_2);
                        end_loc_3 = match_7 ~= nil and match_7 or expr[1];
                        semicolon(env_2);
                        match_6 = --[[ tuple ]]{
                          end_loc_3,
                          --[[ Expression ]]Block.__(1, {expr})
                        };
                      end end 
                    end
                     end 
                    return --[[ tuple ]]{
                            btwn(start_loc, match_6[1]),
                            --[[ ExportDeclaration ]]Block.__(28, {{
                                  default = true,
                                  declaration = match_6[2],
                                  specifiers = nil,
                                  source = nil,
                                  exportKind = --[[ ExportValue ]]1
                                }})
                          }; end end 
                 if ___conditional___ == 14--[[ T_IF ]]
                 or ___conditional___ == 15--[[ T_IN ]]
                 or ___conditional___ == 16--[[ T_INSTANCEOF ]]
                 or ___conditional___ == 17--[[ T_RETURN ]]
                 or ___conditional___ == 18--[[ T_SWITCH ]]
                 or ___conditional___ == 19--[[ T_THIS ]]
                 or ___conditional___ == 20--[[ T_THROW ]]
                 or ___conditional___ == 21--[[ T_TRY ]]
                 or ___conditional___ == 23--[[ T_WHILE ]]
                 or ___conditional___ == 24--[[ T_WITH ]]
                 or ___conditional___ == 27--[[ T_NULL ]]
                 or ___conditional___ == 28--[[ T_FALSE ]]
                 or ___conditional___ == 29--[[ T_TRUE ]]
                 or ___conditional___ == 30--[[ T_BREAK ]]
                 or ___conditional___ == 31--[[ T_CASE ]]
                 or ___conditional___ == 32--[[ T_CATCH ]]
                 or ___conditional___ == 33--[[ T_CONTINUE ]]
                 or ___conditional___ == 35--[[ T_DO ]]
                 or ___conditional___ == 36--[[ T_FINALLY ]]
                 or ___conditional___ == 37--[[ T_FOR ]] then do
                    exit = 1; end else 
                 if ___conditional___ == 12--[[ T_AT ]]
                 or ___conditional___ == 13--[[ T_FUNCTION ]]
                 or ___conditional___ == 22--[[ T_VAR ]]
                 or ___conditional___ == 25--[[ T_CONST ]]
                 or ___conditional___ == 26--[[ T_LET ]]
                 or ___conditional___ == 38--[[ T_CLASS ]] then do
                    exit = 2; end else 
                 end end end end
                exit = 1;
                  
              end
            end end 
          end else do
            exit = 1;
          end end 
          local ___conditional___=(exit);
          do
             if ___conditional___ == 1 then do
                match_8 = Curry._2(Parser_env_Peek.token, nil, env_2);
                exportKind = type(match_8) == "number" and match_8 == 59 and (token_3(env_2), --[[ ExportType ]]0) or --[[ ExportValue ]]1;
                token_4(env_2, --[[ T_LCURLY ]]1);
                match_9 = export_specifiers_and_errs(env_2, --[[ [] ]]0, --[[ [] ]]0);
                specifiers_1 = --[[ ExportSpecifiers ]]Block.__(0, {match_9[1]});
                end_loc_4 = Curry._2(Parser_env_Peek.loc, nil, env_2);
                token_4(env_2, --[[ T_RCURLY ]]2);
                source_3 = Curry._2(Parser_env_Peek.value, nil, env_2) == "from" and export_source(env_2) or (List.iter((function(param) do
                            return error_at(env_2, param);
                          end end), match_9[2]), nil);
                match_10 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_2);
                end_loc_5 = match_10 ~= nil and match_10 or (
                    source_3 ~= nil and source_3[1] or end_loc_4
                  );
                semicolon(env_2);
                return --[[ tuple ]]{
                        btwn(start_loc, end_loc_5),
                        --[[ ExportDeclaration ]]Block.__(28, {{
                              default = false,
                              declaration = nil,
                              specifiers = specifiers_1,
                              source = source_3,
                              exportKind = exportKind
                            }})
                      }; end end 
             if ___conditional___ == 2 then do
                stmt = Curry._2(Parse.statement_list_item, decorators_1, env_2);
                match_11 = stmt[2];
                loc_1 = stmt[1];
                names;
                if (type(match_11) == "number") then do
                  error({
                    Caml_builtin_exceptions.failure,
                    "Internal Flow Error! Unexpected export statement declaration!"
                  })
                end else do
                  local ___conditional___=(match_11.tag | 0);
                  do
                     if ___conditional___ == 18--[[ FunctionDeclaration ]] then do
                        match_12 = match_11[1].id;
                        if (match_12 ~= nil) then do
                          names = --[[ :: ]]{
                            --[[ tuple ]]{
                              loc_1,
                              extract_ident_name(match_12)
                            },
                            --[[ [] ]]0
                          };
                        end else do
                          error_at(env_2, --[[ tuple ]]{
                                loc_1,
                                --[[ ExportNamelessFunction ]]56
                              });
                          names = --[[ [] ]]0;
                        end end  end else 
                     if ___conditional___ == 19--[[ VariableDeclaration ]] then do
                        names = List.fold_left((function(names, param) do
                                id = param[2].id;
                                param_1 = names;
                                param_2 = --[[ :: ]]{
                                  id,
                                  --[[ [] ]]0
                                };
                                return List.fold_left(fold, param_1, param_2);
                              end end), --[[ [] ]]0, match_11[1].declarations); end else 
                     if ___conditional___ == 20--[[ ClassDeclaration ]] then do
                        match_13 = match_11[1].id;
                        if (match_13 ~= nil) then do
                          names = --[[ :: ]]{
                            --[[ tuple ]]{
                              loc_1,
                              extract_ident_name(match_13)
                            },
                            --[[ [] ]]0
                          };
                        end else do
                          error_at(env_2, --[[ tuple ]]{
                                loc_1,
                                --[[ ExportNamelessClass ]]55
                              });
                          names = --[[ [] ]]0;
                        end end  end else 
                     end end end end end end
                    error({
                        Caml_builtin_exceptions.failure,
                        "Internal Flow Error! Unexpected export statement declaration!"
                      })
                      
                  end
                end end 
                List.iter((function(param) do
                        return record_export(env_2, param);
                      end end), names);
                declaration = --[[ Declaration ]]Block.__(0, {stmt});
                return --[[ tuple ]]{
                        btwn(start_loc, stmt[1]),
                        --[[ ExportDeclaration ]]Block.__(28, {{
                              default = false,
                              declaration = declaration,
                              specifiers = nil,
                              source = nil,
                              exportKind = --[[ ExportValue ]]1
                            }})
                      }; end end 
            
          end end end 
       if ___conditional___ == 48--[[ T_IMPORT ]] then do
          error_on_decorators(env)(decorators);
          env_3 = env;
          env_4 = with_strict(true, env_3);
          start_loc_1 = Curry._2(Parser_env_Peek.loc, nil, env_4);
          token_4(env_4, --[[ T_IMPORT ]]48);
          match_14 = Curry._2(Parser_env_Peek.token, nil, env_4);
          match_15;
          if (type(match_14) == "number") then do
            if (match_14 ~= 44) then do
              if (match_14 ~= 59) then do
                match_15 = --[[ tuple ]]{
                  --[[ ImportValue ]]2,
                  nil
                };
              end else do
                if (not env_4.parse_options.types) then do
                  error_1(env_4, --[[ UnexpectedTypeImport ]]8);
                end
                 end 
                match_15 = --[[ tuple ]]{
                  --[[ ImportType ]]0,
                  Curry._2(Parse.identifier, nil, env_4)
                };
              end end 
            end else do
              if (not env_4.parse_options.types) then do
                error_1(env_4, --[[ UnexpectedTypeImport ]]8);
              end
               end 
              token_4(env_4, --[[ T_TYPEOF ]]44);
              match_15 = --[[ tuple ]]{
                --[[ ImportTypeof ]]1,
                nil
              };
            end end 
          end else do
            match_15 = --[[ tuple ]]{
              --[[ ImportValue ]]2,
              nil
            };
          end end 
          type_ident = match_15[2];
          importKind = match_15[1];
          match_16 = Curry._2(Parser_env_Peek.token, nil, env_4);
          match_17 = Curry._2(Parser_env_Peek.is_identifier, nil, env_4);
          exit_2 = 0;
          exit_3 = 0;
          if (type(match_16) == "number") then do
            if (match_16 == --[[ T_COMMA ]]8) then do
              exit_2 = 1;
            end else do
              exit_3 = 2;
            end end 
          end else if (match_16.tag == --[[ T_STRING ]]1 and importKind == --[[ ImportValue ]]2) then do
            match_18 = match_16[1];
            octal = match_18[4];
            raw = match_18[3];
            value = match_18[2];
            str_loc = match_18[1];
            if (octal) then do
              strict_error(env_4, --[[ StrictOctalLiteral ]]31);
            end
             end 
            token_4(env_4, --[[ T_STRING ]]Block.__(1, {--[[ tuple ]]{
                      str_loc,
                      value,
                      raw,
                      octal
                    }}));
            value_1 = --[[ String ]]Block.__(0, {value});
            source_001 = {
              value = value_1,
              raw = raw
            };
            source_4 = --[[ tuple ]]{
              str_loc,
              source_001
            };
            match_19 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_4);
            end_loc_6 = match_19 ~= nil and match_19 or str_loc;
            semicolon(env_4);
            return --[[ tuple ]]{
                    btwn(start_loc_1, end_loc_6),
                    --[[ ImportDeclaration ]]Block.__(29, {{
                          importKind = importKind,
                          source = source_4,
                          specifiers = --[[ [] ]]0
                        }})
                  };
          end else do
            exit_3 = 2;
          end end  end 
          if (exit_3 == 2) then do
            if (match_17) then do
              exit_2 = 1;
            end else do
              specifiers_2 = named_or_namespace_specifier(env_4);
              source_5 = source(env_4);
              match_20 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_4);
              end_loc_7 = match_20 ~= nil and match_20 or source_5[1];
              semicolon(env_4);
              return --[[ tuple ]]{
                      btwn(start_loc_1, end_loc_7),
                      --[[ ImportDeclaration ]]Block.__(29, {{
                            importKind = importKind,
                            source = source_5,
                            specifiers = specifiers_2
                          }})
                    };
            end end 
          end
           end 
          if (exit_2 == 1) then do
            match_21 = Curry._2(Parser_env_Peek.token, nil, env_4);
            match_22 = Curry._2(Parser_env_Peek.value, nil, env_4);
            match_23;
            exit_4 = 0;
            if (type_ident ~= nil and type(match_21) == "number") then do
              type_ident_1 = type_ident;
              if (match_21 ~= 8 and (match_21 ~= 0 or match_22 ~= "from")) then do
                exit_4 = 2;
              end else do
                match_23 = --[[ tuple ]]{
                  --[[ ImportValue ]]2,
                  --[[ ImportDefaultSpecifier ]]Block.__(1, {type_ident_1})
                };
              end end 
            end else do
              exit_4 = 2;
            end end 
            if (exit_4 == 2) then do
              match_23 = --[[ tuple ]]{
                importKind,
                --[[ ImportDefaultSpecifier ]]Block.__(1, {Curry._2(Parse.identifier, nil, env_4)})
              };
            end
             end 
            match_24 = Curry._2(Parser_env_Peek.token, nil, env_4);
            additional_specifiers = type(match_24) == "number" and match_24 == 8 and (token_4(env_4, --[[ T_COMMA ]]8), named_or_namespace_specifier(env_4)) or --[[ [] ]]0;
            source_6 = source(env_4);
            match_25 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_4);
            end_loc_8 = match_25 ~= nil and match_25 or source_6[1];
            semicolon(env_4);
            return --[[ tuple ]]{
                    btwn(start_loc_1, end_loc_8),
                    --[[ ImportDeclaration ]]Block.__(29, {{
                          importKind = match_23[1],
                          source = source_6,
                          specifiers = --[[ :: ]]{
                            match_23[2],
                            additional_specifiers
                          }
                        }})
                  };
          end
           end  end end 
       if ___conditional___ == 49--[[ T_SUPER ]]
       or ___conditional___ == 50--[[ T_IMPLEMENTS ]]
       or ___conditional___ == 51--[[ T_INTERFACE ]]
       or ___conditional___ == 52--[[ T_PACKAGE ]]
       or ___conditional___ == 53--[[ T_PRIVATE ]]
       or ___conditional___ == 54--[[ T_PROTECTED ]]
       or ___conditional___ == 55--[[ T_PUBLIC ]]
       or ___conditional___ == 56--[[ T_YIELD ]]
       or ___conditional___ == 57--[[ T_DEBUGGER ]] then do
          return statement_list_item(decorators, env); end end 
       if ___conditional___ == 58--[[ T_DECLARE ]] then do
          if (Curry._2(Parser_env_Peek.token, 1, env) == --[[ T_EXPORT ]]47) then do
            error_on_decorators(env)(decorators);
            return declare_export_declaration(nil, env);
          end else do
            return statement_list_item(decorators, env);
          end end  end end 
      return statement_list_item(decorators, env);
        
    end
  end else do
    return statement_list_item(decorators, env);
  end end 
end end

function statement(env) do
  while(true) do
    match = Curry._2(Parser_env_Peek.token, nil, env);
    exit = 0;
    if (type(match) == "number") then do
      if (match ~= 105) then do
        if (match >= 58) then do
          exit = 2;
        end else do
          local ___conditional___=(match);
          do
             if ___conditional___ == 1--[[ T_LCURLY ]] then do
                env_1 = env;
                match_1 = Curry._1(Parse.block_body, env_1);
                return --[[ tuple ]]{
                        match_1[1],
                        --[[ Block ]]Block.__(0, {match_1[2]})
                      }; end end 
             if ___conditional___ == 7--[[ T_SEMICOLON ]] then do
                env_2 = env;
                loc = Curry._2(Parser_env_Peek.loc, nil, env_2);
                token_4(env_2, --[[ T_SEMICOLON ]]7);
                return --[[ tuple ]]{
                        loc,
                        --[[ Empty ]]0
                      }; end end 
             if ___conditional___ == 14--[[ T_IF ]] then do
                return _if(env); end end 
             if ___conditional___ == 17--[[ T_RETURN ]] then do
                env_3 = env;
                if (not env_3.in_function) then do
                  error_1(env_3, --[[ IllegalReturn ]]23);
                end
                 end 
                start_loc = Curry._2(Parser_env_Peek.loc, nil, env_3);
                token_4(env_3, --[[ T_RETURN ]]17);
                argument = Curry._2(Parser_env_Peek.token, nil, env_3) == --[[ T_SEMICOLON ]]7 or Curry._1(Parser_env_Peek.is_implicit_semicolon, env_3) and nil or Curry._1(Parse.expression, env_3);
                match_2 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_3);
                end_loc = match_2 ~= nil and match_2 or (
                    argument ~= nil and argument[1] or start_loc
                  );
                semicolon(env_3);
                return --[[ tuple ]]{
                        btwn(start_loc, end_loc),
                        --[[ Return ]]Block.__(9, {{
                              argument = argument
                            }})
                      }; end end 
             if ___conditional___ == 18--[[ T_SWITCH ]] then do
                env_4 = env;
                start_loc_1 = Curry._2(Parser_env_Peek.loc, nil, env_4);
                token_4(env_4, --[[ T_SWITCH ]]18);
                token_4(env_4, --[[ T_LPAREN ]]3);
                discriminant = Curry._1(Parse.expression, env_4);
                token_4(env_4, --[[ T_RPAREN ]]4);
                token_4(env_4, --[[ T_LCURLY ]]1);
                cases = case_list(env_4, --[[ tuple ]]{
                      false,
                      --[[ [] ]]0
                    });
                end_loc_1 = Curry._2(Parser_env_Peek.loc, nil, env_4);
                token_4(env_4, --[[ T_RCURLY ]]2);
                return --[[ tuple ]]{
                        btwn(start_loc_1, end_loc_1),
                        --[[ Switch ]]Block.__(8, {{
                              discriminant = discriminant,
                              cases = cases,
                              lexical = false
                            }})
                      }; end end 
             if ___conditional___ == 20--[[ T_THROW ]] then do
                env_5 = env;
                start_loc_2 = Curry._2(Parser_env_Peek.loc, nil, env_5);
                token_4(env_5, --[[ T_THROW ]]20);
                if (Curry._1(Parser_env_Peek.is_line_terminator, env_5)) then do
                  error_at(env_5, --[[ tuple ]]{
                        start_loc_2,
                        --[[ NewlineAfterThrow ]]11
                      });
                end
                 end 
                argument_1 = Curry._1(Parse.expression, env_5);
                match_3 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_5);
                end_loc_2 = match_3 ~= nil and match_3 or argument_1[1];
                semicolon(env_5);
                return --[[ tuple ]]{
                        btwn(start_loc_2, end_loc_2),
                        --[[ Throw ]]Block.__(10, {{
                              argument = argument_1
                            }})
                      }; end end 
             if ___conditional___ == 21--[[ T_TRY ]] then do
                env_6 = env;
                start_loc_3 = Curry._2(Parser_env_Peek.loc, nil, env_6);
                token_4(env_6, --[[ T_TRY ]]21);
                block = Curry._1(Parse.block_body, env_6);
                match_4 = Curry._2(Parser_env_Peek.token, nil, env_6);
                handler;
                if (type(match_4) == "number" and match_4 == 32) then do
                  start_loc_4 = Curry._2(Parser_env_Peek.loc, nil, env_6);
                  token_4(env_6, --[[ T_CATCH ]]32);
                  token_4(env_6, --[[ T_LPAREN ]]3);
                  id = Curry._2(Parse.identifier, --[[ StrictCatchVariable ]]26, env_6);
                  param_000 = id[1];
                  param_001 = --[[ Identifier ]]Block.__(3, {id});
                  param = --[[ tuple ]]{
                    param_000,
                    param_001
                  };
                  token_4(env_6, --[[ T_RPAREN ]]4);
                  body = Curry._1(Parse.block_body, env_6);
                  loc_1 = btwn(start_loc_4, body[1]);
                  handler = --[[ tuple ]]{
                    loc_1,
                    {
                      param = param,
                      guard = nil,
                      body = body
                    }
                  };
                end else do
                  handler = nil;
                end end 
                match_5 = Curry._2(Parser_env_Peek.token, nil, env_6);
                finalizer = type(match_5) == "number" and match_5 == 36 and (token_4(env_6, --[[ T_FINALLY ]]36), Curry._1(Parse.block_body, env_6)) or nil;
                end_loc_3 = finalizer ~= nil and finalizer[1] or (
                    handler ~= nil and handler[1] or (error_at(env_6, --[[ tuple ]]{
                              block[1],
                              --[[ NoCatchOrFinally ]]20
                            }), block[1])
                  );
                return --[[ tuple ]]{
                        btwn(start_loc_3, end_loc_3),
                        --[[ Try ]]Block.__(11, {{
                              block = block,
                              handler = handler,
                              guardedHandlers = --[[ [] ]]0,
                              finalizer = finalizer
                            }})
                      }; end end 
             if ___conditional___ == 22--[[ T_VAR ]] then do
                return var_or_const(env); end end 
             if ___conditional___ == 23--[[ T_WHILE ]] then do
                env_7 = env;
                start_loc_5 = Curry._2(Parser_env_Peek.loc, nil, env_7);
                token_4(env_7, --[[ T_WHILE ]]23);
                token_4(env_7, --[[ T_LPAREN ]]3);
                test = Curry._1(Parse.expression, env_7);
                token_4(env_7, --[[ T_RPAREN ]]4);
                body_1 = Curry._1(Parse.statement, with_in_loop(true, env_7));
                return --[[ tuple ]]{
                        btwn(start_loc_5, body_1[1]),
                        --[[ While ]]Block.__(12, {{
                              test = test,
                              body = body_1
                            }})
                      }; end end 
             if ___conditional___ == 24--[[ T_WITH ]] then do
                env_8 = env;
                start_loc_6 = Curry._2(Parser_env_Peek.loc, nil, env_8);
                token_4(env_8, --[[ T_WITH ]]24);
                token_4(env_8, --[[ T_LPAREN ]]3);
                _object = Curry._1(Parse.expression, env_8);
                token_4(env_8, --[[ T_RPAREN ]]4);
                body_2 = Curry._1(Parse.statement, env_8);
                loc_2 = btwn(start_loc_6, body_2[1]);
                strict_error_at(env_8, --[[ tuple ]]{
                      loc_2,
                      --[[ StrictModeWith ]]25
                    });
                return --[[ tuple ]]{
                        loc_2,
                        --[[ With ]]Block.__(6, {{
                              _object = _object,
                              body = body_2
                            }})
                      }; end end 
             if ___conditional___ == 30--[[ T_BREAK ]] then do
                env_9 = env;
                start_loc_7 = Curry._2(Parser_env_Peek.loc, nil, env_9);
                token_4(env_9, --[[ T_BREAK ]]30);
                label;
                if (Curry._2(Parser_env_Peek.token, nil, env_9) == --[[ T_SEMICOLON ]]7 or Curry._1(Parser_env_Peek.is_implicit_semicolon, env_9)) then do
                  label = nil;
                end else do
                  label_1 = Curry._2(Parse.identifier, nil, env_9);
                  name = label_1[2].name;
                  if (not mem_1(name, env_9.labels)) then do
                    error_1(env_9, --[[ UnknownLabel ]]Block.__(4, {name}));
                  end
                   end 
                  label = label_1;
                end end 
                match_6 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_9);
                end_loc_4 = match_6 ~= nil and match_6 or (
                    label ~= nil and label[1] or start_loc_7
                  );
                loc_3 = btwn(start_loc_7, end_loc_4);
                if (label == nil and not (env_9.in_loop or env_9.in_switch)) then do
                  error_at(env_9, --[[ tuple ]]{
                        loc_3,
                        --[[ IllegalBreak ]]22
                      });
                end
                 end 
                semicolon(env_9);
                return --[[ tuple ]]{
                        loc_3,
                        --[[ Break ]]Block.__(4, {{
                              label = label
                            }})
                      }; end end 
             if ___conditional___ == 33--[[ T_CONTINUE ]] then do
                env_10 = env;
                start_loc_8 = Curry._2(Parser_env_Peek.loc, nil, env_10);
                token_4(env_10, --[[ T_CONTINUE ]]33);
                label_2;
                if (Curry._2(Parser_env_Peek.token, nil, env_10) == --[[ T_SEMICOLON ]]7 or Curry._1(Parser_env_Peek.is_implicit_semicolon, env_10)) then do
                  label_2 = nil;
                end else do
                  label_3 = Curry._2(Parse.identifier, nil, env_10);
                  name_1 = label_3[2].name;
                  if (not mem_1(name_1, env_10.labels)) then do
                    error_1(env_10, --[[ UnknownLabel ]]Block.__(4, {name_1}));
                  end
                   end 
                  label_2 = label_3;
                end end 
                match_7 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_10);
                end_loc_5 = match_7 ~= nil and match_7 or (
                    label_2 ~= nil and label_2[1] or start_loc_8
                  );
                loc_4 = btwn(start_loc_8, end_loc_5);
                if (not env_10.in_loop) then do
                  error_at(env_10, --[[ tuple ]]{
                        loc_4,
                        --[[ IllegalContinue ]]21
                      });
                end
                 end 
                semicolon(env_10);
                return --[[ tuple ]]{
                        loc_4,
                        --[[ Continue ]]Block.__(5, {{
                              label = label_2
                            }})
                      }; end end 
             if ___conditional___ == 35--[[ T_DO ]] then do
                env_11 = env;
                start_loc_9 = Curry._2(Parser_env_Peek.loc, nil, env_11);
                token_4(env_11, --[[ T_DO ]]35);
                body_3 = Curry._1(Parse.statement, with_in_loop(true, env_11));
                token_4(env_11, --[[ T_WHILE ]]23);
                token_4(env_11, --[[ T_LPAREN ]]3);
                test_1 = Curry._1(Parse.expression, env_11);
                end_loc_6 = Curry._2(Parser_env_Peek.loc, nil, env_11);
                token_4(env_11, --[[ T_RPAREN ]]4);
                match_8 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_11);
                end_loc_7 = match_8 ~= nil and match_8 or end_loc_6;
                if (Curry._2(Parser_env_Peek.token, nil, env_11) == --[[ T_SEMICOLON ]]7) then do
                  semicolon(env_11);
                end
                 end 
                return --[[ tuple ]]{
                        btwn(start_loc_9, end_loc_7),
                        --[[ DoWhile ]]Block.__(13, {{
                              body = body_3,
                              test = test_1
                            }})
                      }; end end 
             if ___conditional___ == 37--[[ T_FOR ]] then do
                env_12 = env;
                start_loc_10 = Curry._2(Parser_env_Peek.loc, nil, env_12);
                token_4(env_12, --[[ T_FOR ]]37);
                token_4(env_12, --[[ T_LPAREN ]]3);
                match_9 = Curry._2(Parser_env_Peek.token, nil, env_12);
                match_10;
                exit_1 = 0;
                if (type(match_9) == "number") then do
                  if (match_9 >= 22) then do
                    if (match_9 >= 27) then do
                      exit_1 = 1;
                    end else do
                      local ___conditional___=(match_9 - 22 | 0);
                      do
                         if ___conditional___ == 0--[[ T_IDENTIFIER ]] then do
                            match_11 = declarations(--[[ T_VAR ]]22, --[[ Var ]]0, with_no_in(true, env_12));
                            match_10 = --[[ tuple ]]{
                              --[[ InitDeclaration ]]Block.__(0, {match_11[1]}),
                              match_11[2]
                            }; end else 
                         if ___conditional___ == 1--[[ T_LCURLY ]]
                         or ___conditional___ == 2--[[ T_RCURLY ]] then do
                            exit_1 = 1; end else 
                         if ___conditional___ == 3--[[ T_LPAREN ]] then do
                            match_12 = __const(with_no_in(true, env_12));
                            match_10 = --[[ tuple ]]{
                              --[[ InitDeclaration ]]Block.__(0, {match_12[1]}),
                              match_12[2]
                            }; end else 
                         if ___conditional___ == 4--[[ T_RPAREN ]] then do
                            match_13 = _let(with_no_in(true, env_12));
                            match_10 = --[[ tuple ]]{
                              --[[ InitDeclaration ]]Block.__(0, {match_13[1]}),
                              match_13[2]
                            }; end else 
                         end end end end end end end end
                        
                      end
                    end end 
                  end else if (match_9 ~= 7) then do
                    exit_1 = 1;
                  end else do
                    match_10 = --[[ tuple ]]{
                      nil,
                      --[[ [] ]]0
                    };
                  end end  end 
                end else do
                  exit_1 = 1;
                end end 
                if (exit_1 == 1) then do
                  expr = Curry._1(Parse.expression, with_no_let(true, with_no_in(true, env_12)));
                  match_10 = --[[ tuple ]]{
                    --[[ InitExpression ]]Block.__(1, {expr}),
                    --[[ [] ]]0
                  };
                end
                 end 
                init = match_10[1];
                match_14 = Curry._2(Parser_env_Peek.token, nil, env_12);
                if (type(match_14) == "number") then do
                  if (match_14 ~= 15) then do
                    if (match_14 == 60) then do
                      assert_can_be_forin_or_forof(env_12, --[[ InvalidLHSInForOf ]]17, init);
                      left;
                      if (init ~= nil) then do
                        match_15 = init;
                        left = match_15.tag and --[[ LeftExpression ]]Block.__(1, {match_15[1]}) or --[[ LeftDeclaration ]]Block.__(0, {match_15[1]});
                      end else do
                        error({
                          Caml_builtin_exceptions.assert_failure,
                          --[[ tuple ]]{
                            "parser_flow.ml",
                            2573,
                            22
                          }
                        })
                      end end 
                      token_4(env_12, --[[ T_OF ]]60);
                      right = Curry._1(Parse.assignment, env_12);
                      token_4(env_12, --[[ T_RPAREN ]]4);
                      body_4 = Curry._1(Parse.statement, with_in_loop(true, env_12));
                      return --[[ tuple ]]{
                              btwn(start_loc_10, body_4[1]),
                              --[[ ForOf ]]Block.__(16, {{
                                    left = left,
                                    right = right,
                                    body = body_4
                                  }})
                            };
                    end
                     end 
                  end else do
                    assert_can_be_forin_or_forof(env_12, --[[ InvalidLHSInForIn ]]16, init);
                    left_1;
                    if (init ~= nil) then do
                      match_16 = init;
                      left_1 = match_16.tag and --[[ LeftExpression ]]Block.__(1, {match_16[1]}) or --[[ LeftDeclaration ]]Block.__(0, {match_16[1]});
                    end else do
                      error({
                        Caml_builtin_exceptions.assert_failure,
                        --[[ tuple ]]{
                          "parser_flow.ml",
                          2556,
                          22
                        }
                      })
                    end end 
                    token_4(env_12, --[[ T_IN ]]15);
                    right_1 = Curry._1(Parse.expression, env_12);
                    token_4(env_12, --[[ T_RPAREN ]]4);
                    body_5 = Curry._1(Parse.statement, with_in_loop(true, env_12));
                    return --[[ tuple ]]{
                            btwn(start_loc_10, body_5[1]),
                            --[[ ForIn ]]Block.__(15, {{
                                  left = left_1,
                                  right = right_1,
                                  body = body_5,
                                  each = false
                                }})
                          };
                  end end 
                end
                 end 
                List.iter((function(env_12)do
                    return function (param) do
                      return error_at(env_12, param);
                    end end
                    end end)(env_12), match_10[2]);
                token_4(env_12, --[[ T_SEMICOLON ]]7);
                match_17 = Curry._2(Parser_env_Peek.token, nil, env_12);
                test_2 = type(match_17) == "number" and match_17 == 7 and nil or Curry._1(Parse.expression, env_12);
                token_4(env_12, --[[ T_SEMICOLON ]]7);
                match_18 = Curry._2(Parser_env_Peek.token, nil, env_12);
                update = type(match_18) == "number" and match_18 == 4 and nil or Curry._1(Parse.expression, env_12);
                token_4(env_12, --[[ T_RPAREN ]]4);
                body_6 = Curry._1(Parse.statement, with_in_loop(true, env_12));
                return --[[ tuple ]]{
                        btwn(start_loc_10, body_6[1]),
                        --[[ For ]]Block.__(14, {{
                              init = init,
                              test = test_2,
                              update = update,
                              body = body_6
                            }})
                      }; end end 
             if ___conditional___ == 0--[[ T_IDENTIFIER ]]
             or ___conditional___ == 2--[[ T_RCURLY ]]
             or ___conditional___ == 3--[[ T_LPAREN ]]
             or ___conditional___ == 4--[[ T_RPAREN ]]
             or ___conditional___ == 5--[[ T_LBRACKET ]]
             or ___conditional___ == 6--[[ T_RBRACKET ]]
             or ___conditional___ == 8--[[ T_COMMA ]]
             or ___conditional___ == 9--[[ T_PERIOD ]]
             or ___conditional___ == 10--[[ T_ARROW ]]
             or ___conditional___ == 11--[[ T_ELLIPSIS ]]
             or ___conditional___ == 12--[[ T_AT ]]
             or ___conditional___ == 13--[[ T_FUNCTION ]]
             or ___conditional___ == 15--[[ T_IN ]]
             or ___conditional___ == 16--[[ T_INSTANCEOF ]]
             or ___conditional___ == 19--[[ T_THIS ]]
             or ___conditional___ == 25--[[ T_CONST ]]
             or ___conditional___ == 26--[[ T_LET ]]
             or ___conditional___ == 27--[[ T_NULL ]]
             or ___conditional___ == 28--[[ T_FALSE ]]
             or ___conditional___ == 29--[[ T_TRUE ]]
             or ___conditional___ == 31--[[ T_CASE ]]
             or ___conditional___ == 32--[[ T_CATCH ]]
             or ___conditional___ == 34--[[ T_DEFAULT ]]
             or ___conditional___ == 36--[[ T_FINALLY ]]
             or ___conditional___ == 38--[[ T_CLASS ]]
             or ___conditional___ == 39--[[ T_EXTENDS ]]
             or ___conditional___ == 40--[[ T_STATIC ]]
             or ___conditional___ == 41--[[ T_ELSE ]]
             or ___conditional___ == 42--[[ T_NEW ]]
             or ___conditional___ == 43--[[ T_DELETE ]]
             or ___conditional___ == 44--[[ T_TYPEOF ]]
             or ___conditional___ == 45--[[ T_VOID ]]
             or ___conditional___ == 46--[[ T_ENUM ]]
             or ___conditional___ == 47--[[ T_EXPORT ]]
             or ___conditional___ == 48--[[ T_IMPORT ]]
             or ___conditional___ == 49--[[ T_SUPER ]]
             or ___conditional___ == 50--[[ T_IMPLEMENTS ]]
             or ___conditional___ == 51--[[ T_INTERFACE ]]
             or ___conditional___ == 52--[[ T_PACKAGE ]]
             or ___conditional___ == 53--[[ T_PRIVATE ]]
             or ___conditional___ == 54--[[ T_PROTECTED ]]
             or ___conditional___ == 55--[[ T_PUBLIC ]]
             or ___conditional___ == 56--[[ T_YIELD ]] then do
                exit = 2; end else 
             if ___conditional___ == 57--[[ T_DEBUGGER ]] then do
                env_13 = env;
                start_loc_11 = Curry._2(Parser_env_Peek.loc, nil, env_13);
                token_4(env_13, --[[ T_DEBUGGER ]]57);
                match_19 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_13);
                end_loc_8 = match_19 ~= nil and match_19 or start_loc_11;
                semicolon(env_13);
                return --[[ tuple ]]{
                        btwn(start_loc_11, end_loc_8),
                        --[[ Debugger ]]1
                      }; end end end end 
            
          end
        end end 
      end else do
        error_unexpected(env);
        return --[[ tuple ]]{
                Curry._2(Parser_env_Peek.loc, nil, env),
                --[[ Empty ]]0
              };
      end end 
    end else do
      exit = 2;
    end end 
    if (exit == 2) then do
      if (Curry._2(Parser_env_Peek.is_identifier, nil, env)) then do
        env_14 = env;
        expr_1 = Curry._1(Parse.expression, env_14);
        match_20 = Curry._2(Parser_env_Peek.token, nil, env_14);
        match_21 = expr_1[2];
        loc_5 = expr_1[1];
        if (type(match_21) ~= "number" and match_21.tag == --[[ Identifier ]]18 and type(match_20) == "number" and match_20 == 77) then do
          label_4 = match_21[1];
          match_22 = label_4[2];
          name_2 = match_22.name;
          token_4(env_14, --[[ T_COLON ]]77);
          if (mem_1(name_2, env_14.labels)) then do
            error_at(env_14, --[[ tuple ]]{
                  loc_5,
                  --[[ Redeclaration ]]Block.__(5, {
                      "Label",
                      name_2
                    })
                });
          end
           end 
          env_15 = add_label(env_14, name_2);
          labeled_stmt = Curry._1(Parse.statement, env_15);
          return --[[ tuple ]]{
                  btwn(loc_5, labeled_stmt[1]),
                  --[[ Labeled ]]Block.__(3, {{
                        label = label_4,
                        body = labeled_stmt
                      }})
                };
        end
         end 
        match_23 = Curry._2(Parser_env_Peek.semicolon_loc, nil, env_14);
        end_loc_9 = match_23 ~= nil and match_23 or expr_1[1];
        semicolon(env_14);
        return --[[ tuple ]]{
                btwn(expr_1[1], end_loc_9),
                --[[ Expression ]]Block.__(1, {{
                      expression = expr_1
                    }})
              };
      end else if (type(match) == "number") then do
        if (match ~= 77) then do
          if (match >= 49) then do
            return expression(env);
          end else do
            local ___conditional___=(match);
            do
               if ___conditional___ == 41--[[ T_ELSE ]] then do
                  return _if(env); end end 
               if ___conditional___ == 0--[[ T_IDENTIFIER ]]
               or ___conditional___ == 1--[[ T_LCURLY ]]
               or ___conditional___ == 3--[[ T_LPAREN ]]
               or ___conditional___ == 5--[[ T_LBRACKET ]]
               or ___conditional___ == 7--[[ T_SEMICOLON ]]
               or ___conditional___ == 12--[[ T_AT ]]
               or ___conditional___ == 13--[[ T_FUNCTION ]]
               or ___conditional___ == 14--[[ T_IF ]]
               or ___conditional___ == 17--[[ T_RETURN ]]
               or ___conditional___ == 18--[[ T_SWITCH ]]
               or ___conditional___ == 19--[[ T_THIS ]]
               or ___conditional___ == 20--[[ T_THROW ]]
               or ___conditional___ == 21--[[ T_TRY ]]
               or ___conditional___ == 22--[[ T_VAR ]]
               or ___conditional___ == 23--[[ T_WHILE ]]
               or ___conditional___ == 24--[[ T_WITH ]]
               or ___conditional___ == 25--[[ T_CONST ]]
               or ___conditional___ == 26--[[ T_LET ]]
               or ___conditional___ == 27--[[ T_NULL ]]
               or ___conditional___ == 28--[[ T_FALSE ]]
               or ___conditional___ == 29--[[ T_TRUE ]]
               or ___conditional___ == 30--[[ T_BREAK ]]
               or ___conditional___ == 33--[[ T_CONTINUE ]]
               or ___conditional___ == 35--[[ T_DO ]]
               or ___conditional___ == 37--[[ T_FOR ]]
               or ___conditional___ == 38--[[ T_CLASS ]]
               or ___conditional___ == 42--[[ T_NEW ]]
               or ___conditional___ == 43--[[ T_DELETE ]]
               or ___conditional___ == 44--[[ T_TYPEOF ]]
               or ___conditional___ == 45--[[ T_VOID ]]
               or ___conditional___ == 46--[[ T_ENUM ]] then do
                  return expression(env); end end 
               if ___conditional___ == 2--[[ T_RCURLY ]]
               or ___conditional___ == 4--[[ T_RPAREN ]]
               or ___conditional___ == 6--[[ T_RBRACKET ]]
               or ___conditional___ == 8--[[ T_COMMA ]]
               or ___conditional___ == 9--[[ T_PERIOD ]]
               or ___conditional___ == 10--[[ T_ARROW ]]
               or ___conditional___ == 11--[[ T_ELLIPSIS ]]
               or ___conditional___ == 15--[[ T_IN ]]
               or ___conditional___ == 16--[[ T_INSTANCEOF ]]
               or ___conditional___ == 31--[[ T_CASE ]]
               or ___conditional___ == 32--[[ T_CATCH ]]
               or ___conditional___ == 34--[[ T_DEFAULT ]]
               or ___conditional___ == 36--[[ T_FINALLY ]]
               or ___conditional___ == 39--[[ T_EXTENDS ]]
               or ___conditional___ == 40--[[ T_STATIC ]]
               or ___conditional___ == 47--[[ T_EXPORT ]]
               or ___conditional___ == 48--[[ T_IMPORT ]]
               end
              
            end
          end end 
        end
         end 
      end else do
        return expression(env);
      end end  end 
    end
     end 
    error_unexpected(env);
    token_3(env);
    ::continue:: ;
  end;
end end

function module_body(term_fn, env) do
  env_1 = env;
  term_fn_1 = term_fn;
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    t = Curry._2(Parser_env_Peek.token, nil, env_1);
    if (type(t) == "number" and t == 105) then do
      return List.rev(acc);
    end
     end 
    if (Curry._1(term_fn_1, t)) then do
      return List.rev(acc);
    end else do
      _acc = --[[ :: ]]{
        module_item(env_1),
        acc
      };
      ::continue:: ;
    end end 
  end;
end end

function statement_list(_env, term_fn, item_fn, _param) do
  while(true) do
    param = _param;
    env = _env;
    stmts = param[2];
    string_tokens = param[1];
    t = Curry._2(Parser_env_Peek.token, nil, env);
    if (type(t) == "number" and t == 105) then do
      return --[[ tuple ]]{
              env,
              string_tokens,
              stmts
            };
    end
     end 
    if (Curry._1(term_fn, t)) then do
      return --[[ tuple ]]{
              env,
              string_tokens,
              stmts
            };
    end else do
      string_token_000 = Curry._2(Parser_env_Peek.loc, nil, env);
      string_token_001 = Curry._2(Parser_env_Peek.token, nil, env);
      string_token = --[[ tuple ]]{
        string_token_000,
        string_token_001
      };
      possible_directive = Curry._1(item_fn, env);
      stmts_1 = --[[ :: ]]{
        possible_directive,
        stmts
      };
      match = possible_directive[2];
      if (type(match) == "number" or match.tag ~= --[[ Expression ]]1) then do
        return --[[ tuple ]]{
                env,
                string_tokens,
                stmts_1
              };
      end else do
        match_1 = match[1].expression;
        match_2 = match_1[2];
        if (type(match_2) == "number" or match_2.tag ~= --[[ Literal ]]19) then do
          return --[[ tuple ]]{
                  env,
                  string_tokens,
                  stmts_1
                };
        end else do
          match_3 = match_2[1].value;
          if (type(match_3) == "number" or match_3.tag) then do
            return --[[ tuple ]]{
                    env,
                    string_tokens,
                    stmts_1
                  };
          end else do
            loc = match_1[1];
            len = loc._end.column - loc.start.column | 0;
            strict = env.in_strict_mode or match_3[1] == "use strict" and len == 12;
            string_tokens_1 = --[[ :: ]]{
              string_token,
              string_tokens
            };
            _param = --[[ tuple ]]{
              string_tokens_1,
              stmts_1
            };
            _env = with_strict(strict, env);
            ::continue:: ;
          end end 
        end end 
      end end 
    end end 
  end;
end end

function directives(env, term_fn, item_fn) do
  match = statement_list(env, term_fn, item_fn, --[[ tuple ]]{
        --[[ [] ]]0,
        --[[ [] ]]0
      });
  env_1 = match[1];
  List.iter((function(param) do
          env_2 = env_1;
          param_1 = param;
          token = param_1[2];
          if (type(token) ~= "number" and token.tag == --[[ T_STRING ]]1) then do
            if (token[1][4]) then do
              return strict_error_at(env_2, --[[ tuple ]]{
                          param_1[1],
                          --[[ StrictOctalLiteral ]]31
                        });
            end else do
              return 0;
            end end 
          end
           end 
          s = "Nooo: " .. (token_to_string(token) .. "\n");
          error({
            Caml_builtin_exceptions.failure,
            s
          })
        end end), List.rev(match[2]));
  return --[[ tuple ]]{
          env_1,
          match[3]
        };
end end

function statement_list_1(term_fn, env) do
  env_1 = env;
  term_fn_1 = term_fn;
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    t = Curry._2(Parser_env_Peek.token, nil, env_1);
    if (type(t) == "number" and t == 105) then do
      return List.rev(acc);
    end
     end 
    if (Curry._1(term_fn_1, t)) then do
      return List.rev(acc);
    end else do
      _acc = --[[ :: ]]{
        statement_list_item(nil, env_1),
        acc
      };
      ::continue:: ;
    end end 
  end;
end end

class_declaration_1 = class_declaration;

function statement_list_with_directives(term_fn, env) do
  match = Curry._3(directives, env, term_fn, (function(eta) do
          return statement_list_item(nil, eta);
        end end));
  env_1 = match[1];
  stmts = Curry._2(statement_list_1, term_fn, env_1);
  stmts_1 = List.fold_left((function(acc, stmt) do
          return --[[ :: ]]{
                  stmt,
                  acc
                };
        end end), stmts, match[2]);
  return --[[ tuple ]]{
          stmts_1,
          env_1.in_strict_mode
        };
end end

function identifier_2(restricted_error, env) do
  loc = Curry._2(Parser_env_Peek.loc, nil, env);
  name = Curry._2(Parser_env_Peek.value, nil, env);
  t = Curry._2(Parser_env_Peek.token, nil, env);
  exit = 0;
  if (type(t) == "number" and t == 26) then do
    if (env.in_strict_mode) then do
      strict_error(env, --[[ StrictReservedWord ]]39);
    end else if (env.no_let) then do
      error_1(env, --[[ UnexpectedToken ]]Block.__(1, {name}));
    end
     end  end 
    token_3(env);
  end else do
    exit = 1;
  end end 
  if (exit == 1) then do
    if (is_strict_reserved(name)) then do
      strict_error(env, --[[ StrictReservedWord ]]39);
      token_3(env);
    end else if (type(t) == "number" and not (t > 62 or t < 58)) then do
      token_4(env, t);
    end else do
      token_4(env, --[[ T_IDENTIFIER ]]0);
    end end  end 
  end
   end 
  if (restricted_error ~= nil) then do
    if (is_restricted(name)) then do
      strict_error_at(env, --[[ tuple ]]{
            loc,
            restricted_error
          });
    end
     end 
  end
   end 
  return --[[ tuple ]]{
          loc,
          {
            name = name,
            typeAnnotation = nil,
            optional = false
          }
        };
end end

function module_body_with_directives(env, term_fn) do
  match = Curry._3(directives, env, term_fn, module_item);
  stmts = Curry._2(module_body, term_fn, match[1]);
  return List.fold_left((function(acc, stmt) do
                return --[[ :: ]]{
                        stmt,
                        acc
                      };
              end end), stmts, match[2]);
end end

function program(env) do
  stmts = module_body_with_directives(env, (function(param) do
          return false;
        end end));
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_EOF ]]105);
  loc = stmts and btwn(List.hd(stmts)[1], List.hd(List.rev(stmts))[1]) or end_loc;
  comments = List.rev(env.comments.contents);
  return --[[ tuple ]]{
          loc,
          stmts,
          comments
        };
end end

function expression_1(env) do
  expr = Curry._1(assignment, env);
  match = Curry._2(Parser_env_Peek.token, nil, env);
  if (type(match) == "number" and match == 8) then do
    return sequence(env, --[[ :: ]]{
                expr,
                --[[ [] ]]0
              });
  end else do
    return expr;
  end end 
end end

function identifier_with_type(env, restricted_error) do
  match = identifier_2(restricted_error, env);
  id = match[2];
  loc = match[1];
  match_1;
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_PLING ]]76) then do
    if (not env.parse_options.types) then do
      error_1(env, --[[ UnexpectedTypeAnnotation ]]6);
    end
     end 
    loc_1 = btwn(loc, Curry._2(Parser_env_Peek.loc, nil, env));
    token_4(env, --[[ T_PLING ]]76);
    match_1 = --[[ tuple ]]{
      loc_1,
      {
        name = id.name,
        typeAnnotation = id.typeAnnotation,
        optional = true
      }
    };
  end else do
    match_1 = --[[ tuple ]]{
      loc,
      id
    };
  end end 
  id_1 = match_1[2];
  loc_2 = match_1[1];
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_COLON ]]77) then do
    typeAnnotation = wrap(annotation, env);
    loc_3 = btwn(loc_2, typeAnnotation[1]);
    typeAnnotation_1 = typeAnnotation;
    return --[[ tuple ]]{
            loc_3,
            {
              name = id_1.name,
              typeAnnotation = typeAnnotation_1,
              optional = id_1.optional
            }
          };
  end else do
    return --[[ tuple ]]{
            loc_2,
            id_1
          };
  end end 
end end

function block_body(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  term_fn = function(t) do
    return t == --[[ T_RCURLY ]]2;
  end end;
  body = Curry._2(statement_list_1, term_fn, env);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            body = body
          }
        };
end end

function function_block_body(env) do
  start_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_LCURLY ]]1);
  term_fn = function(t) do
    return t == --[[ T_RCURLY ]]2;
  end end;
  match = statement_list_with_directives(term_fn, env);
  end_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  token_4(env, --[[ T_RCURLY ]]2);
  return --[[ tuple ]]{
          btwn(start_loc, end_loc),
          {
            body = match[1]
          },
          match[2]
        };
end end

function predicate(env) do
  checks_loc = Curry._2(Parser_env_Peek.loc, nil, env);
  if (Curry._2(Parser_env_Peek.token, nil, env) == --[[ T_IDENTIFIER ]]0 and Curry._2(Parser_env_Peek.value, nil, env) == "checks") then do
    token_4(env, --[[ T_IDENTIFIER ]]0);
    if (maybe(env, --[[ T_LPAREN ]]3)) then do
      exp = Curry._1(Parse.expression, env);
      rparen_loc = Curry._2(Parser_env_Peek.loc, nil, env);
      token_4(env, --[[ T_RPAREN ]]4);
      loc = btwn(checks_loc, rparen_loc);
      return --[[ tuple ]]{
              loc,
              --[[ Declared ]]{exp}
            };
    end else do
      return --[[ tuple ]]{
              checks_loc,
              --[[ Inferred ]]0
            };
    end end 
  end
   end 
end end

Caml_module.update_mod(--[[ Module ]]Block.__(0, {{
          --[[ tuple ]]{
            --[[ Function ]]0,
            "program"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list_item"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "statement_list_with_directives"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "module_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "expression"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "assignment"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "object_initializer"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "array_initializer"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier_or_reserved_keyword"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "identifier_with_type"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "block_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "function_block_body"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "jsx_element"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "pattern"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "pattern_from_expr"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "object_key"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "class_declaration"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "class_expression"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "is_assignable_lhs"
          },
          --[[ tuple ]]{
            --[[ Function ]]0,
            "predicate"
          }
        }}), Parse, {
      program = program,
      statement = statement,
      statement_list_item = statement_list_item,
      statement_list = statement_list_1,
      statement_list_with_directives = statement_list_with_directives,
      module_body = module_body,
      expression = expression_1,
      assignment = assignment,
      object_initializer = _initializer,
      array_initializer = array_initializer,
      identifier = identifier_2,
      identifier_or_reserved_keyword = identifier_or_reserved_keyword,
      identifier_with_type = identifier_with_type,
      block_body = block_body,
      function_block_body = function_block_body,
      jsx_element = element,
      pattern = pattern_1,
      pattern_from_expr = from_expr,
      object_key = key,
      class_declaration = class_declaration_1,
      class_expression = class_expression,
      is_assignable_lhs = is_assignable_lhs,
      predicate = predicate
    });

function program_1(failOpt, token_sinkOpt, parse_optionsOpt, content) do
  fail = failOpt ~= nil and failOpt or true;
  token_sink = token_sinkOpt ~= nil and Caml_option.valFromOption(token_sinkOpt) or nil;
  parse_options = parse_optionsOpt ~= nil and Caml_option.valFromOption(parse_optionsOpt) or nil;
  fail_1 = fail;
  token_sinkOpt_1 = Caml_option.some(token_sink);
  parse_optionsOpt_1 = Caml_option.some(parse_options);
  filename = nil;
  content_1 = content;
  token_sink_1 = token_sinkOpt_1 ~= nil and Caml_option.valFromOption(token_sinkOpt_1) or nil;
  parse_options_1 = parse_optionsOpt_1 ~= nil and Caml_option.valFromOption(parse_optionsOpt_1) or nil;
  env = init_env(Caml_option.some(token_sink_1), Caml_option.some(parse_options_1), filename, content_1);
  env_1 = env;
  parser = Parse.program;
  fail_2 = fail_1;
  ast = Curry._1(parser, env_1);
  error_list = filter_duplicate_errors(env_1.errors.contents);
  if (fail_2 and error_list ~= --[[ [] ]]0) then do
    error({
      __Error,
      error_list
    })
  end
   end 
  return --[[ tuple ]]{
          ast,
          error_list
        };
end end

translation_errors = {
  contents = --[[ [] ]]0
};

string = (function (x) {return x;});

bool = (function (x) {x ? 1 : 0;});

obj = (function(arr) {var ret = {}; arr.forEach(function(a) {ret[a[0]]=a[1];}); return ret});

array = (function (x) {return x;});

number_1 = (function (x) {return x;});

__null = null;

function regexp_1(loc, pattern, flags) do
  xpcall(function() do
    return new __RegExp(pattern, flags);
  end end,function(exn) do
    translation_errors.contents = --[[ :: ]]{
      --[[ tuple ]]{
        loc,
        --[[ InvalidRegExp ]]12
      },
      translation_errors.contents
    };
    return new __RegExp("", flags);
  end end)
end end

function parse(content, options) do
  xpcall(function() do
    match = program_1(false, nil, Caml_option.some(nil), content);
    translation_errors.contents = --[[ [] ]]0;
    array_of_list = function(fn, list) do
      return array(__Array.of_list(List.map(fn, list)));
    end end;
    option = function(f, param) do
      if (param ~= nil) then do
        return Curry._1(f, Caml_option.valFromOption(param));
      end else do
        return __null;
      end end 
    end end;
    position = function(p) do
      return obj({
                  --[[ tuple ]]{
                    "line",
                    number_1(p.line)
                  },
                  --[[ tuple ]]{
                    "column",
                    number_1(p.column)
                  }
                });
    end end;
    loc = function(__location) do
      match = __location.source;
      source;
      if (match ~= nil) then do
        match_1 = match;
        source = type(match_1) == "number" and string("(global)") or string(match_1[1]);
      end else do
        source = __null;
      end end 
      return obj({
                  --[[ tuple ]]{
                    "source",
                    source
                  },
                  --[[ tuple ]]{
                    "start",
                    position(__location.start)
                  },
                  --[[ tuple ]]{
                    "end",
                    position(__location._end)
                  }
                });
    end end;
    range = function(__location) do
      return array({
                  number_1(__location.start.offset),
                  number_1(__location._end.offset)
                });
    end end;
    node = function(_type, __location, props) do
      return obj(__Array.append({
                      --[[ tuple ]]{
                        "type",
                        string(_type)
                      },
                      --[[ tuple ]]{
                        "loc",
                        loc(__location)
                      },
                      --[[ tuple ]]{
                        "range",
                        range(__location)
                      }
                    }, props));
    end end;
    errors = function(l) do
      error_2 = function(param) do
        return obj({
                    --[[ tuple ]]{
                      "loc",
                      loc(param[1])
                    },
                    --[[ tuple ]]{
                      "message",
                      string(error(param[2]))
                    }
                  });
      end end;
      return array_of_list(error_2, l);
    end end;
    _type = function(param) do
      t = param[2];
      loc = param[1];
      if (type(t) == "number") then do
        local ___conditional___=(t);
        do
           if ___conditional___ == 0--[[ Any ]] then do
              loc_1 = loc;
              return node("AnyTypeAnnotation", loc_1, {}); end end 
           if ___conditional___ == 1--[[ Void ]] then do
              loc_2 = loc;
              return node("VoidTypeAnnotation", loc_2, {}); end end 
           if ___conditional___ == 2--[[ Null ]] then do
              loc_3 = loc;
              return node("NullTypeAnnotation", loc_3, {}); end end 
           if ___conditional___ == 3--[[ Number ]] then do
              loc_4 = loc;
              return node("NumberTypeAnnotation", loc_4, {}); end end 
           if ___conditional___ == 4--[[ String ]] then do
              loc_5 = loc;
              return node("StringTypeAnnotation", loc_5, {}); end end 
           if ___conditional___ == 5--[[ Boolean ]] then do
              loc_6 = loc;
              return node("BooleanTypeAnnotation", loc_6, {}); end end 
           if ___conditional___ == 6--[[ Exists ]] then do
              loc_7 = loc;
              return node("ExistsTypeAnnotation", loc_7, {}); end end 
          
        end
      end else do
        local ___conditional___=(t.tag | 0);
        do
           if ___conditional___ == 0--[[ Nullable ]] then do
              loc_8 = loc;
              t_1 = t[1];
              return node("NullableTypeAnnotation", loc_8, {--[[ tuple ]]{
                            "typeAnnotation",
                            _type(t_1)
                          }}); end end 
           if ___conditional___ == 1--[[ Function ]] then do
              return function_type(--[[ tuple ]]{
                          loc,
                          t[1]
                        }); end end 
           if ___conditional___ == 2--[[ Object ]] then do
              return object_type(--[[ tuple ]]{
                          loc,
                          t[1]
                        }); end end 
           if ___conditional___ == 3--[[ Array ]] then do
              loc_9 = loc;
              t_2 = t[1];
              return node("ArrayTypeAnnotation", loc_9, {--[[ tuple ]]{
                            "elementType",
                            _type(t_2)
                          }}); end end 
           if ___conditional___ == 4--[[ Generic ]] then do
              param_1 = --[[ tuple ]]{
                loc,
                t[1]
              };
              g = param_1[2];
              match = g.id;
              id;
              id = match.tag and generic_type_qualified_identifier(match[1]) or identifier(match[1]);
              return node("GenericTypeAnnotation", param_1[1], {
                          --[[ tuple ]]{
                            "id",
                            id
                          },
                          --[[ tuple ]]{
                            "typeParameters",
                            option(type_parameter_instantiation, g.typeParameters)
                          }
                        }); end end 
           if ___conditional___ == 5--[[ Union ]] then do
              param_2 = --[[ tuple ]]{
                loc,
                t[1]
              };
              return node("UnionTypeAnnotation", param_2[1], {--[[ tuple ]]{
                            "types",
                            array_of_list(_type, param_2[2])
                          }}); end end 
           if ___conditional___ == 6--[[ Intersection ]] then do
              param_3 = --[[ tuple ]]{
                loc,
                t[1]
              };
              return node("IntersectionTypeAnnotation", param_3[1], {--[[ tuple ]]{
                            "types",
                            array_of_list(_type, param_3[2])
                          }}); end end 
           if ___conditional___ == 7--[[ Typeof ]] then do
              param_4 = --[[ tuple ]]{
                loc,
                t[1]
              };
              return node("TypeofTypeAnnotation", param_4[1], {--[[ tuple ]]{
                            "argument",
                            _type(param_4[2])
                          }}); end end 
           if ___conditional___ == 8--[[ Tuple ]] then do
              param_5 = --[[ tuple ]]{
                loc,
                t[1]
              };
              return node("TupleTypeAnnotation", param_5[1], {--[[ tuple ]]{
                            "types",
                            array_of_list(_type, param_5[2])
                          }}); end end 
           if ___conditional___ == 9--[[ StringLiteral ]] then do
              param_6 = --[[ tuple ]]{
                loc,
                t[1]
              };
              s = param_6[2];
              return node("StringLiteralTypeAnnotation", param_6[1], {
                          --[[ tuple ]]{
                            "value",
                            string(s.value)
                          },
                          --[[ tuple ]]{
                            "raw",
                            string(s.raw)
                          }
                        }); end end 
           if ___conditional___ == 10--[[ NumberLiteral ]] then do
              param_7 = --[[ tuple ]]{
                loc,
                t[1]
              };
              s_1 = param_7[2];
              return node("NumberLiteralTypeAnnotation", param_7[1], {
                          --[[ tuple ]]{
                            "value",
                            number_1(s_1.value)
                          },
                          --[[ tuple ]]{
                            "raw",
                            string(s_1.raw)
                          }
                        }); end end 
           if ___conditional___ == 11--[[ BooleanLiteral ]] then do
              param_8 = --[[ tuple ]]{
                loc,
                t[1]
              };
              s_2 = param_8[2];
              return node("BooleanLiteralTypeAnnotation", param_8[1], {
                          --[[ tuple ]]{
                            "value",
                            bool(s_2.value)
                          },
                          --[[ tuple ]]{
                            "raw",
                            string(s_2.raw)
                          }
                        }); end end 
          
        end
      end end 
    end end;
    type_annotation = function(param) do
      return node("TypeAnnotation", param[1], {--[[ tuple ]]{
                    "typeAnnotation",
                    _type(param[2])
                  }});
    end end;
    identifier = function(param) do
      id = param[2];
      return node("Identifier", param[1], {
                  --[[ tuple ]]{
                    "name",
                    string(id.name)
                  },
                  --[[ tuple ]]{
                    "typeAnnotation",
                    option(type_annotation, id.typeAnnotation)
                  },
                  --[[ tuple ]]{
                    "optional",
                    bool(id.optional)
                  }
                });
    end end;
    object_type = function(param) do
      o = param[2];
      return node("ObjectTypeAnnotation", param[1], {
                  --[[ tuple ]]{
                    "properties",
                    array_of_list(object_type_property, o.properties)
                  },
                  --[[ tuple ]]{
                    "indexers",
                    array_of_list(object_type_indexer, o.indexers)
                  },
                  --[[ tuple ]]{
                    "callProperties",
                    array_of_list(object_type_call_property, o.callProperties)
                  }
                });
    end end;
    interface_extends = function(param) do
      g = param[2];
      match = g.id;
      id;
      id = match.tag and generic_type_qualified_identifier(match[1]) or identifier(match[1]);
      return node("InterfaceExtends", param[1], {
                  --[[ tuple ]]{
                    "id",
                    id
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_instantiation, g.typeParameters)
                  }
                });
    end end;
    type_parameter_declaration = function(param) do
      return node("TypeParameterDeclaration", param[1], {--[[ tuple ]]{
                    "params",
                    array_of_list(type_param, param[2].params)
                  }});
    end end;
    template_literal = function(param) do
      value = param[2];
      return node("TemplateLiteral", param[1], {
                  --[[ tuple ]]{
                    "quasis",
                    array_of_list(template_element, value.quasis)
                  },
                  --[[ tuple ]]{
                    "expressions",
                    array_of_list(expression, value.expressions)
                  }
                });
    end end;
    expression = function(param) do
      match = param[2];
      loc = param[1];
      if (type(match) == "number") then do
        return node("ThisExpression", loc, {});
      end else do
        local ___conditional___=(match.tag | 0);
        do
           if ___conditional___ == 0--[[ Array ]] then do
              return node("ArrayExpression", loc, {--[[ tuple ]]{
                            "elements",
                            array_of_list((function(param) do
                                    return option(expression_or_spread, param);
                                  end end), match[1].elements)
                          }}); end end 
           if ___conditional___ == 1--[[ Object ]] then do
              return node("ObjectExpression", loc, {--[[ tuple ]]{
                            "properties",
                            array_of_list(object_property, match[1].properties)
                          }}); end end 
           if ___conditional___ == 2--[[ Function ]] then do
              return function_expression(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 3--[[ ArrowFunction ]] then do
              arrow = match[1];
              match_1 = arrow.body;
              body;
              body = match_1.tag and expression(match_1[1]) or block(match_1[1]);
              return node("ArrowFunctionExpression", loc, {
                          --[[ tuple ]]{
                            "id",
                            option(identifier, arrow.id)
                          },
                          --[[ tuple ]]{
                            "params",
                            array_of_list(pattern, arrow.params)
                          },
                          --[[ tuple ]]{
                            "defaults",
                            array_of_list((function(param) do
                                    return option(expression, param);
                                  end end), arrow.defaults)
                          },
                          --[[ tuple ]]{
                            "rest",
                            option(identifier, arrow.rest)
                          },
                          --[[ tuple ]]{
                            "body",
                            body
                          },
                          --[[ tuple ]]{
                            "async",
                            bool(arrow.async)
                          },
                          --[[ tuple ]]{
                            "generator",
                            bool(arrow.generator)
                          },
                          --[[ tuple ]]{
                            "expression",
                            bool(arrow.expression)
                          },
                          --[[ tuple ]]{
                            "returnType",
                            option(type_annotation, arrow.returnType)
                          },
                          --[[ tuple ]]{
                            "typeParameters",
                            option(type_parameter_declaration, arrow.typeParameters)
                          }
                        }); end end 
           if ___conditional___ == 4--[[ Sequence ]] then do
              return node("SequenceExpression", loc, {--[[ tuple ]]{
                            "expressions",
                            array_of_list(expression, match[1].expressions)
                          }}); end end 
           if ___conditional___ == 5--[[ Unary ]] then do
              unary = match[1];
              match_2 = unary.operator;
              if (match_2 >= 7) then do
                return node("AwaitExpression", loc, {--[[ tuple ]]{
                              "argument",
                              expression(unary.argument)
                            }});
              end else do
                match_3 = unary.operator;
                operator;
                local ___conditional___=(match_3);
                do
                   if ___conditional___ == 0--[[ Minus ]] then do
                      operator = "-"; end else 
                   if ___conditional___ == 1--[[ Plus ]] then do
                      operator = "+"; end else 
                   if ___conditional___ == 2--[[ Not ]] then do
                      operator = "!"; end else 
                   if ___conditional___ == 3--[[ BitNot ]] then do
                      operator = "~"; end else 
                   if ___conditional___ == 4--[[ Typeof ]] then do
                      operator = "typeof"; end else 
                   if ___conditional___ == 5--[[ Void ]] then do
                      operator = "void"; end else 
                   if ___conditional___ == 6--[[ Delete ]] then do
                      operator = "delete"; end else 
                   if ___conditional___ == 7--[[ Await ]] then do
                      error({
                        Caml_builtin_exceptions.failure,
                        "matched above"
                      }) end end end end end end end end end end end end end end end end 
                  
                end
                return node("UnaryExpression", loc, {
                            --[[ tuple ]]{
                              "operator",
                              string(operator)
                            },
                            --[[ tuple ]]{
                              "prefix",
                              bool(unary.prefix)
                            },
                            --[[ tuple ]]{
                              "argument",
                              expression(unary.argument)
                            }
                          });
              end end  end end 
           if ___conditional___ == 6--[[ Binary ]] then do
              binary = match[1];
              match_4 = binary.operator;
              operator_1;
              local ___conditional___=(match_4);
              do
                 if ___conditional___ == 0--[[ Equal ]] then do
                    operator_1 = "=="; end else 
                 if ___conditional___ == 1--[[ NotEqual ]] then do
                    operator_1 = "!="; end else 
                 if ___conditional___ == 2--[[ StrictEqual ]] then do
                    operator_1 = "==="; end else 
                 if ___conditional___ == 3--[[ StrictNotEqual ]] then do
                    operator_1 = "!=="; end else 
                 if ___conditional___ == 4--[[ LessThan ]] then do
                    operator_1 = "<"; end else 
                 if ___conditional___ == 5--[[ LessThanEqual ]] then do
                    operator_1 = "<="; end else 
                 if ___conditional___ == 6--[[ GreaterThan ]] then do
                    operator_1 = ">"; end else 
                 if ___conditional___ == 7--[[ GreaterThanEqual ]] then do
                    operator_1 = ">="; end else 
                 if ___conditional___ == 8--[[ LShift ]] then do
                    operator_1 = "<<"; end else 
                 if ___conditional___ == 9--[[ RShift ]] then do
                    operator_1 = ">>"; end else 
                 if ___conditional___ == 10--[[ RShift3 ]] then do
                    operator_1 = ">>>"; end else 
                 if ___conditional___ == 11--[[ Plus ]] then do
                    operator_1 = "+"; end else 
                 if ___conditional___ == 12--[[ Minus ]] then do
                    operator_1 = "-"; end else 
                 if ___conditional___ == 13--[[ Mult ]] then do
                    operator_1 = "*"; end else 
                 if ___conditional___ == 15--[[ Div ]] then do
                    operator_1 = "/"; end else 
                 if ___conditional___ == 16--[[ Mod ]] then do
                    operator_1 = "%"; end else 
                 if ___conditional___ == 17--[[ BitOr ]] then do
                    operator_1 = "|"; end else 
                 if ___conditional___ == 14--[[ Exp ]]
                 or ___conditional___ == 18--[[ Xor ]] then do
                    operator_1 = "^"; end else 
                 if ___conditional___ == 19--[[ BitAnd ]] then do
                    operator_1 = "&"; end else 
                 if ___conditional___ == 20--[[ In ]] then do
                    operator_1 = "in"; end else 
                 if ___conditional___ == 21--[[ Instanceof ]] then do
                    operator_1 = "instanceof"; end else 
                 end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end end
                
              end
              return node("BinaryExpression", loc, {
                          --[[ tuple ]]{
                            "operator",
                            string(operator_1)
                          },
                          --[[ tuple ]]{
                            "left",
                            expression(binary.left)
                          },
                          --[[ tuple ]]{
                            "right",
                            expression(binary.right)
                          }
                        }); end end 
           if ___conditional___ == 7--[[ Assignment ]] then do
              assignment = match[1];
              match_5 = assignment.operator;
              operator_2;
              local ___conditional___=(match_5);
              do
                 if ___conditional___ == 0--[[ Assign ]] then do
                    operator_2 = "="; end else 
                 if ___conditional___ == 1--[[ PlusAssign ]] then do
                    operator_2 = "+="; end else 
                 if ___conditional___ == 2--[[ MinusAssign ]] then do
                    operator_2 = "-="; end else 
                 if ___conditional___ == 3--[[ MultAssign ]] then do
                    operator_2 = "*="; end else 
                 if ___conditional___ == 4--[[ ExpAssign ]] then do
                    operator_2 = "**="; end else 
                 if ___conditional___ == 5--[[ DivAssign ]] then do
                    operator_2 = "/="; end else 
                 if ___conditional___ == 6--[[ ModAssign ]] then do
                    operator_2 = "%="; end else 
                 if ___conditional___ == 7--[[ LShiftAssign ]] then do
                    operator_2 = "<<="; end else 
                 if ___conditional___ == 8--[[ RShiftAssign ]] then do
                    operator_2 = ">>="; end else 
                 if ___conditional___ == 9--[[ RShift3Assign ]] then do
                    operator_2 = ">>>="; end else 
                 if ___conditional___ == 10--[[ BitOrAssign ]] then do
                    operator_2 = "|="; end else 
                 if ___conditional___ == 11--[[ BitXorAssign ]] then do
                    operator_2 = "^="; end else 
                 if ___conditional___ == 12--[[ BitAndAssign ]] then do
                    operator_2 = "&="; end else 
                 end end end end end end end end end end end end end end end end end end end end end end end end end end
                
              end
              return node("AssignmentExpression", loc, {
                          --[[ tuple ]]{
                            "operator",
                            string(operator_2)
                          },
                          --[[ tuple ]]{
                            "left",
                            pattern(assignment.left)
                          },
                          --[[ tuple ]]{
                            "right",
                            expression(assignment.right)
                          }
                        }); end end 
           if ___conditional___ == 8--[[ Update ]] then do
              update = match[1];
              match_6 = update.operator;
              operator_3 = match_6 and "--" or "++";
              return node("UpdateExpression", loc, {
                          --[[ tuple ]]{
                            "operator",
                            string(operator_3)
                          },
                          --[[ tuple ]]{
                            "argument",
                            expression(update.argument)
                          },
                          --[[ tuple ]]{
                            "prefix",
                            bool(update.prefix)
                          }
                        }); end end 
           if ___conditional___ == 9--[[ Logical ]] then do
              logical = match[1];
              match_7 = logical.operator;
              operator_4 = match_7 and "and" or "or";
              return node("LogicalExpression", loc, {
                          --[[ tuple ]]{
                            "operator",
                            string(operator_4)
                          },
                          --[[ tuple ]]{
                            "left",
                            expression(logical.left)
                          },
                          --[[ tuple ]]{
                            "right",
                            expression(logical.right)
                          }
                        }); end end 
           if ___conditional___ == 10--[[ Conditional ]] then do
              conditional = match[1];
              return node("ConditionalExpression", loc, {
                          --[[ tuple ]]{
                            "test",
                            expression(conditional.test)
                          },
                          --[[ tuple ]]{
                            "consequent",
                            expression(conditional.consequent)
                          },
                          --[[ tuple ]]{
                            "alternate",
                            expression(conditional.alternate)
                          }
                        }); end end 
           if ___conditional___ == 11--[[ New ]] then do
              _new = match[1];
              return node("NewExpression", loc, {
                          --[[ tuple ]]{
                            "callee",
                            expression(_new.callee)
                          },
                          --[[ tuple ]]{
                            "arguments",
                            array_of_list(expression_or_spread, _new.__arguments)
                          }
                        }); end end 
           if ___conditional___ == 12--[[ Call ]] then do
              call = match[1];
              return node("CallExpression", loc, {
                          --[[ tuple ]]{
                            "callee",
                            expression(call.callee)
                          },
                          --[[ tuple ]]{
                            "arguments",
                            array_of_list(expression_or_spread, call.__arguments)
                          }
                        }); end end 
           if ___conditional___ == 13--[[ Member ]] then do
              member = match[1];
              match_8 = member.property;
              property;
              property = match_8.tag and expression(match_8[1]) or identifier(match_8[1]);
              return node("MemberExpression", loc, {
                          --[[ tuple ]]{
                            "object",
                            expression(member._object)
                          },
                          --[[ tuple ]]{
                            "property",
                            property
                          },
                          --[[ tuple ]]{
                            "computed",
                            bool(member.computed)
                          }
                        }); end end 
           if ___conditional___ == 14--[[ Yield ]] then do
              __yield = match[1];
              return node("YieldExpression", loc, {
                          --[[ tuple ]]{
                            "argument",
                            option(expression, __yield.argument)
                          },
                          --[[ tuple ]]{
                            "delegate",
                            bool(__yield.delegate)
                          }
                        }); end end 
           if ___conditional___ == 15--[[ Comprehension ]] then do
              comp = match[1];
              return node("ComprehensionExpression", loc, {
                          --[[ tuple ]]{
                            "blocks",
                            array_of_list(comprehension_block, comp.blocks)
                          },
                          --[[ tuple ]]{
                            "filter",
                            option(expression, comp.filter)
                          }
                        }); end end 
           if ___conditional___ == 16--[[ Generator ]] then do
              gen = match[1];
              return node("GeneratorExpression", loc, {
                          --[[ tuple ]]{
                            "blocks",
                            array_of_list(comprehension_block, gen.blocks)
                          },
                          --[[ tuple ]]{
                            "filter",
                            option(expression, gen.filter)
                          }
                        }); end end 
           if ___conditional___ == 17--[[ Let ]] then do
              _let = match[1];
              return node("LetExpression", loc, {
                          --[[ tuple ]]{
                            "head",
                            array_of_list(let_assignment, _let.head)
                          },
                          --[[ tuple ]]{
                            "body",
                            expression(_let.body)
                          }
                        }); end end 
           if ___conditional___ == 18--[[ Identifier ]] then do
              return identifier(match[1]); end end 
           if ___conditional___ == 19--[[ Literal ]] then do
              return literal(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 20--[[ TemplateLiteral ]] then do
              return template_literal(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 21--[[ TaggedTemplate ]] then do
              param_1 = --[[ tuple ]]{
                loc,
                match[1]
              };
              tagged = param_1[2];
              return node("TaggedTemplateExpression", param_1[1], {
                          --[[ tuple ]]{
                            "tag",
                            expression(tagged.tag)
                          },
                          --[[ tuple ]]{
                            "quasi",
                            template_literal(tagged.quasi)
                          }
                        }); end end 
           if ___conditional___ == 22--[[ JSXElement ]] then do
              return jsx_element(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 23--[[ Class ]] then do
              param_2 = --[[ tuple ]]{
                loc,
                match[1]
              };
              c = param_2[2];
              return node("ClassExpression", param_2[1], {
                          --[[ tuple ]]{
                            "id",
                            option(identifier, c.id)
                          },
                          --[[ tuple ]]{
                            "body",
                            class_body(c.body)
                          },
                          --[[ tuple ]]{
                            "superClass",
                            option(expression, c.superClass)
                          },
                          --[[ tuple ]]{
                            "typeParameters",
                            option(type_parameter_declaration, c.typeParameters)
                          },
                          --[[ tuple ]]{
                            "superTypeParameters",
                            option(type_parameter_instantiation, c.superTypeParameters)
                          },
                          --[[ tuple ]]{
                            "implements",
                            array_of_list(class_implements, c.__implements)
                          },
                          --[[ tuple ]]{
                            "decorators",
                            array_of_list(expression, c.classDecorators)
                          }
                        }); end end 
           if ___conditional___ == 24--[[ TypeCast ]] then do
              typecast = match[1];
              return node("TypeCastExpression", loc, {
                          --[[ tuple ]]{
                            "expression",
                            expression(typecast.expression)
                          },
                          --[[ tuple ]]{
                            "typeAnnotation",
                            type_annotation(typecast.typeAnnotation)
                          }
                        }); end end 
          
        end
      end end 
    end end;
    jsx_opening_attribute = function(param) do
      if (param.tag) then do
        param_1 = param[1];
        return node("JSXSpreadAttribute", param_1[1], {--[[ tuple ]]{
                      "argument",
                      expression(param_1[2].argument)
                    }});
      end else do
        param_2 = param[1];
        attribute = param_2[2];
        match = attribute.name;
        name;
        name = match.tag and jsx_namespaced_name(match[1]) or jsx_identifier(match[1]);
        return node("JSXAttribute", param_2[1], {
                    --[[ tuple ]]{
                      "name",
                      name
                    },
                    --[[ tuple ]]{
                      "value",
                      option(jsx_attribute_value, attribute.value)
                    }
                  });
      end end 
    end end;
    jsx_name = function(param) do
      local ___conditional___=(param.tag | 0);
      do
         if ___conditional___ == 0--[[ Identifier ]] then do
            return jsx_identifier(param[1]); end end 
         if ___conditional___ == 1--[[ NamespacedName ]] then do
            return jsx_namespaced_name(param[1]); end end 
         if ___conditional___ == 2--[[ MemberExpression ]] then do
            return jsx_member_expression(param[1]); end end 
        
      end
    end end;
    literal = function(param) do
      lit = param[2];
      raw = lit.raw;
      value = lit.value;
      loc = param[1];
      value_;
      if (type(value) == "number") then do
        value_ = __null;
      end else do
        local ___conditional___=(value.tag | 0);
        do
           if ___conditional___ == 0--[[ String ]] then do
              value_ = string(value[1]); end else 
           if ___conditional___ == 1--[[ Boolean ]] then do
              value_ = bool(value[1]); end else 
           if ___conditional___ == 2--[[ Number ]] then do
              value_ = number_1(value[1]); end else 
           if ___conditional___ == 3--[[ RegExp ]] then do
              match = value[1];
              value_ = regexp_1(loc, match.pattern, match.flags); end else 
           end end end end end end end end
          
        end
      end end 
      props;
      exit = 0;
      if (type(value) == "number" or value.tag ~= --[[ RegExp ]]3) then do
        exit = 1;
      end else do
        match_1 = value[1];
        regex = obj({
              --[[ tuple ]]{
                "pattern",
                string(match_1.pattern)
              },
              --[[ tuple ]]{
                "flags",
                string(match_1.flags)
              }
            });
        props = {
          --[[ tuple ]]{
            "value",
            value_
          },
          --[[ tuple ]]{
            "raw",
            string(raw)
          },
          --[[ tuple ]]{
            "regex",
            regex
          }
        };
      end end 
      if (exit == 1) then do
        props = {
          --[[ tuple ]]{
            "value",
            value_
          },
          --[[ tuple ]]{
            "raw",
            string(raw)
          }
        };
      end
       end 
      return node("Literal", loc, props);
    end end;
    jsx_expression_container = function(param) do
      match = param[2].expression;
      expression_1;
      expression_1 = match.tag and node("JSXEmptyExpression", match[1], {}) or expression(match[1]);
      return node("JSXExpressionContainer", param[1], {--[[ tuple ]]{
                    "expression",
                    expression_1
                  }});
    end end;
    jsx_namespaced_name = function(param) do
      namespaced_name = param[2];
      return node("JSXNamespacedName", param[1], {
                  --[[ tuple ]]{
                    "namespace",
                    jsx_identifier(namespaced_name.namespace)
                  },
                  --[[ tuple ]]{
                    "name",
                    jsx_identifier(namespaced_name.name)
                  }
                });
    end end;
    jsx_identifier = function(param) do
      return node("JSXIdentifier", param[1], {--[[ tuple ]]{
                    "name",
                    string(param[2].name)
                  }});
    end end;
    jsx_member_expression = function(param) do
      member_expression = param[2];
      match = member_expression._object;
      _object;
      _object = match.tag and jsx_member_expression(match[1]) or jsx_identifier(match[1]);
      return node("JSXMemberExpression", param[1], {
                  --[[ tuple ]]{
                    "object",
                    _object
                  },
                  --[[ tuple ]]{
                    "property",
                    jsx_identifier(member_expression.property)
                  }
                });
    end end;
    type_parameter_instantiation = function(param) do
      return node("TypeParameterInstantiation", param[1], {--[[ tuple ]]{
                    "params",
                    array_of_list(_type, param[2].params)
                  }});
    end end;
    generic_type_qualified_identifier = function(param) do
      q = param[2];
      match = q.qualification;
      qualification;
      qualification = match.tag and generic_type_qualified_identifier(match[1]) or identifier(match[1]);
      return node("QualifiedTypeIdentifier", param[1], {
                  --[[ tuple ]]{
                    "qualification",
                    qualification
                  },
                  --[[ tuple ]]{
                    "id",
                    identifier(q.id)
                  }
                });
    end end;
    object_type_indexer = function(param) do
      indexer = param[2];
      return node("ObjectTypeIndexer", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(indexer.id)
                  },
                  --[[ tuple ]]{
                    "key",
                    _type(indexer.key)
                  },
                  --[[ tuple ]]{
                    "value",
                    _type(indexer.value)
                  },
                  --[[ tuple ]]{
                    "static",
                    bool(indexer.__static)
                  }
                });
    end end;
    object_type_call_property = function(param) do
      callProperty = param[2];
      return node("ObjectTypeCallProperty", param[1], {
                  --[[ tuple ]]{
                    "value",
                    function_type(callProperty.value)
                  },
                  --[[ tuple ]]{
                    "static",
                    bool(callProperty.__static)
                  }
                });
    end end;
    object_type_property = function(param) do
      prop = param[2];
      match = prop.key;
      key;
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ Literal ]] then do
            key = literal(match[1]); end else 
         if ___conditional___ == 1--[[ Identifier ]] then do
            key = identifier(match[1]); end else 
         if ___conditional___ == 2--[[ Computed ]] then do
            error({
              Caml_builtin_exceptions.failure,
              "There should not be computed object type property keys"
            }) end end end end end end 
        
      end
      return node("ObjectTypeProperty", param[1], {
                  --[[ tuple ]]{
                    "key",
                    key
                  },
                  --[[ tuple ]]{
                    "value",
                    _type(prop.value)
                  },
                  --[[ tuple ]]{
                    "optional",
                    bool(prop.optional)
                  },
                  --[[ tuple ]]{
                    "static",
                    bool(prop.__static)
                  }
                });
    end end;
    pattern = function(param) do
      match = param[2];
      loc = param[1];
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ Object ]] then do
            obj = match[1];
            return node("ObjectPattern", loc, {
                        --[[ tuple ]]{
                          "properties",
                          array_of_list(object_pattern_property, obj.properties)
                        },
                        --[[ tuple ]]{
                          "typeAnnotation",
                          option(type_annotation, obj.typeAnnotation)
                        }
                      }); end end 
         if ___conditional___ == 1--[[ Array ]] then do
            arr = match[1];
            return node("ArrayPattern", loc, {
                        --[[ tuple ]]{
                          "elements",
                          array_of_list((function(param) do
                                  return option(array_pattern_element, param);
                                end end), arr.elements)
                        },
                        --[[ tuple ]]{
                          "typeAnnotation",
                          option(type_annotation, arr.typeAnnotation)
                        }
                      }); end end 
         if ___conditional___ == 2--[[ Assignment ]] then do
            match_1 = match[1];
            return node("AssignmentPattern", loc, {
                        --[[ tuple ]]{
                          "left",
                          pattern(match_1.left)
                        },
                        --[[ tuple ]]{
                          "right",
                          expression(match_1.right)
                        }
                      }); end end 
         if ___conditional___ == 3--[[ Identifier ]] then do
            return identifier(match[1]); end end 
         if ___conditional___ == 4--[[ Expression ]] then do
            return expression(match[1]); end end 
        
      end
    end end;
    class_implements = function(param) do
      __implements = param[2];
      return node("ClassImplements", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(__implements.id)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_instantiation, __implements.typeParameters)
                  }
                });
    end end;
    class_body = function(param) do
      return node("ClassBody", param[1], {--[[ tuple ]]{
                    "body",
                    array_of_list(class_element, param[2].body)
                  }});
    end end;
    __catch = function(param) do
      c = param[2];
      return node("CatchClause", param[1], {
                  --[[ tuple ]]{
                    "param",
                    pattern(c.param)
                  },
                  --[[ tuple ]]{
                    "guard",
                    option(expression, c.guard)
                  },
                  --[[ tuple ]]{
                    "body",
                    block(c.body)
                  }
                });
    end end;
    declare_class = function(param) do
      d = param[2];
      return node("DeclareClass", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(d.id)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_declaration, d.typeParameters)
                  },
                  --[[ tuple ]]{
                    "body",
                    object_type(d.body)
                  },
                  --[[ tuple ]]{
                    "extends",
                    array_of_list(interface_extends, d.__extends)
                  }
                });
    end end;
    type_alias = function(param) do
      alias = param[2];
      return node("TypeAlias", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(alias.id)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_declaration, alias.typeParameters)
                  },
                  --[[ tuple ]]{
                    "right",
                    _type(alias.right)
                  }
                });
    end end;
    let_assignment = function(assignment) do
      return obj({
                  --[[ tuple ]]{
                    "id",
                    pattern(assignment.id)
                  },
                  --[[ tuple ]]{
                    "init",
                    option(expression, assignment.init)
                  }
                });
    end end;
    declare_function = function(param) do
      return node("DeclareFunction", param[1], {--[[ tuple ]]{
                    "id",
                    identifier(param[2].id)
                  }});
    end end;
    variable_declaration = function(param) do
      __var = param[2];
      match = __var.kind;
      kind;
      local ___conditional___=(match);
      do
         if ___conditional___ == 0--[[ Var ]] then do
            kind = "var"; end else 
         if ___conditional___ == 1--[[ Let ]] then do
            kind = "let"; end else 
         if ___conditional___ == 2--[[ Const ]] then do
            kind = "const"; end else 
         end end end end end end
        
      end
      return node("VariableDeclaration", param[1], {
                  --[[ tuple ]]{
                    "declarations",
                    array_of_list(variable_declarator, __var.declarations)
                  },
                  --[[ tuple ]]{
                    "kind",
                    string(kind)
                  }
                });
    end end;
    statement = function(param) do
      match = param[2];
      loc = param[1];
      if (type(match) == "number") then do
        if (match == --[[ Empty ]]0) then do
          return node("EmptyStatement", loc, {});
        end else do
          return node("DebuggerStatement", loc, {});
        end end 
      end else do
        local ___conditional___=(match.tag | 0);
        do
           if ___conditional___ == 0--[[ Block ]] then do
              return block(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 1--[[ Expression ]] then do
              return node("ExpressionStatement", loc, {--[[ tuple ]]{
                            "expression",
                            expression(match[1].expression)
                          }}); end end 
           if ___conditional___ == 2--[[ If ]] then do
              _if = match[1];
              return node("IfStatement", loc, {
                          --[[ tuple ]]{
                            "test",
                            expression(_if.test)
                          },
                          --[[ tuple ]]{
                            "consequent",
                            statement(_if.consequent)
                          },
                          --[[ tuple ]]{
                            "alternate",
                            option(statement, _if.alternate)
                          }
                        }); end end 
           if ___conditional___ == 3--[[ Labeled ]] then do
              labeled = match[1];
              return node("LabeledStatement", loc, {
                          --[[ tuple ]]{
                            "label",
                            identifier(labeled.label)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(labeled.body)
                          }
                        }); end end 
           if ___conditional___ == 4--[[ Break ]] then do
              return node("BreakStatement", loc, {--[[ tuple ]]{
                            "label",
                            option(identifier, match[1].label)
                          }}); end end 
           if ___conditional___ == 5--[[ Continue ]] then do
              return node("ContinueStatement", loc, {--[[ tuple ]]{
                            "label",
                            option(identifier, match[1].label)
                          }}); end end 
           if ___conditional___ == 6--[[ With ]] then do
              _with = match[1];
              return node("WithStatement", loc, {
                          --[[ tuple ]]{
                            "object",
                            expression(_with._object)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(_with.body)
                          }
                        }); end end 
           if ___conditional___ == 7--[[ TypeAlias ]] then do
              return type_alias(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 8--[[ Switch ]] then do
              __switch = match[1];
              return node("SwitchStatement", loc, {
                          --[[ tuple ]]{
                            "discriminant",
                            expression(__switch.discriminant)
                          },
                          --[[ tuple ]]{
                            "cases",
                            array_of_list(__case, __switch.cases)
                          },
                          --[[ tuple ]]{
                            "lexical",
                            bool(__switch.lexical)
                          }
                        }); end end 
           if ___conditional___ == 9--[[ Return ]] then do
              return node("ReturnStatement", loc, {--[[ tuple ]]{
                            "argument",
                            option(expression, match[1].argument)
                          }}); end end 
           if ___conditional___ == 10--[[ Throw ]] then do
              return node("ThrowStatement", loc, {--[[ tuple ]]{
                            "argument",
                            expression(match[1].argument)
                          }}); end end 
           if ___conditional___ == 11--[[ Try ]] then do
              _try = match[1];
              return node("TryStatement", loc, {
                          --[[ tuple ]]{
                            "block",
                            block(_try.block)
                          },
                          --[[ tuple ]]{
                            "handler",
                            option(__catch, _try.handler)
                          },
                          --[[ tuple ]]{
                            "guardedHandlers",
                            array_of_list(__catch, _try.guardedHandlers)
                          },
                          --[[ tuple ]]{
                            "finalizer",
                            option(block, _try.finalizer)
                          }
                        }); end end 
           if ___conditional___ == 12--[[ While ]] then do
              _while = match[1];
              return node("WhileStatement", loc, {
                          --[[ tuple ]]{
                            "test",
                            expression(_while.test)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(_while.body)
                          }
                        }); end end 
           if ___conditional___ == 13--[[ DoWhile ]] then do
              dowhile = match[1];
              return node("DoWhileStatement", loc, {
                          --[[ tuple ]]{
                            "body",
                            statement(dowhile.body)
                          },
                          --[[ tuple ]]{
                            "test",
                            expression(dowhile.test)
                          }
                        }); end end 
           if ___conditional___ == 14--[[ For ]] then do
              _for = match[1];
              init = function(param) do
                if (param.tag) then do
                  return expression(param[1]);
                end else do
                  return variable_declaration(param[1]);
                end end 
              end end;
              return node("ForStatement", loc, {
                          --[[ tuple ]]{
                            "init",
                            option(init, _for.init)
                          },
                          --[[ tuple ]]{
                            "test",
                            option(expression, _for.test)
                          },
                          --[[ tuple ]]{
                            "update",
                            option(expression, _for.update)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(_for.body)
                          }
                        }); end end 
           if ___conditional___ == 15--[[ ForIn ]] then do
              forin = match[1];
              match_1 = forin.left;
              left;
              left = match_1.tag and expression(match_1[1]) or variable_declaration(match_1[1]);
              return node("ForInStatement", loc, {
                          --[[ tuple ]]{
                            "left",
                            left
                          },
                          --[[ tuple ]]{
                            "right",
                            expression(forin.right)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(forin.body)
                          },
                          --[[ tuple ]]{
                            "each",
                            bool(forin.each)
                          }
                        }); end end 
           if ___conditional___ == 16--[[ ForOf ]] then do
              forof = match[1];
              match_2 = forof.left;
              left_1;
              left_1 = match_2.tag and expression(match_2[1]) or variable_declaration(match_2[1]);
              return node("ForOfStatement", loc, {
                          --[[ tuple ]]{
                            "left",
                            left_1
                          },
                          --[[ tuple ]]{
                            "right",
                            expression(forof.right)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(forof.body)
                          }
                        }); end end 
           if ___conditional___ == 17--[[ Let ]] then do
              _let = match[1];
              return node("LetStatement", loc, {
                          --[[ tuple ]]{
                            "head",
                            array_of_list(let_assignment, _let.head)
                          },
                          --[[ tuple ]]{
                            "body",
                            statement(_let.body)
                          }
                        }); end end 
           if ___conditional___ == 18--[[ FunctionDeclaration ]] then do
              fn = match[1];
              match_3 = fn.id;
              match_4 = match_3 ~= nil and --[[ tuple ]]{
                  "FunctionDeclaration",
                  identifier(match_3)
                } or --[[ tuple ]]{
                  "FunctionExpression",
                  __null
                };
              match_5 = fn.body;
              body;
              body = match_5.tag and expression(match_5[1]) or block(match_5[1]);
              return node(match_4[1], loc, {
                          --[[ tuple ]]{
                            "id",
                            match_4[2]
                          },
                          --[[ tuple ]]{
                            "params",
                            array_of_list(pattern, fn.params)
                          },
                          --[[ tuple ]]{
                            "defaults",
                            array_of_list((function(param) do
                                    return option(expression, param);
                                  end end), fn.defaults)
                          },
                          --[[ tuple ]]{
                            "rest",
                            option(identifier, fn.rest)
                          },
                          --[[ tuple ]]{
                            "body",
                            body
                          },
                          --[[ tuple ]]{
                            "async",
                            bool(fn.async)
                          },
                          --[[ tuple ]]{
                            "generator",
                            bool(fn.generator)
                          },
                          --[[ tuple ]]{
                            "expression",
                            bool(fn.expression)
                          },
                          --[[ tuple ]]{
                            "returnType",
                            option(type_annotation, fn.returnType)
                          },
                          --[[ tuple ]]{
                            "typeParameters",
                            option(type_parameter_declaration, fn.typeParameters)
                          }
                        }); end end 
           if ___conditional___ == 19--[[ VariableDeclaration ]] then do
              return variable_declaration(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 20--[[ ClassDeclaration ]] then do
              param_1 = --[[ tuple ]]{
                loc,
                match[1]
              };
              c = param_1[2];
              match_6 = c.id;
              match_7 = match_6 ~= nil and --[[ tuple ]]{
                  "ClassDeclaration",
                  identifier(match_6)
                } or --[[ tuple ]]{
                  "ClassExpression",
                  __null
                };
              return node(match_7[1], param_1[1], {
                          --[[ tuple ]]{
                            "id",
                            match_7[2]
                          },
                          --[[ tuple ]]{
                            "body",
                            class_body(c.body)
                          },
                          --[[ tuple ]]{
                            "superClass",
                            option(expression, c.superClass)
                          },
                          --[[ tuple ]]{
                            "typeParameters",
                            option(type_parameter_declaration, c.typeParameters)
                          },
                          --[[ tuple ]]{
                            "superTypeParameters",
                            option(type_parameter_instantiation, c.superTypeParameters)
                          },
                          --[[ tuple ]]{
                            "implements",
                            array_of_list(class_implements, c.__implements)
                          },
                          --[[ tuple ]]{
                            "decorators",
                            array_of_list(expression, c.classDecorators)
                          }
                        }); end end 
           if ___conditional___ == 21--[[ InterfaceDeclaration ]] then do
              return interface_declaration(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 22--[[ DeclareVariable ]] then do
              return declare_variable(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 23--[[ DeclareFunction ]] then do
              return declare_function(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 24--[[ DeclareClass ]] then do
              return declare_class(--[[ tuple ]]{
                          loc,
                          match[1]
                        }); end end 
           if ___conditional___ == 25--[[ DeclareModule ]] then do
              m = match[1];
              match_8 = m.id;
              id;
              id = match_8.tag and literal(match_8[1]) or identifier(match_8[1]);
              match_9 = m.kind;
              tmp;
              tmp = match_9.tag and string("ES") or string("CommonJS");
              return node("DeclareModule", loc, {
                          --[[ tuple ]]{
                            "id",
                            id
                          },
                          --[[ tuple ]]{
                            "body",
                            block(m.body)
                          },
                          --[[ tuple ]]{
                            "kind",
                            tmp
                          }
                        }); end end 
           if ___conditional___ == 26--[[ DeclareModuleExports ]] then do
              return node("DeclareModuleExports", loc, {--[[ tuple ]]{
                            "typeAnnotation",
                            type_annotation(match[1])
                          }}); end end 
           if ___conditional___ == 27--[[ DeclareExportDeclaration ]] then do
              __export = match[1];
              match_10 = __export.declaration;
              declaration;
              if (match_10 ~= nil) then do
                match_11 = match_10;
                local ___conditional___=(match_11.tag | 0);
                do
                   if ___conditional___ == 0--[[ Variable ]] then do
                      declaration = declare_variable(match_11[1]); end else 
                   if ___conditional___ == 1--[[ Function ]] then do
                      declaration = declare_function(match_11[1]); end else 
                   if ___conditional___ == 2--[[ Class ]] then do
                      declaration = declare_class(match_11[1]); end else 
                   if ___conditional___ == 3--[[ DefaultType ]] then do
                      declaration = _type(match_11[1]); end else 
                   if ___conditional___ == 4--[[ NamedType ]] then do
                      declaration = type_alias(match_11[1]); end else 
                   if ___conditional___ == 5--[[ Interface ]] then do
                      declaration = interface_declaration(match_11[1]); end else 
                   end end end end end end end end end end end end
                  
                end
              end else do
                declaration = __null;
              end end 
              return node("DeclareExportDeclaration", loc, {
                          --[[ tuple ]]{
                            "default",
                            bool(__export.__default)
                          },
                          --[[ tuple ]]{
                            "declaration",
                            declaration
                          },
                          --[[ tuple ]]{
                            "specifiers",
                            export_specifiers(__export.specifiers)
                          },
                          --[[ tuple ]]{
                            "source",
                            option(literal, __export.source)
                          }
                        }); end end 
           if ___conditional___ == 28--[[ ExportDeclaration ]] then do
              __export_1 = match[1];
              match_12 = __export_1.declaration;
              declaration_1;
              if (match_12 ~= nil) then do
                match_13 = match_12;
                declaration_1 = match_13.tag and expression(match_13[1]) or statement(match_13[1]);
              end else do
                declaration_1 = __null;
              end end 
              return node("ExportDeclaration", loc, {
                          --[[ tuple ]]{
                            "default",
                            bool(__export_1.__default)
                          },
                          --[[ tuple ]]{
                            "declaration",
                            declaration_1
                          },
                          --[[ tuple ]]{
                            "specifiers",
                            export_specifiers(__export_1.specifiers)
                          },
                          --[[ tuple ]]{
                            "source",
                            option(literal, __export_1.source)
                          },
                          --[[ tuple ]]{
                            "exportKind",
                            string(__export_1.exportKind and "value" or "type")
                          }
                        }); end end 
           if ___conditional___ == 29--[[ ImportDeclaration ]] then do
              __import = match[1];
              specifiers = List.map((function(param) do
                      local ___conditional___=(param.tag | 0);
                      do
                         if ___conditional___ == 0--[[ ImportNamedSpecifier ]] then do
                            match = param[1];
                            local_id = match.local;
                            remote_id = match.remote;
                            span_loc = local_id ~= nil and btwn(remote_id[1], local_id[1]) or remote_id[1];
                            return node("ImportSpecifier", span_loc, {
                                        --[[ tuple ]]{
                                          "id",
                                          identifier(remote_id)
                                        },
                                        --[[ tuple ]]{
                                          "name",
                                          option(identifier, local_id)
                                        }
                                      }); end end 
                         if ___conditional___ == 1--[[ ImportDefaultSpecifier ]] then do
                            id = param[1];
                            return node("ImportDefaultSpecifier", id[1], {--[[ tuple ]]{
                                          "id",
                                          identifier(id)
                                        }}); end end 
                         if ___conditional___ == 2--[[ ImportNamespaceSpecifier ]] then do
                            param_1 = param[1];
                            return node("ImportNamespaceSpecifier", param_1[1], {--[[ tuple ]]{
                                          "id",
                                          identifier(param_1[2])
                                        }}); end end 
                        
                      end
                    end end), __import.specifiers);
              match_14 = __import.importKind;
              import_kind;
              local ___conditional___=(match_14);
              do
                 if ___conditional___ == 0--[[ ImportType ]] then do
                    import_kind = "type"; end else 
                 if ___conditional___ == 1--[[ ImportTypeof ]] then do
                    import_kind = "typeof"; end else 
                 if ___conditional___ == 2--[[ ImportValue ]] then do
                    import_kind = "value"; end else 
                 end end end end end end
                
              end
              return node("ImportDeclaration", loc, {
                          --[[ tuple ]]{
                            "specifiers",
                            array(__Array.of_list(specifiers))
                          },
                          --[[ tuple ]]{
                            "source",
                            literal(__import.source)
                          },
                          --[[ tuple ]]{
                            "importKind",
                            string(import_kind)
                          }
                        }); end end 
          
        end
      end end 
    end end;
    __case = function(param) do
      c = param[2];
      return node("SwitchCase", param[1], {
                  --[[ tuple ]]{
                    "test",
                    option(expression, c.test)
                  },
                  --[[ tuple ]]{
                    "consequent",
                    array_of_list(statement, c.consequent)
                  }
                });
    end end;
    declare_variable = function(param) do
      return node("DeclareVariable", param[1], {--[[ tuple ]]{
                    "id",
                    identifier(param[2].id)
                  }});
    end end;
    interface_declaration = function(param) do
      i = param[2];
      return node("InterfaceDeclaration", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(i.id)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_declaration, i.typeParameters)
                  },
                  --[[ tuple ]]{
                    "body",
                    object_type(i.body)
                  },
                  --[[ tuple ]]{
                    "extends",
                    array_of_list(interface_extends, i.__extends)
                  }
                });
    end end;
    export_specifiers = function(param) do
      if (param ~= nil) then do
        match = param;
        if (match.tag) then do
          return array({node("ExportBatchSpecifier", match[1], {--[[ tuple ]]{
                              "name",
                              option(identifier, match[2])
                            }})});
        end else do
          return array_of_list(export_specifier, match[1]);
        end end 
      end else do
        return array({});
      end end 
    end end;
    block = function(param) do
      return node("BlockStatement", param[1], {--[[ tuple ]]{
                    "body",
                    array_of_list(statement, param[2].body)
                  }});
    end end;
    jsx_element = function(param) do
      element = param[2];
      return node("JSXElement", param[1], {
                  --[[ tuple ]]{
                    "openingElement",
                    jsx_opening(element.openingElement)
                  },
                  --[[ tuple ]]{
                    "closingElement",
                    option(jsx_closing, element.closingElement)
                  },
                  --[[ tuple ]]{
                    "children",
                    array_of_list(jsx_child, element.children)
                  }
                });
    end end;
    jsx_attribute_value = function(param) do
      if (param.tag) then do
        return jsx_expression_container(--[[ tuple ]]{
                    param[1],
                    param[2]
                  });
      end else do
        return literal(--[[ tuple ]]{
                    param[1],
                    param[2]
                  });
      end end 
    end end;
    function_type_param = function(param) do
      param_1 = param[2];
      return node("FunctionTypeParam", param[1], {
                  --[[ tuple ]]{
                    "name",
                    identifier(param_1.name)
                  },
                  --[[ tuple ]]{
                    "typeAnnotation",
                    _type(param_1.typeAnnotation)
                  },
                  --[[ tuple ]]{
                    "optional",
                    bool(param_1.optional)
                  }
                });
    end end;
    variable_declarator = function(param) do
      declarator = param[2];
      return node("VariableDeclarator", param[1], {
                  --[[ tuple ]]{
                    "id",
                    pattern(declarator.id)
                  },
                  --[[ tuple ]]{
                    "init",
                    option(expression, declarator.init)
                  }
                });
    end end;
    array_pattern_element = function(param) do
      if (param.tag) then do
        match = param[1];
        return node("SpreadElementPattern", match[1], {--[[ tuple ]]{
                      "argument",
                      pattern(match[2].argument)
                    }});
      end else do
        return pattern(param[1]);
      end end 
    end end;
    object_pattern_property = function(param) do
      if (param.tag) then do
        match = param[1];
        return node("SpreadPropertyPattern", match[1], {--[[ tuple ]]{
                      "argument",
                      pattern(match[2].argument)
                    }});
      end else do
        match_1 = param[1];
        prop = match_1[2];
        match_2 = prop.key;
        match_3;
        local ___conditional___=(match_2.tag | 0);
        do
           if ___conditional___ == 0--[[ Literal ]] then do
              match_3 = --[[ tuple ]]{
                literal(match_2[1]),
                false
              }; end else 
           if ___conditional___ == 1--[[ Identifier ]] then do
              match_3 = --[[ tuple ]]{
                identifier(match_2[1]),
                false
              }; end else 
           if ___conditional___ == 2--[[ Computed ]] then do
              match_3 = --[[ tuple ]]{
                expression(match_2[1]),
                true
              }; end else 
           end end end end end end
          
        end
        return node("PropertyPattern", match_1[1], {
                    --[[ tuple ]]{
                      "key",
                      match_3[1]
                    },
                    --[[ tuple ]]{
                      "pattern",
                      pattern(prop.pattern)
                    },
                    --[[ tuple ]]{
                      "computed",
                      bool(match_3[2])
                    },
                    --[[ tuple ]]{
                      "shorthand",
                      bool(prop.shorthand)
                    }
                  });
      end end 
    end end;
    class_element = function(param) do
      if (param.tag) then do
        param_1 = param[1];
        prop = param_1[2];
        match = prop.key;
        match_1;
        local ___conditional___=(match.tag | 0);
        do
           if ___conditional___ == 0--[[ Literal ]] then do
              match_1 = --[[ tuple ]]{
                literal(match[1]),
                false
              }; end else 
           if ___conditional___ == 1--[[ Identifier ]] then do
              match_1 = --[[ tuple ]]{
                identifier(match[1]),
                false
              }; end else 
           if ___conditional___ == 2--[[ Computed ]] then do
              match_1 = --[[ tuple ]]{
                expression(match[1]),
                true
              }; end else 
           end end end end end end
          
        end
        return node("ClassProperty", param_1[1], {
                    --[[ tuple ]]{
                      "key",
                      match_1[1]
                    },
                    --[[ tuple ]]{
                      "value",
                      option(expression, prop.value)
                    },
                    --[[ tuple ]]{
                      "typeAnnotation",
                      option(type_annotation, prop.typeAnnotation)
                    },
                    --[[ tuple ]]{
                      "computed",
                      bool(match_1[2])
                    },
                    --[[ tuple ]]{
                      "static",
                      bool(prop.__static)
                    }
                  });
      end else do
        param_2 = param[1];
        method_ = param_2[2];
        key = method_.key;
        match_2;
        local ___conditional___=(key.tag | 0);
        do
           if ___conditional___ == 0--[[ Literal ]] then do
              match_2 = --[[ tuple ]]{
                literal(key[1]),
                false
              }; end else 
           if ___conditional___ == 1--[[ Identifier ]] then do
              match_2 = --[[ tuple ]]{
                identifier(key[1]),
                false
              }; end else 
           if ___conditional___ == 2--[[ Computed ]] then do
              match_2 = --[[ tuple ]]{
                expression(key[1]),
                true
              }; end else 
           end end end end end end
          
        end
        kind;
        local ___conditional___=(method_.kind);
        do
           if ___conditional___ == 0--[[ Constructor ]] then do
              kind = "constructor"; end else 
           if ___conditional___ == 1--[[ Method ]] then do
              kind = "method"; end else 
           if ___conditional___ == 2--[[ Get ]] then do
              kind = "get"; end else 
           if ___conditional___ == 3--[[ Set ]] then do
              kind = "set"; end else 
           end end end end end end end end
          
        end
        return node("MethodDefinition", param_2[1], {
                    --[[ tuple ]]{
                      "key",
                      match_2[1]
                    },
                    --[[ tuple ]]{
                      "value",
                      function_expression(method_.value)
                    },
                    --[[ tuple ]]{
                      "kind",
                      string(kind)
                    },
                    --[[ tuple ]]{
                      "static",
                      bool(method_.__static)
                    },
                    --[[ tuple ]]{
                      "computed",
                      bool(match_2[2])
                    },
                    --[[ tuple ]]{
                      "decorators",
                      array_of_list(expression, method_.decorators)
                    }
                  });
      end end 
    end end;
    comment = function(param) do
      c = param[2];
      match;
      match = c.tag and --[[ tuple ]]{
          "Line",
          c[1]
        } or --[[ tuple ]]{
          "Block",
          c[1]
        };
      return node(match[1], param[1], {--[[ tuple ]]{
                    "value",
                    string(match[2])
                  }});
    end end;
    jsx_child = function(param) do
      match = param[2];
      loc = param[1];
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ Element ]] then do
            return jsx_element(--[[ tuple ]]{
                        loc,
                        match[1]
                      }); end end 
         if ___conditional___ == 1--[[ ExpressionContainer ]] then do
            return jsx_expression_container(--[[ tuple ]]{
                        loc,
                        match[1]
                      }); end end 
         if ___conditional___ == 2--[[ Text ]] then do
            param_1 = --[[ tuple ]]{
              loc,
              match[1]
            };
            text = param_1[2];
            return node("JSXText", param_1[1], {
                        --[[ tuple ]]{
                          "value",
                          string(text.value)
                        },
                        --[[ tuple ]]{
                          "raw",
                          string(text.raw)
                        }
                      }); end end 
        
      end
    end end;
    jsx_opening = function(param) do
      opening = param[2];
      return node("JSXOpeningElement", param[1], {
                  --[[ tuple ]]{
                    "name",
                    jsx_name(opening.name)
                  },
                  --[[ tuple ]]{
                    "attributes",
                    array_of_list(jsx_opening_attribute, opening.attributes)
                  },
                  --[[ tuple ]]{
                    "selfClosing",
                    bool(opening.selfClosing)
                  }
                });
    end end;
    jsx_closing = function(param) do
      return node("JSXClosingElement", param[1], {--[[ tuple ]]{
                    "name",
                    jsx_name(param[2].name)
                  }});
    end end;
    template_element = function(param) do
      element = param[2];
      value = obj({
            --[[ tuple ]]{
              "raw",
              string(element.value.raw)
            },
            --[[ tuple ]]{
              "cooked",
              string(element.value.cooked)
            }
          });
      return node("TemplateElement", param[1], {
                  --[[ tuple ]]{
                    "value",
                    value
                  },
                  --[[ tuple ]]{
                    "tail",
                    bool(element.tail)
                  }
                });
    end end;
    export_specifier = function(param) do
      specifier = param[2];
      return node("ExportSpecifier", param[1], {
                  --[[ tuple ]]{
                    "id",
                    identifier(specifier.id)
                  },
                  --[[ tuple ]]{
                    "name",
                    option(identifier, specifier.name)
                  }
                });
    end end;
    type_param = function(param) do
      tp = param[2];
      variance = function(param) do
        if (param) then do
          return string("minus");
        end else do
          return string("plus");
        end end 
      end end;
      return node("TypeParameter", param[1], {
                  --[[ tuple ]]{
                    "name",
                    string(tp.name)
                  },
                  --[[ tuple ]]{
                    "bound",
                    option(type_annotation, tp.bound)
                  },
                  --[[ tuple ]]{
                    "variance",
                    option(variance, tp.variance)
                  },
                  --[[ tuple ]]{
                    "default",
                    option(_type, tp.__default)
                  }
                });
    end end;
    function_expression = function(param) do
      _function = param[2];
      match = _function.body;
      body;
      body = match.tag and expression(match[1]) or block(match[1]);
      return node("FunctionExpression", param[1], {
                  --[[ tuple ]]{
                    "id",
                    option(identifier, _function.id)
                  },
                  --[[ tuple ]]{
                    "params",
                    array_of_list(pattern, _function.params)
                  },
                  --[[ tuple ]]{
                    "defaults",
                    array_of_list((function(param) do
                            return option(expression, param);
                          end end), _function.defaults)
                  },
                  --[[ tuple ]]{
                    "rest",
                    option(identifier, _function.rest)
                  },
                  --[[ tuple ]]{
                    "body",
                    body
                  },
                  --[[ tuple ]]{
                    "async",
                    bool(_function.async)
                  },
                  --[[ tuple ]]{
                    "generator",
                    bool(_function.generator)
                  },
                  --[[ tuple ]]{
                    "expression",
                    bool(_function.expression)
                  },
                  --[[ tuple ]]{
                    "returnType",
                    option(type_annotation, _function.returnType)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_declaration, _function.typeParameters)
                  }
                });
    end end;
    expression_or_spread = function(param) do
      if (param.tag) then do
        match = param[1];
        return node("SpreadElement", match[1], {--[[ tuple ]]{
                      "argument",
                      expression(match[2].argument)
                    }});
      end else do
        return expression(param[1]);
      end end 
    end end;
    object_property = function(param) do
      if (param.tag) then do
        match = param[1];
        return node("SpreadProperty", match[1], {--[[ tuple ]]{
                      "argument",
                      expression(match[2].argument)
                    }});
      end else do
        match_1 = param[1];
        prop = match_1[2];
        match_2 = prop.key;
        match_3;
        local ___conditional___=(match_2.tag | 0);
        do
           if ___conditional___ == 0--[[ Literal ]] then do
              match_3 = --[[ tuple ]]{
                literal(match_2[1]),
                false
              }; end else 
           if ___conditional___ == 1--[[ Identifier ]] then do
              match_3 = --[[ tuple ]]{
                identifier(match_2[1]),
                false
              }; end else 
           if ___conditional___ == 2--[[ Computed ]] then do
              match_3 = --[[ tuple ]]{
                expression(match_2[1]),
                true
              }; end else 
           end end end end end end
          
        end
        match_4 = prop.kind;
        kind;
        local ___conditional___=(match_4);
        do
           if ___conditional___ == 0--[[ Init ]] then do
              kind = "init"; end else 
           if ___conditional___ == 1--[[ Get ]] then do
              kind = "get"; end else 
           if ___conditional___ == 2--[[ Set ]] then do
              kind = "set"; end else 
           end end end end end end
          
        end
        return node("Property", match_1[1], {
                    --[[ tuple ]]{
                      "key",
                      match_3[1]
                    },
                    --[[ tuple ]]{
                      "value",
                      expression(prop.value)
                    },
                    --[[ tuple ]]{
                      "kind",
                      string(kind)
                    },
                    --[[ tuple ]]{
                      "method",
                      bool(prop._method)
                    },
                    --[[ tuple ]]{
                      "shorthand",
                      bool(prop.shorthand)
                    },
                    --[[ tuple ]]{
                      "computed",
                      bool(match_3[2])
                    }
                  });
      end end 
    end end;
    comprehension_block = function(param) do
      b = param[2];
      return node("ComprehensionBlock", param[1], {
                  --[[ tuple ]]{
                    "left",
                    pattern(b.left)
                  },
                  --[[ tuple ]]{
                    "right",
                    expression(b.right)
                  },
                  --[[ tuple ]]{
                    "each",
                    bool(b.each)
                  }
                });
    end end;
    function_type = function(param) do
      fn = param[2];
      return node("FunctionTypeAnnotation", param[1], {
                  --[[ tuple ]]{
                    "params",
                    array_of_list(function_type_param, fn.params)
                  },
                  --[[ tuple ]]{
                    "returnType",
                    _type(fn.returnType)
                  },
                  --[[ tuple ]]{
                    "rest",
                    option(function_type_param, fn.rest)
                  },
                  --[[ tuple ]]{
                    "typeParameters",
                    option(type_parameter_declaration, fn.typeParameters)
                  }
                });
    end end;
    program_2 = function(param) do
      return node("Program", param[1], {
                  --[[ tuple ]]{
                    "body",
                    array_of_list(statement, param[2])
                  },
                  --[[ tuple ]]{
                    "comments",
                    array_of_list(comment, param[3])
                  }
                });
    end end;
    ret = program_2(match[1]);
    translation_errors_1 = translation_errors.contents;
    ret["errors"] = errors(Pervasives._at(match[2], translation_errors_1));
    return ret;
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[1] == __Error) then do
      e = new __Error(__String(List.length(exn[2])) .. " errors");
      e["name"] = "Parse Error";
      __throw(e);
      return ({});
    end else do
      error(exn)
    end end 
  end end)
end end

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      loc .. (" id " .. __String(test_id.contents)),
      (function(param) do
          return --[[ Eq ]]Block.__(0, {
                    x,
                    y
                  });
        end end)
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

match = type(__dirname) == "undefined" and nil or __dirname;

if (match ~= nil) then do
  f = Path.join(match, "flow_parser_sample.js");
  v = parse(Fs.readFileSync(f, "utf8"), nil);
  eq("File \"runParser.ml\", line 14, characters 7-14", --[[ tuple ]]{
        0,
        2842
      }, v.range);
end else do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "runParser.ml",
      15,
      12
    }
  })
end end 

Mt.from_pair_suites("Flow_parser_reg_test", suites.contents);

exports = {};
return exports;
--[[ Literal Not a pure module ]]
