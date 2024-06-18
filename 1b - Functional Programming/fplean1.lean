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
def hello := "Hello"
def lean : String := "Lean"
#eval String.append hello lean

def add1 (n: Nat) : Nat := n + 1
#eval add1 7

def maximum (n : Nat) (k : Nat) : Nat :=
  if n < k then
    k
  else n
#eval maximum 23 45

def joinStringWith (s : String) (left : String) (right : String) : String :=
  String.append left (String.append s right)
#eval joinStringWith ", " "one" "and another"
#check (joinStringWith)

def volume (height : Nat) (width : Nat) (depth : Nat) : Nat :=
  height * width * depth
#eval volume 10 10 10

def str : Type := String
def aStr : str := "This is a str, which is a String"

abbrev N : Type := Nat   -- this marks the new type as reducible, which means it will always unfold to Nat
def thirtyNine : N := 39
