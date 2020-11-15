__console = {log = print};

List = require "..list";
Block = require "..block";
Curry = require "..curry";
Caml_obj = require "..caml_obj";
Caml_bytes = require "..caml_bytes";
Pervasives = require "..pervasives";
Caml_option = require "..caml_option";
Caml_string = require "..caml_string";
Caml_exceptions = require "..caml_exceptions";
CamlinternalLazy = require "..camlinternalLazy";
Caml_builtin_exceptions = require "..caml_builtin_exceptions";

Failure = Caml_exceptions.create("Stream.Failure");

__Error = Caml_exceptions.create("Stream.Error");

function count(param) do
  if (param ~= nil) then do
    return param.count;
  end else do
    return 0;
  end end 
end end

function data(param) do
  if (param ~= nil) then do
    return param.data;
  end else do
    return --[[ Sempty ]]0;
  end end 
end end

function fill_buff(b) do
  b.len = Pervasives.input(b.ic, b.buff, 0, #b.buff);
  b.ind = 0;
  return --[[ () ]]0;
end end

function get_data(count, _d) do
  while(true) do
    d = _d;
    if (type(d) == "number") then do
      return d;
    end else do
      local ___conditional___=(d.tag | 0);
      do
         if ___conditional___ == 0--[[ Scons ]] then do
            return d; end end 
         if ___conditional___ == 1--[[ Sapp ]] then do
            d2 = d[2];
            match = get_data(count, d[1]);
            if (type(match) == "number") then do
              _d = d2;
              ::continue:: ;
            end else if (match.tag) then do
              error({
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]]{
                  "stream.ml",
                  53,
                  12
                }
              })
            end else do
              return --[[ Scons ]]Block.__(0, {
                        match[1],
                        --[[ Sapp ]]Block.__(1, {
                            match[2],
                            d2
                          })
                      });
            end end  end  end end 
         if ___conditional___ == 2--[[ Slazy ]] then do
            _d = CamlinternalLazy.force(d[1]);
            ::continue:: ; end end 
         if ___conditional___ == 3--[[ Sgen ]] then do
            g = d[1];
            match_1 = g.curr;
            if (match_1 ~= nil) then do
              match_2 = Caml_option.valFromOption(match_1);
              if (match_2 ~= nil) then do
                g.curr = nil;
                return --[[ Scons ]]Block.__(0, {
                          Caml_option.valFromOption(match_2),
                          d
                        });
              end else do
                return --[[ Sempty ]]0;
              end end 
            end else do
              match_3 = Curry._1(g.func, count);
              if (match_3 ~= nil) then do
                return --[[ Scons ]]Block.__(0, {
                          Caml_option.valFromOption(match_3),
                          d
                        });
              end else do
                g.curr = Caml_option.some(nil);
                return --[[ Sempty ]]0;
              end end 
            end end  end end 
         if ___conditional___ == 4--[[ Sbuffio ]] then do
            b = d[1];
            if (b.ind >= b.len) then do
              fill_buff(b);
            end
             end 
            if (b.len == 0) then do
              return --[[ Sempty ]]0;
            end else do
              r = b.buff[b.ind];
              b.ind = b.ind + 1 | 0;
              return --[[ Scons ]]Block.__(0, {
                        r,
                        d
                      });
            end end  end end 
        
      end
    end end 
  end;
end end

function peek_data(s) do
  while(true) do
    match = s.data;
    if (type(match) == "number") then do
      return ;
    end else do
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ Scons ]] then do
            return Caml_option.some(match[1]); end end 
         if ___conditional___ == 1--[[ Sapp ]] then do
            d = get_data(s.count, s.data);
            if (type(d) == "number") then do
              return ;
            end else if (d.tag) then do
              error({
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]]{
                  "stream.ml",
                  82,
                  12
                }
              })
            end else do
              s.data = d;
              return Caml_option.some(d[1]);
            end end  end  end end 
         if ___conditional___ == 2--[[ Slazy ]] then do
            s.data = CamlinternalLazy.force(match[1]);
            ::continue:: ; end end 
         if ___conditional___ == 3--[[ Sgen ]] then do
            g = match[1];
            match_1 = g.curr;
            if (match_1 ~= nil) then do
              return Caml_option.valFromOption(match_1);
            end else do
              x = Curry._1(g.func, s.count);
              g.curr = Caml_option.some(x);
              return x;
            end end  end end 
         if ___conditional___ == 4--[[ Sbuffio ]] then do
            b = match[1];
            if (b.ind >= b.len) then do
              fill_buff(b);
            end
             end 
            if (b.len == 0) then do
              s.data = --[[ Sempty ]]0;
              return ;
            end else do
              return b.buff[b.ind];
            end end  end end 
        
      end
    end end 
  end;
