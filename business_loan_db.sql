SELECT * FROM business_loan


1. -- Understand how companies use their loans across activities.

SELECT purpose, AVG(loan_amount) AS avg_loan_amount, SUM(loan_amount) AS total_loan_amount
FROM business_loan
GROUP BY purpose
ORDER BY total_loan_amount DESC;


 2. -- Identify patterns in loan repayments and influencing factors.

-- Loan status and payment patterns

SELECT loan_status, ROUND(AVG(total_payment)) AS avg_payment, COUNT(*) AS loan_count
FROM business_loan
WHERE loan_status IN ('Current', 'Fully Paid', 'Late', 'Charged Off')
GROUP BY loan_status;

-- Delinquencies and late payments

SELECT loan_status, member_id, loan_amount, last_payment_date, emp_title
FROM business_loan
WHERE loan_status = 'Late' OR loan_status = 'Charged Off'
ORDER BY loan_status DESC, emp_title DESC
LIMIT 100000;


3. -- Derive sector-specific financial insights.

SELECT purpose, ROUND(AVG(annual_income)) AS avg_income, AVG(dti) AS avg_dti, COUNT(*) AS loan_count
FROM business_loan
GROUP BY purpose
ORDER BY loan_count DESC;


4. -- Analyze how loans contribute to business growth.

SELECT emp_title, annual_income, loan_amount, (total_payment - loan_amount) AS net_gain
FROM business_loan
WHERE annual_income IS NOT NULL AND loan_amount IS NOT NULL
ORDER BY net_gain DESC;


5. -- Evaluate risk levels based on size, sector, and loan amount.

-- Risk by Loan Amount

SELECT id, emp_title, grade, loan_amount, dti, home_ownership
FROM business_loan
WHERE grade IN ('D', 'E', 'F') OR loan_amount > 1000000
ORDER BY emp_title ASC;

-- Risk by Sector
SELECT purpose, ROUND(AVG(loan_amount)) AS avg_loan, AVG(dti) AS avg_dti, COUNT(*) AS risky_loans
FROM business_loan
WHERE grade IN ('D', 'E', 'F', 'G')
GROUP BY purpose
ORDER BY risky_loans DESC;


6. -- Identify the most common loan purposes.

SELECT purpose, COUNT(*) AS loan_count
FROM business_loan
GROUP BY purpose
ORDER BY loan_count DESC;


7. -- Find Members with More Than 10 Total Accounts

SELECT emp_title, total_acc
FROM business_loan
WHERE total_acc > 10
ORDER BY total_acc DESC;


8. -- Retrieve Borrowers with Sub-Grade 'A1'

SELECT emp_title, member_id, sub_grade, loan_amount
FROM business_loan
WHERE sub_grade = 'A1'
ORDER BY loan_amount DESC;


9. -- Total Loans and Average Income by Application Type

SELECT application_type, COUNT(*) AS total_loans, ROUND(AVG(annual_income)) AS average_income
FROM business_loan
GROUP BY application_type;


10. -- Maximum Installment Amount

SELECT MAX(installment) AS max_installment
FROM business_loan;


11. -- All Homeowners with Loans Above ₹50,00,000

SELECT id, member_id, home_ownership, loan_amount
FROM business_loan
WHERE home_ownership = 'Own' AND loan_amount > 40000;


12. -- Total Payments for Each Loan Purpose

SELECT purpose, SUM(total_payment) AS total_payment_sum
FROM business_loan
GROUP BY purpose;


13. -- Total Loans by Loan Status

SELECT loan_status, COUNT(*) AS total_loans
FROM business_loan
GROUP BY loan_status;


14. -- Borrowers Not Verified for Employment

SELECT id, emp_title, verification_status
FROM business_loan
WHERE verification_status = ('Not Verified');


15. -- Average Interest Rate by Grade

SELECT grade, AVG(int_rate) AS average_interest_rate
FROM business_loan
GROUP BY grade
ORDER BY grade ASC;

16. -- Loans with Late Status

SELECT id, emp_title, member_id, loan_status
FROM business_loan
WHERE loan_status = 'Late'
GROUP BY id, emp_title, member_id, loan_status
ORDER BY emp_title ASC;


17. -- Members with Loan Applications Exceeding ₹10,00,000

SELECT member_id, loan_amount
FROM business_loan
WHERE loan_amount > 1000000;

