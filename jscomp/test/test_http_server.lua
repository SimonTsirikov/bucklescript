__console = {log = print};

Http = require "http";

hostname = "127.0.0.1";

function create_server(http) do
  server = http.createServer((function(req, resp) do
          resp.statusCode = 200;
          resp.setHeader("Content-Type", "text/plain");
          return resp.end("Hello world\n");
        end end));
  return server.listen(3000, hostname, (function() do
                __console.log("Server running at http://" .. (hostname .. (":" .. (__String(3000) .. "/"))));
                return --[[ () ]]0;
              end end));
end end

create_server(Http);

exports = {};
return exports;
--[[  Not a pure module ]]
