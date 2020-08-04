USE [TitleIIAShared]


--Table creation for the temptable as primary table for head and section count and course reassignments.

CREATE TABLE Z_SI_ID195_4Cult_ContentAreaReAssignB					-- Create a table to store courses to reassign accordingly based on the course title
		(SchoolYearCode		VARCHAR(9)
		,SchoolYearId		INT
		,DistrictID			INT
		,SchoolID			INT
		,ClassID			INT
		,SourceSystem		VARCHAR(20)
		,ContentAreaIdCEDARS	INT
		,CAID_Title			CHAR(5)
		,CourseId			VARCHAR(20)
		,CourseTitle		VARCHAR(50)
		,PersonId			INT
		,TeacherOTFReasonId	INT
		,TeacherOTFSpecialistContentAreaId	INT
		,[TeacherOverrideOTFLMCTypeID] INT NULL

		 )



INSERT INTO Z_SI_ID195_4Cult_ContentAreaReAssignB --1,276,816 (2 sec 2/27/2020)
SELECT [SchoolYearCode]
	,[SchoolYearId]
	,[DISTRICT_Organizationid]	AS DistrictID
      ,[SCHOOL_Organizationid]	AS SchoolID
	,[ClassID]
	,[SourceSystem]
	,[ContentAreaIdCEDARS]
	,[ContentAreaIdCEDARS]		AS CAID_Title
	,[CourseId]
	,[CourseTitle]
	,[PersonId]
	,[TeacherOTFReasonId]
	,[TeacherOTFSpecialistContentAreaId]
	,[TeacherOverrideOTFLMCTypeID]
     
  FROM [dev-sql08].[KaorisDatabase].[dbo].[ESSA_EquityGapTeacher] 


--parallel table from the initial course reassignment table

CREATE TABLE [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign](
	[SchoolYearCode] [varchar](9) NULL,
	[SchoolYearId] [int] NULL,
	[DistrictID] [int] NULL,
	[SchoolID] [int] NULL,
	[ClassID] [int] NULL,
	[SourceSystem] [varchar](20) NULL,
	[ContentAreaIdCEDARS] [int] NULL,
	[CAID_Title] [int] NULL,
	[CourseId] [varchar](20) NULL,
	[CourseTitle] [varchar](50) NULL,
	[PersonId] [int] NULL,
	[TeacherOTFReasonId] [int] NULL,
	[TeacherOTFSpecialistContentAreaId] [int] NULL,
	[TeacherOverrideOTFLMCTypeID] [int] NULL
) ON [PRIMARY]
GO

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] -- 1,276,816 (34 sec, 4/8/2020) DUPLICATED FOR REASSIGNMENT ATTEMPT
SELECT * FROM [K12\dennisalvin.david].[Z_SI_ID195_4Cult_ContentAreaReAssignB] -- 1,276,816 (35 sec, 4/8/2020) TO CHECK ALL ENTRIES WERE COPIED

INSERT INTO ZZ_SI_ID195_4Cult_ContentAreaReAssign
SELECT [SchoolYearCode] 
	,[SchoolYearId]
	,[DistrictID] 
	,[SchoolID] 
	,[ClassID]
	,[SourceSystem]
	,[ContentAreaIdCEDARS] 
	,[CAID_Title] 
	,[CourseId] 
	,[CourseTitle]
	,[PersonId] 
	,[TeacherOTFReasonId]
	,[TeacherOTFSpecialistContentAreaId] 
	,[TeacherOverrideOTFLMCTypeID] 
FROM [K12\dennisalvin.david].[Z_SI_ID195_4Cult_ContentAreaReAssignB]

---------------------------------
-----------------------------------
-------------------------------------
-- Course/Reassignment
-----------------------------------


/**************** MUSIC ***********************/

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null --47,998 (1 sec, 4/8/2020)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] = 3  --51,803 (1 sec, 4/8/2020) initial count of Music related courses
																	--70,272 (3 sec, 4/8/2020) after updating the table from CAID_Title Null
																	--71,810 (3 sec, 4/8/2020) after update with courses from 30,31,32,33 codes 
SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --18,469 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --20,007 (0 sec, 4/8/2020) to check if there are music courses with codes 30,31,32,33
	WHERE ([CAID_Title] is null OR [ContentAreaIdCEDARS] in (30,31,32,33))		-- a difference of 1,538
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		)
/********
SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--174
	WHERE ([CAID_Title] is null 
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		OR [CourseTitle] LIKE '%orchstr%'
		OR [CourseTitle] LIKE '%concert%'
		OR [CourseTitle] LIKE '%string%'
		OR [CourseTitle] LIKE '%mariachi%'
		OR [CourseTitle] LIKE '%Chorale%'
		OR [CourseTitle] like '%pop%
		OR [CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro%'
		OR [CourseTitle] like '%concrt%'  -- 101
		OR [CourseTitle] like '%choral%'  --117
		OR [CourseTitle] like '%strng%' --127
		OR [CourseTitle] like '%MIDI%' --131
		OR [CourseTitle] like '%lyrica%' --135
		OR [CourseTitle] like '%rock/roll%' --139
		OR [CourseTitle] like '%instrument%' --152
		OR [CourseTitle] like '%voice%' --161
		OR [CourseTitle] like '%marimba%' --176
		OR [CourseTitle] like '%vocal%' --317
		OR [CourseTitle] like '%chamber orch%' --333
		OR [CourseTitle] like '%chamber%' --337
		OR [CourseTitle] like '%chior%' --340
		OR [CourseTitle] like '%audio%' --353
		OR [CourseTitle] like '%banjo%'--356
		OR [CourseTitle] like '%sax%' --358
		OR [CourseTitle] like '%perc ens%' --369
		OR [CourseTitle] like '%bel canto%' --371
		OR [CourseTitle] like '%bella voce%' --375
		OR [CourseTitle] like '%chanteuse%' --379
		OR [CourseTitle] like '%camerata%' -- 391
		OR [CourseTitle] like '%mus hist%' --393
		OR [CourseTitle] like '%rock and roll%' --394
		OR [CourseTitle] like '%school of rock%' --395
		OR [CourseTitle] like '%sinfonietta%' --399
		OR [CourseTitle] like '%symph orch%' --405
		OR [CourseTitle] like '%symphonia%' --407
		OR [CourseTitle] like '%symphonic%' --413
		OR [CourseTitle] like '%symphony%' --426
		OR [CourseTitle] like '%treble%' --437
		OR [CourseTitle] like '%ukulele%' --446
		OR [CourseTitle] like '%valhalla vox%' --450
		OR [CourseTitle] like '%violin%' --452
		OR [CourseTitle] like '%wms select ens%'
		OR [CourseTitle] like '%brass%'
		OR [CourseTitle] like '%cappella%' 
		OR [CourseId] like 'MUS%'
		OR [CourseTitle] = 'history of rock & roll'
		))
	OR
		([CAID_Title] in (30,31,32,33) 
		and([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		OR [CourseTitle] LIKE '%Drum%'
		OR [CourseTitle] LIKE '%orchstr%'
		OR [CourseTitle] LIKE '%concert%'
		OR [CourseTitle] LIKE '%string%'
		OR [CourseTitle] LIKE '%mariachi%'
		OR [CourseTitle] LIKE '%Chorale%'
		OR [CourseTitle] like '%pop%
		OR [CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro%'
		OR [CourseTitle] like '%concrt%'  -- 101
		OR [CourseTitle] like '%choral%'  --117
		OR [CourseTitle] like '%strng%' --127
		OR [CourseTitle] like '%MIDI%' --131
		OR [CourseTitle] like '%lyrica%' --135
		OR [CourseTitle] like '%rock/roll%' --139
		OR [CourseTitle] like '%instrument%' --152
		OR [CourseTitle] like '%voice%' --161
		OR [CourseTitle] like '%marimba%' --176
		OR [CourseTitle] like '%vocal%' --317
		OR [CourseTitle] like '%chamber orch%' --333
		OR [CourseTitle] like '%chamber%' --337
		OR [CourseTitle] like '%chior%' --340
		OR [CourseTitle] like '%audio%' --353
		OR [CourseTitle] like '%banjo%'--356
		OR [CourseTitle] like '%sax%' --358
		OR [CourseTitle] like '%perc ens%' --369
		OR [CourseTitle] like '%bel canto%' --371
		OR [CourseTitle] like '%bella voce%' --375
		OR [CourseTitle] like '%chanteuse%' --379
		OR [CourseTitle] like '%camerata%' -- 391
		OR [CourseTitle] like '%mus hist%' --393
		OR [CourseTitle] like '%rock and roll%' --394
		OR [CourseTitle] like '%school of rock%' --395
		OR [CourseTitle] like '%sinfonietta%' --399
		OR [CourseTitle] like '%symph orch%' --405
		OR [CourseTitle] like '%symphonia%' --407
		OR [CourseTitle] like '%symphonic%' --413
		OR [CourseTitle] like '%symphony%' --426
		OR [CourseTitle] like '%treble%' --437
		OR [CourseTitle] like '%ukulele%' --446
		OR [CourseTitle] like '%valhalla vox%' --450
		OR [CourseTitle] like '%violin%' --452
		OR [CourseTitle] like '%wms select ens%'
		OR [CourseTitle] like '%brass%'
		OR [CourseTitle] like '%cappella%' 
		OR [CourseTitle] = 'history of rock & roll'
		))
*******/

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as NULL but with course title containing
set CAID_Title = 3 --18,469 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
where [CAID_Title] is null 
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 1,538 (0 sec, 4/8/2020) count of music related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)					
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		)

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --1,538 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
where	[ContentAreaIdCEDARS] in (30,31,32,33)					
	and ([CourseTitle] LIKE '%Guitar%' 
		OR [CourseTitle] LIKE '%WIND%'
		OR [CourseTitle] LIKE '%Band%'
		OR [CourseTitle] LIKE '%Choir%'
		OR [CourseTitle] LIKE '%Orchestra%'
		OR [CourseTitle] LIKE '%Music%'
		OR [CourseTitle] LIKE '%Percussion%'
		OR [CourseTitle] LIKE '%Jazz%'
		OR [CourseTitle] LIKE '%Chorus%'
		OR [CourseTitle] LIKE '%Piano%'
		OR [CourseTitle] LIKE '%Percus%'
		OR [CourseTitle] LIKE '%Sinfonia%'
		OR [CourseTitle] LIKE '%Drum%'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --352 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
	and ([CourseTitle] LIKE '%orchstr%'
	OR [CourseTitle] LIKE '%concert%'
	OR [CourseTitle] LIKE '%string%'
	OR [CourseTitle] LIKE '%mariachi%'
	OR [CourseTitle] LIKE '%Chorale%')

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  
	WHERE [CAID_Title] is null 
	and ([CourseTitle] LIKE '%orchstr%'
	OR [CourseTitle] LIKE '%concert%'
	OR [CourseTitle] LIKE '%string%'
	OR [CourseTitle] LIKE '%mariachi%'
	OR [CourseTitle] LIKE '%Chorale%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as NULL but with course title containing
set CAID_Title = 3 --352 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
where [CAID_Title] is null 
and ([CourseTitle] LIKE '%orchstr%'
	OR [CourseTitle] LIKE '%concert%'
	OR [CourseTitle] LIKE '%string%'
	OR [CourseTitle] LIKE '%mariachi%'
	OR [CourseTitle] LIKE '%Chorale%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 26 (0 sec, 4/8/2020) count of music related courses coded as 30, 31, 32, and 33
	WHERE [CAID_Title] in (30,31,32,33)
	and ([CourseTitle] LIKE '%orchstr%'
	OR [CourseTitle] LIKE '%concert%'
	OR [CourseTitle] LIKE '%string%'
	OR [CourseTitle] LIKE '%mariachi%'
	OR [CourseTitle] LIKE '%Chorale%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --26 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] in (30,31,32,33)
	and ([CourseTitle] LIKE '%orchstr%'
	OR [CourseTitle] LIKE '%concert%'
	OR [CourseTitle] LIKE '%string%'
	OR [CourseTitle] LIKE '%mariachi%'
	OR [CourseTitle] LIKE '%Chorale%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null and [CourseTitle] is not null --1
	AND [CourseTitle] like '%pop%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as NULL but with course title containing
set CAID_Title = 3 --1 (0 sec: 4/9/2020)						-- music related keywords in the condition shown
where [CAID_Title] is null 
and [CourseTitle] LIKE '%pop%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [SchoolID] = 101346

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --454 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
		AND (
		[CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro di uoma%'
		OR [CourseTitle] like '%concrt%'  -- 101
		OR [CourseTitle] like '%choral%'  --117
		OR [CourseTitle] like '%strng%' --127
		OR [CourseTitle] like '%MIDI%' --131
		OR [CourseTitle] like '%lyrica%' --135
		OR [CourseTitle] like '%rock/roll%' --139
		OR [CourseTitle] like '%instrument%' --152
		OR [CourseTitle] like '%voice%' --161
		OR [CourseTitle] like '%marimba%' --176
		OR [CourseTitle] like '%vocal%' --317
		OR [CourseTitle] like '%chamber orch%' --333
		OR [CourseTitle] like '%chamber%' --337
		OR [CourseTitle] like '%chior%' --340
		OR [CourseTitle] like '%audio%' --353
		OR [CourseTitle] like '%banjo%'--356
		OR [CourseTitle] like '%sax%' --358
		OR [CourseTitle] like '%perc ens%' --369
		OR [CourseTitle] like '%bel canto%' --371
		OR [CourseTitle] like '%bella voce%' --375
		OR [CourseTitle] like '%chanteuse%' --379
		OR [CourseTitle] like '%camerata%' -- 391
		OR [CourseTitle] like '%mus hist%' --393
		OR [CourseTitle] like '%rock and roll%' --394
		OR [CourseTitle] like '%school of rock%' --395
		OR [CourseTitle] like '%sinfonietta%' --399
		OR [CourseTitle] like '%symph orch%' --405
		OR [CourseTitle] like '%symphonia%' --407
		OR [CourseTitle] like '%symphonic%' --413
		OR [CourseTitle] like '%symphony%' --426
		OR [CourseTitle] like '%treble%' --437
		OR [CourseTitle] like '%ukulele%' --446
		OR [CourseTitle] like '%valhalla vox%' --450
		OR [CourseTitle] like '%violin%' --452
		OR [CourseTitle] like '%wms select ens%' --454
		OR [CourseTitle] like '%acapella%'
			)
	ORDER by [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --26 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] is null 
		AND (
		[CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro di uoma%'
		OR [CourseTitle] like '%concrt%'  -- 101
		OR [CourseTitle] like '%choral%'  --117
		OR [CourseTitle] like '%strng%' --127
		OR [CourseTitle] like '%MIDI%' --131
		OR [CourseTitle] like '%lyrica%' --135
		OR [CourseTitle] like '%rock/roll%' --139
		OR [CourseTitle] like '%instrument%' --152
		OR [CourseTitle] like '%voice%' --161
		OR [CourseTitle] like '%marimba%' --176
		OR [CourseTitle] like '%vocal%' --317
		OR [CourseTitle] like '%chamber orch%' --333
		OR [CourseTitle] like '%chamber%' --337
		OR [CourseTitle] like '%chior%' --340
		OR [CourseTitle] like '%audio%' --353
		OR [CourseTitle] like '%banjo%'--356
		OR [CourseTitle] like '%sax%' --358
		OR [CourseTitle] like '%perc ens%' --369
		OR [CourseTitle] like '%bel canto%' --371
		OR [CourseTitle] like '%bella voce%' --375
		OR [CourseTitle] like '%chanteuse%' --379
		OR [CourseTitle] like '%camerata%' -- 391
		OR [CourseTitle] like '%mus hist%' --393
		OR [CourseTitle] like '%rock and roll%' --394
		OR [CourseTitle] like '%school of rock%' --395
		OR [CourseTitle] like '%sinfonietta%' --399
		OR [CourseTitle] like '%symph orch%' --405
		OR [CourseTitle] like '%symphonia%' --407
		OR [CourseTitle] like '%symphonic%' --413
		OR [CourseTitle] like '%symphony%' --426
		OR [CourseTitle] like '%treble%' --437
		OR [CourseTitle] like '%ukulele%' --446
		OR [CourseTitle] like '%valhalla vox%' --450
		OR [CourseTitle] like '%violin%' --452
		OR [CourseTitle] like '%wms select ens%' --454
			)


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 95 (0 sec, 4/8/2020) count of music related courses coded as 30, 31, 32, and 33
	WHERE [CAID_Title] in (30,31,32,33)
	and (
		[CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro di uoma%'
		OR [CourseTitle] like '%concrt%'  -- 
		OR [CourseTitle] like '%choral%'  --
		OR [CourseTitle] like '%strng%' --
		OR [CourseTitle] like '%MIDI%' --
		OR [CourseTitle] like '%lyrica%' --
		OR [CourseTitle] like '%rock/roll%' --
		OR [CourseTitle] like '%instrument%' --
		OR [CourseTitle] like '%voice%' --
		OR [CourseTitle] like '%marimba%' --
		OR [CourseTitle] like '%vocal%' --
		OR [CourseTitle] like '%chamber orch%' --
		OR [CourseTitle] like '%chamber%' --
		OR [CourseTitle] like '%chior%' --
		OR [CourseTitle] like '%audio%' --
		OR [CourseTitle] like '%banjo%'--
		OR [CourseTitle] like '%sax%' --
		OR [CourseTitle] like '%perc ens%' --
		OR [CourseTitle] like '%bel canto%' --
		OR [CourseTitle] like '%bella voce%' --
		OR [CourseTitle] like '%chanteuse%' --
		OR [CourseTitle] like '%camerata%' -- 
		OR [CourseTitle] like '%mus hist%' --
		OR [CourseTitle] like '%rock and roll%' --
		OR [CourseTitle] like '%school of rock%' --
		OR [CourseTitle] like '%sinfonietta%' --
		OR [CourseTitle] like '%symph orch%' --
		OR [CourseTitle] like '%symphonia%' --
		OR [CourseTitle] like '%symphonic%' --
		OR [CourseTitle] like '%symphony%' --
		OR [CourseTitle] like '%treble%' --
		OR [CourseTitle] like '%ukulele%' --
		OR [CourseTitle] like '%valhalla vox%' --
		OR [CourseTitle] like '%violin%' 
		OR [CourseTitle] like '%wms select ens%' --95
				)

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --26 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] in (30,31,32,33)
	and (
		[CourseTitle] like '%mello-aires%'
		OR [CourseTitle] like '%goldenaires%'
		OR [CourseTitle] like '%fiddle%' 
		OR [CourseTitle] like '%philharmonic%'
		OR [CourseTitle] like '%rhythm%'
		OR [CourseTitle] like '%harmonia%'
		OR [CourseTitle] like '%singer%'
		OR [CourseTitle] like '%song%'
		OR [CourseTitle] like '%singing%'
		OR [CourseTitle] like '%coro di uoma%'
		OR [CourseTitle] like '%concrt%'  -- 
		OR [CourseTitle] like '%choral%'  --
		OR [CourseTitle] like '%strng%' --
		OR [CourseTitle] like '%MIDI%' --
		OR [CourseTitle] like '%lyrica%' --
		OR [CourseTitle] like '%rock/roll%' --
		OR [CourseTitle] like '%instrument%' --
		OR [CourseTitle] like '%voice%' --
		OR [CourseTitle] like '%marimba%' --
		OR [CourseTitle] like '%vocal%' --
		OR [CourseTitle] like '%chamber orch%' --
		OR [CourseTitle] like '%chamber%' --
		OR [CourseTitle] like '%chior%' --
		OR [CourseTitle] like '%audio%' --
		OR [CourseTitle] like '%banjo%'--
		OR [CourseTitle] like '%sax%' --
		OR [CourseTitle] like '%perc ens%' --
		OR [CourseTitle] like '%bel canto%' --
		OR [CourseTitle] like '%bella voce%' --
		OR [CourseTitle] like '%chanteuse%' --
		OR [CourseTitle] like '%camerata%' -- 
		OR [CourseTitle] like '%mus hist%' --
		OR [CourseTitle] like '%rock and roll%' --
		OR [CourseTitle] like '%school of rock%' --
		OR [CourseTitle] like '%sinfonietta%' --
		OR [CourseTitle] like '%symph orch%' --
		OR [CourseTitle] like '%symphonia%' --
		OR [CourseTitle] like '%symphonic%' --
		OR [CourseTitle] like '%symphony%' --
		OR [CourseTitle] like '%treble%' --
		OR [CourseTitle] like '%ukulele%' --
		OR [CourseTitle] like '%valhalla vox%' --
		OR [CourseTitle] like '%violin%' 
		OR [CourseTitle] like '%wms select ens%' --95
				)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --2 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
		AND (
		[CourseTitle] like '%brass%'
		)

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --2 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] is null 
		AND (
		[CourseTitle] like '%brass%'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --10 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%a cappella%'
			
	ORDER by [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --2 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%a cappella%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--41
	WHERE [CAID_Title] is null and [CourseTitle] is not null 
	AND [CourseId] like 'MUS%'
		ORDER BY [CourseTitle]--

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --41 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] is null and [CourseTitle] is not null 
	AND [CourseId] like 'MUS%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--28
	WHERE [CAID_Title] in (30,21,32,33) 
	AND [CourseId] like 'MUS%'
		ORDER BY [CourseTitle]--

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --41 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] in (30,21,32,33) 
	AND [CourseId] like 'MUS%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--4
	WHERE [CAID_Title] is null and [CourseTitle] is not null --ORDER BY [CourseTitle]
		AND [CourseTitle] = 'history of rock & roll'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 3 --4 (0 sec: 4/8/2020)						-- music related keywords in the condition shown
WHERE [CAID_Title] is null and [CourseTitle] is not null --ORDER BY [CourseTitle]
		AND [CourseTitle] = 'history of rock & roll'

/******************** DANCE 11 ************************/

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null	
																		--29,529 (1 sec, 4/8/2020) expected to be smaller than previous due to reassignment of nulls

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CourseTitle] = 'Theatre Arts' -- 399 (0 sec, 4/8/2020) INITIAL COUNT OF Dance related courses
																	--+151 NULLS and dance keywords
																	--+ 66 30,31,32,33 and keywords
																	--------------------------------
																	-- 616 dance classes

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --151 (0 sec, 4/9/2020) count check before updating the table
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] LIKE '%dance%' 
		OR [CourseTitle] LIKE '%choreo%'
		OR [CourseTitle] LIKE '%stomp%'
		)


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --66 (0 sec, 4/9/2020) to check if there are music courses with codes 30,31,32,33
	WHERE ([CAID_Title] is null OR [ContentAreaIdCEDARS] in (30,31,32,33))		
	AND ([CourseTitle] LIKE '%dance%' 
		OR [CourseTitle] LIKE '%choreo%'
		OR [CourseTitle] LIKE '%stomp%'
		)
	and [CourseTitle] not LIKE '%theatre%'
	and [CourseTitle] not LIKE '%attendance%'
	and [CourseTitle] not LIKE '%guidance%'


update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as NULL but with course title containing
set CAID_Title = 11 --151 (0 sec: 4/9/2020) same count in line 145		-- dance related keywords in the condition shown
where [CAID_Title] is null 
	AND ([CourseTitle] LIKE '%dance%' 
		OR [CourseTitle] LIKE '%choreo%'
		OR [CourseTitle] LIKE '%stomp%'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 66 (0 sec, 4/9/2020) count of dance related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	AND ([CourseTitle] LIKE '%dance%' 
		OR [CourseTitle] LIKE '%choreo%'
		OR [CourseTitle] LIKE '%stomp%'
		)
	and [CourseTitle] not LIKE '%theatre%'
	and [CourseTitle] not LIKE '%attendance%'
	and [CourseTitle] not LIKE '%guidance%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 11 --66 (0 sec: 4/8/2020)						-- dance related keywords in the condition shown
WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	AND ([CourseTitle] LIKE '%dance%' 
		OR [CourseTitle] LIKE '%choreo%'
		OR [CourseTitle] LIKE '%stomp%'
		)
	and [CourseTitle] not LIKE '%theatre%'
	and [CourseTitle] not LIKE '%attendance%'
	and [CourseTitle] not LIKE '%guidance%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --12 (0 sec, 4/9/2020) courses with keyword 'art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%ballet%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as NULL but with course title containing
set CAID_Title = 11 --12 (0 sec: 4/9/2020) same count in line 145		-- dance related keywords in the condition shown
where [CAID_Title] is null 
	AND [CourseTitle] like '%ballet%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --0 (0 sec, 4/9/2020) courses with keyword 'art' count check before updating the table 
	WHERE [CAID_Title] IN (30,31,32,33) 
		AND [CourseTitle] like '%ballet%'


/*********************** Theatre/Drama 12 **********************/

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null	--29,374 (0 sec, 4/9/2020)
																		--less 2,289 = 27,085 null but theatre/drama

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] = 12		-- 914 initial count of theatre/drama related courses
																		-- + 2,289	= 3,203 theatre/drama classes
																		-- + 273	= 3,476 30,31,32,33 assigned theatre/drama courses
																		-- + 'theater = 3,765

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with CAID Title 11 but are actually 12
set CAID_Title = 12 --4 (0 sec: 4/8/2020)						-- theatre drama related keywords in the condition shown
WHERE [CAID_Title] = 11 and [CourseTitle] = 'Theatre ARts'

SELECT * FROM  [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]
WHERE [CAID_Title] = 11 and [CourseTitle] = 'Theatre ARts'

SELECT * FROM  [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]
WHERE [CAID_Title] is null and [CourseTitle] = 'Theatre ARts'--4 rows (0 sec 4/9/2020)

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 12
set CAID_Title = 12 --4 (0 sec: 4/9/2020)							-- theatre drama related keywords in the condition shown
WHERE [CAID_Title] is null and [CourseTitle] = 'Theatre ARts'--4 rows (0 sec 4/9/2020)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --2,289 (0 sec, 4/8/2020) count check before updating the table
	WHERE [CAID_Title] is null 
	and
		([CourseTitle] = 'stagecraft' or 
				[CourseTitle] = 'play production' or 
				[CourseTitle] LIKE '%theatre%' or
				[CourseTitle] LIKE '%acting%' or
				[CourseTitle] LIKE '%drama%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 12
set CAID_Title = 12  --2,289 rows same with line 218
WHERE [CAID_Title] is null 
	and
		([CourseTitle] = 'stagecraft' or 
				[CourseTitle] = 'play production' or 
				[CourseTitle] LIKE '%theatre%' or
				[CourseTitle] LIKE '%acting%' or
				[CourseTitle] LIKE '%drama%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 273 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and
		([CourseTitle] = 'stagecraft' or 
				[CourseTitle] = 'play production' or 
				[CourseTitle] LIKE '%theatre%' or
				[CourseTitle] LIKE '%acting%' or
				[CourseTitle] LIKE '%drama%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 12 --273 (0 sec: 4/9/2020) refer to line 239			-- theatre/drama related keywords in the condition shown
WHERE [ContentAreaIdCEDARS] in (30,31,32,33)
	and
		([CourseTitle] = 'stagecraft' or 
				[CourseTitle] = 'play production' or 
				[CourseTitle] LIKE '%theatre%' or
				[CourseTitle] LIKE '%acting%' or
				[CourseTitle] LIKE '%drama%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]		-- 289 (0 sec, 4/9/2020)
	WHERE [CAID_Title] is null AND [CourseTitle] LIKE '%Theater%'

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null AND [CourseTitle] LIKE '%Theater%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 12
set CAID_Title = 12  --289 rows same with line 259
WHERE [CAID_Title] is null AND [CourseTitle] LIKE '%Theater%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]		-- 28 (0 sec, 4/9/2020)
	WHERE [CAID_Title] is null AND [CourseTitle] LIKE '%Theatr%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 12
set CAID_Title = 12  --28 rows same with line 259
WHERE [CAID_Title] is null AND [CourseTitle] LIKE '%Theatr%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 28 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [CAID_Title] in (30,31,32,33)	
	and ([CourseTitle] LIKE '%Theater%'
		OR [CourseTitle] LIKE '%Theatr%')
	AND [CourseTitle] not like 'Reader%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 12 --28 (0 sec: 4/9/2020) refer to line 239			-- theatre/drama related keywords in the condition shown
WHERE [CAID_Title] in (30,31,32,33)
and ([CourseTitle] LIKE '%Theater%'
		OR [CourseTitle] LIKE '%Theatr%')
	AND [CourseTitle] not like 'Reader%'


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]		-- 143 (0 sec, 4/9/2020)
	WHERE [CAID_Title] is null 
	AND (
		[CourseTitle] LIKE '%shakespeare%' --3
		OR [CourseTitle] LIKE '%actor%'
		OR [CourseTitle] LIKE '%ensemble%' --85
		OR [CourseTitle] LIKE '%thtr%' --95
		OR  [CourseTitle] LIKE '%directing%' --104
		OR [CourseTitle] LIKE '%play%' --132
		OR [CourseTitle] LIKE '%screenwriting%' --138
		OR [CourseTitle] LIKE '%stage management%' --141
		OR [CourseTitle] LIKE '%writing for stage%' --143

		)
		AND  [CourseTitle] not LIKE 'panther%'
		AND  [CourseTitle] not LIKE 'cosplay' 

		ORDER BY [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 12
set CAID_Title = 12  --143 rows same with line 567
WHERE [CAID_Title] is null 
	AND (
		[CourseTitle] LIKE '%shakespeare%' --3
		OR [CourseTitle] LIKE '%actor%'
		OR [CourseTitle] LIKE '%ensemble%' --85
		OR [CourseTitle] LIKE '%thtr%' --95
		OR  [CourseTitle] LIKE '%directing%' --104
		OR [CourseTitle] LIKE '%play%' --132
		OR [CourseTitle] LIKE '%screenwriting%' --138
		OR [CourseTitle] LIKE '%stage management%' --141
		OR [CourseTitle] LIKE '%writing for stage%' --143

		)
		AND  [CourseTitle] not LIKE 'panther%'
		AND  [CourseTitle] not LIKE 'cosplay' 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 8 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [CAID_Title] in (30,31,32,33)	
	and (
		[CourseTitle] LIKE '%thtr%' --
		OR  [CourseTitle] LIKE '%directing%' --
		OR [CourseTitle] LIKE '%screenwriting%' --
				)
		AND  [CourseTitle] not LIKE 'panther%'
		AND  [CourseTitle] not LIKE 'cosplay' 

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 12 --8 (0 sec: 4/9/2020) refer to line 239			-- theatre/drama related keywords in the condition shown
WHERE [CAID_Title] in (30,31,32,33)
and (
		[CourseTitle] LIKE '%thtr%' --
		OR  [CourseTitle] LIKE '%directing%' --
		OR [CourseTitle] LIKE '%screenwriting%' --
				)
		AND  [CourseTitle] not LIKE 'panther%'
		AND  [CourseTitle] not LIKE 'cosplay' 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--174
	WHERE ([CAID_Title] is null and [CourseTitle] is not null 
		and [CourseTitle] like '%stage%')
	OR
		([CAID_Title] in (30,31,32,33) 
		and [CourseTitle] like '%stage%'
		AND [CourseTitle] not like 'Human life%'
		AND [CourseTitle] not like 'Stage management'
		)
	ORDER By [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 12 
WHERE ([CAID_Title] is null and [CourseTitle] is not null 
		and [CourseTitle] like '%stage%')
	OR
		([CAID_Title] in (30,31,32,33) 
		and [CourseTitle] like '%stage%'
		AND [CourseTitle] not like 'Human life%'
		AND [CourseTitle] not like 'Stage management'
		)

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--174
	WHERE ([CAID_Title] is null and [CourseTitle] is not null 
		and [CourseTitle] like '%Production%')  --16
	--OR
	--	([CAID_Title] in (30,31,32,33) 
	--	and [CourseTitle] like '%Production%')
	ORDER By [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses reported as 30,31,32,33 but with course title containing
set CAID_Title = 12 --16
WHERE ([CAID_Title] is null and [CourseTitle] is not null 
		and [CourseTitle] like '%Production%') 

/********************** VISUAL ART 5 ****************************/

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null	-- 27,085 (1 sec, 4/9/2020) expected lower count of nulls after previous data update
																		-- less 1,538 = 25,547 'paint' classes
																		-- less 1,043 = 24,504 'visual art' classes
																		-- less   324 = 25,180 art classes
																		-- less 'theater' classes = 23,891
																		-- less draw,sign, etc classes = 14,958

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] = 5		-- 19,545 (0 sec, 4/9/2020) Initial count of visual arts
																		-- + 1,538 = 21,083 'paint' classes
																		-- + 1,043 = 22,126 'visual art' classes
																		-- +   324 = 22,450 art classes
																		---	     = 32,562 adding draw, sign, calligraphy, etc

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,538 (0 sec, 4/9/2020) courses with keyword 'paint' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%paint%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --1,538 rows same with line 266
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%paint%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 79 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and [CourseTitle] like '%paint%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --79 rows same with line 293
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)
		AND [CourseTitle] like '%paint%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,043 (0 sec, 4/9/2020) courses with keyword 'visual art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%visual art%'

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- distinct name check purposes only
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%visual art%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --1,043 rows same with line 277
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%visual art%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 33 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and [CourseTitle] like '%visual art%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --33 rows same with line 315
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)
		AND [CourseTitle] like '%visual art%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --324 (0 sec, 4/9/2020) courses with keyword 'art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] = 'art'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --324 rows same with line 292
	WHERE [CAID_Title] is null 
		AND [CourseTitle] = 'art'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 105 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and [CourseTitle] like 'art'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --105 rows same with line 292
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
		AND [CourseTitle] = 'art'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,203 (0 sec, 4/9/2020) courses with keyword 'draw' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%draw%'

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,043 (0 sec, 4/9/2020) courses with keyword 'visual art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%draw%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --1,203 rows same with line 342
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%draw%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 124 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and [CourseTitle] like '%draw%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --124 rows same with line 292
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
		AND [CourseTitle] like '%draw%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,961 (0 sec, 4/9/2020) courses with keyword 'visual art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%sign%'

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%sign%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --1,961 rows same with line 364
	WHERE [CAID_Title] is null 
		AND [CourseTitle] like '%sign%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 166 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	and [CourseTitle] like '%sign%' 
	and [CourseTitle] not like '%ELA%'
	and [CourseTitle] not like '%engineering%'
	and [CourseTitle] not like 'individually designed%'
	and [CourseTitle] not like '%sign lang%'
	and [CourseTitle] not like '%stuct eng%'
	and [CourseTitle] not like 'designed math'
	and [CourseTitle] not like 'leadership by design'
	and [CourseTitle] not like '%amer sign%'
	and [CourseTitle] not like '%designed inst%'
	and [CourseTitle] not like '%theatre%'
	and [CourseTitle] not like '%theater%'
	and [CourseTitle] not like 'design build test'
	and [CourseTitle] not like 'design think%'
	and [CourseTitle] not like '%computer aided%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --166 rows same with line 292
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
		and [CourseTitle] like '%sign%' 
		and [CourseTitle] not like '%ELA%'
		and [CourseTitle] not like '%engineering%'
		and [CourseTitle] not like 'individually designed%'
		and [CourseTitle] not like '%sign lang%'
		and [CourseTitle] not like '%stuct eng%'
		and [CourseTitle] not like 'designed math'
		and [CourseTitle] not like 'leadership by design'
		and [CourseTitle] not like '%amer sign%'
		and [CourseTitle] not like '%designed inst%'
		and [CourseTitle] not like '%theatre%'
		and [CourseTitle] not like '%theater%'
		and [CourseTitle] not like 'design build test'
		and [CourseTitle] not like 'design think%'
		and [CourseTitle] not like '%computer aided%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --5,769 (0 sec, 4/9/2020) courses with keyword 'visual art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND ([CourseTitle] like '%sculpture%'
		OR [CourseTitle] LIKE '%CERAMICS%'
		OR [CourseTitle] LIKE '%photo%'
		OR [CourseTitle] LIKE '%Calligraphy%'
		OR [CourseTitle] LIKE '%pottery%'
		OR [CourseTitle] LIKE '%MEDIA%'
		OR [CourseTitle] LIKE '%color%'
		OR [CourseTitle] LIKE '%jewelry%')
		AND [CourseTitle] not like '%Mariachi%'
		AND [CourseTitle] not like '%ensemble%'
		AND [CourseTitle] not like '%chorale%'
		AND [CourseTitle] not like '%strings%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --5,769 rows same with line 414
	WHERE [CAID_Title] is null 
		AND ([CourseTitle] like '%sculpture%'
		OR [CourseTitle] LIKE '%CERAMICS%'
		OR [CourseTitle] LIKE '%photo%'
		OR [CourseTitle] LIKE '%Calligraphy%'
		OR [CourseTitle] LIKE '%pottery%'
		OR [CourseTitle] LIKE '%MEDIA%'
		OR [CourseTitle] LIKE '%color%'
		OR [CourseTitle] LIKE '%jewelry%')
		AND [CourseTitle] not like '%Mariachi%'
		AND [CourseTitle] not like '%ensemble%'
		AND [CourseTitle] not like '%chorale%'
		AND [CourseTitle] not like '%strings%'

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 702 (0 sec, 4/9/2020) count of theare/drama related courses coded as 30, 31, 32, and 33
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)
	AND ([CourseTitle] like '%sculpture%'
		OR [CourseTitle] LIKE '%CERAMICS%'
		OR [CourseTitle] LIKE '%photo%'
		OR [CourseTitle] LIKE '%Calligraphy%'
		OR [CourseTitle] LIKE '%pottery%'
		OR [CourseTitle] LIKE '%MEDIA%'
		OR [CourseTitle] LIKE '%color%'
		OR [CourseTitle] LIKE '%jewelry%')
		AND [CourseTitle] not like '%Remedial Skills%'
		AND [CourseTitle] not like 'ELL%'
		AND [CourseTitle] not like '%mediation%'
		AND [CourseTitle] not like '%CHESS%'
		AND [CourseTitle] not like 'Intermediate Band'
		AND [CourseTitle] not like 'Intermediate ESL'
		AND [CourseTitle] not like '%ESL RDG'
		AND [CourseTitle] not like '%Health Science'
		AND [CourseTitle] not like '%reading%'

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)
	AND ([CourseTitle] like '%sculpture%'
		OR [CourseTitle] LIKE '%CERAMICS%'
		OR [CourseTitle] LIKE '%photo%'
		OR [CourseTitle] LIKE '%Calligraphy%'
		OR [CourseTitle] LIKE '%pottery%'
		OR [CourseTitle] LIKE '%MEDIA%'
		OR [CourseTitle] LIKE '%color%'
		OR [CourseTitle] LIKE '%jewelry%')
		AND [CourseTitle] not like '%Remedial Skills%'
		AND [CourseTitle] not like 'ELL%'
		AND [CourseTitle] not like '%mediation%'
		AND [CourseTitle] not like '%CHESS%'
		AND [CourseTitle] not like 'Intermediate Band'
		AND [CourseTitle] not like 'Intermediate ESL'
		AND [CourseTitle] not like '%ESL RDG'
		AND [CourseTitle] not like '%Health Science'
		AND [CourseTitle] not like '%reading%'
	ORDER BY [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --702 rows same with line 447
	WHERE [ContentAreaIdCEDARS] in (30,31,32,33)	
	AND ([CourseTitle] like '%sculpture%'
		OR [CourseTitle] LIKE '%CERAMICS%'
		OR [CourseTitle] LIKE '%photo%'
		OR [CourseTitle] LIKE '%Calligraphy%'
		OR [CourseTitle] LIKE '%pottery%'
		OR [CourseTitle] LIKE '%MEDIA%'
		OR [CourseTitle] LIKE '%color%'
		OR [CourseTitle] LIKE '%jewelry%')
		AND [CourseTitle] not like '%Remedial Skills%'
		AND [CourseTitle] not like 'ELL%'
		AND [CourseTitle] not like '%mediation%'
		AND [CourseTitle] not like '%CHESS%'
		AND [CourseTitle] not like 'Intermediate Band'
		AND [CourseTitle] not like 'Intermediate ESL'
		AND [CourseTitle] not like '%ESL RDG'
		AND [CourseTitle] not like '%Health Science'
		AND [CourseTitle] not like '%reading%'


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]					--14
	WHERE [CAID_Title] is null 
	--AND [CourseTitle] like '%animation%' 
	order by [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --14 rows same with line 512
	WHERE [CAID_Title] is null AND [CourseTitle] like '%animation%' 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]					--187
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] like '%2D%'
	OR [CourseTitle] like '%2-Dimensional%'
	OR [CourseTitle] like '%2 Dimensional%'
	OR [CourseTitle] like '%3D%'
	OR [CourseTitle] like '%3-Dimensional%'
	OR [CourseTitle] like '%3 Dimensional%')
	order by [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --187 rows same with line 521
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] like '%2D%'
	OR [CourseTitle] like '%2-Dimensional%'
	OR [CourseTitle] like '%2 Dimensional%'
	OR [CourseTitle] like '%3D%'
	OR [CourseTitle] like '%3-Dimensional%'
	OR [CourseTitle] like '%3 Dimensional%') 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 31
	WHERE [CAID_Title] in (30,31,32,33)
	AND ([CourseTitle] like '%animation%' 
		OR [CourseTitle] like '%2D%'
		OR [CourseTitle] like '%2-Dimensional%'
		OR [CourseTitle] like '%2 Dimensional%'
		OR [CourseTitle] like '%3D%'
		OR [CourseTitle] like '%3-Dimensional%'
		OR [CourseTitle] like '%3 Dimensional%') 

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --31 rows same with line 541
	WHERE [CAID_Title] in (30,31,32,33)	
	AND ([CourseTitle] like '%animation%' 
		OR [CourseTitle] like '%2D%'
		OR [CourseTitle] like '%2-Dimensional%'
		OR [CourseTitle] like '%2 Dimensional%'
		OR [CourseTitle] like '%3D%'
		OR [CourseTitle] like '%3-Dimensional%'
		OR [CourseTitle] like '%3 Dimensional%') 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]					--46
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] like '%2-D%'
		OR [CourseTitle] like '%3-D%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --46 rows same with line 562
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] like '%2-D%'
		OR [CourseTitle] like '%3-D%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null --14,319

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --138 (0 sec, 4/9/2020) courses with keyword 'art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND ([CourseTitle] like '%vis art%'
			OR [CourseTitle] Like '%CRAFTS%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --138 rows same with line 647
	WHERE [CAID_Title] is null 
	AND ([CourseTitle] like '%vis art%'
			OR [CourseTitle] Like '%CRAFTS%')

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 4
	WHERE [CAID_Title] in (30,31,32,33)
	AND ([CourseTitle] like '%vis art%'
			OR [CourseTitle] Like '%CRAFTS%')

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --4 rows same with line 658
	WHERE [CAID_Title] in (30,31,32,33)	
	AND ([CourseTitle] like '%vis art%'
			OR [CourseTitle] Like '%CRAFTS%') 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null and [CourseTitle] is not null--7,765

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null and [CourseTitle] is not null --7,765
	AND [CourseTitle] not like '%engineer%' -- 7,754
	AND [CourseTitle] not like '%health%'--7,748
	AND [CourseTitle] not like 'PE Adaptive%' -- 7,740
	AND [CourseTitle] not like 'PE Bridges%' -- 7,738
	AND [CourseTitle] not like '%Sports%' -- 7,733

	ORDER BY [CourseTitle]

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null and [CourseTitle] is not null Order by [CourseTitle]--7,765

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] WHERE [CAID_Title] is null --14,180

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] 
	WHERE [CAID_Title] is null 
	and [CourseTitle] like '%art%' 
		ORDER BY [CourseTitle]-- 3,201


