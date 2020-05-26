

import * as Caml_gc from "./caml_gc.js";
import * as Caml_io from "./caml_io.js";
import * as Pervasives from "./pervasives.js";
import * as Caml_external_polyfill from "./caml_external_polyfill.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function if_spacetime_enabled(f) do
  return --[ () ]--0;
end end

function create(path) do
  return do
          channel: Pervasives.stdout,
          closed: true
        end;
end end

function save_event(time, t, event_name) do
  return if_spacetime_enabled((function (param) do
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, t.channel, event_name);
              end end));
end end

function save_and_close(time, t) do
  return if_spacetime_enabled((function (param) do
                if (t.closed) then do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Series is closed"
                      ];
                end
                 end 
                Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, t.channel);
                oc = t.channel;
                Caml_io.caml_ml_flush(oc);
                Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
                t.closed = true;
                return --[ () ]--0;
              end end));
end end

Series = do
  create: create,
  save_event: save_event,
  save_and_close: save_and_close
end;

function take(time, param) do
  channel = param.channel;
  closed = param.closed;
  return if_spacetime_enabled((function (param) do
                if (closed) then do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Series is closed"
                      ];
                end
                 end 
                Caml_gc.caml_gc_minor(--[ () ]--0);
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, channel);
              end end));
end end

Snapshot = do
  take: take
end;

function save_event_for_automatic_snapshots(event_name) do
  return if_spacetime_enabled((function (param) do
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(event_name);
              end end));
end end

enabled = false;

export do
  enabled ,
  Series ,
  Snapshot ,
  save_event_for_automatic_snapshots ,
  
end
--[ No side effect ]--
