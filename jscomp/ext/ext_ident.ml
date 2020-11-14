(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)








let js_flag = 0b1_000 (* check with ocaml compiler *)

(* let js_module_flag = 0b10_000 (\* javascript external modules *\) *)
(* TODO:
    check name conflicts with javascript conventions
   {[
     Ext_ident.convert "^";;
     - : string = "$caret"
   ]}
*)
let js_object_flag = 0b100_000 (* javascript object flags *)

let is_js (i : Ident.t) =
  i.flags land js_flag <> 0

let is_js_or_global (i : Ident.t) =
  i.flags land (8 lor 1) <> 0


let is_js_object (i : Ident.t) =
  i.flags land js_object_flag <> 0

let make_js_object (i : Ident.t) =
  i.flags <- i.flags lor js_object_flag

(* It's a js function hard coded by js api, so when printing,
   it should preserve the name
*)
let create_js (name : string) : Ident.t  =
  { name = name; flags = js_flag ; stamp = 0}

let create = Ident.create

(* FIXME: no need for `$' operator *)
let create_tmp ?(name=Literals.tmp) () = create name


let js_module_table : Ident.t Hash_string.t = Hash_string.create 31

(* This is for a js exeternal module, we can change it when printing
   for example
   {[
     var React$1 = require('react');
     React$1.render(..)
   ]}

   Given a name, if duplicated, they should  have the same id
*)
(* let create_js_module (name : string) : Ident.t =
  let name =
    String.concat "" @@ Ext_list.map
    (Ext_string.split name '-')  Ext_string.capitalize_ascii in
  (* TODO: if we do such transformation, we should avoid       collision for example:
      react-dom
      react--dom
      check collision later
  *)
  match Hash_string.find_exn js_module_table name  with
  | exception Not_found ->
    let ans = Ident.create name in
    (* let ans = { v with flags = js_module_flag} in  *)
    Hash_string.add js_module_table name ans;
    ans
  | v -> (* v *) Ident.rename v


 *)



exception Not_normal_letter of int
let name_mangle name =

  let len = String.length name  in
  try
    for i  = 0 to len - 1 do
      match String.unsafe_get name i with
      | 'a' .. 'z' | 'A' .. 'Z'
      | '0' .. '9' | '_' | '$'
        -> ()
      | _ -> raise (Not_normal_letter i)
    done;
    name (* Normal letter *)
  with
  | Not_normal_letter 0 ->

    let buffer = Buffer.create len in
    for j = 0 to  len - 1 do
      let c = String.unsafe_get name j in
      match c with
      | '*' -> Buffer.add_string buffer "_star"
      | '\'' -> Buffer.add_string buffer "_prime"
      | '!' -> Buffer.add_string buffer "_bang"
      | '>' -> Buffer.add_string buffer "_great"
      | '<' -> Buffer.add_string buffer "_less"
      | '=' -> Buffer.add_string buffer "_eq"
      | '+' -> Buffer.add_string buffer "_plus"
      | '-' -> Buffer.add_string buffer "_neg"
      | '@' -> Buffer.add_string buffer "_at"
      | '^' -> Buffer.add_string buffer "_caret"
      | '/' -> Buffer.add_string buffer "_slash"
      | '|' -> Buffer.add_string buffer "_pipe"
      | '.' -> Buffer.add_string buffer "_dot"
      | '%' -> Buffer.add_string buffer "_percent"
      | '~' -> Buffer.add_string buffer "_tilde"
      | '#' -> Buffer.add_string buffer "_hash"
      | ':' -> Buffer.add_string buffer "_colon"
      | '?' -> Buffer.add_string buffer "_question"
      | '&' -> Buffer.add_string buffer "_amp"
      | 'a'..'z' | 'A'..'Z'| '_'
      | '$'
      | '0'..'9'-> Buffer.add_char buffer  c
      | _ -> Buffer.add_string buffer "_unknown"
    done; Buffer.contents buffer
  | Not_normal_letter i ->
    String.sub name 0 i ^
    (let buffer = Buffer.create len in
     for j = i to  len - 1 do
       let c = String.unsafe_get name j in
       match c with
       | '*' -> Buffer.add_string buffer "_star"
       | '\'' -> Buffer.add_string buffer "_prime"
       | '!' -> Buffer.add_string buffer "_bang"
       | '>' -> Buffer.add_string buffer "_great"
       | '<' -> Buffer.add_string buffer "_less"
       | '=' -> Buffer.add_string buffer "_eq"
       | '+' -> Buffer.add_string buffer "_plus"
       | '-' -> Buffer.add_string buffer "_"
        (* Note ocaml compiler also has [self-] *)
       | '@' -> Buffer.add_string buffer "_at"
       | '^' -> Buffer.add_string buffer "_caret"
       | '/' -> Buffer.add_string buffer "_slash"
       | '|' -> Buffer.add_string buffer "_pipe"
       | '.' -> Buffer.add_string buffer "_dot"
       | '%' -> Buffer.add_string buffer "_percent"
       | '~' -> Buffer.add_string buffer "_tilde"
       | '#' -> Buffer.add_string buffer "_hash"
       | ':' -> Buffer.add_string buffer "_colon"
       | '?' -> Buffer.add_string buffer "_question"
       | '&' -> Buffer.add_string buffer "_amp"
       | '$' -> Buffer.add_string buffer "_dollar"
       | 'a'..'z' | 'A'..'Z'| '_'
       | '0'..'9'-> Buffer.add_char buffer  c
       | _ -> Buffer.add_string buffer "_unknown"
     done; Buffer.contents buffer)
(* TODO:
    check name conflicts with javascript conventions
   {[
     Ext_ident.convert "^";;
     - : string = "$caret"
   ]}
   [convert name] if [name] is a js keyword,add "$$"
   otherwise do the name mangling to make sure ocaml identifier it is
   a valid js identifier
*)
let convert_word (name : string) = 
  if  Js_reserved_map.is_reserved name  then
    "__" ^ name
  else name_mangle name

let convert (name : string) =
  String.concat "." (List.map convert_word (String.split_on_char '.' name))

(** keyword could be used in property *)

(* It is currently made a persistent ident to avoid fresh ids
    which would result in different signature files
    - other solution: use lazy values
*)
let make_unused () = create "_"



let reset () =
  Hash_string.clear js_module_table


(* Has to be total order, [x < y]
   and [x > y] should be consistent
   flags are not relevant here
*)
let compare (x : Ident.t ) ( y : Ident.t) =
  let u = x.stamp - y.stamp in
  if u = 0 then
    Ext_string.compare x.name y.name
  else u

let equal ( x : Ident.t) ( y : Ident.t) =
  if x.stamp <> 0 then x.stamp = y.stamp
  else y.stamp = 0 && x.name = y.name
