'use strict';

List = require("./list.js");
Block = require("./block.js");
Curry = require("./curry.js");
Caml_obj = require("./caml_obj.js");
Caml_bytes = require("./caml_bytes.js");
Pervasives = require("./pervasives.js");
Caml_option = require("./caml_option.js");
Caml_string = require("./caml_string.js");
Caml_exceptions = require("./caml_exceptions.js");
CamlinternalLazy = require("./camlinternalLazy.js");
Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

Failure = Caml_exceptions.create("Stream.Failure");

$$Error = Caml_exceptions.create("Stream.Error");

function count(param) do
  if (param ~= undefined) then do
    return param.count;
  end else do
    return 0;
  end end 
end end

function data(param) do
  if (param ~= undefined) then do
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
    if (typeof d == "number") then do
      return d;
    end else do
      local ___conditional___=(d.tag | 0);
      do
         if ___conditional___ = 0--[[ Scons ]] then do
            return d;end end end 
         if ___conditional___ = 1--[[ Sapp ]] then do
            d2 = d[1];
            match = get_data(count, d[0]);
            if (typeof match == "number") then do
              _d = d2;
              continue ;
            end else if (match.tag) then do
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]][
                      "stream.ml",
                      53,
                      12
                    ]
                  ];
            end else do
              return --[[ Scons ]]Block.__(0, [
                        match[0],
                        --[[ Sapp ]]Block.__(1, [
                            match[1],
                            d2
                          ])
                      ]);
            end end  end end end end 
         if ___conditional___ = 2--[[ Slazy ]] then do
            _d = CamlinternalLazy.force(d[0]);
            continue ;end end end 
         if ___conditional___ = 3--[[ Sgen ]] then do
            g = d[0];
            match$1 = g.curr;
            if (match$1 ~= undefined) then do
              match$2 = Caml_option.valFromOption(match$1);
              if (match$2 ~= undefined) then do
                g.curr = undefined;
                return --[[ Scons ]]Block.__(0, [
                          Caml_option.valFromOption(match$2),
                          d
                        ]);
              end else do
                return --[[ Sempty ]]0;
              end end 
            end else do
              match$3 = Curry._1(g.func, count);
              if (match$3 ~= undefined) then do
                return --[[ Scons ]]Block.__(0, [
                          Caml_option.valFromOption(match$3),
                          d
                        ]);
              end else do
                g.curr = Caml_option.some(undefined);
                return --[[ Sempty ]]0;
              end end 
            end end end end end 
         if ___conditional___ = 4--[[ Sbuffio ]] then do
            b = d[0];
            if (b.ind >= b.len) then do
              fill_buff(b);
            end
             end 
            if (b.len == 0) then do
              return --[[ Sempty ]]0;
            end else do
              r = b.buff[b.ind];
              b.ind = b.ind + 1 | 0;
              return --[[ Scons ]]Block.__(0, [
                        r,
                        d
                      ]);
            end end end end end 
         do
        
      end
    end end 
  end;
end end

function peek_data(s) do
  while(true) do
    match = s.data;
    if (typeof match == "number") then do
      return ;
    end else do
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ = 0--[[ Scons ]] then do
            return Caml_option.some(match[0]);end end end 
         if ___conditional___ = 1--[[ Sapp ]] then do
            d = get_data(s.count, s.data);
            if (typeof d == "number") then do
              return ;
            end else if (d.tag) then do
              throw [
                    Caml_builtin_exceptions.assert_failure,
                    --[[ tuple ]][
                      "stream.ml",
                      82,
                      12
                    ]
                  ];
            end else do
              s.data = d;
              return Caml_option.some(d[0]);
            end end  end end end end 
         if ___conditional___ = 2--[[ Slazy ]] then do
            s.data = CamlinternalLazy.force(match[0]);
            continue ;end end end 
         if ___conditional___ = 3--[[ Sgen ]] then do
            g = match[0];
            match$1 = g.curr;
            if (match$1 ~= undefined) then do
              return Caml_option.valFromOption(match$1);
            end else do
              x = Curry._1(g.func, s.count);
              g.curr = Caml_option.some(x);
              return x;
            end end end end end 
         if ___conditional___ = 4--[[ Sbuffio ]] then do
            b = match[0];
            if (b.ind >= b.len) then do
              fill_buff(b);
            end
             end 
            if (b.len == 0) then do
              s.data = --[[ Sempty ]]0;
              return ;
            end else do
              return b.buff[b.ind];
            end end end end end 
         do
        
      end
    end end 
  end;