update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --138 rows same with line 647
WHERE [CAID_Title] is null 
	and [CourseId] like '%art%' 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]   -- 925
	WHERE [CAID_Title] is null and [CourseTitle] is not null 
		AND ([CourseTitle] like '%textile%'
			OR [CourseTitle] like '%metalwork%'
			OR [CourseTitle] like '%glasswork%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%graph des%'
			OR [CourseTitle] like '%yearbook%'
			OR [CourseTitle] like '%glass art%'
			OR [CourseTitle] like '%graph art%'
			OR [CourseTitle] like '%screen printing%'
			OR [CourseTitle] like '%wood carv%'
			OR [CourseTitle] like '%business graphic%'
			OR [CourseTitle] like '%cartoon%'
			OR [CourseTitle] like '%carving%'
			OR [CourseTitle] like 'clay%'
			OR [CourseTitle] like '%sculpt%'
			OR [CourseTitle] like '%commercial art%'
			OR [CourseTitle] like '%graphics%'
			OR [CourseTitle] like '%woodwork%'
			OR [CourseTitle] like '%fiber art%'
			OR [CourseTitle] like '%digital art%'
			OR [CourseTitle] like '%drw/scul/pnt%'
			OR [CourseTitle] like '%fine art%'
			OR [CourseTitle] like '%glass%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%graphicart%'
			OR [CourseTitle] like '%housing interior%'
			OR [CourseTitle] like '%film%'
			OR [CourseTitle] like '%multi media%'
			OR [CourseTitle] like '%multimedia%'
			OR [CourseTitle] like '%impressionism%'
			OR [CourseTitle] like '%v-art%'
			OR [CourseTitle] like '%jewelery%'
			OR [CourseTitle] = 'lettering'
			OR [CourseTitle] like '%print%'
			OR [CourseTitle] like '%production art%'
			OR [CourseTitle] like '%quilt%'
			OR [CourseTitle] like '%street art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%video edit%'
			OR [CourseTitle] like '%video graph%'
			OR [CourseTitle] like '%video prod%'
			OR [CourseTitle] like '%video tech%'
			OR [CourseTitle] like '%videograph%'
			OR [CourseTitle] like 'viscomm%'
			OR [CourseTitle] like '%visual comm%'
			OR [CourseTitle] like '%wood%'
			)
					
		Order by [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --138 rows same with line 647
WHERE [CAID_Title] is null and [CourseTitle] is not null 
		AND ([CourseTitle] like '%textile%'
			OR [CourseTitle] like '%metalwork%'
			OR [CourseTitle] like '%glasswork%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%graph des%'
			OR [CourseTitle] like '%yearbook%'
			OR [CourseTitle] like '%glass art%'
			OR [CourseTitle] like '%graph art%'
			OR [CourseTitle] like '%screen printing%'
			OR [CourseTitle] like '%wood carv%'
			OR [CourseTitle] like '%business graphic%'
			OR [CourseTitle] like '%cartoon%'
			OR [CourseTitle] like '%carving%'
			OR [CourseTitle] like 'clay%'
			OR [CourseTitle] like '%sculpt%'
			OR [CourseTitle] like '%commercial art%'
			OR [CourseTitle] like '%graphics%'
			OR [CourseTitle] like '%woodwork%'
			OR [CourseTitle] like '%fiber art%'
			OR [CourseTitle] like '%digital art%'
			OR [CourseTitle] like '%drw/scul/pnt%'
			OR [CourseTitle] like '%fine art%'
			OR [CourseTitle] like '%glass%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%graphicart%'
			OR [CourseTitle] like '%housing interior%'
			OR [CourseTitle] like '%film%'
			OR [CourseTitle] like '%multi media%'
			OR [CourseTitle] like '%multimedia%'
			OR [CourseTitle] like '%impressionism%'
			OR [CourseTitle] like '%v-art%'
			OR [CourseTitle] like '%jewelery%'
			OR [CourseTitle] = 'lettering'
			OR [CourseTitle] like '%print%'
			OR [CourseTitle] like '%production art%'
			OR [CourseTitle] like '%quilt%'
			OR [CourseTitle] like '%street art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%video edit%'
			OR [CourseTitle] like '%video graph%'
			OR [CourseTitle] like '%video prod%'
			OR [CourseTitle] like '%video tech%'
			OR [CourseTitle] like '%videograph%'
			OR [CourseTitle] like 'viscomm%'
			OR [CourseTitle] like '%visual comm%'
			OR [CourseTitle] like '%wood%'
			)
					
SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  -- 624
	WHERE [CAID_Title] in (30,31,32,33)
	AND ([CourseTitle] like '%textile%'
			OR [CourseTitle] like '%metalwork%'
			OR [CourseTitle] like '%glasswork%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%graph des%'
			OR [CourseTitle] like '%yearbook%'
			OR [CourseTitle] like '%glass art%'
			OR [CourseTitle] like '%graph art%'
			OR [CourseTitle] like '%screen printing%'
			OR [CourseTitle] like '%wood carv%'
			OR [CourseTitle] like '%business graphic%'
			OR [CourseTitle] like '%cartoon%'
			OR [CourseTitle] like '%carving%'
			OR [CourseTitle] like 'clay%'
			OR [CourseTitle] like '%sculpt%'
			OR [CourseTitle] like '%commercial art%'
			OR [CourseTitle] like '%graphics%'
			OR [CourseTitle] like '%woodwork%'
			OR [CourseTitle] like '%fiber art%'
			OR [CourseTitle] like '%digital art%'
			OR [CourseTitle] like '%drw/scul/pnt%'
			OR [CourseTitle] like '%fine art%'
			OR [CourseTitle] like '%glass%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%graphicart%'
			OR [CourseTitle] like '%housing interior%'
			OR [CourseTitle] like '%film%'
			OR [CourseTitle] like '%multi media%'
			OR [CourseTitle] like '%multimedia%'
			OR [CourseTitle] like '%impressionism%'
			OR [CourseTitle] like '%v-art%'
			OR [CourseTitle] like '%jewelery%'
			OR [CourseTitle] = 'lettering'
			OR [CourseTitle] like '%print%'
			OR [CourseTitle] like '%production art%'
			OR [CourseTitle] like '%quilt%'
			OR [CourseTitle] like '%street art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%video edit%'
			OR [CourseTitle] like '%video graph%'
			OR [CourseTitle] like '%video prod%'
			OR [CourseTitle] like '%video tech%'
			OR [CourseTitle] like '%videograph%'
			OR [CourseTitle] like 'viscomm%'
			OR [CourseTitle] like '%visual comm%'
			OR [CourseTitle] like '%wood%'
			)
			AND [CourseTitle] not like '%Haselwood%'
			AND [CourseTitle] not like 'History%'

		ORDER BY [CourseTitle]

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --138 rows same with line 647
WHERE [CAID_Title] in (30,31,32,33)
	AND ([CourseTitle] like '%textile%'
			OR [CourseTitle] like '%metalwork%'
			OR [CourseTitle] like '%glasswork%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%graph des%'
			OR [CourseTitle] like '%yearbook%'
			OR [CourseTitle] like '%glass art%'
			OR [CourseTitle] like '%graph art%'
			OR [CourseTitle] like '%screen printing%'
			OR [CourseTitle] like '%wood carv%'
			OR [CourseTitle] like '%business graphic%'
			OR [CourseTitle] like '%cartoon%'
			OR [CourseTitle] like '%carving%'
			OR [CourseTitle] like 'clay%'
			OR [CourseTitle] like '%sculpt%'
			OR [CourseTitle] like '%commercial art%'
			OR [CourseTitle] like '%graphics%'
			OR [CourseTitle] like '%woodwork%'
			OR [CourseTitle] like '%fiber art%'
			OR [CourseTitle] like '%digital art%'
			OR [CourseTitle] like '%drw/scul/pnt%'
			OR [CourseTitle] like '%fine art%'
			OR [CourseTitle] like '%glass%'
			OR [CourseTitle] like '%graphic art%'
			OR [CourseTitle] like '%graphicart%'
			OR [CourseTitle] like '%housing interior%'
			OR [CourseTitle] like '%film%'
			OR [CourseTitle] like '%multi media%'
			OR [CourseTitle] like '%multimedia%'
			OR [CourseTitle] like '%impressionism%'
			OR [CourseTitle] like '%v-art%'
			OR [CourseTitle] like '%jewelery%'
			OR [CourseTitle] = 'lettering'
			OR [CourseTitle] like '%print%'
			OR [CourseTitle] like '%production art%'
			OR [CourseTitle] like '%quilt%'
			OR [CourseTitle] like '%street art%'
			OR [CourseTitle] like '%studio art%'
			OR [CourseTitle] like '%video edit%'
			OR [CourseTitle] like '%video graph%'
			OR [CourseTitle] like '%video prod%'
			OR [CourseTitle] like '%video tech%'
			OR [CourseTitle] like '%videograph%'
			OR [CourseTitle] like 'viscomm%'
			OR [CourseTitle] like '%visual comm%'
			OR [CourseTitle] like '%wood%'
			)
			AND [CourseTitle] not like '%Haselwood%'
			AND [CourseTitle] not like 'History%'

		ORDER BY [CourseTitle]

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] 
	WHERE [CAID_Title] is null and [CourseTitle] = 'art'
	--[ContentAreaIdCEDARS] is null AND 
	--[CourseTitle] = '%art%'
	--and 
	
		ORDER BY [CourseTitle]-- 324

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --324 rows same with line 647
WHERE [CAID_Title] is null AND [CourseTitle] = 'art'
	and [CAID_Title] = 5  

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] 
	WHERE [CAID_Title] = 5 and [CourseTitle] Like 'Art %'
		ORDER BY [CourseTitle]-- 324

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]  --1,043 (0 sec, 4/9/2020) courses with keyword 'visual art' count check before updating the table 
	WHERE [CAID_Title] is null 
		AND [CourseTitle] is not null ORDER BY [CourseTitle]


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] 
	WHERE [CAID_Title] is null 
	and [CourseTitle] like '%art%' 
		ORDER BY [CourseTitle]-- 2,073

