--[['use strict';]]

Http = require "http";

hostname = "127.0.0.1";

function create_server(http) do
  server = http.createServer((function (req, resp) do
          resp.statusCode = 200;
          resp.setHeader("Content-Type", "text/plain");
          return resp.end("Hello world\n");
        end end));
  return server.listen(3000, hostname, (function () do
                console.log("Server running at http://" .. (hostname .. (":" .. (String(3000) .. "/"))));
                return --[[ () ]]0;
              end end));
end end

create_server(Http);

--[[  Not a pure module ]]
