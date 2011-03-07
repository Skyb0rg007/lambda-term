(*
 * hello.ml
 * --------
 * Copyright : (c) 2011, Jeremie Dimino <jeremie@dimino.org>
 * Licence   : BSD3
 *
 * This file is a part of Lambda-Term.
 *)

open React
open Lwt

lwt () =
  (* Create a thread waiting for escape to be pressed. *)
  let waiter, wakener = wait () in

  (* Create the label. *)
  let widget =
    new Lt_widget.vbox
      (S.const [
         (new Lt_widget.label (S.const "Hello, world!") :> Lt_widget.t);
         (new Lt_widget.label (S.const "Press escape to exit.") :> Lt_widget.t);
       ])
  in

  (* Exit when escape is pressed. *)
  Lwt_event.always_notify
    (function
       | { Lt_key.code = Lt_key.Escape } -> wakeup wakener ()
       | _ -> ())
    widget#key_pressed;

  (* Run. *)
  Lt_widget.run Lt_term.stdout widget waiter