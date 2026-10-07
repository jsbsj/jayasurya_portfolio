# Power BI MVP

## Purpose
A proportionate analytical MVP for the NHS ERIC 2024/25 case study.

## Pages
1. Overview
2. Exception Analysis
3. Site Investigation
4. Definitions & Methodology

## Core analytical logic
- Finance cost per occupied m² = Estates & Facilities Finance Costs / Occupied Floor Area.
- Occupied-area validation checks whether Occupied Floor Area exceeds Gross Internal Floor Area.
- Context validation checks whether applicable experimental area measures exceed Occupied Floor Area.
- Finance observation flags identify missing finance cost where occupied area exists, negative calculated rates, and observations above the exploratory £1,000/m² screening threshold.

## Important
£1,000/m² is an exploratory case-study threshold, not an NHS benchmark.
The MVP is designed/prepared; this portfolio does not claim production deployment.
Power Apps, Dataverse, Power Automate and AI are out of scope for the MVP because validated requirements did not establish a need for operational case management, workflow or AI.
