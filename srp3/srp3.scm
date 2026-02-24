(herald
 "SRP protocol with leak of verifier that also allows leak of b"
 (algebra diffie-hellman)
 (bound 40)
 (limit 8000)
)

(defprotocol srp diffie-hellman
  (defrole client-init
    (vars (s text) (x rndx) (client server name) (client-state locn)) 
    (trace
     (stor client-state (cat "Client state" s x client server))
     (send (enc "Enroll" s (exp (gen) x) client (ltk client server)))
     )
    (uniq-gen s x)
    (gen-st client-state)
    )

  (defrole server-init
    (vars (s text) (x expt) (client server name) (server-state locn))
    (trace
     (recv (enc "Enroll" s (exp (gen) x) client (ltk client server)))
     (stor server-state (cat "Server record" s (exp (gen) x) client server))
     (send (exp (gen) x)) ;Leak of the verifier to the intruder
	)
	(gen-st server-state)
    )

  (defrole client
    (vars (client server name) (a rndx) (b u x expt) (s text) (client-state locn))     
    (trace
     (send client)
     (recv s)
     (load client-state (cat "Client state" s x client server))
     (send (exp (gen) a))
     (recv (cat (enc (exp (gen) b) (exp (gen) x)) u))
     (send (hash (exp (gen) a)
		 (enc (exp (gen) b) (exp (gen) x)) u
		 (hash (exp (gen) (mul b a)) (exp (gen) (mul b u x)))))
     (recv (hash (exp (gen) a)
		 (hash (exp (gen) a)
		       (enc (exp (gen) b) (exp (gen) x)) u
		       (hash (exp (gen) (mul b a)) (exp (gen) (mul b u x))))
		 (hash (exp (gen) (mul b a)) (exp (gen) (mul b u x))))))
    (uniq-gen a)
    )

  (defrole server
    (vars (client server name) (a x expt) (b u rndx) (s text) (server-state locn))
    (trace
     (recv client)
     (load server-state (cat "Server record" s (exp (gen) x) client server))
     (send s)
     (recv (exp (gen) a))
     (send (cat (enc (exp (gen) b) (exp (gen) x)) u))
     (recv (hash (exp (gen) a)
		 (enc (exp (gen) b) (exp (gen) x)) u
		 (hash (exp (gen) (mul a b)) (exp (exp (gen) x) (mul u b)))))
     (send (hash (exp (gen) a)
		 (hash (exp (gen) a)
		       (enc (exp (gen) b) (exp (gen) x)) u
		       (hash (exp (gen) (mul a b)) (exp (exp (gen) x) (mul u b))))
		 (hash (exp (gen) (mul a b)) (exp (exp (gen) x) (mul u b))))))
    (uniq-gen u b)
    )

  (defrule at-most-one-server-init-per-client
    (forall ((z0 z1 strd) (client server name))
            (implies
	     (and (p "server-init" z0 1)
		  (p "server-init" z1 1)
		  (p "server-init" "client" z0 client)
		  (p "server-init" "client" z1 client)
		  (p "server-init" "server" z0 server)
		  (p "server-init" "server" z1 server)
		  )
	     (= z0 z1)
            )
     )
   )
  
  (comment "This version of the SRP protocol includes the leak of the verifier to the adversary,")
  (comment "but does not require that b is not equal to u. This allows CPSA to explore the possibility")
  (comment "that the adversary can also acquire the value b. This should only be possible if the")
  (comment "authentication mechanism on the server were compromised and can be checked with listener")
  (comment "strands for b in the actual protocol without the leaks.")
)

(defskeleton srp
  (vars (client server name) (x b u expt) (a rndx) (client-state locn) (s text))
  (defstrand client 7 (server server) (client client) (x x) (b b) (u u) (a a) (client-state client-state))
  (non-orig (ltk client server))
)

(defskeleton srp
  (vars (client server name) (u b rndx) (a x rndx) (server-state locn) (s text))
  (defstrand server 6 (server server) (client client) (x x) (b b) (u u) (a a) (server-state server-state))
  (non-orig (ltk client server))
)
