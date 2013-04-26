(*---------------------------------------------------------------------------
   Copyright 2013 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

open Gg
open Vg

(** Sierpiński Arrowhead curve images 
    http://mathworld.wolfram.com/SierpinskiArrowheadCurve.html *)

let author = "Daniel C. Bünzli <daniel.buenzl i@erratique.ch>"

let arrowhead_path i len = 
  let angle = Float.pi /. 3. in
  let rec loop i len turn p = 
    if i = 0 then p >> P.line ~rel:true V2.(len * polar_unit turn) else
    let angle = if i mod 2 = 0 then -.angle else angle in
    p >>
    loop (i - 1) (len /. 2.) (turn +. angle) >>
    loop (i - 1) (len /. 2.) turn >> 
    loop (i - 1) (len /. 2.) (turn -. angle) 
  in
  P.empty >> loop i len 0.
;;

for i = 0 to 8 do 
  Db.image (Printf.sprintf "arrowhead-%d" i) ~author
    ~title:(Printf.sprintf "Sierpiński Arrowhead curve level %d" i)
    ~tags:["arrowhead"; "fractal"; "curve"]
    ~size:(Size2.v 12. 12.)
    ~view:(Box2.v (P2.v ~-.0.1 ~-.0.1) (Size2.v 1.1 1.1))
    begin fun () ->
      let area = `O { P.o with P.width = 0.1 } in
      I.mono Color.black >> I.cut ~area (arrowhead_path i 1.0) 
    end
done

(*---------------------------------------------------------------------------
   Copyright 2013 Daniel C. Bünzli.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:
     
   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

   3. Neither the name of Daniel C. Bünzli nor the names of
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ---------------------------------------------------------------------------*)
