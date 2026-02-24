(herald "diffie-hellman" (algebra diffie-hellman))

(defprotocol dh diffie-hellman
	(defrole alice (vars (a b rndx) (n text))
		(trace
			(send (exp (gen) a)) ; send alice's exponent
			(recv (exp (gen) b)) ; get bob's exponent
			(send (enc n (exp (gen) (mul a b)))) ; send a nonce with the mutual key
		)
	)


	(defrole bob (vars (a b rndx) (n text))
		(trace
			(recv (exp (gen) a)) ; send alice's exponent
			(send (exp (gen) b)) ; get bob's exponent
			(recv (enc n (exp (gen) (mul b a)))) ; send a nonce with the mutual key
		)
	)

)


(defskeleton dh (vars (a b rndx) (n text))
	(defstrandmax alice (a a) (n n))
	(defstrandmax bob (b b) (n n))

	(pen-non-orig a)
	(pen-non-orig b)
	(uniq-orig n)
)