SELECT DISTINCT [CourseTitle] FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] 
	WHERE [CAID_Title] is null 
	and [CourseTitle] like '%art%' 
		ORDER BY [CourseTitle]-- 2,073


update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --2,073 rows same with line 647
WHERE  [CAID_Title] is null 
	and [CourseTitle] like '%art%' 

SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]		-- 310
	WHERE [CAID_Title] in (30,31,32,33)
	and [CourseId] like 'art%' 
	and [CourseTitle] like '%art%'
	AND [CourseTitle] not like '%ART TA%'

update ZZ_SI_ID195_4Cult_ContentAreaReAssign						-- update the ContentAreaReAssign with courses with NULL CAID Title but are actually 5
set CAID_Title = 5  --310 rows 
WHERE  [CAID_Title] in (30,31,32,33)
	and [CourseId] like 'art%' 
	and [CourseTitle] like '%art%'
	AND [CourseTitle] not like '%ART TA%' 


SELECT * FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]			--724
	WHERE [CAID_Title] is null and [CourseTitle] is not null 

		ORDER BY [CourseTitle]--

/************************************************************************
*************************************************************************
*************************************************************************/

SELECT w.[SchoolYear]							-- generate a table containing all necessary data for teacher head count, section count, in-field teacher count, and in-field section count
      --,[SchoolYearId]
      ,w.[DistrictID]		
      ,x.[schoolorganizationid] AS SchoolID
	,x.[SchoolCode]
	,x.[DistrictName]
	,x.[SchoolName]
	--,[ClassID]
      --,[SourceSystem]
      --,[ContentAreaIdCEDARS]
	,w.[CAID_Title]
      ,CASE	
		WHEN w.[CAID_Title] = 3	 THEN 'Music'
		WHEN w.[CAID_Title] = 5	 THEN 'VisualArts'
		WHEN w.[CAID_Title] = 11 THEN 'Dance'
		WHEN w.[CAID_Title] = 12 THEN 'TheatreDrama'
		ELSE 'Elementary'
	END As ContentArea
	--,y.[ContentAreaid]  
	--,y.[ContentAreaName]
 --     ,[CourseId]
 --     ,[CourseTitle]
 --     ,[PersonId]
 --     ,[TeacherOTFReasonId]
 --     ,[TeacherOTFSpecialistContentAreaId]
	--,[TeacherOverrideOTFLMCTypeID] 
	,count(distinct [PersonId])	as HeadCount
	,count([ClassID])			as SectionCount
	,count(distinct case when [TeacherOTFReasonId] IS NULL --INF for classroom teachers and Specialists who are reported with specific state course codes
					OR ([TeacherOTFReasonId] IS NOT NULL AND [TeacherOverrideOTFLMCTypeID] IS NOT NULL) --INF for classroom teachers to override OTF status using Limited certificate
				then [PersonId] else null end) 
						as INFHeadCount
	,count(case when  [TeacherOTFReasonId] IS NULL --INF for classroom teachers and Specialists who are reported with specific state course codes
					OR ([TeacherOTFReasonId] IS NOT NULL AND [TeacherOverrideOTFLMCTypeID] IS NOT NULL) --INF for classroom teachers to override OTF status using Limited certificate
				then 1 else null end) 
						as INFSectionCount
