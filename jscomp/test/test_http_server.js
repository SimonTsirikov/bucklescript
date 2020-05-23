'use strict';

var Http = require("http");

var hostname = "127.0.0.1";

function create_server(http) do
  var server = http.createServer((function (req, resp) do
          resp.statusCode = 200;
          resp.setHeader("Content-Type", "text/plain");
          return resp.end("Hello world\n");
        end));
  return server.listen(3000, hostname, (function () do
                console.log("Server running at http://" .. (hostname .. (":" .. (String(3000) .. "/"))));
                return --[ () ]--0;
              end));
end

create_server(Http);

--[  Not a pure module ]--
