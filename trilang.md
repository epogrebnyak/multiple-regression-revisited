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

Julia sometimes seems to be following matlab (arrays, good), opposing python 
(syntax) and trying to be lisp (fucntions). Results are mixed and screwed to the better,
but my eye-brow raisers are:

- keywords `function` and `end` (Ruby, no!)
- dictionary syntax, `=>`
- common namespace of `using` imports
   

Julia, thanks!
---------------

- type system - if I had to name a single best feature about the language that would be it
- one line function defintions `greet(name::String) = println("Hello, $name")`
- simple tests with `@assert`, `@test`, `@throws` 
- greeks support: `\beta<tab>`
- user-defined function [vectorisation](https://julialang.org/blog/2017/01/moredots) `.f`

Julia, at par
-------------

- [fast compiler](https://www.sas.upenn.edu/~jesusfv/Update_March_23_2018.pdf), but you 
  would not notice much advantage over Numba python or Cython


Julia, I'm learning!
--------------------

- built-in package manager: `]` vs `pip`
- macros
- multiple dispatch
- [own neat forum](https://discourse.julialang.org/) vs Stack Overflow
- one-based index: I got convinced zero-based was a true thing
- overlapping packages of different provenance for similar tasks,
  annoying for beginner, but hey it is a young ecosystem (was it this 
  way in early python?)

Julia, we are hoping
--------------------

As opposed to *Julia, why*, which is not likely to be corrected, there are few things that 
actually may improve.

I side with [this user](https://discourse.julialang.org/t/list-of-most-desired-features-for-julia-v1-x/4481/83)
for julia dev priorities: 

- compiling to executables 
- better error messages 
- a debugger

Also integration with Spyder IDE could be nice, mentioned in that thread. Spyder seems to carry the 
traditions on RStudio and Matlab for 'scientific experimentation' with code, enabling to try small parts
of code and assembling larger programs. Technically, other IDEs do not forbid that, practically,
Spyder much more convinient for that, even though I have a feeling it falls out of mainstream IDEs
(too much focus of Jupyter now). 

Documentation - the style of writing large chunks of text, before getting practical. 
Please be courageous to scrap some of it for the better. 

However, one should remember to take [free software as gift](https://gist.github.com/richhickey/1563cddea1002958f96e7ba9519972d9), so I'm grateful to what Julia achieved so far and that there is for us to use.


Rules of thumb 
--------------

1. Do not make Julia your **first programming language** - there are far less 
   examples on Stack Overflow than python and R, which limits quick 
   googling-learning, also choosing a proper library is sometimes ambigious.  
   Julia borows heavily from python, R, Matlab, lisp, maybe haskell, 
   and some features are better exposed and documented there than in Julia. 

2. For some tasks the speed up comes from compiler, but often C-based 
   python libraries are faster and better developed. The real sweet spot
   is ability to do **static typing**, this will help julia develop long-term 
   over python (extreme view: any dynamically typed program over 200 lines 
   of code is trash).

3. Skip a question which is a better language to learn - **start with some microtasks**
   in any language and see where your progress is the fastest. Learn any second  
   language because you are likely in a trap of some sacrifices been made by 
   developpers of the first language you learnt. That means you of not likely to write 
   scalable and maintainable programs in the first language of your choice. 

Suggested reading
------------------


### Priority

- I like all the stack of Quantecon.org both for python and Julia, there are lectures and quick cheatsheets,
  the pace of delivery and wording are very good to me. Recommended even if you are not in economics, this part of 
  lectures is very general.

- [How is Julia different form other programming languages](https://docs.julialang.org/en/v1/manual/noteworthy-differences/) 
  is a good section in Julia docs, very saturated with food for thought.

- Some cheatsheets, like [1](https://juliadocs.github.io/Julia-Cheat-Sheet/), [2](https://cheatsheets.quantecon.org/julia-cheatsheet.html). 

- I also find R-Matlb-numpy-Julia comparison charts very fruitful and quick to grasp. They are a bit hard to maintain,
  there is one very detailed [here at hyperpolyglot](http://hyperpolyglot.org/numerical-analysis2#numpy), 
  one by Sebastian Raschka [here](http://sebastianraschka.com/Articles/2014_matrix_cheatsheet.html), and
  several at [quantecon.org](https://cheatsheets.quantecon.org/), you can also Goolge some others.

### Other choices

- Of course, we all should [read the docs](https://docs.julialang.org/en/v1.1-dev/), but Julia docs 
  are a bit of a pain to read through in some sections - too much blind text.   

- [Think Julia: How to Think Like a Computer Scientist](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html) - a replica of similar python book, nice, but a bit too long

- I like Bogumil Kaminski's work and his [quick intro](http://bogumilkaminski.pl/files/julia_express.pdf) to Julia, it is just 12 pages and gives you an idea of the language (a PDF could use some syntx highlighting, though). 

- [Julia Tutorial by J Fernandez-Villaverde](https://www.sas.upenn.edu/~jesusfv/Chapter_HPC_8_Julia.pdf), a part of larger 
   work of computatinal economics.

- [Exploring Julia. A Statistical Primer](https://people.smp.uq.edu.au/YoniNazarathy/julia-stats/exploring-julia-a-statistical-primer-DRAFT.pdf), nice 200+ pages on stats and Julia.