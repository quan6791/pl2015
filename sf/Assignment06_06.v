Require Export Assignment06_05.

(* problem #06: 20 points *)

(** **** Exercise: 4 stars, advanced (no_repeats)  *)
(** The following inductively defined proposition... *)

Inductive appears_in {X:Type} (a:X) : list X -> Prop :=
  | ai_here : forall l, appears_in a (a::l)
  | ai_later : forall b l, appears_in a l -> appears_in a (b::l).

(** ...gives us a precise way of saying that a value [a] appears at
    least once as a member of a list [l]. 

    Here's a pair of warm-ups about [appears_in].
*)

Lemma appears_in_app : forall (X:Type) (xs ys : list X) (x:X), 
     appears_in x (xs ++ ys) -> appears_in x xs \/ appears_in x ys.
Proof.
intros X xs ys x H. induction xs as [|x' xs]. right. simpl in H. apply H. simpl in H. inversion H. 
left. apply ai_here. apply IHxs in H1. destruct H1. left. apply ai_later. apply H1.
right. apply H1. 
Qed. 


Lemma app_appears_in : forall (X:Type) (xs ys : list X) (x:X), 
     appears_in x xs \/ appears_in x ys -> appears_in x (xs ++ ys).
Proof.

intros X xs ys x H. induction xs . destruct H. inversion H. simpl. apply H.
destruct H.  inversion H. apply ai_here. simpl. constructor 2.
apply IHxs. left. apply H1.  simpl. constructor 2.  apply IHxs. right. apply H.
Qed.
