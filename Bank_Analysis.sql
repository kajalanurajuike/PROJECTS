
show tables;

select * from finance_1;
select * from finance_2;

/*Year wise loan amount Stats

Grade and sub grade wise revol_bal

Total Payment for Verified Status Vs Total Payment for Non Verified Status

State wise and last_credit_pull_d wise loan status

Home ownership Vs last payment date stats
*/

# KPI 1
select issue_d, loan_amnt from finance_1;

select year(issue_d) as Year_Issue_d, concat("$",format(sum(loan_amnt)/1000000,2),"M") as Total_loan
 from finance_1
 group by Year_Issue_d
 order by Year_Issue_d desc;

#KPI 2

select grade,sub_grade, concat("$",format(sum(revol_bal)/1000000,2),"M") as Total_revol_bal from finance_1 inner join finance_2 on (finance_1.id = finance_2.id) 
group by grade,sub_grade order by grade,sub_grade;


#KPI 3

select verification_status, concat("$",format(round(sum(total_pymnt)/1000000,2),2),"M") as Total_payment  
from finance_1 inner join finance_2 on (finance_1.id = finance_2.id)  
 group by  verification_status having  verification_status in('verified','not verified');


select verification_status, concat("$",format(round(sum(total_pymnt)/1000000,2),2),"M") as Total_payment 
from finance_1 inner join finance_2 on (finance_1.id = finance_2.id)  group by verification_status;


#KPI 4

select addr_state,last_credit_pull_d,loan_status 
from finance_1 inner join finance_2 on (finance_1.id = finance_2.id)
group by addr_state,last_credit_pull_d,loan_status
order by last_credit_pull_d;

#KPI 5

select home_ownership,(last_pymnt_d),
concat("$",format(round(sum(last_pymnt_amnt)/1000,2),2),"k") as last_pymnt_amnt 
from finance_1 inner join finance_2
on(finance_1.id = finance_2.id)
group by home_ownership,last_pymnt_d order by home_ownership,last_pymnt_d ;
