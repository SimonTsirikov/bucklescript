console = {log = print};

List = require "./list";
Block = require "./block";
Bytes = require "./bytes";
Curry = require "./curry";
__Buffer = require "./buffer";
__String = require "./string";
Caml_io = require "./caml_io";
Caml_obj = require "./caml_obj";
Caml_bytes = require "./caml_bytes";
Pervasives = require "./pervasives";
Caml_string = require "./caml_string";
Caml_primitive = require "./caml_primitive";
Caml_exceptions = require "./caml_exceptions";
CamlinternalFormat = require "./camlinternalFormat";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function add_queue(x, q) do
  c = --[[ Cons ]]{
    --[[ head ]]x,
    --[[ tail : Nil ]]0
  };
  match = q.insert;
  if (match) then do
    q.insert = c;
    match[--[[ tail ]]1] = c;
    return --[[ () ]]0;
  end else do
    q.insert = c;
    q.body = c;
    return --[[ () ]]0;
  end end 
end end

Empty_queue = Caml_exceptions.create("Format.Empty_queue");

function peek_queue(param) do
  match = param.body;
  if (match) then do
    return match[--[[ head ]]0];
  end else do
    error(Empty_queue)
  end end 
end end

function take_queue(q) do
  match = q.body;
  if (match) then do
    tl = match[--[[ tail ]]1];
    q.body = tl;
    if (tl == --[[ Nil ]]0) then do
      q.insert = --[[ Nil ]]0;
    end
     end 
    return match[--[[ head ]]0];
  end else do
    error(Empty_queue)
  end end 
end end

function pp_enqueue(state, token) do
  state.pp_right_total = state.pp_right_total + token.length | 0;
  return add_queue(token, state.pp_queue);
end end

function pp_clear_queue(state) do
  state.pp_left_total = 1;
  state.pp_right_total = 1;
  q = state.pp_queue;
  q.insert = --[[ Nil ]]0;
  q.body = --[[ Nil ]]0;
  return --[[ () ]]0;
end end

