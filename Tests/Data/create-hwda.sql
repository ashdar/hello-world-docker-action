/*
.SYNOPSIS
Create a database and some dumb objects that I can use as experiment for deployment/taskrunner code.

.NOTES
In retrospect, the names of the schema and of the table are kind of dumb. 

Meh, this is just an experiment.


*/
go
-- create database hwda;

use hwda;

go

if not exists (select * from sys.schemas s where s.name = 'lookup')
BEGIN
	EXECUTE ('CREATE SCHEMA [LookUp]')
END

go


drop table if exists [LookUp].[State]

create table [LookUp].[State] (
    StateID integer not null primary key
    , StateName nvarchar(64) not null
    , StateStatus nvarchar(64) not null

    , StateCodeISO nchar(5) not null
    , StateCodeANSI2Character nchar(2) not null
    , StateCodeANSI2Digit char(2) not null

    , StateCodeUSPS char(2) not null
    , StateCodeUSCG char(2) not null

	, StateCodeGPO nvarchar(64) not null
	, StateCodeAP nvarchar(64) not null

)
go

-- create schema InitializeData
go
CREATE OR ALTER PROCEDURE InitializeData.Initialize_All
	@SkipInsert BIT = 0
AS
BEGIN
    /*
    .LINK
    https://en.wikipedia.org/wiki/List_of_U.S._state_and_territory_abbreviations
    */

	DECLARE @Message NVARCHAR(MAX)

	BEGIN TRY

		BEGIN TRANSACTION

		TRUNCATE TABLE [LookUp].State
		SET @Message = 'WARNING: Performed data truncation on [Lookup].[State]'
		RAISERROR(@Message, 0,1) WITH NOWAIT

		IF (@SkipInsert = 1) 
		BEGIN
			SET @Message = 'WARNING: Skipped insert to [Lookup].[State] due to @SkipInsert switch'
			RAISERROR(@Message, 0,1) WITH NOWAIT
		END
		ELSE
		BEGIN
			INSERT INTO [LookUp].[State]

			VALUES (1, 'Alabama', 'State', 'US-AL', 'AL', '01', 'AL', 'AL',	'Ala', 'Ala')
				, (2, 'Alaska', 'State', 'US-AK', 'AK', '02', 'AK', 'AK',	'Alaska', 'Alaska')
				, (4, 'Arizona',	'State',	'US-AZ',	'AZ',	'04',	'AZ',	'AZ',	'Ariz.'	,'Ariz.')
				, (5, 'Arkansas',	'State', 'US-AR', 'AR', '05', 'AR', 'AR', 'Ark.', 'Ark.')
				, (6, 'California','State', 'US-CA', 'CA', '06', 'CA', 'CF', 'Calif.', 'Calif.')
				, (8, 'Colorado',	'State', 'US-CO', 'CO', '08', 'CO', 'CL', 'Colo.', 'Colo.')
				, (9, 'Connecticut','State', 'US-CT', 'CT', '09', 'CT', 'CT', 'Conn.', 'Conn.')
				, (10, 'Delaware',	'State', 'US-DE', 'DE', '10', 'DE', 'DL', 'Del.', 'Del.')
				, (11, 'District of Columbia',	'Federal district',	'US-DC','DC', '11', 'DC','DC','D.C.','D.C.')
				, (12, 'Florida',	'State',	'US-FL','FL','12', 'FL', 'FL', 'Fla.', 'Fla.')
				, (13, 'Georgia',	'State',	'US-GA','GA','13', 'GA', 'GA', 'Ga.', 'Ga.')
				, (15, 'Hawaii',	'State',	'US-HI','HI','15', 'HI', 'HA', 'Hawaii', 'Hawaii')
				, (16, 'Idaho',	'State',		'US-ID','ID','16', 'ID', 'ID', 'Idaho', 'Idaho')
				, (17, 'Illinois',	'State',	'US-IL','IL','17', 'IL', 'IL', 'Ill.', 'Ill.')
				, (18, 'Indiana',	'State',	'US-IN','IN','18', 'IN', 'IN', 'Ind.', 'Ind.')
				, (19, 'Iowa',	'State',		'US-IA','IA','19', 'IA', 'IA', 'Iowa', 'Iowa')
				, (20, 'Kansas',	'State',	'US-KS','KS','20', 'KS', 'KA', 'Kans.', 'Kan.')
				, (21, 'Kentucky',	'State',	'US-KY','KY','21', 'KY', 'KY', 'Ky.', 'Ky.')
				, (22, 'Louisiana',	'State',	'US-LA','LA','22', 'LA', 'LA', 'La.', 'La.')
				, (23, 'Maine',	'State',		'US-ME','ME','23', 'ME', 'ME', 'Maine', 'Maine')
				, (24, 'Maryland',	'State',	'US-MD','MD','24', 'MD', 'MD', 'Md.', 'Md.')
				, (25, 'Massachusetts',	'State','US-MA','MA','25', 'MA', 'MS', 'Mass.', 'Mass.')
				, (26, 'Michigan',	'State',	'US-MI','MI','26', 'MI', 'MC', 'Mich.', 'Mich.')
				, (27, 'Minnesota',	'State',	'US-MN','MN','27', 'MN', 'MN', 'Minn.', 'Minn.')
				, (28, 'Mississippi',	'State','US-MS','MS','28', 'MS', 'MI', 'Miss.', 'Miss.')
				, (29, 'Missouri',	'State',	'US-MO','MO','29', 'MO', 'MO', 'Mo.', 'Mo.')
				, (30, 'Montana',	'State',	'US-MT','MT','30', 'MT', 'MT', 'Mont.', 'Mont.')
				, (31, 'Nebraska',	'State',	'US-NE','NE','31', 'NE', 'NB', 'Nebr.', 'Neb.')
				, (32, 'Nevada',	'State',	'US-NV','NV','32', 'NV', 'NV', 'Nev.', 'Nev.')
				, (33, 'New Hampshire',	'State',	'US-NH','NH','33', 'NH', 'NH', 'N.H.', 'N.H.')
				, (34, 'New Jersey',	'State',	'US-NJ','NJ','34', 'NJ', 'NJ', 'N.J.', 'N.J.')
				, (35, 'New Mexico',	'State',	'US-NM','NM','35', 'NM', 'NM', 'N. Mex.', 'N.M.')
				, (36, 'New York',	'State',		'US-NY','NY','36', 'NY', 'NY', 'N.Y.', 'N.Y.')
				, (37, 'North Carolina','State',	'US-NC','NC','37', 'NC', 'NC', 'N.C.', 'N.C.')
				, (38, 'North Dakota',	'State',	'US-ND','ND','38', 'ND', 'ND', 'N. Dak.', 'N.D.')
				, (39, 'Ohio',	'State',		'US-OH','OH','39', 'OH', 'OH', 'Ohio', 'Ohio')
				, (40, 'Oklahoma',	'State',	'US-OK','OK','40', 'OK', 'OK', 'Okla.', 'Okla.')
				, (41, 'Oregon',	'State',	'US-OR','OR','41', 'OR', 'OR', 'Oreg.', 'Ore.')
				, (42, 'Pennsylvania',	'State',	'US-PA',	'PA',	'42',	'PA',	'PA',	'Pa.',	'Pa.')
				, (44, 'Rhode Island',	'State','US-RI', 'RI', '44', 'RI', 'RI', 'R.I.'	,'R.I.')
				, (45, 'South Carolina','State','US-SC', 'SC', '45', 'SC', 'SC', 'S.C.'	,'S.C.')
				, (46, 'South Dakota',	'State','US-SD', 'SD', '46', 'SD', 'SD', 'S. Dak.','S.D.')
				, (47, 'Tennessee',	'State',	'US-TN', 'TN', '47', 'TN', 'TN', 'Tenn.','Tenn.')
				, (48, 'Texas',	'State',		'US-TX', 'TX', '48', 'TX', 'TX', 'Tex.','Texas')
				, (49, 'Utah',	'State',		'US-UT', 'UT', '49', 'UT', 'UT', 'Utah','Utah')
				, (50, 'Vermont',	'State',	'US-VT', 'VT', '50', 'VT', 'VT', 'Vt.','Vt.')
				, (51, 'Virginia',	'State',	'US-VA', 'VA', '51', 'VA', 'VA', 'Va.','Va.')
				, (53, 'Washington','State',	'US-WA', 'WA', '53', 'WA', 'WN', 'Wash.','Wash')
				, (54, 'West Virginia',	'State','US-WV', 'WV', '54', 'WV', 'WV', 'W. Va.','W.Va.')
				, (55, 'Wisconsin',	'State',	'US-WI', 'WI', '55', 'WI', 'WS', 'Wis.','Wis.')
				, (56, 'Wyoming',	'State',	'US-WY', 'WY', '56', 'WY', 'WY', 'Wyo.','Wyo.')

		END

		COMMIT TRANSACTION

	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
		THROW
	END CATCH

END

go

/* TEST
*/
execute InitializeData.Initialize_All @skipinsert = 0
select * from [LookUp].[State]


