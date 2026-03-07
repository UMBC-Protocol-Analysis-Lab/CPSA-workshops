# CPSA workshops

This repository contains the code for the UMBC Protocol Analysis Lab's CPSA workshops.
For more information on these trainings and CPSA, visit our website [here](cisa.umbc.edu).



## Week 0 - Installing CPSA
To install CPSA, follow the instructions in the CPSA installation instructions file, linked [here](CPSA_INSTALL.md).
Note that you will need to install [Haskell](https://www.haskell.org/) to use the `cabal` package manager.
Once CPSA is installed, make sure everything is working by running `cpsa4 -v`.
You should see something like `CPSA 4.4.7`, corresponding to the current version of CPSA.
These training use CPSA 4, and we advise users use CPSA major version 4.4 for the best experience following these trainings.

## Week 1
The first week includes an introduction to the Dolev-Yao adversary, which CPSA uses to formulate attacks against an adversary.
We design a meeting protocol on the whiteboard between Alice and Bob, which we want to be *Confidential*, *Authenticated*, and have *Message Integrity*.

## Week 2
Using the meeting protocol we designed last week on the whiteboard, we created models in CPSA to identify flaws or provably show that a protocol is secure.
We will discuss these models in week 3.
We then discuss a common solution for executing the meeting protocol, [Needham-Schroeder](needham-schroeder/ns.scm).
We work together to write a model in CPSA using the Needham-Schroeder specification and a protocol diagram.
We then use CPSA to see if there are any flaws with the protocol and see what the tool tells us about fixing the flaws.
We add the Lowe fix [here](needham-schroeder/ns-fix.scm).

## Week 3
We discuss attacks in CPSA, including what common attacks look like in CPSA shape files.
We look at the MITM attack for Needham-Schroeder and discuss the model for the [NSL fix](needham-schroeder/ns-fix.scm), and how CPSA can "tell us" what would fix a protocol.
We then discuss the models from week 1, asking students to think about what a CPSA model for their protocol might look like, and then running CPSA to see if their protocols work.

## Week 4
We now consider authenticity in the case where the secret is not a key, but a password.
We discuss the PAKE-0 protocol, where hashing is used to verify the password.
While PAKE-0 is an educational protocol and great for modeling in CPSA, it is not widely used, but protocols like it are.

## Week 5
We analyze the key exchange algorithm Diffie-Hellman.
We discuss protocol goals that go beyond security, like minimizing messages, and some of the original number theory behind Diffie-Hellman.
We then discuss [flaws](diffie-hellman/dh-orig_shapes.xhtml) in DH key exchange, and fixes.

## Week 6 and 7 (do the hand gesture)
We consider password authenticated key exchange (PAKE) again, but this time in a way that is more widely used.
SRP is a protocol for PAKE, with some additional goals in both security and functionality.
We model SRP3.
We discuss server-side password storage for protocols like this, including hashing and salting passwords.
We also discuss setting up complicated initial stages, including by using initialization roles that do not really exist, and workarounds for modular addition.
We then discuss more kinds of attacks on the protocol