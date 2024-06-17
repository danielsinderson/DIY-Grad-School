-- Evaluating Expressions
#eval 1 + 2
#eval 1 + 2 * 5
#eval String.append "Hello, " "world!"
#eval String.append "It is " (if 1 < 2 then "true." else "false.")
#eval 42 + 19
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7 -- Conditionals are expressions, not statements
#eval if 3 == 4 then "equal" else "not equal"


-- Types
#eval (1 + 2 : Nat)
#eval (1 - 2 : Nat)  -- Evaluates to 0 since -1 is not in the naturals
#eval (1 - 2 : Int) -- Properly evaluates to -1
#check String.append "This is a type mismatch. " ["A list of strings" " isn't a string"]



-- Functions and Definitions
