---
title: "Searching for Exotrojans in Pulsar Systems"
authors:
  - "Jackson D. Taylor"
  - "Emmanuel Fonseca"
  - "Lankeswar Dey"
  - "Sergey Zharikov"
  - "Aida Kirichenko"
  - "Joseph Glaser"
  - "Gabriella Agazie"
  - "Akash Anumarlapudi"
  - "Anne M. Archibald"
  - "Zaven Arzoumanian"
authorPosition: 1
firstAuthor: true
authorsTruncated: true
authorCount: 53
journal: "The Astrophysical Journal"
volume: "1000"
articleNumber: "82"
pages: "16 pp."
year: 2026
published: 2026-03-13
doi: "10.3847/1538-4357/ae4317"
topic: "Exotrojans"
weight: 100
explainer: "trojan-libration"
explainerReviewed: true
figures:
  - src: "/figures/exotrojans/tadpole-orbit.webp"
    kind: "result"
    unpublished: true
    alt: >-
      A plot headed "Pulsar, companion, and trojan position (rotating frame)", with both axes
      marked in units of the orbital separation. A black dot sits at the origin and a short red
      streak at x = 1.0, y = 0. Between and above them, at about x = 0.5, y = 0.87, a grey dot is
      labelled the stable point. A thick blue band curves around that grey dot, broad and rounded
      at its lower-right end near x = 0.75 and tapering towards the upper left at x = 0.13, with a
      narrow split running along its middle.
    caption: >-
      This is a computed path of a Trojan that starts away from the stable point, followed for
      many orbits in a frame that turns with the binary so only the Trojan moves. It swings
      around the point and comes back, tracing the same tadpole as the explainer above. We
      looked for this signal around eight pulsars and found no Trojan.
  - src: "/figures/exotrojans/trojan-libration-poster.webp"
    kind: "animation"
    unpublished: true
    video:
      mp4: "/figures/exotrojans/trojan-libration.mp4"
      webm: "/figures/exotrojans/trojan-libration.webm"
      poster: "/figures/exotrojans/trojan-libration-poster.webp"
    alt: >-
      An animation of a three-body system seen from above. A green pulsar sits at the centre, a
      red planet orbits it, and a blue asteroid starts 60 degrees ahead of the planet on the
      same orbit. As the animation runs, the asteroid drifts slowly back and forth around that
      point while the planet keeps circling.
    caption: >-
      A Trojan sits near one of the two points 60 degrees ahead of or behind a companion in its
      orbit, and swings slowly back and forth about that point. The slow swing, called
      libration, is what tugs on the pulsar and shows up in the arrival times of its pulses.
  - src: "/figures/exotrojans/zombies-logo.webp"
    kind: "logo"
    unpublished: true
    alt: >-
      The ZOMBIES project logo: a small grey clock face at the centre of a set of nested
      orbits, with a red star and a tiny green companion circling each other on one side, a
      blue body on a wider shared orbit, and a black body on the outermost circle, while a
      pale blue object swings past from outside on an open curve.
lay:
  reviewed: true
  hook: >-
    We looked for features of our own solar system, Trojans, around eight pulsars. We did
    not find any, but placed the first limits on how heavy Trojans around pulsars can be.
  keyNumber:
    value: "~1 Earth mass"
    label: "is the heaviest Trojan that could be hiding around these eight pulsars without us seeing it"
  whatWeDid: >-
    Jupiter shares its orbit with thousands of asteroids. They gather at two points, one 60
    degrees ahead of the planet and one 60 degrees behind. There, the pull of the Sun and of
    Jupiter combine into just the force needed to carry a body around at Jupiter's own pace.
    These bodies are known as Trojans, because the first Trojan was named after a hero in
    the Trojan War. Despite their multitude in our own solar system, astronomers have yet to
    find them around another star. We searched around pulsars that have binary companions to
    see if they host any Trojans. Pulses from a pulsar arrive on a schedule that can be
    predicted very accurately, so a Trojan in the system would tug the pulsar around and
    leave a unique marker in those arrival times. We searched the arrival times of eight
    pulsars in the NANOGrav 15 year dataset.
  whatWeFound: >-
    No Trojans. Across all eight pulsars nothing in the times of arrival indicates Trojans.
    However, we found that a Trojan in those systems could be lighter than the Earth and
    still not detectable. Two systems, PSR J0023+0923 and PSR J1705−1903, show a weak signal
    of the sort a Trojan of two to four Jupiter masses would make, but we think that these
    are false positives. For the PSR J1641+8049 system, we looked for inconsistencies
    between an optical light curve and the radio times of arrival and ruled out Trojans
    heavier than about eight Jupiters.
  whyItMatters: >-
    Trojans are common in our own solar system, so it is reasonable to ask whether they
    exist elsewhere. Nobody had done a serious study of Trojans around pulsars before. These
    are the first observational limits on pulsar-bound Trojans. If Trojans are absent, then
    their absence must be explained. We don't rigorously investigate how Trojans could form
    around pulsars, leaving that to more theoretical work.
  analogy: >-
    Imagine driving on a highway. The cars next to you won't appear to be driving that fast,
    because you're cruising along with them. From Jupiter's perspective, the Trojans appear
    to hardly move at all, just like how a driver doesn't perceive neighboring cars to be
    moving. What makes Trojans interesting is that if you give them a tiny shove, then they
    will oscillate back and forth while in orbit, so from Jupiter's perspective they would
    be moving. This jostling back and forth is what we can measure with respect to Trojans
    in pulsar systems.
  glossary:
    - term: "Trojan"
      definition: >-
        A small body that shares a larger body's orbit, sitting near one of the two stable
        points 60 degrees ahead of or behind it. Jupiter has at least thousands of them.
    - term: "Exotrojan"
      definition: >-
        A Trojan in another star system. None have been confirmed, although there are
        candidates.
    - term: "Libration"
      definition: >-
        The slow rocking of a Trojan back and forth around its stable point rather than
        sitting still. That rocking is what makes it detectable.
    - term: "Times of arrival"
      definition: >-
        The moments a pulsar's pulses reach the telescope. Comparing them with a model is
        how pulsar astronomers make inferences.
    - term: "NANOGrav 15 year dataset"
      definition: >-
        Fifteen years of precisely timed observations of dozens of millisecond pulsars,
        collected by the NANOGrav collaboration.
---

## Abstract

Trojan asteroids are found in the equilateral triangle Lagrange points of the Sun–Jupiter system in a great number, although they also exist less prolifically in other parts of the solar system. Despite up to planetary mass Trojans being predicted in extrasolar systems (i.e., exotrojans), they remain unconfirmed, although strong candidate evidence has emerged recently. For the first time, we extend the search for exotrojans to radio pulsars with low-mass (∼0.01 M⊙) companions using accurately measured pulse times of arrival. With techniques developed for detecting the reflex motion of a star due to a librating Trojan, we place ∼1 M⊕ upper mass constraints on potential exotrojans around eight pulsars observed in the NANOGrav 15 yr dataset. We find weak evidence consistent with ∼2–4 MJ exotrojans in the PSR J0023+0923 and PSR J1705−1903 binary systems, although the signals likely have a different, unknown source. We also place a libration-independent upper mass constraint of ∼8 MJ on exotrojans in the PSR J1641+8049 system by looking for an inconsistency between the times of superior conjunction as measured by optical light curves and those predicted by radio timing. These results offer initial observational constraints on the existence of exotrojans around pulsars, while their possible formation mechanisms remain unexplored.
