-- NHS ERIC 2024/25 — Practical SQL Investigation
-- Purpose: demonstrate business-question-led analytical SQL.
-- Replace table/column names with the implementation-specific schema as required.

-- 1. Business question: Are there duplicate site identifiers?
SELECT SiteCode, COUNT(*) AS RecordCount
FROM ERIC_Site
WHERE SiteCode IS NOT NULL
GROUP BY SiteCode
HAVING COUNT(*) > 1;

-- 2. Business question: Which records have missing occupied floor area?
SELECT SiteCode, SiteName, SiteType, OccupiedFloorArea
FROM ERIC_Site
WHERE OccupiedFloorArea IS NULL;

-- 3. Business question: Are missing occupied-area values concentrated in a contextual site type?
SELECT SiteType, COUNT(*) AS MissingOccupiedAreaCount
FROM ERIC_Site
WHERE OccupiedFloorArea IS NULL
GROUP BY SiteType
ORDER BY MissingOccupiedAreaCount DESC;

-- 4. Business question: Does occupied floor area exceed gross internal area?
SELECT SiteCode, GrossInternalFloorArea, OccupiedFloorArea
FROM ERIC_Site
WHERE OccupiedFloorArea > GrossInternalFloorArea;

-- 5. Business question: What is finance cost per occupied square metre?
SELECT
    TrustCode,
    SiteCode,
    TrustType,
    SiteType,
    OccupiedFloorArea,
    EstatesFacilitiesFinanceCosts,
    EstatesFacilitiesFinanceCosts
        / NULLIF(OccupiedFloorArea, 0) AS FinanceCostPerOccupiedM2
FROM ERIC_Site
WHERE SiteCode IS NOT NULL
  AND OccupiedFloorArea > 0;

-- 6. Business question: Which observations meet the exploratory screening rule?
-- NOTE: £1,000/m² is an exploratory case-study threshold, not an NHS benchmark.
SELECT
    SiteCode,
    SiteName,
    SiteType,
    EstatesFacilitiesFinanceCosts,
    OccupiedFloorArea,
    EstatesFacilitiesFinanceCosts
        / NULLIF(OccupiedFloorArea, 0) AS FinanceCostPerOccupiedM2
FROM ERIC_Site
WHERE OccupiedFloorArea > 0
  AND EstatesFacilitiesFinanceCosts IS NOT NULL
  AND (
      EstatesFacilitiesFinanceCosts < 0
      OR EstatesFacilitiesFinanceCosts
          / NULLIF(OccupiedFloorArea, 0) > 1000
  )
ORDER BY FinanceCostPerOccupiedM2 DESC;
