-- EVALUATING EXPRESSIONS
#eval 1 + 2
#eval 1 + 2 * 5
#eval String.append "Hello, " "world!"
#eval String.append "It is " (if 1 < 2 then "true." else "false.")
#eval 42 + 19
#eval String.append "A" (String.append "B" "C")
#eval String.append (String.append "A" "B") "C"
#eval if 3 == 3 then 5 else 7 -- Conditionals are expressions, not statements
#eval if 3 == 4 then "equal" else "not equal"


-- TYPES
#eval (1 + 2 : Nat)
#eval (1 - 2 : Nat)  -- Evaluates to 0 since -1 is not in the naturals
#eval (1 - 2 : Int) -- Properly evaluates to -1
-- #check String.append "This is a type mismatch. " ["A list of strings" " isn't a string"]



-- FUNCTIONS AND DEFINITIONS
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


-- STRUCTURES
structure Point where
  x : Float
  y : Float
deriving Repr -- this line tells Lean to create code for displaying Point values in #eval expressions

def origin : Point := {x := 0.0, y := 0.0}
#eval origin
#eval origin.x
#eval origin.y

def addPoints (p1 : Point) (p2 : Point) : Point :=
  {x := p1.x + p2.x, y := p1.y + p2.y}

def distance (p1 : Point) (p2 : Point) : Float :=
  Float.sqrt (((p1.x - p2.x)^2) + ((p1.y - p2.y)^2))

#eval distance { x := 1.0, y := 2.0 } { x := 5.0, y := -1.0 }

def zeroX (p : Point) : Point :=
  { p with x := 0.0 }

structure RectangularPrism where
  h : Float
  w : Float
  d : Float
deriving Repr

def volumeOfPrism (r : RectangularPrism) : Float :=
  r.h * r.w * r.d

structure LineSegment where
  start : Point
  ending : Point
deriving Repr

def lengthOfSegment (s : LineSegment) : Float :=
  distance s.start s.ending



-- DATA TYPES, PATTERNS, AND RECURSION
-- inductive Nat where
--   | zero : Nat
--   | succ (n : Nat) : Nat

def isZero (n : Nat) : Bool :=
  match n with
  | Nat.zero => true
  | Nat.succ k => false

def pred (n : Nat) : Nat :=
  match n with
  | Nat.zero => Nat.zero
  | Nat.succ k => k
#eval pred 5

def width (p : Point) : Float :=
  match p with
  | { x := h, y := w } => w

def even (n: Nat) : Nat :=
  match n with
  | Nat.zero => true
  | Nat.succ k => not (even k)

def plus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => n
  | Nat.succ k' => Nat.succ (plus n k')

def minus (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => N
  | Nat.succ k' => pred (minus n k')

def times (n : Nat) (k : Nat) : Nat :=
  match k with
  | Nat.zero => Nat.zero
  | Nat.succ k' => plus n (times n k')



-- POLYMORPHISM

-- a polymorphic 2D point type, where the x and y coordinates are an arbitrary type
structure PPoint (α : Type) where
  x : α
  y : α
deriving Repr

-- Definitions can also be polymorphic, and should be when taking polymorphic types
-- E.g. this function takes a polymorphic point of type α and replaces its "x" value
def replaceX (α : Type) (point : PPoint) (newX : α) : PPoint α :=
  { point with x := newX }

#check replaceX
#check replaceX Nat


def primes : List Nat := [2, 3, 5, 7]