end end

function peek(param) do
  if (param ~= nil) then do
    return peek_data(param);
  end
   end 
end end

function junk_data(s) do
  while(true) do
    match = s.data;
    if (type(match) ~= "number") then do
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ == 0--[[ Scons ]] then do
            s.count = s.count + 1 | 0;
            s.data = match[2];
            return --[[ () ]]0; end end 
         if ___conditional___ == 3--[[ Sgen ]] then do
            g = match[1];
            match_1 = g.curr;
            if (match_1 ~= nil) then do
              s.count = s.count + 1 | 0;
              g.curr = nil;
              return --[[ () ]]0;
            end
             end  end else 
         if ___conditional___ == 4--[[ Sbuffio ]] then do
            b = match[1];
            s.count = s.count + 1 | 0;
            b.ind = b.ind + 1 | 0;
            return --[[ () ]]0; end end end end 
        
      end
    end
     end 
    match_2 = peek_data(s);
    if (match_2 ~= nil) then do
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function junk(param) do
  if (param ~= nil) then do
    return junk_data(param);
  end else do
    return --[[ () ]]0;
  end end 
end end

function nget_data(n, s) do
  if (n <= 0) then do
    return --[[ tuple ]]{
            --[[ [] ]]0,
            s.data,
            0
          };
  end else do
    match = peek_data(s);
    if (match ~= nil) then do
      a = Caml_option.valFromOption(match);
      junk_data(s);
      match_1 = nget_data(n - 1 | 0, s);
      return --[[ tuple ]]{
              --[[ :: ]]{
                a,
                match_1[1]
              },
              --[[ Scons ]]Block.__(0, {
                  a,
                  match_1[2]
                }),
              match_1[3] + 1 | 0
            };
    end else do
      return --[[ tuple ]]{
              --[[ [] ]]0,
              s.data,
              0
            };
    end end 
  end end 
end end

function npeek(n, param) do
  if (param ~= nil) then do
    n_1 = n;
    s = param;
    match = nget_data(n_1, s);
    s.count = s.count - match[3] | 0;
    s.data = match[2];
    return match[1];
  end else do
    return --[[ [] ]]0;
  end end 
end end

function next(s) do
  match = peek(s);
  if (match ~= nil) then do
    junk(s);
    return Caml_option.valFromOption(match);
  end else do
    error(Failure)
  end end 
end end

function empty(s) do
  match = peek(s);
  if (match ~= nil) then do
    error(Failure)
  end else do
    return --[[ () ]]0;
  end end 
end end

function iter(f, strm) do
  _param = --[[ () ]]0;
  while(true) do
    match = peek(strm);
    if (match ~= nil) then do
      junk(strm);
      Curry._1(f, Caml_option.valFromOption(match));
      _param = --[[ () ]]0;
      ::continue:: ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function from(f) do
  return {
          count = 0,
          data = --[[ Sgen ]]Block.__(3, {{
                curr = nil,
                func = f
              }})
        };
end end

function of_list(l) do
  return {
          count = 0,
          data = List.fold_right((function(x, l) do
                  return --[[ Scons ]]Block.__(0, {
                            x,
                            l
                          });
                end end), l, --[[ Sempty ]]0)
        };
end end

