USE GamingSiteDB
GO

CREATE TRIGGER MoneyCheck
On Gaming.ServerStats
INSTEAD OF Update
AS

DECLARE @ServerStatsID INT = (SELECT ServerStatsID FROM INSERTED);
DECLARE @ServerID INT = (SELECT ServerID FROM INSERTED);
DECLARE @UniquePlayers INT = (SELECT UniquePlayers FROM INSERTED);
DECLARE @Bans INT = (SELECT Bans FROM INSERTED);
DECLARE @PlayerKills INT = (SELECT PlayerKills FROM INSERTED);
DECLARE @PlayerAIKills INT = (SELECT PlayerAIKills FROM INSERTED);
DECLARE @AIPlayerKills INT = (SELECT AIPlayerKills FROM INSERTED);
DECLARE @MoneyCirculatedInShop MONEY = (SELECT MoneyCirculatedInShop FROM INSERTED);
DECLARE @FullMoney INT = (SELECT FullMoney FROM INSERTED);
DECLARE @MissionsDone INT = (SELECT MissionsDone FROM INSERTED);


IF(@MoneyCirculatedInShop >= 912337203685477.5807)
BEGIN
DECLARE @MoneyLeft MONEY = (SELECT (MoneyCirculatedInShop - 912337203685477.5807) FROM INSERTED)
SET @FullMoney = @FullMoney + 1;
SET @MoneyCirculatedInShop = @MoneyLeft;

UPDATE  Gaming.ServerStats
SET ServerID = @ServerStatsID,
	UniquePlayers = @UniquePlayers,
	Bans = @Bans,
	PlayerKills = @PlayerKills,
	PlayerAIKills = @PlayerAIKills,
	AIPlayerKills = @AIPlayerKills,
	MoneyCirculatedInShop = @MoneyLeft,
	FullMoney = @FullMoney,
	MissionsDone = @MissionsDone
WHERE ServerStatsID = @ServerStatsID

END
Else
UPDATE  Gaming.ServerStats
SET ServerID = @ServerStatsID,
	UniquePlayers = @UniquePlayers,
	Bans = @Bans,
	PlayerKills = @PlayerKills,
	PlayerAIKills = @PlayerAIKills,
	AIPlayerKills = @AIPlayerKills,
	MoneyCirculatedInShop = @MoneyCirculatedInShop,
	FullMoney = @FullMoney,
	MissionsDone = @MissionsDone
WHERE ServerStatsID = @ServerStatsID

