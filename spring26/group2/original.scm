(defprotocol group_two basic 
             (defrole alice 
                      (vars (alice bob name) (nonce_A nonce_B msg text))
                      (trace 
                        (send (enc alice nonce_A (pubk bob) ))
                        (recv (enc nonce_A nonce_B bob (pubk alice)))
                        (send (enc nonce_B (pubk bob)))
                        (recv (cat (enc msg (pubk bob)) (pubk alice)))))
             (defrole bob
                      (vars (bob alice name)  (nonce_B nonce_A msg text))
                      (trace
                        (recv (enc alice nonce_A (pubk bob)))
                        (send (enc nonce_A nonce_B bob (pubk alice)))
                        (recv (enc nonce_B (pubk bob)))
                        (send (cat (enc msg (pubk bob)) (pubk alice))))))


(defskeleton group_two
             (vars (alice bob name) (nonce_A nonce_B msg text))
             (defstrandmax alice (alice alice) (bob bob)  (nonce_A nonce_A))
             (uniq-orig nonce_A)
             (non-orig (privk alice) (privk bob)))

(defskeleton group_two
             (vars (alice bob name) (nonce_A nonce_B msg text))
             (defstrandmax bob (alice alice) (bob bob) (msg msg) (nonce_B nonce_B))
             (uniq-orig nonce_B msg)
             (non-orig (privk alice) (privk bob)))
