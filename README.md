# Power-Market-Operations-Final-Project-Unit-Commitment

Security-Constrained Unit Commitment Programming Project


Submitted for graduate course Power Market Operations – May 9th, 2005


Project Blog Site is here: https://portfolio.katiegirl.net/2017/12/20/security-constrained-unit-commitment-programming-project/


This project discusses the security-constrained unit commitment programming project guidelines, formulations, high-level and low-level programming, and procedures to complete a secure and economical system model. Low-level programming was completed for the unit commitment portion. In lieu of security program, a high-level process flow will show security based constraints due to the author’s own constraints discussed in the comments section of the report.


Introduction


Security-Constrained Unit Commitment (SCUC) consists of two components, system security, and economic dispatch. The objective of the problem is focused solely on the economic dispatch of generators with bidding segments, no load costs, starting costs, and other costs incurred during operation. Least cost is desired according to the system operators. Simple economics dictates that generators can supply (X) MW of power at location xyz and deliver the power through the transmission lines L123. However, this is not such a simple problem of who can “bid the lowest price” and win the contract in a short period of time. Location, transmission design, and the generator’s operating efficiencies are conglomerated together to form a complex set of questions that the system operators must answer using analysis before awarding contracts to independent power producers. Thus, much planning and analysis are needed to determine the minimal cost that satisfies system security.


The power market operations course has set guidelines to help make cost-effect and secure dispatch decisions for diverse system models. The final project for the course outlines a good practice problem of determining the least-cost dispatch for three generators, 5 transmission lines, phase shifters, and bidding segments. The problem definition will describe the project overview with given information and final expectations. The game plan will then be drawn to show how the author tackled the challenge. Program components are discussed to categorize the project portions into manageable sub-programming projects. Finally, the process flow shows a high-level procedure for the life of the program.