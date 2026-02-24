# CPSA workshops

This repository contains the code for the UMBC Protocol Analysis Lab's CPSA workshops.
For more information on these trainings and CPSA, visit our website [here](cisa.umbc.edu).



## Week 0 - Installing CPSA
To install CPSA, follow the instructions in the CPSA installation instructions file, linked [here](CPSA_INSTALL.md).
Once CPSA is installed, make sure everything is working by running `cpsa4 -v`.
You should see something like `CPSA 4.4.7`, corresponding to the current version of CPSA.
These training use CPSA 4, and we advise users use CPSA major version 4.4 for the best experience following these trainings.

## Week 1
The first week includes an introduction to the Dolev-Yao adversary, which CPSA uses to formulate attacks against an adversary.
We design a meeting protocol on the whiteboard between Alice and Bob, which we want to be *Confidential*, *Authenticated*, and have *Message Integrity*.

## Week 2
Using the meeting protocol we designed last week on the whiteboard, we create a model in CPSA to identify flaws or provably show that a protocol is secure.
We then discuss a common solution for executing the meeting protocol, [Needham-Schroeder](needham-schroeder/ns.scm).
We work together to write a model in CPSA using the Needham-Schroeder specification and a protocol diagram.
We then use CPSA to see if there are any flaws with the protocol, and see what the tool tells us about fixing the flaws.
We add the Lowe fix [here](needham-schroeder/ns-fix.scm).

## Week 3
