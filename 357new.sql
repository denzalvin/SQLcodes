--DECLARE @SchoolYearId INT
DECLARE @SchoolYearCode CHAR(9)

--SET @SchoolYearId = 10
SET @SchoolYearCode = '2019-2020'

/* 
ALL TEACHERS
SY2017-2018 --26,217
SY2018-2019 -- 26,760
SY2019-2020 --27,507 using teacherlocked.teacherquality
*/


SELECT DISTINCT
	T.SchoolYearId,
	CASE 
		WHEN T.SchoolYearId = 7 THEN '2016'
		WHEN T.SchoolYearId = 8 THEN '2017'
		WHEN T.SchoolYearId = 9 THEN '2018'
		WHEN T.SchoolYearId = 10 THEN '2019'
		WHEN T.SchoolYearId = 11 THEN '2020'
		ELSE NULL
		END AS SchoolYear,
	SY.Name AS SchoolYearCode,
	'103300' AS STATE_OrganizationId,

	T.DistrictOrganizationId AS DISTRICT_OrganizationId,
	--S.OrganizationId,
	T.SchoolOrganizationID AS SCHOOL_OrganizationId,
	--O_School.OrganizationID,
	O_School.OSPILegacyCode,
	S.UnitCode,

	T.PersonID,
	H.EducatorID, 
	H.TeacherNumber AS CertTeacher_Number,
	H.SAFS_PersonnelID,
	S.PersonnelID,

	S.Teacher_Category,
	S.Program,
	CASE	
		WHEN T.StudentCount = T.StudentCountSped THEN 'Yes'
		ELSE 'No'
		END AS FullSPEDClass,
	CASE WHEN T.StudentLowestGradeLevelCode IN ('0') AND T.StudentHighestGradeLevelCode IN ('0') THEN 'K' 
			  WHEN T.StudentLowestGradeLevelCode IN ('1', '2', '3', '4', '5') AND T.StudentHighestGradeLevelCode IN ('1', '2', '3', '4', '5') THEN 'Elementary' 
			  WHEN T.StudentLowestGradeLevelCode IN ('6','7','8') AND T.StudentHighestGradeLevelCode IN ('6','7','8') THEN 'Middle' 
			   WHEN T.StudentLowestGradeLevelCode IN ('9', '10', '11', '12') AND T.StudentHighestGradeLevelCode IN ('9', '10', '11', '12') THEN 'High' 
			   WHEN T.StudentLowestGradeLevelCode IN ('0') AND T.StudentHighestGradeLevelCode IN ('1', '2', '3', '4', '5') THEN 'K & Elementary' 
			  WHEN T.StudentLowestGradeLevelCode IN ('6','7','8') AND T.StudentHighestGradeLevelCode IN ('9','10','11','12') THEN 'Middle & High'
			  WHEN T.StudentLowestGradeLevelCode IN ('0', '1', '2', '3', '4', '5') AND T.StudentHighestGradeLevelCode IN ('6', '7', '8', '9', '10', '11', '12') THEN 'K12' 
			  ELSE CONCAT(T.StudentLowestGradeLevelCode, '-', T.StudentHighestGradeLevelCode)
		END AS GradeLevel,
	S.FTE,

	H.CertificateCode,
	H.CertificateType,


	T.teacherExperienceyears,

	H.EthnicityCode,
	H.Ethnicity,
	H.RaceCode,
	H.Race,
	CASE 
		WHEN H.RaceEthnicity IS NULL THEN '8'
		ELSE H.RaceEthnicity END AS RaceEthnicity,

	GETDATE() AS DataAsOf

/*
IF OBJECT_ID(N'tempdb..#1819') IS NOT NULL
DROP TABLE #1819
*/
--SPED CLASSES
--INTO #1718 --12,138 (42 sec 8/3/2020)
--INTO #1819 --12,991 (48 sec 8/3/2020)
--INTO #1920 --9,433 (29 sec 8/4/2020)
--------TOTAL-- 34,329
/* ******************************************************** */
/*		TeacherQuality Data: Vetted Educator Data			*/
/* ******************************************************** */
--FROM [SRV-SQL11].TeacherQuality.dbo.TeacherLMCOTFDistrictSubmission AS T -- 2017-2019
FROM [SRV-SQL11].TEacherQuality.[dbo].[TeacherLMCOTFBuildingLocked] AS T --2019-2020

/* ******************************************************** */
/*		TeacherQuality Data: School Year ID					*/
/* ******************************************************** */
LEFT JOIN [SRV-SQL11].TeacherQuality.dbo.SchoolYear AS SY
	ON T.SchoolYearID=SY.SchoolYearID

