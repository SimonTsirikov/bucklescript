'use strict';


var v1 = do
  stdio: "inherit",
  v: 3
end;

var v2 = do
  stdio: 1,
  v: 2
end;

process.on("exit", (function (exit_code) do
        return String(exit_code);
      end));

process.on(1, (function (param) do
        return --[ () ]--0;
      end));

process.on((function (i) do
        return String(i);
      end), "exit");

process.on((function (i) do
        return String(i);
      end), 1);

xx(3, 3, "xxx", "a", "b");

function f(x) do
  x.xx(110, [
        1,
        2,
        3
      ]);
  x.xx(111, 3, "xxx", [
        1,
        2,
        3
      ]);
  x.xx(112, 3, "xxx", 1, 2, 3);
  x.xx(113, 3, "xxx", 0, "b", 1, 2, 3, 4, 5);
  x.xx(114, 3, true, false, ("你好"), (["你好",1,2,3]), ([{ "arr" : ["你好",1,2,3], "encoding" : "utf8"}]), ([{ "arr" : ["你好",1,2,3], "encoding" : "utf8"}]), "xxx", 0, "yyy", "b", 1, 2, 3, 4, 5);
  return --[ () ]--0;
end

process.on("exit", (function (exit_code) do
        console.log("error code: " .. String(exit_code));
        return --[ () ]--0;
      end));

function register(p) do
  p.on("exit", (function (i) do
          console.log(i);
          return --[ () ]--0;
        end));
  return --[ () ]--0;
end

var config = do
  stdio: "inherit",
  cwd: "."
end;

exports.v1 = v1;
exports.v2 = v2;
exports.f = f;
exports.register = register;
exports.config = config;
--[  Not a pure module ]--