-- into #t -- 9,674 rows (8sec: 04/12/2020)
  FROM [K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign] w left outer join [KaorisDatabase].[dbo].[DirectoryLong] x ON w.[SchoolID] = x.[schoolorganizationid] and w.[SchoolYear] = x.[SchoolYearCode]
											       left outer join [KaorisDatabase].[dbo].[LU_wrcContentAreaID] y ON w.[CAID_Title] = y.[ContentAreaID] 
  where [CAID_Title] in (3,5,11,12,8) and [schoolorganizationid] in (106169, 106176,106175,101946,102061,103974,105805,105980,106079)
  group by w.[SchoolYear],w.[DistrictID],x.[DistrictName],x.[SchoolName],x.[schoolorganizationid],x.[SchoolCode],w.[CAID_Title],y.[ContentAreaId],y.[ContentAreaName]
  ORDER BY w.[SchoolYear],w.[DistrictID],x.[DistrictName],x.[SchoolName],x.[schoolorganizationid],x.[SchoolCode],w.[CAID_Title],y.[ContentAreaId],y.[ContentAreaName]




/****************************************************/
IF OBJECT_ID('tempdb..#t') IS NOT NULL
    DROP TABLE #t

/***************************************************/

-- pivot table the results from previous 


SELECT * 
FROM	tempdb.sys.columns 
WHERE object_id = object_id('tempdb..#t');