/* ******************************************************** */
/*		EMS Data: OSPI Legacy School (needed for SAFS)		*/
/* ******************************************************** */
LEFT JOIN [SRV-SQL11].EMS.dbo.Organization AS O_School
	ON T.SchoolOrganizationID=O_School.OrganizationID

/* ******************************************************** */
/*		HITLS Data: Certification, Degree, & Demographics	*/
/* ******************************************************** */
LEFT JOIN 
(
SELECT DISTINCT
		E.EducatorID, 
		E.TeacherNumber,
		E.SAFS_PersonnelID,
		EC.CertificateCode,
		EC.CertificateType
		,E.EthnicityCode
		,CE.Description AS Ethnicity
		,E.RaceCodeList AS RaceCode
		,CASE 
			WHEN E.RaceCodeList IS NOT NULL AND CR.Description IS NULL THEN 'Two or More Races'
			ELSE CR.DESCRIPTION END AS Race,
		CASE 
			WHEN E.EthnicityCode='Y' THEN '4'	-- Hispanic/Latino of any race(s)
			WHEN E.RaceCodeList='AM' THEN '1'	-- American Indian/Alaskan Native
			WHEN E.RaceCodeList='AS' THEN '2'	-- Asian
			WHEN E.RaceCodeList='BL' THEN '3'	-- Black/African American
			WHEN E.RaceCodeList='WH' THEN '5'	-- White
			WHEN E.RaceCodeList='PA' THEN '6'	-- Native Hawaiian/Other Pacific Islander
			WHEN E.RaceCodeList='NP' THEN '8'	-- Not Provided
			ELSE '7' END AS RaceEthnicity		-- Two or More Races

	FROM [SRV-SQL11].HITLS.dbo.tb_hitls_Educator AS E

	/* **************************************************** 
		HITLS Data: Certifications				
	 **************************************************** */
	LEFT JOIN 
		(

		SELECT DISTINCT
			EducatorID
			,CertificateCode
			,CASE WHEN CertificateCode LIKE '1%' OR CertificateCode LIKE 'T3%' OR CertificateCode LIKE 'T2%'  OR certificatecode  LIKE 'TCTE%' THEN 'Full'
				WHEN CertificateCode LIKE 'CCTE1%' or certificatecode Like 'CCTE2%' THEN 'Conditional'
				WHEN certificatecode in ('C190700','C250700','C260700','C270700','C280700','C305000','C360500','PRERES') OR CertificateCode LIKE 'TALI%' OR CertificateCode LIKE 'TNONIM%'  THEN 'Limited'
				ELSE NULL
			END AS CertificateType

		FROM [SRV-SQL11].HITLS.dbo.tb_hitls_EducatorCertificate
		WHERE (OriginalIssueDate <= CAST( CAST(LEFT(@SchoolYearCode, 4) AS CHAR(4)) + '-06-30' AS DATE) 
				OR IssueDate <= CAST( CAST(LEFT(@SchoolYearCode, 4) AS CHAR(4)) + '-06-30' AS DATE) 
				OR EffectiveDate <= CAST( CAST(LEFT(@SchoolYearCode, 4) AS CHAR(4)) + '-06-30' AS DATE)
			  )
			  AND (ExpireDate >= CAST( CAST(LEFT(@SchoolYearCode, 4) AS CHAR(4)) + '-09-01' AS DATE) OR ExpireDate IS NULL)
		) AS EC
		ON E.EducatorID=EC.EducatorID


	/* **************************************************** 
			HITLS Data: Ethnicity Code & Descriptions	
	 **************************************************** */
	LEFT JOIN [SRV-SQL11].HITLS.dbo.tb_hitls_CodeEthnicity AS CE
		ON E.EthnicityCode=CE.EthnicityCode

	/* **************************************************** *
			HITLS Data: Race Code & Descriptions		
	 **************************************************** */
	LEFT JOIN [SRV-SQL11].HITLS.dbo.tb_hitls_CodeRace AS CR
		ON E.RaceCodeList=CR.RaceCode


	/* **************************************************** *
			HITLS Data: Degree Information				
	 **************************************************** */
	LEFT JOIN 
		(
		--DECLARE @SchoolYearId INT
		--DECLARE @SchoolYearCode CHAR(9)

		--SET @SchoolYearId = 10
		--SET @SchoolYearCode = '2018-2019'
		
		SELECT DISTINCT
			HD.EducatorID,
			HCD.DegreeCode,
			HCD.Description,
			HD_MAX.Degree_Rank

		FROM [SRV-SQL11].HITLS.dbo.tb_hitls_EducatorDegree AS HD

		INNER JOIN 
			(SELECT DISTINCT
				HD.EducatorID,
				MAX(HCD.DegreeSequenceNumber) AS Degree_Rank
			FROM [SRV-SQL11].HITLS.dbo.tb_hitls_EducatorDegree AS HD
			LEFT JOIN [SRV-SQL11].HITLS.dbo.tb_hitls_CodeDegree AS HCD
				ON HD.DegreeCode=HCD.DegreeCode
			WHERE HD.DegreeDate<= CAST( CAST(RIGHT(@SchoolYearCode, 4) AS CHAR(4)) + '-08-31' AS DATE)
			GROUP BY HD.EducatorID
			) AS HD_MAX
			ON HD.EducatorID=HD_MAX.EducatorID

		INNER JOIN [SRV-SQL11].HITLS.dbo.tb_hitls_CodeDegree AS HCD
			ON HD_MAX.Degree_Rank=HCD.DegreeSequenceNumber
			AND HD.DegreeCode=HCD.DegreeCode
		) AS HD
		ON E.EducatorID=HD.EducatorID
	) AS H
	ON T.PersonID=H.EducatorID


