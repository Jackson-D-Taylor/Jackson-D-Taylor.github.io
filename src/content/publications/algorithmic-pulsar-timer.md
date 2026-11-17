---
title: "Algorithmic Pulsar Timer for Binaries"
authors:
  - "Jackson Taylor"
  - "Scott Ransom"
  - "Prajwal V. Padmanabh"
authorPosition: 1
firstAuthor: true
authorsTruncated: false
authorCount: 3
journal: "The Astrophysical Journal"
volume: "964"
articleNumber: "128"
pages: "10 pp."
year: 2024
published: 2024-03-22
doi: "10.3847/1538-4357/ad1ce9"
topic: "Pulsar timing"
weight: 100
explainer: "count-the-turns"
explainerReviewed: true
figures:
  - src: "/figures/algorithmic-pulsar-timer/solution-tree-j2109.webp"
    kind: "result"
    unpublished: true
    alt: >-
      A tree diagram titled "Solution Tree for J2109+50". Depth runs from 0 at the top to 20
      at the bottom, one level for each observation added. Short branches on the left and
      right die out within three levels. A single column down the middle keeps going all the
      way to the bottom, shading from dark purple to yellow as later observations are folded
      in. That surviving column is the one rotation count consistent with every observation.
    caption: >-
      Each level of the tree adds one more observation. The branches are competing guesses at
      how many rotations the pulsar made during the gap, and the statistical tests cut away
      the ones that fail. Here a single path survives to the bottom.
  - src: "/figures/algorithmic-pulsar-timer/solution-tree-sidelobe.webp"
    kind: "result"
    unpublished: true
    alt: >-
      A second solution tree, titled "Solution Tree for sidelobe", running 54 levels deep.
      Several branches survive for ten or more levels before stopping, and one long column on
      the left reaches the bottom. Compared with the first tree, many more wrong rotation
      counts hold on for a while before the data rule them out.
    caption: >-
      In this harder case, wrong branches persist much longer and the tree grows deep before
      only one solution is left.
  - src: "/figures/algorithmic-pulsar-timer/aptb-logo.webp"
    kind: "logo"
    unpublished: true
    alt: >-
      The APTB project logo: the letters A, P, T, and B set along a tilted elliptical orbit,
      with a red star at one end of the ellipse and a small clock face at the other.
lay:
  reviewed: true
  hook: >-
    Timing a pulsar means counting every single rotation it makes even between telescope
    observations that can be months apart. We built a software that does this counting with
    minimal human input, allowing us to solve two newly discovered pulsars before any human
    could.
  keyNumber:
    value: "13 years"
    label: "of Green Bank Telescope observations tied together into one unbroken count of rotations"
  whatWeDid: >-
    A pulsar is a collapsed star that sweeps a radio beam past Earth like a lighthouse.
    Accounting for every rotation between observations allows astronomers to learn the
    position of the star, how fast it spins, how that speed is changing, and the shape of
    its orbit if it has a companion. What's difficult is that our prior understanding of the
    pulsar is sometimes so inaccurate that this process can take hours, days, or simply be
    impossible to be carried out by an astronomer. A telescope might not look at a pulsar
    for months, and the number of rotations missed in between has to be exactly right. We
    wrote an algorithm that explores possible missed rotation counts in a tree-like manner,
    checks each one with standard statistical tests, and discards branches that fail.
  whatWeFound: >-
    The method works. We used it to establish the timing solutions for two binary pulsars
    that had just been discovered in Terzan 5. Terzan 5 is a globular cluster (a big ball of
    stars) near the center of the Milky Way. These pulsars are called PSR J1748−2446aq and
    PSR J1748−2446at. For both, the algorithm pieced together about 70 Green Bank Telescope
    observations spread over 13 years.
  whyItMatters: >-
    A newly discovered pulsar is not much use to anyone until someone has worked out its
    timing solution, and doing that by hand takes both practice and a tightly controlled
    observing schedule. An algorithm that handles the counting lowers both of those costs,
    and it works on binary pulsars, which are trickier than pulsars without orbiting
    companions.
  analogy: >-
    Imagine having a clock that ticks at regular intervals, but you only stare at it once
    every month or so. Each glance tells you where the hand is pointing, but you don't know
    how many ticks you missed. To know how many you missed, you need to know how quickly the
    clock is ticking and whether that rate is itself changing. If you guess the wrong number
    of in-between ticks, then your analysis of the clock will be wrong. That's why we made
    an algorithm to systematically try possible tick numbers between glances and to throw
    out guesses that clearly misunderstand the clock.
  glossary:
    - term: "Pulsar"
      definition: >-
        A collapsed, fast-spinning star that sends out a beam of radio waves. We see a pulse
        each time the beam sweeps past Earth.
    - term: "Timing solution"
      definition: >-
        A model that accounts for every rotation a pulsar has made across years of
        observing. It gives the spin rate, the position on the sky, and characteristics of
        its orbit if there are any.
    - term: "Phase connection"
      definition: >-
        Knowing the exact number of rotations between two observations, with no ambiguity.
        It is what makes a timing solution precise.
    - term: "Binary pulsar"
      definition: >-
        A pulsar in orbit with another star. The orbital motion shifts the arrival times of
        the pulses, which adds unknowns to the timing solution.
    - term: "Globular cluster"
      definition: >-
        A tightly packed, ancient group of hundreds of thousands of stars. Terzan 5, where
        these two pulsars live, is a globular cluster.
---

## Abstract

Pulsar timing is a powerful tool that, by accounting for every rotation of a pulsar, precisely measures the spin frequency, spin frequency derivatives, astrometric position, binary parameters when applicable, properties of the interstellar medium, and potentially general relativistic effects. Typically, this process demands fairly stringent scheduling requirements for monitoring observations as well as deep domain knowledge to “phase connect” the timing data. We present an algorithm that automates the pulsar-timing process for binary pulsars, whose timing solutions have an additional level of complexity, although the algorithm works for isolated pulsars as well. Using the statistical F-test and the quadratic dependence of the reduced χ2 near a minimum, the global rotation count of a pulsar can be determined efficiently and systematically. We have used our algorithm to establish timing solutions for two newly discovered binary pulsars, PSRs J1748−2446aq and J1748−2446at, in the globular cluster Terzan 5, using ∼70 Green Bank Telescope observations from the last 13 yr.