--Tabel 1: ArtsEndorsedTeacher -- 4,302 (0sec 4/12/2020)
SELECT	[SchoolYear],[DistrictID],[SchoolID],[SchoolCode],[DistrictName],[SchoolName]
		--,Music,VisualArts,Dance,TheatreDrama,Elementary
		,ISNULL(Music,0) AS Music
		,ISNULL(VisualArts,0) AS VisualArts
		,ISNULL(Dance,0) AS Dance
		,ISNULL(TheatreDrama,0) AS TheatreDrama
		,ISNULL(Elementary,0) AS Elementary--1944*/
FROM 		(SELECT [ContentArea],[SchoolYear],[DistrictID]
			,[SchoolID],[SchoolCode]
			,[DistrictName],[SchoolName],[HeadCount]
			FROM #t)
			
		AS	sourcetable
		PIVOT
			(MAX ([HeadCount]) FOR [ContentArea] 
				IN (Music,VisualArts,Dance,TheatreDrama,Elementary) )
				AS PivotTable
--GROUP BY [SchoolNAme]
ORDER BY	[SchoolYear],[DistrictName],[SchoolName]

--Tabel 2: TotalArtsSectionOffered
SELECT	[SchoolYear],[DistrictID],[SchoolID],[SchoolCode],[DistrictName],[SchoolName]
		,ISNULL(Music,0) AS Music
		,ISNULL(VisualArts,0) AS VisualArts
		,ISNULL(Dance,0) AS Dance
		,ISNULL(TheatreDrama,0) AS TheatreDrama
		,ISNULL(Elementary,0) AS Elementary
FROM		(SELECT [ContentArea],[SchoolYear],[DistrictID]
			,[SchoolID],[SchoolCode]
			,[DistrictName],[SchoolName],[SectionCount]
			FROM #t)
			
		AS	sourcetable
		PIVOT
			(MAX ([SectionCount]) FOR [ContentArea] 
				IN (Music,VisualArts,Dance,TheatreDrama,Elementary) )
				AS PivotTable
--GROUP BY [SchoolNAme]
ORDER BY	[SchoolYear],[DistrictName],[SchoolName]


--Tabel 3: Arts Section being taught by INFTeacherHeadCount
SELECT	[SchoolYear],[DistrictID],[SchoolID],[SchoolCode],[DistrictName],[SchoolName]
		,ISNULL(Music,0) AS Music
		,ISNULL(VisualArts,0) AS VisualArts
		,ISNULL(Dance,0) AS Dance
		,ISNULL(TheatreDrama,0) AS TheatreDrama
		,ISNULL(Elementary,0) AS Elementary
FROM		(SELECT [ContentArea],[SchoolYear],[DistrictID]
			,[SchoolID],[SchoolCode]
			,[DistrictName],[SchoolName],[INFHeadCount]
			FROM #t)
			
		AS	sourcetable
		PIVOT
			(MAX ([INFHeadCount]) FOR [ContentArea] 
				IN (Music,VisualArts,Dance,TheatreDrama,Elementary) )
				AS PivotTable
ORDER BY	[SchoolYear],[DistrictName],[SchoolName]


--Tabel 4: Arts Section being taught by INFSectionCount
SELECT	[SchoolYear],[DistrictID],[SchoolID],[SchoolCode],[DistrictName],[SchoolName]
		,ISNULL(Music,0) AS Music
		,ISNULL(VisualArts,0) AS VisualArts
		,ISNULL(Dance,0) AS Dance
		,ISNULL(TheatreDrama,0) AS TheatreDrama
		,ISNULL(Elementary,0) AS Elementary
FROM		(SELECT [ContentArea],[SchoolYear],[DistrictID]
			,[SchoolID],[SchoolCode]
			,[DistrictName],[SchoolName],[INFSectionCount]
			FROM #t)
			
		AS	sourcetable
		PIVOT
			(MAX ([INFSectionCount]) FOR [ContentArea] 
				IN (Music,VisualArts,Dance,TheatreDrama,Elementary) )
				AS PivotTable
ORDER BY	[SchoolYear],[DistrictName],[SchoolName]



-- generate a data summary 

SELECT	[SchoolYear],
CASE		WHEN [CAID_Title] = 3	THEN 'Music'
		WHEN [CAID_Title] = 5	THEN 'VisualArts'
		WHEN [CAID_Title] = 11	THEN 'Dance'
		WHEN [CAID_Title] = 12	THEN 'TheatreDrama'
		WHEN [CAID_Title] = 8	THEN 'Elementary'
		ELSE NULL
	END As ContentArea
		,count(distinct [PersonId])	as HeadCount
		,count(distinct case when [TeacherOTFReasonId] IS NULL --INF for classroom teachers and Specialists who are reported with specific state course codes
					OR ([TeacherOTFReasonId] IS NOT NULL AND [TeacherOverrideOTFLMCTypeID] IS NOT NULL) --INF for classroom teachers to override OTF status using Limited certificate
						then [PersonId] else null end) 
							as INFHeadCount
		,count([ClassID])			as SectionCount
		,count(case when  [TeacherOTFReasonId] IS NULL --INF for classroom teachers and Specialists who are reported with specific state course codes
					OR ([TeacherOTFReasonId] IS NOT NULL AND [TeacherOverrideOTFLMCTypeID] IS NOT NULL) --INF for classroom teachers to override OTF status using Limited certificate
						then 1 else null end) 
							as INFSectionCount

  FROM	[K12\dennisalvin.david].[ZZ_SI_ID195_4Cult_ContentAreaReAssign]
  WHERE	[SchoolYearId] in (9, 10) AND [CAID_Title] IN (3,5,11,12,8)
  GROUP BY	[SchoolYear] , [CAID_Title]
  ORDER BY	[SchoolYear] ,[CAID_Title]