Julia and surprises: what I'm learning with a new programming language 
======================================================================

This is a preview of what I can talk and write about concerning my 
experience in learning Julia programming language. I'm willing this articel 
if there is reader interest. 

I this articels I'm coming up with some mental shortcuts to study new programming 
language and a list of entry points to Julia which I find useful. 

Here is my background, not quite a novice, but neither a 
guru/maverick/influencer/thinker/jedai/evangelist, for God's sake:

- decent knowledge of python (>1.5k on Stack Overflow, if it counts)
- used, but mostly forgotten R
- small dive into haskell to learn fucntinal programming
- BASIC, Pascal, C

My current task is writing a demonstration code in Julia that 
enables to refresh undergraduate econometrics, confront econometrics 
to machine learning and to discover a new propramming language (doing 
this in a language I know is not challenging enough). 

While learning the Julia programming language I started documented 
surprises - something negative that breaks a least astonishment
principle, but also something positive, where you say - thank you so much 
for doing this this way. You actaully learn form both kind of surprises,
in a different way. Some times a negative surprise has a deeper reason,
worth looking at, the positives onces just make you slightly happier. 

I start with some ideas about what is essential when learing a new language,
document surprises in Julia and give some follow-up links and concluding 
advice to the best of my knowledge. Please let me know what caught your attention/ 

What is essential to learn a language
-------------------------------------

### Minimum

- variable assignment 
- data structures (list, dictionary, set, tuple)
- function syntax 
- input and output (to console, to file)
- control operators (for, while, if-then)

### A bit more: soft issues 

- some philosophy (everything is a... funciton, expression, object)
- popular libraries, thier alternatives, degree of competition
- what language authors had in mind and what is their sense of beauty 
- why people stick to this programming language?

### ... little harder issues

- list of keywords
- iteration / comprehension
- (im)mutability
- package manager
- syntax for arrays
- support for OOP

 
Julia, why?
-----------

- keywords `function` and `end`
- dictionary syntax
- one- based index
- following matlab, fighting python, trying to be lisp
- documentation - the style of writing large chunks of text,
  before getting practical, please be courageous to scap some
  of it 
   

Julia, thanks!
---------------

- type system
- one line functions
- user-defined function vectorisation 
- fast compiler
- simple tests
- greeks support


Julia, I'm learning!
--------------------

- built-in package manager `]`
- not as much of discussion Stack Overflow, but [own neat forum](https://discourse.julialang.org/) 

Rules of thumb 
==============

1. Do not make Julia your first programming language - there are far less 
   examples on Stack Overflow than python and R, which limits quick 
   googling-learning, also choosing a proper library is sometimes ambigious.  
   Julia borows heavily from python, R, Matlab, lisp, maybe haskell, 
   and some features are better documented there than in Julia. 

2. For some tasks the speed up comes from compiler, but often C-based 
   python libraries are faster and better developed. The real sweet spot
   is ability to do static typing, this will help julia develop long-term 
   over python (extreme view: any dynamically typed program over 200 lines 
   of code is trash)      






## Packages

- julia and R have build-in package managers in REPL, python has separate utility `pip`
- julia seems to advocate `import *` style, where in code you normally do not reference
  where the function is coming from. Sometimes this creates confusion as even in std lib 
  function names vary across versions, sometimes it is handy as very basic fucntions in 
  linear algebra and probability are coming from packages and you avoid longer names. 

### Installation  

python

```
$pip install pandas
```

julia 


### Import
```python
# python
import pandas as pd
```

```julia
#julia
using DataFrames
```