function pp_output_string(state, s) do
  return Curry._3(state.pp_out_string, s, 0, #s);
end end

function break_new_line(state, offset, width) do
  Curry._1(state.pp_out_newline, --[[ () ]]0);
  state.pp_is_new_line = true;
  indent = (state.pp_margin - width | 0) + offset | 0;
  real_indent = state.pp_max_indent < indent and state.pp_max_indent or indent;
  state.pp_current_indent = real_indent;
  state.pp_space_left = state.pp_margin - state.pp_current_indent | 0;
  return Curry._1(state.pp_out_indent, state.pp_current_indent);
end end

function break_same_line(state, width) do
  state.pp_space_left = state.pp_space_left - width | 0;
  return Curry._1(state.pp_out_spaces, width);
end end

function pp_force_break_line(state) do
  match = state.pp_format_stack;
  if (match) then do
    match_1 = match[0];
    width = match_1[1];
    if (width > state.pp_space_left and (match_1[0] - 1 >>> 0) <= 3) then do
      return break_new_line(state, 0, width);
    end else do
      return 0;
    end end 
  end else do
    return Curry._1(state.pp_out_newline, --[[ () ]]0);
  end end 
end end

function format_pp_token(state, size, param) do
  if (typeof param == "number") then do
    local ___conditional___=(param);
    do
       if ___conditional___ == 0--[[ Pp_stab ]] then do
          match = state.pp_tbox_stack;
          if (match) then do
            tabs = match[0][0];
            add_tab = function(n, ls) do
              if (ls) then do
                x = ls[0];
                if (Caml_obj.caml_lessthan(n, x)) then do
                  return --[[ :: ]]{
                          n,
                          ls
                        };
                end else do
                  return --[[ :: ]]{
                          x,
                          add_tab(n, ls[1])
                        };
                end end 
              end else do
                return --[[ :: ]]{
                        n,
                        --[[ [] ]]0
                      };
              end end 
            end end;
            tabs.contents = add_tab(state.pp_margin - state.pp_space_left | 0, tabs.contents);
            return --[[ () ]]0;
          end else do
            return --[[ () ]]0;
          end end  end end 
       if ___conditional___ == 1--[[ Pp_end ]] then do
          match_1 = state.pp_format_stack;
          if (match_1) then do
            state.pp_format_stack = match_1[1];
            return --[[ () ]]0;
          end else do
            return --[[ () ]]0;
          end end  end end 
       if ___conditional___ == 2--[[ Pp_tend ]] then do
          match_2 = state.pp_tbox_stack;
          if (match_2) then do
            state.pp_tbox_stack = match_2[1];
            return --[[ () ]]0;
          end else do
            return --[[ () ]]0;
          end end  end end 
       if ___conditional___ == 3--[[ Pp_newline ]] then do
          match_3 = state.pp_format_stack;
          if (match_3) then do
            return break_new_line(state, 0, match_3[0][1]);
          end else do
            return Curry._1(state.pp_out_newline, --[[ () ]]0);
          end end  end end 
       if ___conditional___ == 4--[[ Pp_if_newline ]] then do
          if (state.pp_current_indent ~= (state.pp_margin - state.pp_space_left | 0)) then do
            state_1 = state;
            match_4 = take_queue(state_1.pp_queue);
            size_1 = match_4.elem_size;
            state_1.pp_left_total = state_1.pp_left_total - match_4.length | 0;
            state_1.pp_space_left = state_1.pp_space_left + size_1 | 0;
            return --[[ () ]]0;
          end else do
            return 0;
          end end  end end 
       if ___conditional___ == 5--[[ Pp_close_tag ]] then do
          match_5 = state.pp_mark_stack;
          if (match_5) then do
            marker = Curry._1(state.pp_mark_close_tag, match_5[0]);
            pp_output_string(state, marker);
            state.pp_mark_stack = match_5[1];
            return --[[ () ]]0;
          end else do
            return --[[ () ]]0;
          end end  end end 
      
    end
  end else do
    local ___conditional___=(param.tag | 0);
    do
       if ___conditional___ == 0--[[ Pp_text ]] then do
          state.pp_space_left = state.pp_space_left - size | 0;
          pp_output_string(state, param[0]);
          state.pp_is_new_line = false;
          return --[[ () ]]0; end end 
       if ___conditional___ == 1--[[ Pp_break ]] then do
          off = param[1];
          n = param[0];
          match_6 = state.pp_format_stack;
          if (match_6) then do
            match_7 = match_6[0];
            width = match_7[1];
            local ___conditional___=(match_7[0]);
            do
               if ___conditional___ == 1--[[ Pp_vbox ]]
               or ___conditional___ == 2--[[ Pp_hvbox ]] then do
                  return break_new_line(state, off, width); end end 
               if ___conditional___ == 3--[[ Pp_hovbox ]] then do
                  if (size > state.pp_space_left) then do
                    return break_new_line(state, off, width);
                  end else do
                    return break_same_line(state, n);
                  end end  end end 
               if ___conditional___ == 4--[[ Pp_box ]] then do
                  if (state.pp_is_new_line or not (size > state.pp_space_left or state.pp_current_indent > ((state.pp_margin - width | 0) + off | 0))) then do
                    return break_same_line(state, n);
                  end else do
                    return break_new_line(state, off, width);
                  end end  end end 
               if ___conditional___ == 0--[[ Pp_hbox ]]
               or ___conditional___ == 5--[[ Pp_fits ]] then do
                  return break_same_line(state, n); end end 
              
            end
          end else do
            return --[[ () ]]0;
          end end  end end 
       if ___conditional___ == 2--[[ Pp_tbreak ]] then do
          insertion_point = state.pp_margin - state.pp_space_left | 0;
          match_8 = state.pp_tbox_stack;
          if (match_8) then do
            tabs_1 = match_8[0][0];
            find = function(n, _param) do
              while(true) do
                param = _param;
                if (param) then do
                  x = param[0];
                  if (Caml_obj.caml_greaterequal(x, n)) then do
                    return x;
                  end else do
                    _param = param[1];
                    ::continue:: ;
                  end end 
                end else do
                  error(Caml_builtin_exceptions.not_found)
                end end 
              end;
            end end;
            match_9 = tabs_1.contents;
            tab;
            if (match_9) then do
              xpcall(function() do
                tab = find(insertion_point, tabs_1.contents);
              end end,function(exn) do
                if (exn == Caml_builtin_exceptions.not_found) then do
                  tab = match_9[0];
                end else do
                  error(exn)
                end end 
              end end)
            end else do
              tab = insertion_point;
            end end 
            offset = tab - insertion_point | 0;
            if (offset >= 0) then do
              return break_same_line(state, offset + param[0] | 0);
            end else do
              return break_new_line(state, tab + param[1] | 0, state.pp_margin);
            end end 
          end else do
            return --[[ () ]]0;
          end end  end end 
       if ___conditional___ == 3--[[ Pp_begin ]] then do
          ty = param[1];
          insertion_point_1 = state.pp_margin - state.pp_space_left | 0;
          if (insertion_point_1 > state.pp_max_indent) then do
            pp_force_break_line(state);
          end
           end 
          offset_1 = state.pp_space_left - param[0] | 0;
          bl_type = ty ~= 1 and (
              size > state.pp_space_left and ty or --[[ Pp_fits ]]5
            ) or --[[ Pp_vbox ]]1;
          state.pp_format_stack = --[[ :: ]]{
            --[[ Format_elem ]]{
              bl_type,
              offset_1
            },
            state.pp_format_stack
          };
          return --[[ () ]]0; end end 
       if ___conditional___ == 4--[[ Pp_tbegin ]] then do
          state.pp_tbox_stack = --[[ :: ]]{
            param[0],
            state.pp_tbox_stack
          };
          return --[[ () ]]0; end end 
       if ___conditional___ == 5--[[ Pp_open_tag ]] then do
          tag_name = param[0];
          marker_1 = Curry._1(state.pp_mark_open_tag, tag_name);
          pp_output_string(state, marker_1);
          state.pp_mark_stack = --[[ :: ]]{
            tag_name,
            state.pp_mark_stack
          };
          return --[[ () ]]0; end end 
      
    end
  end end 
end end

function advance_left(state) do
  xpcall(function() do
    state_1 = state;
    while(true) do
      match = peek_queue(state_1.pp_queue);
      size = match.elem_size;
      if (size < 0 and (state_1.pp_right_total - state_1.pp_left_total | 0) < state_1.pp_space_left) then do
        return 0;
      end else do
        take_queue(state_1.pp_queue);
        format_pp_token(state_1, size < 0 and 1000000010 or size, match.token);
        state_1.pp_left_total = match.length + state_1.pp_left_total | 0;
        ::continue:: ;
      end end 
    end;
  end end,function(exn) do
    if (exn == Empty_queue) then do
      return --[[ () ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

function enqueue_advance(state, tok) do
  pp_enqueue(state, tok);
  return advance_left(state);
end end

function enqueue_string_as(state, size, s) do
  return enqueue_advance(state, {
              elem_size = size,
              token = --[[ Pp_text ]]Block.__(0, {s}),
              length = size
            });
end end

q_elem = {
  elem_size = -1,
  token = --[[ Pp_text ]]Block.__(0, {""}),
  length = 0
};

scan_stack_bottom_000 = --[[ Scan_elem ]]{
  -1,
  q_elem
};

scan_stack_bottom = --[[ :: ]]{
  scan_stack_bottom_000,
  --[[ [] ]]0
};

function set_size(state, ty) do
  match = state.pp_scan_stack;
  if (match) then do
    match_1 = match[0];
    queue_elem = match_1[1];
    size = queue_elem.elem_size;
    t = match[1];
    if (match_1[0] < state.pp_left_total) then do
      state.pp_scan_stack = scan_stack_bottom;
      return --[[ () ]]0;
    end else do
      tmp = queue_elem.token;
      if (typeof tmp == "number") then do
        return --[[ () ]]0;
      end else do
        local ___conditional___=(tmp.tag | 0);
        do
           if ___conditional___ == 1--[[ Pp_break ]]
           or ___conditional___ == 2--[[ Pp_tbreak ]]
           or ___conditional___ == 3--[[ Pp_begin ]] then do
              if (ty) then do
                return 0;
              end else do
                queue_elem.elem_size = state.pp_right_total + size | 0;
                state.pp_scan_stack = t;
                return --[[ () ]]0;
              end end  end end 
          return --[[ () ]]0;
            
        end
      end end 
      if (ty) then do
        queue_elem.elem_size = state.pp_right_total + size | 0;
        state.pp_scan_stack = t;
        return --[[ () ]]0;
      end else do
        return 0;
      end end 
    end end 
  end else do
    return --[[ () ]]0;
  end end 
end end

function scan_push(state, b, tok) do
  pp_enqueue(state, tok);
  if (b) then do
    set_size(state, true);
  end
   end 
  state.pp_scan_stack = --[[ :: ]]{
    --[[ Scan_elem ]]{
      state.pp_right_total,
      tok
    },
    state.pp_scan_stack
  };
  return --[[ () ]]0;
end end

function pp_open_box_gen(state, indent, br_ty) do
  state.pp_curr_depth = state.pp_curr_depth + 1 | 0;
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = -state.pp_right_total | 0,
      token = --[[ Pp_begin ]]Block.__(3, {
          indent,
          br_ty
        }),
      length = 0
    };
    return scan_push(state, false, elem);
  end else if (state.pp_curr_depth == state.pp_max_boxes) then do
    state_1 = state;
    s = state.pp_ellipsis;
    len = #s;
    return enqueue_string_as(state_1, len, s);
  end else do
    return 0;
  end end  end 
end end

function pp_close_box(state, param) do
  if (state.pp_curr_depth > 1) then do
    if (state.pp_curr_depth < state.pp_max_boxes) then do
      pp_enqueue(state, {
            elem_size = 0,
            token = --[[ Pp_end ]]1,
            length = 0
          });
      set_size(state, true);
      set_size(state, false);
    end
     end 
    state.pp_curr_depth = state.pp_curr_depth - 1 | 0;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function pp_open_tag(state, tag_name) do
  if (state.pp_print_tags) then do
    state.pp_tag_stack = --[[ :: ]]{
      tag_name,
      state.pp_tag_stack
    };
    Curry._1(state.pp_print_open_tag, tag_name);
  end
   end 
  if (state.pp_mark_tags) then do
    return pp_enqueue(state, {
                elem_size = 0,
                token = --[[ Pp_open_tag ]]Block.__(5, {tag_name}),
                length = 0
              });
  end else do
    return 0;
  end end 
end end

function pp_close_tag(state, param) do
  if (state.pp_mark_tags) then do
    pp_enqueue(state, {
          elem_size = 0,
          token = --[[ Pp_close_tag ]]5,
          length = 0
        });
  end
   end 
  if (state.pp_print_tags) then do
    match = state.pp_tag_stack;
    if (match) then do
      Curry._1(state.pp_print_close_tag, match[0]);
      state.pp_tag_stack = match[1];
      return --[[ () ]]0;
    end else do
      return --[[ () ]]0;
    end end 
  end else do
    return 0;
  end end 
end end

function pp_set_print_tags(state, b) do
  state.pp_print_tags = b;
  return --[[ () ]]0;
end end

function pp_set_mark_tags(state, b) do
  state.pp_mark_tags = b;
  return --[[ () ]]0;
end end

function pp_get_print_tags(state, param) do
  return state.pp_print_tags;
end end

function pp_get_mark_tags(state, param) do
  return state.pp_mark_tags;
end end

function pp_set_tags(state, b) do
  state.pp_print_tags = b;
  state.pp_mark_tags = b;
  return --[[ () ]]0;
end end

function pp_get_formatter_tag_functions(state, param) do
  return {
          mark_open_tag = state.pp_mark_open_tag,
          mark_close_tag = state.pp_mark_close_tag,
          print_open_tag = state.pp_print_open_tag,
          print_close_tag = state.pp_print_close_tag
        };
end end

function pp_set_formatter_tag_functions(state, param) do
  state.pp_mark_open_tag = param.mark_open_tag;
  state.pp_mark_close_tag = param.mark_close_tag;
  state.pp_print_open_tag = param.print_open_tag;
  state.pp_print_close_tag = param.print_close_tag;
  return --[[ () ]]0;
end end

function pp_rinit(state) do
  pp_clear_queue(state);
  state.pp_scan_stack = scan_stack_bottom;
  state.pp_format_stack = --[[ [] ]]0;
  state.pp_tbox_stack = --[[ [] ]]0;
  state.pp_tag_stack = --[[ [] ]]0;
  state.pp_mark_stack = --[[ [] ]]0;
  state.pp_current_indent = 0;
  state.pp_curr_depth = 0;
  state.pp_space_left = state.pp_margin;
  return pp_open_box_gen(state, 0, --[[ Pp_hovbox ]]3);
end end

function clear_tag_stack(state) do
  return List.iter((function(param) do
                return pp_close_tag(state, --[[ () ]]0);
              end end), state.pp_tag_stack);
end end

function pp_flush_queue(state, b) do
  clear_tag_stack(state);
  while(state.pp_curr_depth > 1) do
    pp_close_box(state, --[[ () ]]0);
  end;
  state.pp_right_total = 1000000010;
  advance_left(state);
  if (b) then do
    Curry._1(state.pp_out_newline, --[[ () ]]0);
  end
   end 
  return pp_rinit(state);
end end

function pp_print_as_size(state, size, s) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    return enqueue_string_as(state, size, s);
  end else do
    return 0;
  end end 
end end

pp_print_as = pp_print_as_size;

function pp_print_string(state, s) do
  return pp_print_as(state, #s, s);
end end

function pp_print_int(state, i) do
  return pp_print_string(state, String(i));
end end

function pp_print_float(state, f) do
  return pp_print_string(state, Pervasives.string_of_float(f));
end end

function pp_print_bool(state, b) do
  return pp_print_string(state, b and "true" or "false");
end end

function pp_print_char(state, c) do
  return pp_print_as(state, 1, Caml_bytes.bytes_to_string(Bytes.make(1, c)));
end end

function pp_open_hbox(state, param) do
  return pp_open_box_gen(state, 0, --[[ Pp_hbox ]]0);
end end

function pp_open_vbox(state, indent) do
  return pp_open_box_gen(state, indent, --[[ Pp_vbox ]]1);
end end

function pp_open_hvbox(state, indent) do
  return pp_open_box_gen(state, indent, --[[ Pp_hvbox ]]2);
end end

function pp_open_hovbox(state, indent) do
  return pp_open_box_gen(state, indent, --[[ Pp_hovbox ]]3);
end end

function pp_open_box(state, indent) do
  return pp_open_box_gen(state, indent, --[[ Pp_box ]]4);
end end

function pp_print_newline(state, param) do
  pp_flush_queue(state, true);
  return Curry._1(state.pp_out_flush, --[[ () ]]0);
end end

function pp_print_flush(state, param) do
  pp_flush_queue(state, false);
  return Curry._1(state.pp_out_flush, --[[ () ]]0);
end end

function pp_force_newline(state, param) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    return enqueue_advance(state, {
                elem_size = 0,
                token = --[[ Pp_newline ]]3,
                length = 0
              });
  end else do
    return 0;
  end end 
end end

function pp_print_if_newline(state, param) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    return enqueue_advance(state, {
                elem_size = 0,
                token = --[[ Pp_if_newline ]]4,
                length = 0
              });
  end else do
    return 0;
  end end 
end end

function pp_print_break(state, width, offset) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = -state.pp_right_total | 0,
      token = --[[ Pp_break ]]Block.__(1, {
          width,
          offset
        }),
      length = width
    };
    return scan_push(state, true, elem);
  end else do
    return 0;
  end end 
end end

function pp_print_space(state, param) do
  return pp_print_break(state, 1, 0);
end end

function pp_print_cut(state, param) do
  return pp_print_break(state, 0, 0);
end end

function pp_open_tbox(state, param) do
  state.pp_curr_depth = state.pp_curr_depth + 1 | 0;
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = 0,
      token = --[[ Pp_tbegin ]]Block.__(4, {--[[ Pp_tbox ]]{{
              contents = --[[ [] ]]0
            }}}),
      length = 0
    };
    return enqueue_advance(state, elem);
  end else do
    return 0;
  end end 
end end

function pp_close_tbox(state, param) do
  if (state.pp_curr_depth > 1 and state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = 0,
      token = --[[ Pp_tend ]]2,
      length = 0
    };
    enqueue_advance(state, elem);
    state.pp_curr_depth = state.pp_curr_depth - 1 | 0;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function pp_print_tbreak(state, width, offset) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = -state.pp_right_total | 0,
      token = --[[ Pp_tbreak ]]Block.__(2, {
          width,
          offset
        }),
      length = width
    };
    return scan_push(state, true, elem);
  end else do
    return 0;
  end end 
end end

function pp_print_tab(state, param) do
  return pp_print_tbreak(state, 0, 0);
end end

function pp_set_tab(state, param) do
  if (state.pp_curr_depth < state.pp_max_boxes) then do
    elem = {
      elem_size = 0,
      token = --[[ Pp_stab ]]0,
      length = 0
    };
    return enqueue_advance(state, elem);
  end else do
    return 0;
  end end 
end end

function pp_set_max_boxes(state, n) do
  if (n > 1) then do
    state.pp_max_boxes = n;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function pp_get_max_boxes(state, param) do
  return state.pp_max_boxes;
end end

function pp_over_max_boxes(state, param) do
  return state.pp_curr_depth == state.pp_max_boxes;
end end

function pp_set_ellipsis_text(state, s) do
  state.pp_ellipsis = s;
  return --[[ () ]]0;
end end

function pp_get_ellipsis_text(state, param) do
  return state.pp_ellipsis;
end end

function pp_limit(n) do
  if (n < 1000000010) then do
    return n;
  end else do
    return 1000000009;
  end end 
end end

function pp_set_max_indent(state, n) do
  state_1 = state;
  n_1 = state.pp_margin - n | 0;
  if (n_1 >= 1) then do
    n_2 = pp_limit(n_1);
    state_1.pp_min_space_left = n_2;
    state_1.pp_max_indent = state_1.pp_margin - state_1.pp_min_space_left | 0;
    return pp_rinit(state_1);
  end else do
    return 0;
  end end 
end end

function pp_get_max_indent(state, param) do
  return state.pp_max_indent;
end end

function pp_set_margin(state, n) do
  if (n >= 1) then do
    n_1 = pp_limit(n);
    state.pp_margin = n_1;
    new_max_indent = state.pp_max_indent <= state.pp_margin and state.pp_max_indent or Caml_primitive.caml_int_max(Caml_primitive.caml_int_max(state.pp_margin - state.pp_min_space_left | 0, state.pp_margin / 2 | 0), 1);
    return pp_set_max_indent(state, new_max_indent);
  end else do
    return 0;
  end end 
end end

function pp_get_margin(state, param) do
  return state.pp_margin;
end end

function pp_set_formatter_out_functions(state, param) do
  state.pp_out_string = param.out_string;
  state.pp_out_flush = param.out_flush;
  state.pp_out_newline = param.out_newline;
  state.pp_out_spaces = param.out_spaces;
  state.pp_out_indent = param.out_indent;
  return --[[ () ]]0;
end end

function pp_get_formatter_out_functions(state, param) do
  return {
          out_string = state.pp_out_string,
          out_flush = state.pp_out_flush,
          out_newline = state.pp_out_newline,
          out_spaces = state.pp_out_spaces,
          out_indent = state.pp_out_indent
        };
end end

function pp_set_formatter_output_functions(state, f, g) do
  state.pp_out_string = f;
  state.pp_out_flush = g;
  return --[[ () ]]0;
end end

function pp_get_formatter_output_functions(state, param) do
  return --[[ tuple ]]{
          state.pp_out_string,
          state.pp_out_flush
        };
end end

function display_newline(state, param) do
  return Curry._3(state.pp_out_string, "\n", 0, 1);
end end

blank_line = Caml_bytes.bytes_to_string(Bytes.make(80, --[[ " " ]]32));

function display_blanks(state, _n) do
  while(true) do
    n = _n;
    if (n > 0) then do
      if (n <= 80) then do
        return Curry._3(state.pp_out_string, blank_line, 0, n);
      end else do
        Curry._3(state.pp_out_string, blank_line, 0, 80);
        _n = n - 80 | 0;
        ::continue:: ;
      end end 
    end else do
      return 0;
    end end 
  end;
end end

function pp_set_formatter_out_channel(state, oc) do
  state.pp_out_string = (function(param, param_1, param_2) do
      return Pervasives.output_substring(oc, param, param_1, param_2);
    end end);
  state.pp_out_flush = (function(param) do
      return Caml_io.caml_ml_flush(oc);
    end end);
  state.pp_out_newline = (function(param) do
      return display_newline(state, param);
    end end);
  state.pp_out_spaces = (function(param) do
      return display_blanks(state, param);
    end end);
  state.pp_out_indent = (function(param) do
      return display_blanks(state, param);
    end end);
  return --[[ () ]]0;
end end

function default_pp_mark_open_tag(s) do
  return "<" .. (s .. ">");
end end

function default_pp_mark_close_tag(s) do
  return "</" .. (s .. ">");
end end

function default_pp_print_open_tag(prim) do
  return --[[ () ]]0;
end end

function default_pp_print_close_tag(prim) do
  return --[[ () ]]0;
end end

function pp_make_formatter(f, g, h, i, j) do
  pp_queue = {
    insert = --[[ Nil ]]0,
    body = --[[ Nil ]]0
  };
  sys_tok = {
    elem_size = -1,
    token = --[[ Pp_begin ]]Block.__(3, {
        0,
        --[[ Pp_hovbox ]]3
      }),
    length = 0
  };
  add_queue(sys_tok, pp_queue);
  sys_scan_stack_000 = --[[ Scan_elem ]]{
    1,
    sys_tok
  };
  sys_scan_stack = --[[ :: ]]{
    sys_scan_stack_000,
    scan_stack_bottom
  };
  return {
          pp_scan_stack = sys_scan_stack,
          pp_format_stack = --[[ [] ]]0,
          pp_tbox_stack = --[[ [] ]]0,
          pp_tag_stack = --[[ [] ]]0,
          pp_mark_stack = --[[ [] ]]0,
          pp_margin = 78,
          pp_min_space_left = 10,
          pp_max_indent = 68,
          pp_space_left = 78,
          pp_current_indent = 0,
          pp_is_new_line = true,
          pp_left_total = 1,
          pp_right_total = 1,
          pp_curr_depth = 1,
          pp_max_boxes = Pervasives.max_int,
          pp_ellipsis = ".",
          pp_out_string = f,
          pp_out_flush = g,
          pp_out_newline = h,
          pp_out_spaces = i,
          pp_out_indent = j,
          pp_print_tags = false,
          pp_mark_tags = false,
          pp_mark_open_tag = default_pp_mark_open_tag,
          pp_mark_close_tag = default_pp_mark_close_tag,
          pp_print_open_tag = default_pp_print_open_tag,
          pp_print_close_tag = default_pp_print_close_tag,
          pp_queue = pp_queue
        };
end end

function formatter_of_out_functions(out_funs) do
  return pp_make_formatter(out_funs.out_string, out_funs.out_flush, out_funs.out_newline, out_funs.out_spaces, out_funs.out_indent);
end end

function make_formatter(output, flush) do
  ppf = pp_make_formatter(output, flush, (function(prim) do
          return --[[ () ]]0;
        end end), (function(prim) do
          return --[[ () ]]0;
        end end), (function(prim) do
          return --[[ () ]]0;
        end end));
  ppf.pp_out_newline = (function(param) do
      return display_newline(ppf, param);
    end end);
  ppf.pp_out_spaces = (function(param) do
      return display_blanks(ppf, param);
    end end);
  ppf.pp_out_indent = (function(param) do
      return display_blanks(ppf, param);
    end end);
  return ppf;
end end

function formatter_of_out_channel(oc) do
  return make_formatter((function(param, param_1, param_2) do
                return Pervasives.output_substring(oc, param, param_1, param_2);
              end end), (function(param) do
                return Caml_io.caml_ml_flush(oc);
              end end));
end end

function formatter_of_buffer(b) do
  return make_formatter((function(param, param_1, param_2) do
                return __Buffer.add_substring(b, param, param_1, param_2);
              end end), (function(prim) do
                return --[[ () ]]0;
              end end));
end end

stdbuf = __Buffer.create(512);

std_formatter = formatter_of_out_channel(Pervasives.stdout);

err_formatter = formatter_of_out_channel(Pervasives.stderr);

str_formatter = formatter_of_buffer(stdbuf);

function flush_buffer_formatter(buf, ppf) do
  pp_flush_queue(ppf, false);
  s = __Buffer.contents(buf);
  __Buffer.reset(buf);
  return s;
end end

function flush_str_formatter(param) do
  return flush_buffer_formatter(stdbuf, str_formatter);
end end

function make_symbolic_output_buffer(param) do
  return {
          symbolic_output_contents = --[[ [] ]]0
        };
end end

function clear_symbolic_output_buffer(sob) do
  sob.symbolic_output_contents = --[[ [] ]]0;
  return --[[ () ]]0;
end end

function get_symbolic_output_buffer(sob) do
  return List.rev(sob.symbolic_output_contents);
end end

function flush_symbolic_output_buffer(sob) do
  items = List.rev(sob.symbolic_output_contents);
  sob.symbolic_output_contents = --[[ [] ]]0;
  return items;
end end

function add_symbolic_output_item(sob, item) do
  sob.symbolic_output_contents = --[[ :: ]]{
    item,
    sob.symbolic_output_contents
  };
  return --[[ () ]]0;
end end

function formatter_of_symbolic_output_buffer(sob) do
  f = function(param, param_1, param_2) do
    sob_1 = sob;
    s = param;
    i = param_1;
    n = param_2;
    return add_symbolic_output_item(sob_1, --[[ Output_string ]]Block.__(0, {__String.sub(s, i, n)}));
  end end;
  g = function(param) do
    return add_symbolic_output_item(sob, --[[ Output_flush ]]0);
  end end;
  h = function(param) do
    return add_symbolic_output_item(sob, --[[ Output_newline ]]1);
  end end;
  i = function(param) do
    return add_symbolic_output_item(sob, --[[ Output_spaces ]]Block.__(1, {param}));
  end end;
  j = function(param) do
    return add_symbolic_output_item(sob, --[[ Output_indent ]]Block.__(2, {param}));
  end end;
  return pp_make_formatter(f, g, h, i, j);
end end

function open_hbox(param) do
  return pp_open_hbox(std_formatter, param);
end end

function open_vbox(param) do
  return pp_open_vbox(std_formatter, param);
end end

function open_hvbox(param) do
  return pp_open_hvbox(std_formatter, param);
end end

function open_hovbox(param) do
  return pp_open_hovbox(std_formatter, param);
end end

function open_box(param) do
  return pp_open_box(std_formatter, param);
end end

function close_box(param) do
  return pp_close_box(std_formatter, param);
end end

function open_tag(param) do
  return pp_open_tag(std_formatter, param);
end end

function close_tag(param) do
  return pp_close_tag(std_formatter, param);
end end

function print_as(param, param_1) do
  return pp_print_as(std_formatter, param, param_1);
end end

function print_string(param) do
  return pp_print_string(std_formatter, param);
end end

function print_int(param) do
  return pp_print_string(std_formatter, String(param));
end end

function print_float(param) do
  return pp_print_string(std_formatter, Pervasives.string_of_float(param));
end end

function print_char(param) do
  return pp_print_char(std_formatter, param);
end end

function print_bool(param) do
  return pp_print_string(std_formatter, param and "true" or "false");
end end

function print_break(param, param_1) do
  return pp_print_break(std_formatter, param, param_1);
end end

function print_cut(param) do
  return pp_print_break(std_formatter, 0, 0);
end end

function print_space(param) do
  return pp_print_break(std_formatter, 1, 0);
end end

function force_newline(param) do
  return pp_force_newline(std_formatter, param);
end end

function print_flush(param) do
  return pp_print_flush(std_formatter, param);
end end

function print_newline(param) do
  return pp_print_newline(std_formatter, param);
end end

function print_if_newline(param) do
  return pp_print_if_newline(std_formatter, param);
end end

function open_tbox(param) do
  return pp_open_tbox(std_formatter, param);
end end

function close_tbox(param) do
  return pp_close_tbox(std_formatter, param);
end end

function print_tbreak(param, param_1) do
  return pp_print_tbreak(std_formatter, param, param_1);
end end

function set_tab(param) do
  return pp_set_tab(std_formatter, param);
end end

function print_tab(param) do
  return pp_print_tbreak(std_formatter, 0, 0);
end end

function set_margin(param) do
  return pp_set_margin(std_formatter, param);
end end

function get_margin(param) do
  return std_formatter.pp_margin;
end end

function set_max_indent(param) do
  return pp_set_max_indent(std_formatter, param);
end end

function get_max_indent(param) do
  return std_formatter.pp_max_indent;
end end

function set_max_boxes(param) do
  return pp_set_max_boxes(std_formatter, param);
end end

function get_max_boxes(param) do
  return std_formatter.pp_max_boxes;
end end

function over_max_boxes(param) do
  return pp_over_max_boxes(std_formatter, param);
end end

function set_ellipsis_text(param) do
  std_formatter.pp_ellipsis = param;
  return --[[ () ]]0;
end end

function get_ellipsis_text(param) do
  return std_formatter.pp_ellipsis;
end end

function set_formatter_out_channel(param) do
  return pp_set_formatter_out_channel(std_formatter, param);
end end

function set_formatter_out_functions(param) do
  return pp_set_formatter_out_functions(std_formatter, param);
end end

function get_formatter_out_functions(param) do
  return pp_get_formatter_out_functions(std_formatter, param);
end end

function set_formatter_output_functions(param, param_1) do
  return pp_set_formatter_output_functions(std_formatter, param, param_1);
end end

function get_formatter_output_functions(param) do
  return pp_get_formatter_output_functions(std_formatter, param);
end end

function set_formatter_tag_functions(param) do
  return pp_set_formatter_tag_functions(std_formatter, param);
end end

function get_formatter_tag_functions(param) do
  return pp_get_formatter_tag_functions(std_formatter, param);
end end

function set_print_tags(param) do
  std_formatter.pp_print_tags = param;
  return --[[ () ]]0;
end end

function get_print_tags(param) do
  return std_formatter.pp_print_tags;
end end

function set_mark_tags(param) do
  std_formatter.pp_mark_tags = param;
  return --[[ () ]]0;
end end

function get_mark_tags(param) do
  return std_formatter.pp_mark_tags;
end end

function set_tags(param) do
  return pp_set_tags(std_formatter, param);
end end

function pp_print_list(_$staropt$star, pp_v, ppf, _param) do
  while(true) do
    param = _param;
    $staropt$star = _$staropt$star;
    pp_sep = $staropt$star ~= nil and $staropt$star or pp_print_cut;
    if (param) then do
      vs = param[1];
      v = param[0];
      if (vs) then do
        Curry._2(pp_v, ppf, v);
        Curry._2(pp_sep, ppf, --[[ () ]]0);
        _param = vs;
        _$staropt$star = pp_sep;
        ::continue:: ;
      end else do
        return Curry._2(pp_v, ppf, v);
      end end 
    end else do
      return --[[ () ]]0;
    end end 
  end;
end end

function pp_print_text(ppf, s) do
  len = #s;
  left = {
    contents = 0
  };
  right = {
    contents = 0
  };
  flush = function(param) do
    pp_print_string(ppf, __String.sub(s, left.contents, right.contents - left.contents | 0));
    right.contents = right.contents + 1 | 0;
    left.contents = right.contents;
    return --[[ () ]]0;
  end end;
  while(right.contents ~= len) do
    match = Caml_string.get(s, right.contents);
    if (match ~= 10) then do
      if (match ~= 32) then do
        right.contents = right.contents + 1 | 0;
      end else do
        flush(--[[ () ]]0);
        pp_print_break(ppf, 1, 0);
      end end 
    end else do
      flush(--[[ () ]]0);
      pp_force_newline(ppf, --[[ () ]]0);
    end end 
  end;
  if (left.contents ~= len) then do
    return flush(--[[ () ]]0);
  end else do
    return 0;
  end end 
end end

function compute_tag(output, tag_acc) do
  buf = __Buffer.create(16);
  ppf = formatter_of_buffer(buf);
  Curry._2(output, ppf, tag_acc);
  pp_print_flush(ppf, --[[ () ]]0);
  len = buf.position;
  if (len < 2) then do
    return __Buffer.contents(buf);
  end else do
    return __Buffer.sub(buf, 1, len - 2 | 0);
  end end 
end end

function output_formatting_lit(ppf, fmting_lit) do
  if (typeof fmting_lit == "number") then do
    local ___conditional___=(fmting_lit);
    do
       if ___conditional___ == 0--[[ Close_box ]] then do
          return pp_close_box(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 1--[[ Close_tag ]] then do
          return pp_close_tag(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 2--[[ FFlush ]] then do
          return pp_print_flush(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 3--[[ Force_newline ]] then do
          return pp_force_newline(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 4--[[ Flush_newline ]] then do
          return pp_print_newline(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 5--[[ Escaped_at ]] then do
          return pp_print_char(ppf, --[[ "@" ]]64); end end 
       if ___conditional___ == 6--[[ Escaped_percent ]] then do
          return pp_print_char(ppf, --[[ "%" ]]37); end end 
      
    end
  end else do
    local ___conditional___=(fmting_lit.tag | 0);
    do
       if ___conditional___ == 0--[[ Break ]] then do
          return pp_print_break(ppf, fmting_lit[1], fmting_lit[2]); end end 
       if ___conditional___ == 1--[[ Magic_size ]] then do
          return --[[ () ]]0; end end 
       if ___conditional___ == 2--[[ Scan_indic ]] then do
          pp_print_char(ppf, --[[ "@" ]]64);
          return pp_print_char(ppf, fmting_lit[0]); end end 
      
    end
  end end 
end end

function output_acc(ppf, acc) do
  exit = 0;
  p;
  size;
  s;
  p_1;
  size_1;
  c;
  if (typeof acc == "number") then do
    return --[[ () ]]0;
  end else do
    local ___conditional___=(acc.tag | 0);
    do
       if ___conditional___ == 0--[[ Acc_formatting_lit ]] then do
          output_acc(ppf, acc[0]);
          return output_formatting_lit(ppf, acc[1]); end end 
       if ___conditional___ == 1--[[ Acc_formatting_gen ]] then do
          match = acc[1];
          p_2 = acc[0];
          output_acc(ppf, p_2);
          if (match.tag) then do
            match_1 = CamlinternalFormat.open_box_of_string(compute_tag(output_acc, match[0]));
            return pp_open_box_gen(ppf, match_1[0], match_1[1]);
          end else do
            return pp_open_tag(ppf, compute_tag(output_acc, match[0]));
          end end  end end 
       if ___conditional___ == 2--[[ Acc_string_literal ]] then do
          p_3 = acc[0];
          if (typeof p_3 ~= "number" and not p_3.tag) then do
            match_2 = p_3[1];
            if (typeof match_2 ~= "number" and match_2.tag == --[[ Magic_size ]]1) then do
              p = p_3[0];
              size = match_2[1];
              s = acc[1];
              exit = 1;
            end
             end 
          end
           end 
          output_acc(ppf, p_3);
          return pp_print_string(ppf, acc[1]); end end 
       if ___conditional___ == 3--[[ Acc_char_literal ]] then do
          p_4 = acc[0];
          if (typeof p_4 ~= "number" and not p_4.tag) then do
            match_3 = p_4[1];
            if (typeof match_3 ~= "number" and match_3.tag == --[[ Magic_size ]]1) then do
              p_1 = p_4[0];
              size_1 = match_3[1];
              c = acc[1];
              exit = 2;
            end
             end 
          end
           end 
          output_acc(ppf, p_4);
          return pp_print_char(ppf, acc[1]); end end 
       if ___conditional___ == 4--[[ Acc_data_string ]] then do
          p_5 = acc[0];
          if (typeof p_5 ~= "number" and not p_5.tag) then do
            match_4 = p_5[1];
            if (typeof match_4 ~= "number" and match_4.tag == --[[ Magic_size ]]1) then do
              p = p_5[0];
              size = match_4[1];
              s = acc[1];
              exit = 1;
            end
             end 
          end
           end 
          output_acc(ppf, p_5);
          return pp_print_string(ppf, acc[1]); end end 
       if ___conditional___ == 5--[[ Acc_data_char ]] then do
          p_6 = acc[0];
          if (typeof p_6 ~= "number" and not p_6.tag) then do
            match_5 = p_6[1];
            if (typeof match_5 ~= "number" and match_5.tag == --[[ Magic_size ]]1) then do
              p_1 = p_6[0];
              size_1 = match_5[1];
              c = acc[1];
              exit = 2;
            end
             end 
          end
           end 
          output_acc(ppf, p_6);
          return pp_print_char(ppf, acc[1]); end end 
       if ___conditional___ == 6--[[ Acc_delay ]] then do
          output_acc(ppf, acc[0]);
          return Curry._1(acc[1], ppf); end end 
       if ___conditional___ == 7--[[ Acc_flush ]] then do
          output_acc(ppf, acc[0]);
          return pp_print_flush(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 8--[[ Acc_invalid_arg ]] then do
          output_acc(ppf, acc[0]);
          error({
            Caml_builtin_exceptions.invalid_argument,
            acc[1]
          }) end end 
      
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        output_acc(ppf, p);
        return pp_print_as_size(ppf, size, s); end end 
     if ___conditional___ == 2 then do
        output_acc(ppf, p_1);
        return pp_print_as_size(ppf, size_1, Caml_bytes.bytes_to_string(Bytes.make(1, c))); end end 
    
  end
end end

function strput_acc(ppf, acc) do
  exit = 0;
  p;
  size;
  s;
  p_1;
  size_1;
  c;
  if (typeof acc == "number") then do
    return --[[ () ]]0;
  end else do
    local ___conditional___=(acc.tag | 0);
    do
       if ___conditional___ == 0--[[ Acc_formatting_lit ]] then do
          strput_acc(ppf, acc[0]);
          return output_formatting_lit(ppf, acc[1]); end end 
       if ___conditional___ == 1--[[ Acc_formatting_gen ]] then do
          match = acc[1];
          p_2 = acc[0];
          strput_acc(ppf, p_2);
          if (match.tag) then do
            match_1 = CamlinternalFormat.open_box_of_string(compute_tag(strput_acc, match[0]));
            return pp_open_box_gen(ppf, match_1[0], match_1[1]);
          end else do
            return pp_open_tag(ppf, compute_tag(strput_acc, match[0]));
          end end  end end 
       if ___conditional___ == 2--[[ Acc_string_literal ]] then do
          p_3 = acc[0];
          if (typeof p_3 ~= "number" and not p_3.tag) then do
            match_2 = p_3[1];
            if (typeof match_2 ~= "number" and match_2.tag == --[[ Magic_size ]]1) then do
              p = p_3[0];
              size = match_2[1];
              s = acc[1];
              exit = 1;
            end
             end 
          end
           end 
          strput_acc(ppf, p_3);
          return pp_print_string(ppf, acc[1]); end end 
       if ___conditional___ == 3--[[ Acc_char_literal ]] then do
          p_4 = acc[0];
          if (typeof p_4 ~= "number" and not p_4.tag) then do
            match_3 = p_4[1];
            if (typeof match_3 ~= "number" and match_3.tag == --[[ Magic_size ]]1) then do
              p_1 = p_4[0];
              size_1 = match_3[1];
              c = acc[1];
              exit = 2;
            end
             end 
          end
           end 
          strput_acc(ppf, p_4);
          return pp_print_char(ppf, acc[1]); end end 
       if ___conditional___ == 4--[[ Acc_data_string ]] then do
          p_5 = acc[0];
          if (typeof p_5 ~= "number" and not p_5.tag) then do
            match_4 = p_5[1];
            if (typeof match_4 ~= "number" and match_4.tag == --[[ Magic_size ]]1) then do
              p = p_5[0];
              size = match_4[1];
              s = acc[1];
              exit = 1;
            end
             end 
          end
           end 
          strput_acc(ppf, p_5);
          return pp_print_string(ppf, acc[1]); end end 
       if ___conditional___ == 5--[[ Acc_data_char ]] then do
          p_6 = acc[0];
          if (typeof p_6 ~= "number" and not p_6.tag) then do
            match_5 = p_6[1];
            if (typeof match_5 ~= "number" and match_5.tag == --[[ Magic_size ]]1) then do
              p_1 = p_6[0];
              size_1 = match_5[1];
              c = acc[1];
              exit = 2;
            end
             end 
          end
           end 
          strput_acc(ppf, p_6);
          return pp_print_char(ppf, acc[1]); end end 
       if ___conditional___ == 6--[[ Acc_delay ]] then do
          p_7 = acc[0];
          if (typeof p_7 ~= "number" and not p_7.tag) then do
            match_6 = p_7[1];
            if (typeof match_6 ~= "number" and match_6.tag == --[[ Magic_size ]]1) then do
              strput_acc(ppf, p_7[0]);
              return pp_print_as_size(ppf, match_6[1], Curry._1(acc[1], --[[ () ]]0));
            end
             end 
          end
           end 
          strput_acc(ppf, p_7);
          return pp_print_string(ppf, Curry._1(acc[1], --[[ () ]]0)); end end 
       if ___conditional___ == 7--[[ Acc_flush ]] then do
          strput_acc(ppf, acc[0]);
          return pp_print_flush(ppf, --[[ () ]]0); end end 
       if ___conditional___ == 8--[[ Acc_invalid_arg ]] then do
          strput_acc(ppf, acc[0]);
          error({
            Caml_builtin_exceptions.invalid_argument,
            acc[1]
          }) end end 
      
    end
  end end 
  local ___conditional___=(exit);
  do
     if ___conditional___ == 1 then do
        strput_acc(ppf, p);
        return pp_print_as_size(ppf, size, s); end end 
     if ___conditional___ == 2 then do
        strput_acc(ppf, p_1);
        return pp_print_as_size(ppf, size_1, Caml_bytes.bytes_to_string(Bytes.make(1, c))); end end 
    
  end
end end

function kfprintf(k, ppf, param) do
  return CamlinternalFormat.make_printf((function(ppf, acc) do
                output_acc(ppf, acc);
                return Curry._1(k, ppf);
              end end), ppf, --[[ End_of_acc ]]0, param[0]);
end end

function ikfprintf(k, ppf, param) do
  return CamlinternalFormat.make_iprintf(k, ppf, param[0]);
end end

function fprintf(ppf, fmt) do
  return kfprintf((function(prim) do
                return --[[ () ]]0;
              end end), ppf, fmt);
end end

function ifprintf(ppf, fmt) do
  return ikfprintf((function(prim) do
                return --[[ () ]]0;
              end end), ppf, fmt);
end end

function printf(fmt) do
  return fprintf(std_formatter, fmt);
end end

function eprintf(fmt) do
  return fprintf(err_formatter, fmt);
end end

function ksprintf(k, param) do
  b = __Buffer.create(512);
  ppf = formatter_of_buffer(b);
  k_1 = function(param, acc) do
    strput_acc(ppf, acc);
    return Curry._1(k, flush_buffer_formatter(b, ppf));
  end end;
  return CamlinternalFormat.make_printf(k_1, --[[ () ]]0, --[[ End_of_acc ]]0, param[0]);
end end

function sprintf(fmt) do
  return ksprintf((function(s) do
                return s;
              end end), fmt);
end end

function kasprintf(k, param) do
  b = __Buffer.create(512);
  ppf = formatter_of_buffer(b);
  k_1 = function(ppf, acc) do
    output_acc(ppf, acc);
    return Curry._1(k, flush_buffer_formatter(b, ppf));
  end end;
  return CamlinternalFormat.make_printf(k_1, ppf, --[[ End_of_acc ]]0, param[0]);
end end

function asprintf(fmt) do
  return kasprintf((function(s) do
                return s;
              end end), fmt);
end end

Pervasives.at_exit(print_flush);

function pp_set_all_formatter_output_functions(state, f, g, h, i) do
  pp_set_formatter_output_functions(state, f, g);
  state.pp_out_newline = h;
  state.pp_out_spaces = i;
  return --[[ () ]]0;
end end

function pp_get_all_formatter_output_functions(state, param) do
  return --[[ tuple ]]{
          state.pp_out_string,
          state.pp_out_flush,
          state.pp_out_newline,
          state.pp_out_spaces
        };
end end

function set_all_formatter_output_functions(param, param_1, param_2, param_3) do
  return pp_set_all_formatter_output_functions(std_formatter, param, param_1, param_2, param_3);
end end

function get_all_formatter_output_functions(param) do
  return pp_get_all_formatter_output_functions(std_formatter, param);
end end

function bprintf(b, param) do
  k = function(ppf, acc) do
    output_acc(ppf, acc);
    return pp_flush_queue(ppf, false);
  end end;
  return CamlinternalFormat.make_printf(k, formatter_of_buffer(b), --[[ End_of_acc ]]0, param[0]);
end end

kprintf = ksprintf;

exports = {}
exports.pp_open_box = pp_open_box;
exports.open_box = open_box;
exports.pp_close_box = pp_close_box;
exports.close_box = close_box;
exports.pp_open_hbox = pp_open_hbox;
exports.open_hbox = open_hbox;
exports.pp_open_vbox = pp_open_vbox;
exports.open_vbox = open_vbox;
exports.pp_open_hvbox = pp_open_hvbox;
exports.open_hvbox = open_hvbox;
exports.pp_open_hovbox = pp_open_hovbox;
exports.open_hovbox = open_hovbox;
exports.pp_print_string = pp_print_string;
exports.print_string = print_string;
exports.pp_print_as = pp_print_as;
exports.print_as = print_as;
exports.pp_print_int = pp_print_int;
exports.print_int = print_int;
exports.pp_print_float = pp_print_float;
exports.print_float = print_float;
exports.pp_print_char = pp_print_char;
exports.print_char = print_char;
exports.pp_print_bool = pp_print_bool;
exports.print_bool = print_bool;
exports.pp_print_space = pp_print_space;
exports.print_space = print_space;
exports.pp_print_cut = pp_print_cut;
exports.print_cut = print_cut;
exports.pp_print_break = pp_print_break;
exports.print_break = print_break;
exports.pp_force_newline = pp_force_newline;
exports.force_newline = force_newline;
exports.pp_print_if_newline = pp_print_if_newline;
exports.print_if_newline = print_if_newline;
exports.pp_print_flush = pp_print_flush;
exports.print_flush = print_flush;
exports.pp_print_newline = pp_print_newline;
exports.print_newline = print_newline;
exports.pp_set_margin = pp_set_margin;
exports.set_margin = set_margin;
exports.pp_get_margin = pp_get_margin;
exports.get_margin = get_margin;
exports.pp_set_max_indent = pp_set_max_indent;
exports.set_max_indent = set_max_indent;
exports.pp_get_max_indent = pp_get_max_indent;
exports.get_max_indent = get_max_indent;
exports.pp_set_max_boxes = pp_set_max_boxes;
exports.set_max_boxes = set_max_boxes;
exports.pp_get_max_boxes = pp_get_max_boxes;
exports.get_max_boxes = get_max_boxes;
exports.pp_over_max_boxes = pp_over_max_boxes;
exports.over_max_boxes = over_max_boxes;
exports.pp_open_tbox = pp_open_tbox;
exports.open_tbox = open_tbox;
exports.pp_close_tbox = pp_close_tbox;
exports.close_tbox = close_tbox;
exports.pp_set_tab = pp_set_tab;
exports.set_tab = set_tab;
exports.pp_print_tab = pp_print_tab;
exports.print_tab = print_tab;
exports.pp_print_tbreak = pp_print_tbreak;
exports.print_tbreak = print_tbreak;
exports.pp_set_ellipsis_text = pp_set_ellipsis_text;
exports.set_ellipsis_text = set_ellipsis_text;
exports.pp_get_ellipsis_text = pp_get_ellipsis_text;
exports.get_ellipsis_text = get_ellipsis_text;
exports.pp_open_tag = pp_open_tag;
exports.open_tag = open_tag;
exports.pp_close_tag = pp_close_tag;
exports.close_tag = close_tag;
exports.pp_set_tags = pp_set_tags;
exports.set_tags = set_tags;
exports.pp_set_print_tags = pp_set_print_tags;
exports.set_print_tags = set_print_tags;
exports.pp_set_mark_tags = pp_set_mark_tags;
exports.set_mark_tags = set_mark_tags;
exports.pp_get_print_tags = pp_get_print_tags;
exports.get_print_tags = get_print_tags;
exports.pp_get_mark_tags = pp_get_mark_tags;
exports.get_mark_tags = get_mark_tags;
exports.pp_set_formatter_out_channel = pp_set_formatter_out_channel;
exports.set_formatter_out_channel = set_formatter_out_channel;
exports.pp_set_formatter_output_functions = pp_set_formatter_output_functions;
exports.set_formatter_output_functions = set_formatter_output_functions;
exports.pp_get_formatter_output_functions = pp_get_formatter_output_functions;
exports.get_formatter_output_functions = get_formatter_output_functions;
exports.pp_set_formatter_out_functions = pp_set_formatter_out_functions;
exports.set_formatter_out_functions = set_formatter_out_functions;
exports.pp_get_formatter_out_functions = pp_get_formatter_out_functions;
exports.get_formatter_out_functions = get_formatter_out_functions;
exports.pp_set_formatter_tag_functions = pp_set_formatter_tag_functions;
exports.set_formatter_tag_functions = set_formatter_tag_functions;
exports.pp_get_formatter_tag_functions = pp_get_formatter_tag_functions;
exports.get_formatter_tag_functions = get_formatter_tag_functions;
exports.formatter_of_out_channel = formatter_of_out_channel;
exports.std_formatter = std_formatter;
exports.err_formatter = err_formatter;
exports.formatter_of_buffer = formatter_of_buffer;
exports.stdbuf = stdbuf;
exports.str_formatter = str_formatter;
exports.flush_str_formatter = flush_str_formatter;
exports.make_formatter = make_formatter;
exports.formatter_of_out_functions = formatter_of_out_functions;
exports.make_symbolic_output_buffer = make_symbolic_output_buffer;
exports.clear_symbolic_output_buffer = clear_symbolic_output_buffer;
exports.get_symbolic_output_buffer = get_symbolic_output_buffer;
exports.flush_symbolic_output_buffer = flush_symbolic_output_buffer;
exports.add_symbolic_output_item = add_symbolic_output_item;
exports.formatter_of_symbolic_output_buffer = formatter_of_symbolic_output_buffer;
exports.pp_print_list = pp_print_list;
exports.pp_print_text = pp_print_text;
exports.fprintf = fprintf;
exports.printf = printf;
exports.eprintf = eprintf;
exports.sprintf = sprintf;
exports.asprintf = asprintf;
exports.ifprintf = ifprintf;
exports.kfprintf = kfprintf;
exports.ikfprintf = ikfprintf;
exports.ksprintf = ksprintf;
exports.kasprintf = kasprintf;
exports.bprintf = bprintf;
exports.kprintf = kprintf;
exports.set_all_formatter_output_functions = set_all_formatter_output_functions;
exports.get_all_formatter_output_functions = get_all_formatter_output_functions;
exports.pp_set_all_formatter_output_functions = pp_set_all_formatter_output_functions;
exports.pp_get_all_formatter_output_functions = pp_get_all_formatter_output_functions;
--[[ blank_line Not a pure module ]]
