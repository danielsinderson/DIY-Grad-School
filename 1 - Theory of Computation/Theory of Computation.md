
## Class Resources
- [ ] **book**: The Structure and Interpretation of Computer Programs
	- [ ] Chapter One: Building Abstractions with Procedures
	- [ ] Chapter Two: Building Abstractions with Data
	- [ ] Chapter Three: Modularity, Objects, and State
	- [ ] Chapter Four: Metalinguistic Abstraction


## Notes
-------------------------------------------------
*(what computer science is about*)
Computer science is not about computers, but about imperative knowledge. It's the study of computational processes.


-------------------------------------------------
*(rewritten and paraphrased from SICP pg. 6)*

Programming languages have two tasks. The first is to instruct a computer to compute things. The second is to provide a language within which humans organize their thoughts about processes. To accomplish the first, a language has some method for compiling down to machine code. To accomplish the second, a language has primitives (the atoms of operations and data), means for combining primitives, and means for abstracting over combined primitives so they can be manipulated as single units.


-------------------------------------------------
*(types of processes)*

Three common kinds of processes that procedures generate are linear recursive (heavy memory useage on the interpreter), iterative (requires more state variables and can require procedures that are less readable), and tree recursive processes (powerful for computing over hierarchical data, but often far too computationally expensive otherwise).


-------------------------------------------------
*(Compound Data Types, Functional Programming in Lean)*

Product types are data types built from the Cartesian product of other types. They include things like structs and are great for modeling objects as a collection of properties (represented by other types).

Sum types are data types build from the disjoint union of other types. They include things like enums and are great for modeling choices or states.

Recursive types are data types that are recursively built on themselves. They include things like lists, where a list can be thought of as some element conjoined with a list [an element, [another list]], or binary trees, where the brances of a binary tree are also binary trees.

Inductive types are data types that are recursive sum types: they recursively contain themselves and they also contain choices. They're called inductive types because mathematical induction can be used to prove statements about them. Inductive types include things like booleans or the natural numbers. Using inductive data types involves both pattern matching on their choices and recursive functions to traverse their recursive structure.


-------------------------------------------------
*(Polymorphic Types, Functional Programming in Lean)*

A polymorphic type is a data type that takes another type as an argument. An example of this is List T, which is a list whose elements are all of type T.


-------------------------------------------------
*(Currying and Partial Application)*

Currying is where a function that takes X arguments, when given only Y arguments (Y < X), produces a new function that takes X-Y arguments. In other words, the function was partially applied using the given arguments. This takes advantage of the proof that a function $f: A \times B \rightarrow C$ is isomorphic to a function $f': A \rightarrow (B \rightarrow C)$. 


----------
*(Functions Follow Data)*

In general, the type of data you're dealing with will determine the appropriate type of function for dealing with it: recursive data types require recursive functions, and polymorphic data types will require polymorphic functions.


---------------
*(Naming Conventions in Lean for Operations that Might Fail)*

In Lean, when a function / operation might fail, it is common for that operation to have multiple forms. For instance, take List.head.
- List.head requires mathematical proof that the list isn't empty
- List.head? returns an Option type
- List.head! will crash if the list is empty
- List.headD will provide a default value is the list is empty

These are just naming conventions, not special syntax.

