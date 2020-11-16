type expr =
    | Plus of expr * expr
    | Minus of expr * expr
    | Times of expr * expr
    | Divide of expr * expr
    | Value of string
;;

let rec to_string e =
    match e with
    | Plus (left, right) ->
       "(" ^ to_string left ^ " + " ^ to_string right ^ ")"
    | Minus (left, right) ->
       "(" ^ to_string left ^ " - " ^ to_string right ^ ")"
    | Times (left, right) ->
       "(" ^ to_string left ^ " * " ^ to_string right ^ ")"
    | Divide (left, right) ->
       "(" ^ to_string left ^ " / " ^ to_string right ^ ")"
    | Value v -> v
;;

let print_expr e = print_endline (to_string e);;

print_expr (Times (Value "n", Plus (Value "x", Divide (Value "y", Minus (Value "z", Value "w")))));;

