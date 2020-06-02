console.log = print;

List = require "../../lib/js/list";
Pervasives = require "../../lib/js/pervasives";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Foo = Caml_exceptions.create("Gpr_1701_test.Foo");

function test(n) do
  if (n == 0) then do
    error(Foo)
  end
   end 
  xpcall(function() do
    return test(n - 1 | 0);
  end end,function(exn) do
    if (exn == Foo) then do
      return --[[ () ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

test(100);

function read_lines(inc) do
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    match;
    xpcall(function() do
      match = Pervasives.input_line(inc);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.end_of_file) then do
        match = undefined;
      end else do
        error(exn)
      end end 
    end end)
    if (match ~= undefined) then do
      _acc = --[[ :: ]]{
        match,
        acc
      };
      ::continue:: ;
    end else do
      return List.rev(acc);
    end end 
  end;
end end

function read_lines2(inc) do
  _acc = --[[ [] ]]0;
  while(true) do
    acc = _acc;
    l;
    xpcall(function() do
      l = Pervasives.input_line(inc);
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.end_of_file) then do
        return List.rev(acc);
      end else do
        error(exn)
      end end 
    end end)
    _acc = --[[ :: ]]{
      l,
      acc
    };
    ::continue:: ;
  end;
end end

function read_lines3(inc) do
  loop = function (acc) do
    xpcall(function() do
      l = Pervasives.input_line(inc);
      return loop(--[[ :: ]]{
                  l,
                  acc
                });
    end end,function(exn) do
      if (exn == Caml_builtin_exceptions.end_of_file) then do
        return List.rev(acc);
      end else do
        error(exn)
      end end 
    end end)
  end end;
  return loop(--[[ [] ]]0);
end end

function fff(f, x) do
  xpcall(function() do
    return fff(f, x);
  end end,function(exn) do
    return x + 1 | 0;
  end end)
end end

exports.Foo = Foo;
exports.test = test;
exports.read_lines = read_lines;
exports.read_lines2 = read_lines2;
exports.read_lines3 = read_lines3;
exports.fff = fff;
--[[  Not a pure module ]]
