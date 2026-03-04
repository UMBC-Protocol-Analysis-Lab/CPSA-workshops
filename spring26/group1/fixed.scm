(defprotocol group_one basic 
             (defrole alice 
                      (vars (alice bob name) (time place text))
                      (trace 
                        (send (enc (enc time place bob (privk alice)) (pubk bob)))
                        (recv (enc (enc (cat "Yes" time place alice) (privk bob)) (pubk alice)))))
             (defrole bob
                      (vars (bob alice name) (time place text))
                      (trace 
                        (recv (enc (enc time place bob (privk alice)) (pubk bob)))
                        (send (enc (enc (cat "Yes" time place alice) (privk bob)) (pubk alice))))))

(defskeleton group_one
             (vars (alice bob name) (time place text))
             (defstrandmax alice (time time) (place place) (alice alice) (bob bob))
             (uniq-orig time place)
             (non-orig (privk alice)(privk bob)))
(defskeleton group_one
             (vars (bob alice name) (time place text))
             (defstrandmax bob  (time time) (place place)(alice alice) (bob bob))
             (uniq-orig time place)
             (non-orig (privk alice) (privk bob)))
