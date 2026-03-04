(herald "Needham-Schroeder")

(defprotocol need-schroe basic

	(defrole alice (vars (a b name) (Na Nb text))
		(trace
			(send (enc (cat Na a) (pubk b))) ;step 1: alice sends bob alice's nonce
			(recv (enc (cat Na Nb) (pubk a))) ; step 2: alice receives bob's nonce 
			(send (enc Nb (pubk b))) ; step 3: alice sends bob his nonce
		)
	)

	(defrole bob (vars (a b name) (Na Nb text))
		(trace
			(recv (enc (cat Na a) (pubk b))) 			
			(send (enc (cat Na Nb) (pubk a)))
			(recv (enc Nb (pubk b)))
		)
	)
)

(defskeleton need-schroe (vars (alice bob name) (Nonce_a Nonce_b text))
	(defstrandmax alice (a alice) (b bob) (Na Nonce_a))

	(uniq-orig Nonce_a)
	(non-orig (privk alice) (privk bob))
)

(defskeleton need-schroe (vars (alice bob name) (Nonce_a Nonce_b text))
	(defstrandmax bob (a alice) (b bob) (Nb Nonce_b))

	(uniq-orig Nonce_b)
	(non-orig (privk alice) (privk bob))
)








