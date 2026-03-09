(herald "PAKE 1" (algebra diffie-hellman))


(defmacro (u) (exp (gen) alpha))
(defmacro (v) (exp (gen) beta))
(defmacro (w) (exp (u) beta))
(defmacro (k) (hash (cat pw a b (u) (v) (w))))
(defprotocol pake1 diffie-hellman

	(defrole init (vars (a b name) (pw data) (alpha beta rndx))
		(trace
			(send (u)) ; Sending the first part of the key
			(recv (v))  ; Receiving the second part of the key
			(send (enc "hello" b "I am" a (k)))
			(recv (enc "got it" a "I am" b (k)))
		)
	)

	(defrole resp (vars (a b name) (pw data) (alpha beta rndx))
		(trace 
			(recv (u)) ; Sending the first part of the key
			(send (v))  ; Receiving the second part of the key
			(recv (enc "hello" b "I am" a (k)))
			(send (enc "got it" a "I am" b (k)))
		)
	)

)


(defskeleton pake1 (vars (a b name) (pw data) (alpha rndx))
	(defstrandmax init (a a) (b b) (pw pw) (alpha alpha))

	(uniq-gen alpha)
	(pen-non-orig pw)
	(neq a b)
)


(defskeleton pake1 (vars (a b name) (pw data) (beta rndx))
	(defstrandmax resp (a a) (b b) (pw pw) (beta beta))

	(uniq-gen beta)
	(pen-non-orig pw)
	(neq a b)
)
