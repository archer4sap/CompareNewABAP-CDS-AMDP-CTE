# CompareNewABAP-CDS-AMDP-CTE
Comparison of New ABAP, CDS, AMDP and CTE

To compare runtime for each, I am executing each for 10 times and taking average of them.
I am not giving time for CTE because it has a different use case than a simple join. You can anyway go ahead and execute by yourself to see CTE performance.
All Times in milli-seconds!

	  Open SQL	CDS	      AMDP
1	  264.16	  228.28	  197.63
2	  178.751	  204.22	  223.59
3	  210.28	  201.12	  219.49
4	  203.02	  184.15	  223.47
5	  207.51	  170.6	    221.25
6	  182.65	  207.63	  207.4
7	  194.28	  170	      209.98
8	  195.05	  181.01	  238.32
9	  215.18	  170.15	  232.45
10	184.97	  161.35	  208.81
-----------------------------------
Avg	203.5851	187.851	  218.239

Conclusion:
Open SQL, CDS and AMDP are not competitors for each other and they have different use-cases.

In this particular case of joining 4 tables, CDS is clear winner followed by open SQL and AMDP.


Best Regards,
archer4sap@gmail.com 
