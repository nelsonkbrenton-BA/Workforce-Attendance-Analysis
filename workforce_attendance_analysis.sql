-- Workforce Attendance & Overtime Operations Analysis
-- Dataset: data/workforce_attendance_sample.csv
-- Recommended table name after import: workforce_attendance_sample
-- Grain: one row per employee scheduled shift
-- SQL style: ANSI-friendly queries using the modeled week_start_date and month_start_date fields.

-- 1. Total scheduled shifts
SELECT
    COUNT(*) AS scheduled_shifts
FROM workforce_attendance_sample;

-- 2. Attendance status breakdown
SELECT
    attendance_status,
    COUNT(*) AS scheduled_shifts,
    ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM workforce_attendance_sample), 0), 2) AS share_of_shifts_pct
FROM workforce_attendance_sample
GROUP BY attendance_status
ORDER BY scheduled_shifts DESC;

-- 3. Core attendance rate
SELECT
    COUNT(*) AS scheduled_shifts,
    SUM(present_flag) AS present_shifts,
    ROUND(100.0 * SUM(present_flag) / NULLIF(COUNT(*), 0), 2) AS attendance_rate_pct,
    SUM(absence_flag) AS absence_count,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct,
    SUM(late_flag) AS late_arrival_count,
    ROUND(100.0 * SUM(late_flag) / NULLIF(COUNT(*), 0), 2) AS late_arrival_rate_pct
FROM workforce_attendance_sample;

-- 4. Absence rate by department
SELECT
    department,
    COUNT(*) AS scheduled_shifts,
    SUM(absence_flag) AS absences,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct
FROM workforce_attendance_sample
GROUP BY department
ORDER BY absence_rate_pct DESC, scheduled_shifts DESC;

-- 5. Late arrival rate by department
SELECT
    department,
    COUNT(*) AS scheduled_shifts,
    SUM(late_flag) AS late_arrivals,
    ROUND(100.0 * SUM(late_flag) / NULLIF(COUNT(*), 0), 2) AS late_arrival_rate_pct
FROM workforce_attendance_sample
GROUP BY department
ORDER BY late_arrival_rate_pct DESC, scheduled_shifts DESC;

-- 6. Average minutes late by department
SELECT
    department,
    SUM(late_flag) AS late_arrivals,
    ROUND(AVG(CASE WHEN late_flag = 1 THEN minutes_late END), 2) AS avg_minutes_late
FROM workforce_attendance_sample
GROUP BY department
ORDER BY avg_minutes_late DESC;

-- 7. Average minutes late by employee
SELECT
    employee_id,
    employee_name,
    department,
    manager_name,
    COUNT(*) AS scheduled_shifts,
    SUM(late_flag) AS late_arrivals,
    ROUND(AVG(CASE WHEN late_flag = 1 THEN minutes_late END), 2) AS avg_minutes_late
FROM workforce_attendance_sample
GROUP BY employee_id, employee_name, department, manager_name
HAVING SUM(late_flag) > 0
ORDER BY late_arrivals DESC, avg_minutes_late DESC;

-- 8. Overtime hours and overtime cost by department
SELECT
    department,
    ROUND(SUM(overtime_hours), 2) AS overtime_hours,
    ROUND(SUM(overtime_labor_cost), 2) AS overtime_cost,
    SUM(overtime_flag) AS shifts_with_overtime,
    ROUND(100.0 * SUM(overtime_flag) / NULLIF(COUNT(*), 0), 2) AS overtime_shift_rate_pct
FROM workforce_attendance_sample
GROUP BY department
ORDER BY overtime_cost DESC;

-- 9. Repeat late employees: employees with 3+ late arrivals
SELECT
    employee_id,
    employee_name,
    department,
    manager_name,
    COUNT(*) AS scheduled_shifts,
    SUM(late_flag) AS late_arrivals,
    ROUND(AVG(CASE WHEN late_flag = 1 THEN minutes_late END), 2) AS avg_minutes_late,
    MAX(risk_level) AS risk_level,
    MAX(risk_reason) AS risk_reason
FROM workforce_attendance_sample
GROUP BY employee_id, employee_name, department, manager_name
HAVING SUM(late_flag) >= 3
ORDER BY late_arrivals DESC, avg_minutes_late DESC;

