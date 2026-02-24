(herald "PAL Module 2 example protocol")

(defprotocol example basic 

    (defrole alice (vars (a b name))
      (trace
        (send (cat "Hello, I am" a ",are you" b))
        (recv (cat "Hello, I am," b ",you are" a))
      )
    )

    (defrole bob (vars (a b name))
      (trace
        (recv (cat "Hello, I am" a ",are you" b))
        (send (cat "Hello, I am," b ",you are" a))
      )
    )
)


(defskeleton example (vars (a b name))
    (defstrand alice 2 (a a) (b b))
)

(defskeleton example (vars (a b name))
    (defstrand bob 2 (a a) (b b))
)