end end

function peek(param) do
  if (param ~= undefined) then do
    return peek_data(param);
  end
   end 
end end

function junk_data(s) do
  while(true) do
    match = s.data;
    if (typeof match ~= "number") then do
      local ___conditional___=(match.tag | 0);
      do
         if ___conditional___ = 0--[[ Scons ]] then do
            s.count = s.count + 1 | 0;
            s.data = match[1];
            return --[[ () ]]0;end end end 
         if ___conditional___ = 3--[[ Sgen ]] then do
            g = match[0];
            match$1 = g.curr;
            if (match$1 ~= undefined) then do
              s.count = s.count + 1 | 0;
              g.curr = undefined;
              return --[[ () ]]0;
            end
             end end else 
         if ___conditional___ = 4--[[ Sbuffio ]] then do
            b = match[0];
            s.count = s.count + 1 | 0;
            b.ind = b.ind + 1 | 0;
            return --[[ () ]]0;end end end 
         do
        else do
          end end
          
      end
    end
     end 
    match$2 = peek_data(s);
    if (match$2 ~= undefined) then do
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function junk(param) do
  if (param ~= undefined) then do
    return junk_data(param);
  end else do
    return --[[ () ]]0;
  end end 
end end

function nget_data(n, s) do
  if (n <= 0) then do
    return --[[ tuple ]][
            --[[ [] ]]0,
            s.data,
            0
          ];
  end else do
    match = peek_data(s);
    if (match ~= undefined) then do
      a = Caml_option.valFromOption(match);
      junk_data(s);
      match$1 = nget_data(n - 1 | 0, s);
      return --[[ tuple ]][
              --[[ :: ]][
                a,
                match$1[0]
              ],
              --[[ Scons ]]Block.__(0, [
                  a,
                  match$1[1]
                ]),
              match$1[2] + 1 | 0
            ];
    end else do
      return --[[ tuple ]][
              --[[ [] ]]0,
              s.data,
              0
            ];
    end end 
  end end 
end end

function npeek(n, param) do
  if (param ~= undefined) then do
    n$1 = n;
    s = param;
    match = nget_data(n$1, s);
    s.count = s.count - match[2] | 0;
    s.data = match[1];
    return match[0];
  end else do
    return --[[ [] ]]0;
  end end 
end end

function next(s) do
  match = peek(s);
  if (match ~= undefined) then do
    junk(s);
    return Caml_option.valFromOption(match);
  end else do
    throw Failure;
  end end 
end end

function empty(s) do
  match = peek(s);
  if (match ~= undefined) then do
    throw Failure;
  end else do
    return --[[ () ]]0;
  end end 
end end

function iter(f, strm) do
  _param = --[[ () ]]0;
  while(true) do
    match = peek(strm);
    if (match ~= undefined) then do
      junk(strm);
      Curry._1(f, Caml_option.valFromOption(match));
      _param = --[[ () ]]0;
      continue ;
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function from(f) do
  return do
          count: 0,
          data: --[[ Sgen ]]Block.__(3, [do
                curr: undefined,
                func: f
              end])
        end;
end end

function of_list(l) do
  return do
          count: 0,
          data: List.fold_right((function (x, l) do
                  return --[[ Scons ]]Block.__(0, [
                            x,
                            l
                          ]);
                end end), l, --[[ Sempty ]]0)
        end;