function of_string(s) do
  count = {
    contents = 0
  };
  return from((function(param) do
                c = count.contents;
                if (c < #s) then do
                  count.contents = count.contents + 1 | 0;
                  return Caml_string.get(s, c);
                end
                 end 
              end end));
end end

function of_bytes(s) do
  count = {
    contents = 0
  };
  return from((function(param) do
                c = count.contents;
                if (c < #s) then do
                  count.contents = count.contents + 1 | 0;
                  return Caml_bytes.get(s, c);
                end
                 end 
              end end));
end end

function of_channel(ic) do
  return {
          count = 0,
          data = --[[ Sbuffio ]]Block.__(4, {{
                ic = ic,
                buff = Caml_bytes.caml_create_bytes(4096),
                len = 0,
                ind = 0
              }})
        };
end end

function iapp(i, s) do
  return {
          count = 0,
          data = --[[ Sapp ]]Block.__(1, {
              data(i),
              data(s)
            })
        };
end end

function icons(i, s) do
  return {
          count = 0,
          data = --[[ Scons ]]Block.__(0, {
              i,
              data(s)
            })
        };
end end

function ising(i) do
  return {
          count = 0,
          data = --[[ Scons ]]Block.__(0, {
              i,
              --[[ Sempty ]]0
            })
        };
end end

function lapp(f, s) do
  return {
          count = 0,
          data = --[[ Slazy ]]Block.__(2, {Caml_obj.caml_lazy_make((function(param) do
                      return --[[ Sapp ]]Block.__(1, {
                                data(Curry._1(f, --[[ () ]]0)),
                                data(s)
                              });
                    end end))})
        };
end end

function lcons(f, s) do
  return {
          count = 0,
          data = --[[ Slazy ]]Block.__(2, {Caml_obj.caml_lazy_make((function(param) do
                      return --[[ Scons ]]Block.__(0, {
                                Curry._1(f, --[[ () ]]0),
                                data(s)
                              });
                    end end))})
        };
end end

function lsing(f) do
  return {
          count = 0,
          data = --[[ Slazy ]]Block.__(2, {Caml_obj.caml_lazy_make((function(param) do
                      return --[[ Scons ]]Block.__(0, {
                                Curry._1(f, --[[ () ]]0),
                                --[[ Sempty ]]0
                              });
                    end end))})
        };
end end

function slazy(f) do
  return {
          count = 0,
          data = --[[ Slazy ]]Block.__(2, {Caml_obj.caml_lazy_make((function(param) do
                      return data(Curry._1(f, --[[ () ]]0));
                    end end))})
        };
end end

function dump_data(f, param) do
  if (type(param) == "number") then do
    return Pervasives.print_string("Sempty");
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Scons ]] then do
          Pervasives.print_string("Scons (");
          Curry._1(f, param[1]);
          Pervasives.print_string(", ");
          dump_data(f, param[2]);
          return Pervasives.print_string(")"); end end 
       if ___conditional___ == 1--[[ Sapp ]] then do
          Pervasives.print_string("Sapp (");
          dump_data(f, param[1]);
          Pervasives.print_string(", ");
          dump_data(f, param[2]);
          return Pervasives.print_string(")"); end end 
       if ___conditional___ == 2--[[ Slazy ]] then do
          return Pervasives.print_string("Slazy"); end end 
       if ___conditional___ == 3--[[ Sgen ]] then do
          return Pervasives.print_string("Sgen"); end end 
       if ___conditional___ == 4--[[ Sbuffio ]] then do
          return Pervasives.print_string("Sbuffio"); end end 
      
    end
  end end 
end end

function dump(f, s) do
  Pervasives.print_string("{count = ");
  Pervasives.print_int(count(s));
  Pervasives.print_string("; data = ");
  dump_data(f, data(s));
  Pervasives.print_string("}");
  return Pervasives.print_newline(--[[ () ]]0);
end end

sempty = nil;

exports = {};
exports.Failure = Failure;
exports.__Error = __Error;
exports.from = from;
exports.of_list = of_list;
exports.of_string = of_string;
exports.of_bytes = of_bytes;
exports.of_channel = of_channel;
exports.iter = iter;
exports.next = next;
exports.empty = empty;
exports.peek = peek;
exports.junk = junk;
exports.count = count;
exports.npeek = npeek;
exports.iapp = iapp;
exports.icons = icons;
exports.ising = ising;
exports.lapp = lapp;
exports.lcons = lcons;
exports.lsing = lsing;
exports.sempty = sempty;
exports.slazy = slazy;
exports.dump = dump;
return exports;
--[[ No side effect ]]
