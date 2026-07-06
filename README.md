# Workforce Attendance & Overtime Operations Analysis

Operations analysis project using synthetic workforce attendance data to identify attendance reliability, late-arrival risk, absence patterns, overtime concentration, coverage gaps, and data quality issues through Excel, SQL, and dashboard-ready KPI reporting.

## Project Overview

This project analyzes workforce attendance, absences, late arrivals, overtime usage, coverage gaps, and data quality issues in a synthetic workforce operations environment.

The goal was to turn raw scheduled-shift records into leadership-ready insights that could help operations, workforce planning, HR, and finance leaders understand where attendance and labor cost risks are concentrated.

This project is part of a broader Workflow Optimization & Operations Analysis Portfolio for Operations Analyst, Business Analyst, and Process Improvement roles.

## Business Problem

The organization lacked a centralized attendance performance view. Without structured reporting, leaders had limited visibility into which departments, shifts, managers, or employee groups were driving attendance risk, overtime cost, and coverage issues.

This analysis helps move the organization from reactive attendance follow-up to proactive workforce performance management.

## Executive Summary

This analysis gives operations leadership a clearer way to move from raw attendance records to operational decision-making.

Instead of only knowing that attendance issues exist, the Director of Operations, Workforce Planning Manager, Fulfillment Manager, Customer Support Manager, Shift Supervisors, HR / People Operations, Finance leadership, and Operations Reporting owner can identify where risk is concentrated, which departments are driving overtime cost, which shifts need targeted review, and where data cleanup is required before recurring reporting.

Key results from the sample dataset:

| Metric                     | Result     |
| -------------------------- | ----------:|
| Scheduled Shifts           | 7,079      |
| Employees                  | 120        |
| Departments                | 6          |
| Locations                  | 4          |
| Attendance Rate            | 96.6%      |
| Absence Rate               | 3.4%       |
| Late Arrival Rate          | 8.45%      |
| High-Repeat Late Employees | 13         |
| Overtime Hours             | 1,414.5    |
| Overtime Cost              | $55,844.77 |
| Coverage Gaps              | 98         |
| Data Quality Issue Rate    | 2.09%      |

## Dashboard Preview

<img width="1400" alt="Dashboard Preview" src="assets/dashboard_preview.png" />

## Dataset

This project uses a representative synthetic workforce attendance dataset. The dataset is not based on real employee records.

The dataset grain is one row per employee scheduled shift.

| Attribute                 | Value                    |
| ------------------------- | -----------------------: |
| Scheduled Shift Records   | 7,079                    |
| Employees                 | 120                      |
| Departments               | 6                        |
| Locations                 | 4                        |
| Shift Types               | 4                        |
| Date Range                | 2025-10-01 to 2025-12-29 |

Core fields include employee, department, manager, location, role, shift, attendance status, scheduled and actual clock times, late minutes, absence type, overtime hours, overtime cost, coverage gap flags, data quality issue flags, and manager action category.

The data dictionary defines each field and the KPI logic used throughout the project.

## Tools Used

| Tool               | Purpose                                                                                       |
| ------------------ | --------------------------------------------------------------------------------------------- |
| Excel              | KPI summary, trend analysis, department review, employee risk review, and data quality analysis |
| SQL                | KPI validation and business-question-driven analysis                                           |
| CSV                | GitHub-readable source dataset                                                                |
| Dashboard Planning | Power BI-style KPI layout and dashboard preview                                                |

## Key Findings

### 1. Fulfillment had the highest absence risk

Fulfillment had a 4.78% absence rate, above the overall absence rate of 3.4%. Because Fulfillment also had a high scheduled-shift volume, this creates a more material operational risk.

### 2. The overnight shift had the highest reliability risk

Overnight had the highest late-arrival rate at 10.47% and the highest absence rate at 5.28%. This suggests overnight staffing may need closer schedule review, supervisor follow-up, or attendance support.

### 3. Overtime cost was concentrated in two departments

Fulfillment generated $17,947.91 in overtime cost, while Customer Support generated $12,787.75. These departments should be reviewed for workload, staffing, schedule coverage, and recurring overtime drivers.

### 4. High-repeat lateness was concentrated in a smaller employee group

The targeted coaching population was 13 employees with 9 or more late arrivals over 90 days. This creates a more actionable follow-up list than broad late-arrival tracking.

### 5. Data quality issues were limited but important

The data quality issue rate was 2.09%. The most common issues were missing clock events, status/clock mismatches, and missing absence types. These issues should be resolved before using the dataset for recurring leadership reporting.

## Stakeholder Impact

This analysis is designed for specific leadership users, not just a generic manager audience.

| Stakeholder                 | How They Would Use the Analysis                                                        |
| --------------------------- | -------------------------------------------------------------------------------------- |
| Director of Operations      | Monitor workforce reliability, coverage risk, and department-level attendance performance |
| Workforce Planning Manager  | Identify staffing patterns, shift coverage issues, and overtime drivers                 |
| Fulfillment Manager         | Review the department with the highest absence risk and highest overtime cost           |
| Customer Support Manager    | Review overtime concentration and potential workload or scheduling issues               |
| Overnight Shift Supervisors | Investigate the shift with the highest late-arrival and absence risk                    |
| HR / People Operations      | Review high-repeat lateness, coaching needs, and attendance support opportunities       |
| Finance Leadership          | Understand overtime labor cost and where avoidable cost may be concentrated             |
| Operations Reporting Owner  | Resolve data quality issues before recurring leadership reporting                       |

## Files Included

| File                                                                                           | Description                         |
| ---------------------------------------------------------------------------------------------- | ----------------------------------- |
| [workforce_attendance_sample.csv](data/workforce_attendance_sample.csv)                         | Synthetic source dataset            |
| [data_dictionary.xlsx](data/data_dictionary.xlsx)                                               | Field definitions and KPI logic     |
| [workforce_attendance_analysis_workbook.xlsx](excel/workforce_attendance_analysis_workbook.xlsx) | Excel analysis workbook             |
| [workforce_attendance_analysis.sql](sql/workforce_attendance_analysis.sql)                       | SQL validation and analysis queries |
| [dashboard_preview.png](assets/dashboard_preview.png)                                           | Dashboard preview image             |
| [full_project_summary.md](docs/full_project_summary.md)                                         | Expanded project summary            |

## Recommendations

* Prioritize Fulfillment attendance review due to elevated absence risk and overtime cost.
* Review Overnight shift reliability, including start-time adherence, scheduling barriers, handoffs, and supervisor coverage.
* Use targeted coaching for the 13 high-repeat late employees.
* Monitor overtime concentration in Fulfillment and Customer Support.
* Fix missing clock events, status mismatches, and missing absence types before recurring dashboard reporting.
* Establish a weekly workforce KPI review cadence for operations leadership.

## Analyst Capabilities Demonstrated

* Operations Analysis
* Workforce Performance Analysis
* KPI Development
* Excel-Based Business Analysis
* SQL Analysis and Validation
* Dashboard Planning
* Data Quality Review
* Overtime Cost Analysis
* Trend Analysis
* Leadership Reporting
* Business Recommendations

## Project Outcome

This project demonstrates how workforce attendance data can be used to identify operational risk, improve staffing visibility, reduce avoidable overtime, and support better manager decision-making.

The analysis gives leadership a clearer view of where attendance issues are concentrated, which KPIs should be monitored, and what actions can improve schedule reliability.

The recommended approach helps managers move from reactive attendance tracking to proactive workforce performance management.


## Author

Brenton Nelson
