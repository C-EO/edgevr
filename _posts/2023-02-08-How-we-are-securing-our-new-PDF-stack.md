---
title: "Behind the Scenes: How we are securing our new PDF stack"
author: Gareth Evans
date: 2023-02-08 03:00:00 -0800
categories: [Vulnerabilities]
tags: [Memory Corruption, fuzzing]
math: true
author_twitter: kryc_uk
---

As we recently published on the [Microsoft Edge Dev blog], Adobe and Microsoft 
are enhancing the PDF experience and value users have come to expect in 
Microsoft Edge. Adobe brings an unrivalled breadth of experience in the PDF 
space, and we are looking forward to unveiling new features and experiences 
with them in the future. The Microsoft Edge Vulnerability Research team has 
been heavily involved in this process and want to share some of the work that 
we have been doing alongside our colleagues at Adobe to help ensure your PDF 
experience is secure.

[Microsoft Edge Dev blog]: https://aka.ms/AdobeEdgeFAQ

One of the key pillars of our strategy for maintaining the security standards 
of Microsoft Edge is to “make exploits hard”. A significant part of our work 
in PDF was to ensure that we made no compromises on the security-enforcing 
technologies already deployed in our PDF stack. One such technology is 
PartitionAlloc, a highly performant, dynamic, and secure heap implementation 
developed on Chromium, which is designed with security in mind. This 
technology is already used extensively across Microsoft Edge. If you are not 
familiar with PartitionAlloc, a comprehensive introduction can be found in 
the [design docs]. To put it simply, PartitionAlloc is designed in such a way 
as to keep objects of different types separate from each other with minimal 
intervention from the developer. An example of a security mechanism it 
provides is the ability to break exploitation primitives by isolating objects 
using Partitions and [MiraclePtr/*Scan] (two mitigations that aim to minimize 
the impact of Use-After-Free (UAF) vulnerabilities). This unique heap 
implementation provides a rapid understanding of vulnerabilities and a 
strong layer of protection that the new PDF stack will benefit from. 

[design docs]: https://chromium.googlesource.com/chromium/src/+/refs/heads/main/base/allocator/partition_allocator/PartitionAlloc.md
[MiraclePtr/*Scan]: https://www.youtube.com/watch?v=ohlxw5kDn-k

Alongside PartitionAlloc, we ensured that a suite of additional technical 
countermeasures, also already used across Microsoft Edge, were compatible 
with the new PDF stack. This includes compile-time mitigations such as 
Intel’s new Control Flow Enforcement Technology (CET), enabled in Microsoft 
Edge with update 94 for CPUs that support it. This complements Microsoft’s 
own Control Flow Guard (CFG). We are pleased to announce that our new PDF 
stack will benefit from all these technologies in addition to the industry 
standard protections expected from modern compilation toolchains.  

The second pillar of our approach to security is to “make exploits rare”. 
Strategically, this means building and running our fuzz-testing capabilities. 
Readers who are unfamiliar with fuzzing can look at the [brief intro to fuzzing]
 prepared by our colleagues in Microsoft Research. The article provides 
detailed insight into just how important this tool is for developers. In our 
Microsoft Edge Vulnerability Research blog, most articles, in some way, 
mention our use of fuzzing as one of our main tools for identifying potential 
security issues in Microsoft Edge. Whilst the technique has been used for 
quite some time, it is only in recent years that the tooling and compiler 
support has matured to the point where it became more easily integrated into 
the development lifecycle. Prior to this support, fuzzing was more often done 
via grammar or syntax-based solutions such as Peach Fuzzer. We have invested 
significant effort in building out our fuzzing support for this project, 
surpassing the coverage numbers currently achieved.  

[brief intro to fuzzing]: https://www.microsoft.com/en-us/research/blog/a-brief-introduction-to-fuzzing-and-why-its-an-important-tool-for-developers/

A significant string to our fuzzing bow is the use of the Microsoft owned 
[OneFuzz] solution to power our aggressive scaling requirements. More 
information on OneFuzz can be found on the project website, but in essence it 
is a scalable fuzzing solution powered by the Microsoft Azure cloud 
infrastructure. To complement the fuzzing resources from Microsoft, Adobe has 
also deployed their own OneFuzz-based solution. To date Microsoft has 
developed 61 unique fuzzers for the new PDF stack (and counting), covering 
features from the document parser to image streams. The Microsoft security 
team has been running these fuzzers 24 hours a day for the past year, an 
expenditure of almost 1 million compute hours in fuzzing alone. Typical issues 
discovered have been common memory corruption bugs, out of bound reads and 
writes, and an occasional type-confusion bug. This is all just part of a larger
 commitment to security by Adobe and Microsoft.

[OneFuzz]: https://github.com/microsoft/onefuzz

The final pillar of our approach to security is to engage with our researcher 
and user communities. Ensuring that our PDF solution is covered within the 
scope of the Microsoft [incentive program] is core to our success and we are 
pleased to announce its inclusion. Issues in PDF will be eligible for bounty 
awards within the existing framework of our [incentive program]. We plan to 
provide our researcher community with the tools and guidance to effectively 
perform research against our new PDF library. We will begin accepting reports 
through the [MSRC portal] as soon as the feature makes it to the Stable channel 
later in 2023. Keep an eye out for more details on this! 

[incentive program]: https://www.microsoft.com/en-us/msrc/bounty-new-edge#:~:text=The%20goal%20of%20the%20Microsoft%20Edge%20Bounty%20Program,following%20criteria%20to%20be%20eligible%20for%20bounty%20awards%3A
[MSRC portal]: https://msrc.microsoft.com/

We look forward to continued collaboration with Adobe to bring greater value 
and peace of mind to our users. We are also excited to connect with you, the 
community, for your feedback on this solution and your contributions to the bug 
bounty, as we strive to build the best and most secure PDF solution. 