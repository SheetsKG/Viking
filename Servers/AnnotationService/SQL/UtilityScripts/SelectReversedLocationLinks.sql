/****** Script for SelectTopNRows command from SSMS  ******/
Delete R
FROM LocationLink R
	inner join 
	(select A as AA,B as BB FROM LocationLink) L2
	ON A = L2.BB AND B=L2.AA
	WHERE B < A
	
Update LocationLink
 set A = B, B = A 
 from LocationLink
 where B < A
 
 select * from LocationLink