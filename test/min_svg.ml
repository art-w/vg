(* This code is in the public domain.

   Minimal Vgr_svg example, renders on stdout. Compile with:

   ocamlfind ocamlopt -package gg -package vg \
                      -linkpkg -o min_svg.native min_svg.ml
*)

open Gg
open Vg

(* 1. Define your image *)

let aspect = 1.618  
let size = Size2.v (aspect *. 100.) 100. (* mm *)
let view = Box2.v P2.o (Size2.v aspect 1.)
let image = I.const (Color.v_srgb 0.314 0.784 0.471)

(* 2. Render *)

let () = 
  let meta = Vgm.add Vgm.empty Vgm.title "Vgr_svg minimal example" in
  let meta = Vgm.add meta Vgm.description "Emerald color" in
  let warn w = Vgr.pp_warning Format.err_formatter w in
  let r = Vgr.create ~warn ~meta (Vgr_svg.target ()) (`Channel stdout) in
  ignore (Vgr.render r (`Image (size, view, image))); 
  ignore (Vgr.render r `End)
  