end end

function of_string(s) do
  count = do
    contents: 0
  end;
  return from((function (param) do
                c = count.contents;
                if (c < #s) then do
                  count.contents = count.contents + 1 | 0;
                  return Caml_string.get(s, c);
                end
                 end 
              end end));
end end

function of_bytes(s) do
  count = do
    contents: 0
  end;
  return from((function (param) do
                c = count.contents;
                if (c < #s) then do
                  count.contents = count.contents + 1 | 0;
                  return Caml_bytes.get(s, c);
                end
                 end 
              end end));
end end

function of_channel(ic) do
  return do
          count: 0,
          data: --[[ Sbuffio ]]Block.__(4, [do
                ic: ic,
                buff: Caml_bytes.caml_create_bytes(4096),
                len: 0,
                ind: 0
              end])
        end;
end end

function iapp(i, s) do
  return do
          count: 0,
          data: --[[ Sapp ]]Block.__(1, [
              data(i),
              data(s)
            ])
        end;
end end

function icons(i, s) do
  return do
          count: 0,
          data: --[[ Scons ]]Block.__(0, [
              i,
              data(s)
            ])
        end;
end end

function ising(i) do
  return do
          count: 0,
          data: --[[ Scons ]]Block.__(0, [
              i,
              --[[ Sempty ]]0
            ])
        end;
end end

function lapp(f, s) do
  return do
          count: 0,
          data: --[[ Slazy ]]Block.__(2, [Caml_obj.caml_lazy_make((function (param) do
                      return --[[ Sapp ]]Block.__(1, [
                                data(Curry._1(f, --[[ () ]]0)),
                                data(s)
                              ]);
                    end end))])
        end;
end end

function lcons(f, s) do
  return do
          count: 0,
          data: --[[ Slazy ]]Block.__(2, [Caml_obj.caml_lazy_make((function (param) do
                      return --[[ Scons ]]Block.__(0, [
                                Curry._1(f, --[[ () ]]0),
                                data(s)
                              ]);
                    end end))])
        end;
end end

function lsing(f) do
  return do
          count: 0,
          data: --[[ Slazy ]]Block.__(2, [Caml_obj.caml_lazy_make((function (param) do
                      return --[[ Scons ]]Block.__(0, [
                                Curry._1(f, --[[ () ]]0),
                                --[[ Sempty ]]0
                              ]);
                    end end))])
        end;
end end

function slazy(f) do
  return do
          count: 0,
          data: --[[ Slazy ]]Block.__(2, [Caml_obj.caml_lazy_make((function (param) do
                      return data(Curry._1(f, --[[ () ]]0));
                    end end))])
        end;
end end

function dump_data(f, param) do
  if (typeof param == "number") then do
    return Pervasives.print_string("Sempty");
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ = 0--[[ Scons ]] then do
          Pervasives.print_string("Scons (");
          Curry._1(f, param[0]);
          Pervasives.print_string(", ");
          dump_data(f, param[1]);
          return Pervasives.print_string(")");end end end 
       if ___conditional___ = 1--[[ Sapp ]] then do
          Pervasives.print_string("Sapp (");
          dump_data(f, param[0]);
          Pervasives.print_string(", ");
          dump_data(f, param[1]);
          return Pervasives.print_string(")");end end end 
       if ___conditional___ = 2--[[ Slazy ]] then do
          return Pervasives.print_string("Slazy");end end end 
       if ___conditional___ = 3--[[ Sgen ]] then do
          return Pervasives.print_string("Sgen");end end end 
       if ___conditional___ = 4--[[ Sbuffio ]] then do
          return Pervasives.print_string("Sbuffio");end end end 
       do
      
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

sempty = undefined;

exports.Failure = Failure;
exports.$$Error = $$Error;
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
--[[ No side effect ]]
