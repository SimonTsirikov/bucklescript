'use strict';

var Caml_gc = require("./caml_gc.js");
var Caml_io = require("./caml_io.js");
var Pervasives = require("./pervasives.js");
var Caml_external_polyfill = require("./caml_external_polyfill.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function if_spacetime_enabled(f) do
  return --[ () ]--0;
end

function create(path) do
  return do
          channel: Pervasives.stdout,
          closed: true
        end;
end

function save_event(time, t, event_name) do
  return if_spacetime_enabled((function (param) do
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, t.channel, event_name);
              end));
end

function save_and_close(time, t) do
  return if_spacetime_enabled((function (param) do
                if (t.closed) do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Series is closed"
                      ];
                end
                Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, t.channel);
                var oc = t.channel;
                Caml_io.caml_ml_flush(oc);
                Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
                t.closed = true;
                return --[ () ]--0;
              end));
end

var Series = do
  create: create,
  save_event: save_event,
  save_and_close: save_and_close
end;

function take(time, param) do
  var channel = param.channel;
  var closed = param.closed;
  return if_spacetime_enabled((function (param) do
                if (closed) do
                  throw [
                        Caml_builtin_exceptions.failure,
                        "Series is closed"
                      ];
                end
                Caml_gc.caml_gc_minor(--[ () ]--0);
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(time, channel);
              end));
end

var Snapshot = do
  take: take
end;

function save_event_for_automatic_snapshots(event_name) do
  return if_spacetime_enabled((function (param) do
                return Caml_external_polyfill.resolve("caml_spacetime_only_works_for_native_code")(event_name);
              end));
end

var enabled = false;

exports.enabled = enabled;
exports.Series = Series;
exports.Snapshot = Snapshot;
exports.save_event_for_automatic_snapshots = save_event_for_automatic_snapshots;
--[ No side effect ]--
