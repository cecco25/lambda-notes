#import "../lib.typ": *

#show: lambda-notes.with(
  title: "Algorithms and Data Structures",
  author: "Example Author",
  date: "Fall 2026",
  subject: "lambda-notes showcase",
  keywords: ("algorithms", "data structures", "typst", "template"),
  color: blue,
  show-outline: true,
  outline-title: [Contents],
  chapter-label: [Chapter],
)

= Getting started

This document is a tour of the *lambda-notes* template. Every page you see was
produced by the template's styling: the chapter titles, the running header at the
top of the page, the tables, the code blocks, and the algorithm figures.

Links come in two colors. External links like
#link("https://typst.app")[the Typst website] use the theme color, while internal
links like #link(<components>)[the components chapter] or
#link(<sorting>)[the sorting chapter] are shown in green, so you can tell
navigation apart from the outside world at a glance. Plain references such as
@sorting work too.

== Headings

Level-1 headings open a new chapter on a fresh page, with a small tracked
"Chapter N" label, a large title, and a rule. Level-2 and level-3 headings are
numbered and tinted with the theme color.

=== A third-level heading

Deeper headings keep the same numbering scheme, e.g. `1.1.1`.

== Running header

Starting from the second page of a chapter, the header shows the current chapter
on the left and the current section on the right. Look at the top of the next
pages to see it change as sections go by.

= Components <components>

== Notes

#note[
  A `note` is a plain, undecorated aside. It ignores the theme color, so it
  stays neutral no matter how the document is styled.
]

#note[
  Notes can hold anything: *bold*, _italic_, `inline code`, and math like
  $sum_(i=1)^n i = (n(n+1)) / 2$.
]

== Callouts

Callouts take an optional `title` and a `color`, which makes them handy for
building your own vocabulary of boxes.

#callout(title: "Definition", color: blue)[
  A *graph* is a pair $G = (V, E)$ where $V$ is a set of vertices and
  $E subset.eq V times V$ is a set of edges.
]

#callout(title: "Theorem", color: purple)[
  Every comparison-based sorting algorithm performs $Omega(n log n)$
  comparisons in the worst case.
]

#callout(title: "Tip", color: green)[
  Use a hash map when you need $O(1)$ average-case lookups by key.
]

#callout(title: "Warning", color: orange)[
  Quicksort degrades to $O(n^2)$ on already-sorted input if the pivot is always
  the first element.
]

#callout(title: "Common mistake", color: red)[
  Forgetting the base case of a recursive function leads to infinite recursion.
]

#callout(color: gray)[
  The title is optional: without it, a callout is just a tinted box.
]

== Tables

The header row picks up a tint of the theme color, body rows are zebra-striped,
and the first column is left-aligned while the others are centered.

#figure(
  table(
    columns: 4,
    [*Data structure*], [*Access*], [*Search*], [*Insert*],
    [Array], [$O(1)$], [$O(n)$], [$O(n)$],
    [Linked list], [$O(n)$], [$O(n)$], [$O(1)$],
    [Hash table], [—], [$O(1)$], [$O(1)$],
    [Binary search tree], [$O(log n)$], [$O(log n)$], [$O(log n)$],
    [Heap], [$O(1)$], [$O(n)$], [$O(log n)$],
  ),
  caption: [Average-case complexity of common data structures.],
) <complexity>

@complexity summarizes the trade-offs; figures are numbered and can be
referenced like any other label.

== Code

Inline code such as `let x = 42` gets a small highlighted box. Code blocks are
rendered with #link("https://typst.app/universe/package/codly")[codly], with a
language icon for each snippet.

```python
def fibonacci(n: int) -> int:
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a
```

```c
int gcd(int a, int b) {
    while (b != 0) {
        int t = b;
        b = a % b;
        a = t;
    }
    return a;
}
```

```rust
fn is_prime(n: u64) -> bool {
    if n < 2 {
        return false;
    }
    (2..).take_while(|i| i * i <= n).all(|i| n % i != 0)
}
```