-- 10. Absence and overtime relationship by department
SELECT
    department,
    COUNT(*) AS scheduled_shifts,
    SUM(absence_flag) AS absences,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct,
    ROUND(SUM(overtime_hours), 2) AS overtime_hours,
    ROUND(SUM(overtime_labor_cost), 2) AS overtime_cost,
    SUM(coverage_gap_flag) AS coverage_gaps
FROM workforce_attendance_sample
GROUP BY department
ORDER BY absence_rate_pct DESC, overtime_cost DESC;

-- 11. Weekly trend analysis
SELECT
    week_start_date,
    COUNT(*) AS scheduled_shifts,
    ROUND(100.0 * SUM(present_flag) / NULLIF(COUNT(*), 0), 2) AS attendance_rate_pct,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct,
    ROUND(100.0 * SUM(late_flag) / NULLIF(COUNT(*), 0), 2) AS late_arrival_rate_pct,
    ROUND(SUM(overtime_hours), 2) AS overtime_hours,
    ROUND(SUM(overtime_labor_cost), 2) AS overtime_cost,
    SUM(coverage_gap_flag) AS coverage_gaps
FROM workforce_attendance_sample
GROUP BY week_start_date
ORDER BY week_start_date;

-- 12. Monthly trend analysis
SELECT
    month_start_date,
    COUNT(*) AS scheduled_shifts,
    ROUND(100.0 * SUM(present_flag) / NULLIF(COUNT(*), 0), 2) AS attendance_rate_pct,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct,
    ROUND(100.0 * SUM(late_flag) / NULLIF(COUNT(*), 0), 2) AS late_arrival_rate_pct,
    ROUND(SUM(overtime_hours), 2) AS overtime_hours,
    ROUND(SUM(overtime_labor_cost), 2) AS overtime_cost
FROM workforce_attendance_sample
GROUP BY month_start_date
ORDER BY month_start_date;

-- 13. Shift and day-of-week analysis
SELECT
    shift_name,
    day_of_week,
    COUNT(*) AS scheduled_shifts,
    ROUND(100.0 * SUM(absence_flag) / NULLIF(COUNT(*), 0), 2) AS absence_rate_pct,
    ROUND(100.0 * SUM(late_flag) / NULLIF(COUNT(*), 0), 2) AS late_arrival_rate_pct,
    ROUND(AVG(CASE WHEN late_flag = 1 THEN minutes_late END), 2) AS avg_minutes_late,
    SUM(replacement_needed_flag) AS replacement_needed_count
FROM workforce_attendance_sample
GROUP BY shift_name, day_of_week
ORDER BY late_arrival_rate_pct DESC, absence_rate_pct DESC;

-- 14. Data quality checks
SELECT
    data_quality_issue_type,
    COUNT(*) AS issue_records,
    ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM workforce_attendance_sample), 0), 2) AS issue_rate_pct
FROM workforce_attendance_sample
WHERE data_quality_issue_flag = 1
GROUP BY data_quality_issue_type
ORDER BY issue_records DESC;

-- 15. Records needing manager follow-up
SELECT
    manager_name,
    department,
    COUNT(*) AS follow_up_records,
    SUM(coaching_recommended_flag) AS coaching_recommended_records,
    SUM(coverage_gap_flag) AS coverage_gap_records,
    SUM(data_quality_issue_flag) AS data_quality_issue_records
FROM workforce_attendance_sample
WHERE manager_follow_up_required_flag = 1
GROUP BY manager_name, department
ORDER BY follow_up_records DESC;

-- 16. Leadership risk summary by risk level
SELECT
    risk_level,
    COUNT(DISTINCT employee_id) AS employees,
    COUNT(*) AS scheduled_shifts,
    SUM(late_flag) AS late_arrivals,
    SUM(absence_flag) AS absences,
    ROUND(SUM(overtime_hours), 2) AS overtime_hours,
    SUM(coverage_gap_flag) AS coverage_gaps
FROM workforce_attendance_sample
GROUP BY risk_level
ORDER BY
    CASE risk_level
        WHEN 'High' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Low' THEN 3
        ELSE 4
    END;

-- 17. Leadership action summary
SELECT
    manager_action_category,
    COUNT(*) AS records,
    COUNT(DISTINCT employee_id) AS employees,
    ROUND(100.0 * COUNT(*) / NULLIF((SELECT COUNT(*) FROM workforce_attendance_sample), 0), 2) AS share_of_records_pct
FROM workforce_attendance_sample
GROUP BY manager_action_category
ORDER BY records DESC;