/* ******************************************************** *
			S-275 Data: Teacher Category & FTE				
* ******************************************************** */
LEFT JOIN 
	(SELECT DISTINCT 
		PersonnelID,
		OrganizationID,
		UnitCode,
		Teacher_Category,
		Program,
		SUM(FTE) AS FTE
	FROM 
		(SELECT DISTINCT 
			PersonnelId,
			OrganizationId,
			UnitCode,
			CRAS_ASGN_FTE AS FTE,
			CASE 
				/* Classroom Teachers */
				WHEN AssignCodeDuty LIKE '31%' OR AssignCodeDuty LIKE '32%' OR AssignCodeDuty LIKE '33%' OR AssignCodeDuty LIKE '34%' OR AssignCodeDuty='630' THEN 'T'
				/*Substitute Teachers*/
				WHEN AssignCodeDuty LIKE '52%'  THEN 'S'
				/* Principals (+ Vice-Principals) */
				WHEN AssignCodeDuty LIKE '21%' OR AssignCodeDuty LIKE '22%' OR AssignCodeDuty LIKE '23%' OR AssignCodeDuty LIKE '24%' THEN 'P'
				/* Other School Leaders (Superintendents, Director/Supervisor, etc.) */
				WHEN AssignCodeDuty LIKE '11%' OR AssignCodeDuty LIKE '12%' OR AssignCodeDuty LIKE '99%' OR AssignCodeActivity IN('21','31') THEN 'O'
				ELSE NULL END AS Teacher_Category, -- !!! Make Last as other categories can have AssignedCodeActivity IN ('21','31')
			CASE 
				WHEN AssignCodeProgram='01' THEN 'Basic Ed'										-- Basic Education
				WHEN AssignCodeProgram='02' THEN 'ALE'											-- Alternate Learning Experience
				WHEN AssignCodeProgram IN('31','32','34','38','39','45','46','47') THEN 'CTE'	-- CTE -- 45-47 (Skills Center)
				WHEN AssignCodeProgram IN('21','22','23','24','25','26','29') THEN 'SPED'		-- Special Education -- DO NOT INCLUDE: 12,13,51,53,54
				WHEN AssignCodeProgram='65' THEN 'TBIP'											-- Transitional Bilingual Instructional Program
				ELSE NULL END AS Program
		FROM [SRV-SQL11].[SAFS].[dbo].[PersonnelAssignments]
		WHERE SchoolYearCode = @schoolYearCode /*in (
				'2015-2016',  -- 40,025 SPED
				'2016-2017', --42,831 SPED
				'2017-2018', --43,968 SPED
				'2018-2019' ,-- 46,334 SPED
				'2019-2020' --48,597 SPED
				)*/
			AND CRAS_ASGN_FTE>0  AND AssignCodeProgram in ('21','22','23','24','25','26','29')  -- FTE must be greater than 0 in order for teacher category to be included in analysis
		) AS SPA
		GROUP BY PersonnelID, OrganizationID, UnitCode, Program, Teacher_Category
	) AS S
	ON H.SAFS_PersonnelID=S.PersonnelId
	AND T.DistrictOrganizationId=S.OrganizationId
	AND O_School.OSPILegacyCode=S.UnitCode
WHERE T.SchoolYearId = 11 -- in (9,10) AND --= 11 and 
	AND S.Program = 'SPED'


/******************************************************
		UNION SY 2017 - 2020
*******************************************************/
/*
SELECT * From #1718
UNION
SELECT * FROM #1819
UNION
SELECT * FROM #1920
*/