```java
public class Stack<T> {
    private final List<T> items = new ArrayList<>();

    public void push(T item) { items.add(item); }
    public T pop() { return items.remove(items.size() - 1); }
}
```

== Math

Math is plain Typst math, set in the body text style:

$ T(n) = 2 T(n / 2) + Theta(n) quad => quad T(n) = Theta(n log n) $

= Sorting algorithms <sorting>

Pseudocode is written with the
#link("https://typst.app/universe/package/algorithmic")[algorithmic] package,
styled to match the rest of the document.

== Binary search

#algorithm-figure(
  "Binary search",
  {
    Procedure(
      "BINARY-SEARCH",
      ("A", "target"),
      {
        Assign[lo][0]
        Assign[hi][$|A| - 1$]
        While($"lo" <= "hi"$, {
          Assign[mid][$floor(("lo" + "hi") / 2)$]
          If($A["mid"] = "target"$, {
            Return[mid]
          })
          ElseIf($A["mid"] < "target"$, {
            Assign[lo][$"mid" + 1$]
          })
          Else({
            Assign[hi][$"mid" - 1$]
          })
        })
        Return[$-1$]
      },
    )
  },
) <binary-search>

@binary-search runs in $O(log n)$ time on a sorted array of size $n$.

== Insertion sort

#algorithm-figure(
  "Insertion sort",
  {
    Procedure(
      "INSERTION-SORT",
      ("A", "n"),
      {
        For($i = 2 "to" n$, {
          Assign[key][$A[i]$]
          Comment[Insert $A[i]$ into the sorted prefix $A[1..i-1]$]
          Assign[j][$i - 1$]
          While($j > 0 "and" A[j] > "key"$, {
            Assign[$A[j+1]$][$A[j]$]
            Assign[j][$j - 1$]
          })
          Assign[$A[j+1]$][key]
        })
      },
    )
  },
) <insertion-sort>

#callout(title: "Complexity", color: blue)[
  @insertion-sort is $O(n^2)$ in the worst case but $O(n)$ on nearly-sorted
  input, which makes it a good fallback for small subarrays.
]

== Heapsort

#algorithm-figure(
  "Heapsort",
  {
    Procedure(
      "HEAPSORT",
      ("A", "n"),
      {
        Call("BUILD-MAX-HEAP", [A, n])
        For($i = n "downto" 2$, {
          Comment[Move the current maximum to the end]
          Assign[$A[1], A[i]$][$A[i], A[1]$]
          Assign[A.heap-size][$"A.heap-size" - 1$]
          Call("MAX-HEAPIFY", [A, 1])
        })
      },
    )
  },
) <heapsort>

== Comparison

#table(
  columns: 4,
  [*Algorithm*], [*Best*], [*Average*], [*Worst*],
  [Insertion sort], [$O(n)$], [$O(n^2)$], [$O(n^2)$],
  [Heapsort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$],
  [Merge sort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$],
  [Quicksort], [$O(n log n)$], [$O(n log n)$], [$O(n^2)$],
)

#note[
  Back to #link(<components>)[the components chapter], or read about theming
  in the next chapter.
]

= Theming

The whole look is driven by a single `color` argument: chapter titles, rules,
headings, links, and table headers all derive from it. Try swapping `blue` at the
top of this file for `rgb("#8E24AA")`, `olive`, or `none` for a plain
black-and-white document.

```typ
#show: lambda-notes.with(
  title: "Networking",
  color: rgb("#1E88E5"),
  chapter-label: [Capitolo],
  outline-title: [Indice],
)
```

`chapter-label` and `outline-title` let you localize the template, for example
into Italian as shown above.

= Accessibility

All of the accessibility settings for the document can be configured through the `#show: lambda-notes.with` block.

```typ
#show: lambda-notes.with(
  title: "Algorithms and Data Structures",
  author: "Example Author",
  subject: "lambda-notes showcase",
  keywords: ("algorithms", "data structures", "typst", "template"),
)
```

These attributes will show up in the PDF metadata.
