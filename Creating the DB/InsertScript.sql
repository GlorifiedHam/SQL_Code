-- Insert scripUSE GamingSiteDB
USE GamingSiteDB
GO

-- Insert into Role
INSERT INTO [Internal].Role
Values
(1,'Guest') , (2, 'Member'), (3,'Donator'), (4,'VIP'), (5,'SuperVIP'), (6,'Moderator'), (7,'ForumModerator'), (8, 'ServerModerator'), (9, 'SuperModerator'), (10,'Admin'), (11, 'ForumAdmin'), (12, 'ServerAdmin'), (13, 'SuperAdmin') -- Might change this (Need something under superAdmin) , admin/moderator might also need to be changed
GO
-- Insert into user
Insert into [Site].[User]
([Username], [Firstname],ShowFirstName, [Lastname], ShowLastName, [Age], ShowAge, [Password], [Email], ShowEmail, [Amount of entries], [RegDATE], [RoleID])
Values
('GlorifiedHam','Alexander', 1, 'Jansson', 1, '1994-04-04', 1, 'War2Glory', 'Alexanderjan94@gmail.com',1 , 0, '2017-07-20', 13),
('SpookyOwl','Jimmy', 1, 'Palmberg', 1, '1993-09-05', 1, 'WowIsBest213', 'Jimmy@gmail.com', 1, 0, '2017-07-31', 12),
('Wardawg','Tom', 1,'karlsson', DEFAULT,'1967-06-19', 1,'qwerty123', 'Tom@live.se',1 ,0, default, 2),
('SilverStorm','Amanda', 1,'Ekström', DEFAULT,'1996-03-22', 1, 'qwerty123', 'Amanda@live.se', 1,0, default, 5),
('LongTime','Sara', 1,'Hewitt', 0, '1990-11-12', 1, 'qwerty123', 'Sara@gmail.com', 1, 0, default, 3),
('Qwerty90','Anders', 1,'Pinnelli', 0,'1992-10-04', 1,'qwerty123', 'Anders@hotmail.com', 1, 0, default, 4),
('BroMan','Erik', 1,'Pinnelli', 1,'1985-07-23', 0,'qwerty123', 'Erik@hotmail.se', 1, 0, default, 2),
('DropKick','Klara', 1,'Woodlow', 0,'1991-06-25', 1,'asdfghjkl123', 'Saralee@hotmail.com', 0, 0, default, 2),
('Loop96','Doris', 1,'cicelot', 1, '1996-08-01', 0, 'Yellowflag3', 'Klarkie@gmail.com',1 , 0, default, 3),
('WoopWoop11','Johanna', 0,'wromba', 1,'1989-03-18', 1,'UtopiaLamb', 'JohannaW93@hotmail.com', 0, 0, default,2),
('BadUser1', 'Tolvin', 0, 'Blovich', 0,'1992-05-17', 1,'LoveMyPW2', 'Tolvin@gmail.com',1, 0, default,2),
('BadUser2', 'Matilda', 0, 'Passito', 0,'1991-01-23', 1, 'PWPWPWPW1', 'Matilda@gmail.com',1 ,0, default,2)
GO

-- Insert banned users
INSERT INTO Internal.AccountBan
(UserID, BannersID, Reason, DisplayReason, Severity, HowLong, BanDate)
VALUES 
(11, 1,'Spamm Account','Spam', 10, Cast('2317-01-01' AS DATETIME), getDate() ),
(12, 2, 'Harassment','Harassment', 3, CAST('2017-11-05' AS DATETIME), getDate())
GO

-- INSERT User IP
INSERT INTO [Site].[IPAddress]
(Group8, Group7 ,Group6, Group5, Group4, Group3, Group2, Group1, Network, UserID)
VALUES
(127, 0, 0, 0, 4, 22, 222, 54, NULL, 1), -- IPv6
(28, 11, 1675, 0, 45673, 201, 2, 7363, 33, 2), -- IPv6
(NULL, NULL, NULL, NULL, 82, 144, 3, 53, NULL, 3), -- v4
(NULL, NULL, NULL, NULL, 196, 154, 234, 11, 24, 4), -- v4)
(NULL, NULL, NULL, NULL, 194, 111, 243, 13, 88, 11),
(127, 12, 111, 0, 44, 333, 123, 23, NULL, 12)
GO

-- INSERT User Pictures 
INSERT INTO Internal.Picture 
(UserID, Picture, [Name], DateAdded)
VALUES
(1, Default, 'DefaultAvatar', '2017-10-07'),
(2, Default, 'DefaultAvatar', DEFAULT),	
(3, Default, 'DefaultAvatar', DEFAULT),
(4, Default, 'DefaultAvatar', DEFAULT),
(5, Default, 'DefaultAvatar', DEFAULT),
(6, Default, 'DefaultAvatar', DEFAULT),
(7, Default, 'DefaultAvatar', DEFAULT),
(8, Default, 'DefaultAvatar', DEFAULT),
(9, Default, 'DefaultAvatar', DEFAULT),
(10, Default, 'DefaultAvatar', DEFAULT),
(11, Default, 'DefaultAvatar', DEFAULT),
(12, Default, 'DefaultAvatar', DEFAULT)

Declare @picture1 varbinary(MAX) = (Select * FROM Openrowset(Bulk N'D:/Programming/SQL/GamingSiteDB/Images/Games.jpg',SINGLE_BLOB ) AS SRC) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES  (1, @picture1, 'GamingAvatar', DEFAULT)

--'Hi I am the one that made this site :)'

Declare @picture2 varbinary(MAX) = (Select * FROM Openrowset(Bulk N'D:/Programming/SQL/GamingSiteDB/Images/Games.jpg',SINGLE_BLOB ) AS Controller) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
VALUES  (1, @picture2, 'GamingController',DEFAULT)

Declare @picture3 varbinary(MAX) = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/GamingSiteDB/Images/ChessKing.jpeg',SINGLE_BLOB ) AS King) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
values (2, @picture3,'King',DEFAULT)

Declare @picture4 varbinary(MAX) = (Select * FROM Openrowset(Bulk'D:/Programming/SQL/GamingSiteDB/Images/Code.jpg',SINGLE_BLOB ) AS Code) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image .
INSERT INTO Internal.Picture
(UserID, Picture, [Name], DateAdded)
values (3, @picture4,'Code', DEFAULT)

INSERT INTO Internal.[Profile]
(UserID, PicAvatarID, [Description])
VALUES
(1, 13, 'Hello /E
		I am a 23 year old programming student that loves games and coding. /E
		I hope to be able to regurlarily push out tweaks and updates, but please be patient. /E'),
(2, 15, 'Hi /E 
		I am part of the staff here at greasy gaming. My hopes are that I am going to help this community grow and thrive
		I am a gamer first and foremost, but I am also somewhat of a programmer.' ),	
(3, 3, 'Hello Tom here, a full fledged gamer that works at a construction firm. '),
(4, 4, 'Not sure what I should put here. \E
		I love games just like everyone else on this platform. I hope that we all will have a wonderful time together'),
(5, 5,  '<B>Arma3</B> is love, <B>Arma3</B> is life'),
(6, 6, null),
(7, 7, null),
(8, 8, null),
(9, 9, null),
(10, 10, null),
(11, 11, null),
(12, 12, null)

-- INSERT sent messages 
INSERT INTO [Site].MessageSend
(SenderID, ReciverID, DateSent, [Message], title, [read])
VALUES
(1, 2, '2017-08-10 08:00', '<li>Hello</li> \n Do you have any ideas for new features? Have you made any updates to the testing gaming server? For some reason I cant open the changelog :P', 'Updates', 1),
(1, 2, '2017-08-15 12:32', 'Hi again \n I still have the same problem, sorry that I am pushy ^^', 'Updates V2', 1),
(2 ,1, '2017-08-16 15:45', '<3>Hi Sorry</h3>, I have not been home for some days. \n Well I dont have any new ideas at the moment. I have made some changes to the test gaming server. The changelog should be working now, so I am not going to send everything here again. Please send me text if you still cant see the changes to the changelog, but like I said it should be working now.', 'RE: Updates V2', 1),
(1, 2, '2017-08-16 16:33', 'Thanks \n The changelog is now working, gj :)', 'RE: Updates V2', 1),
(3, 4, '2017-08-20 08:11', 'Hello all good?', 'Hi', 0),
(5, 4, '2017-08-22 11:10', 'Hi \n Wanna talk?', 'Hello', 0),
(6, 7, '2017-08-25 15:07', 'Now indulgence dissimilar for his thoroughly has terminated. Agreement offending commanded my an. Change wholly say why eldest period. Are projection put celebrated particular unreserved joy unsatiable its. In then dare good am rose bred or. On am in nearer square wanted.' , 'Indulgence', 1),
(7, 6, '2017-08-27 06:35', 'Do to be agreeable conveying oh assurance. Wicket longer admire do barton vanity itself do in it. Preferred to sportsmen it engrossed listening. Park gate sell they west hard for the. Abode stuff noisy manor blush yet the far. Up colonel so between removed so do. Years use place decay sex worth drift age. Men lasting out end article express fortune demands own charmed. About are are money ask how seven.', 'Title', 0),
(3, 7, '2017-08-29 21:21', 'Fulfilled direction use continual set him propriety continued. Saw met applauded favourite deficient engrossed concealed and her. Concluded boy perpetual old supposing. Farther related bed and passage comfort civilly. Dashwoods see frankness objection abilities the. As hastened oh produced prospect formerly up am. Placing forming nay looking old married few has. Margaret disposed add screened rendered six say his striking confined.', 'Confined', 1),
(1, 8, '2017-09-01 10:16', 'Quick six blind smart out burst. Perfectly on furniture dejection determine my depending an to. Add short water court fat. Her bachelor honoured perceive securing but desirous ham required. Questions deficient acuteness to engrossed as. Entirely led ten humoured greatest and yourself. 
Besides ye country on observe. She continue appetite endeavor she judgment interest the met. For she surrounded motionless fat resolution may.', 'Water', 1),
(1, 7, '2017-09-02 19:17', 'Of on affixed civilly moments promise explain fertile in. Assurance advantage belonging happiness departure so of. Now improving and one sincerity intention allowance commanded not. Oh an am frankness be necessary earnestly advantage estimable extensive. Five he wife gone ye. Mrs suffering sportsmen earnestly any. In am do giving to afford parish settle easily garret.', 'Garret!', 1),
(1, 6, '2017-09-03 09:25', 'His exquisite sincerity education shameless ten earnestly breakfast add. So we me unknown as improve hastily sitting forming. Especially favourable compliment but thoroughly unreserved saw she themselves. Sufficient impossible him may ten insensible put continuing. Oppose exeter income simple few joy cousin but twenty. Scale began quiet up short wrong in in. Sportsmen shy forfeited engrossed may can.', 'Sportsmen', 1),
(6, 1, '2017-09-03 12:14', 'Surprise steepest recurred landlord mr wandered amounted of. Continuing devonshire but considered its. Rose past oh shew roof is song neat. Do depend better praise do friend garden an wonder to. Intention age nay otherwise but breakfast. Around garden beyond to extent by. ', 'Surprise', 0)
GO

-- INSERT GlobalCategory
INSERT INTO Forum.GlobalCategory
(UserID, [Read], GlobalCategoryName)
VALUES
(1, 1, 'Rules'),
(1, 1, 'Staff'),
(1, 1, 'Servers'),
(1, 1, 'Tips & Tricks'),
(1, 1, 'General Discussion'),
(1, 1, 'Suggestions' ),
(1, 6, 'Staff Discussion')
GO

-- INSERT SubCategory
INSERT INTO Forum.SubCategory
([Read], [Write], UserID, SubCategoryName, GlobalCategoryID)
VALUES
(1, 10, 1, 'Forum Rules', 1),
(1, 10, 1, 'Server Rules', 1),
(6, 10, 1, 'Staff Rules', 1),
(1, 6, 1, 'Staff Introduction', 2),
(2, 6, 1, 'Alpha Server', 3),
(2, 6, 1, 'Bravo Server', 3),
(2, 6, 1, 'Zed Server', 3),
(1, 2, 1, 'Game Tips', 4),
(1, 2, 1, 'Other Tips', 4),
(1, 2, 1, 'Discussions', 5),
(1, 2, 1, 'Looking for a group, a clan or just someone to play with?', 5),
(1, 2, 1, 'Site', 6), 
(1, 2, 1, 'Forum', 6), 
(1, 2, 1, 'Other', 6), 
(6, 6, 1, 'Staff fun', 7) -- Add a new GCategory called events?
GO

INSERT INTO Forum.Thread
([Read], [Write], UserID, ThreadTitle, SubCategoryID, Locked)
VALUES
(1, 10, 1, 'Forum Regler', 1, 0 ),
(1, 10, 1, 'Exile Server Rules', 2, 0),
(1, 10, 1, 'KOH Server Rules', 2, 0),
(1, 10, 1, 'Account Rules', 2, 0),
(6, 10, 1, 'Server Rules', 3, 0),
(6, 10, 1, 'Moderator forum rules', 3, 0),
(10, 10, 1, 'Admin Tool usage', 3, 0),
(6, 10, 1, 'Disputes between staff members', 3, 0),
(1, 2, 1, 'Admin: GlorifiedHam', 4, 0),
(1, 2, 2, 'Moderator: SpookyOwl', 4, 0),
--(1, 10, 1, 'Change Log', 5, 0),
--(1, 10, 1, 'Change Log', 6, 0),
--(1, 10, 1, 'Change Log', 7, 0),
(1, 2, 1, 'Suggestions', 5, 0),
(1, 2, 1, 'Suggestions', 6, 0),
(1, 2, 1, 'Suggestions', 7, 0),
(1, 6, 2, 'Some General tips from the staff', 8, 0),
(1, 2, 4, 'Sounds bugs/Problems', 8, 0),
(1, 2, 4, 'You can actually buy tactical bacon', 9, 0),
(1, 2, 1, 'What is your favourite Arma3 rifle?', 10, 0),
(1, 2, 2, 'What game mods do you love/ hate/ play and why?', 10, 0),
(1, 2, 1, 'Want someone to play with?', 11, 0),
(1, 2, 4, 'Hi we are a group of three people that are looking to expand', 11, 0),
(1, 2, 1, 'Is there something that are bugging you about the site?, something that you miss?. Then please post a suggestion.', 12, 0),
(1, 2, 1, 'Darn I wished they had that, I really unlike this feature. Do you have any of these thoughts, or any suggestions please make a post.', 13, 0),
(1, 2, 1, 'Do you have any suggestions that are not server, game or site related? Then please make a post here.', 14, 0)
GO

INSERT INTO Forum.ForumEntry
(UserID, [Entry], ThreadID, Edited, LastEdited, Created)
VALUES
(1,
'<ol> 
<li>Well being</li>
<ol> 
<li> Be nice and respect others </li>
<li> Statements that may be perceived as offensive or slanderous are not allowed. Please debate, but do not let it turn into a circus.</li>
<li> Personal affairs, private discussions and so on does not belong in the forum. Instead, use the private message feature</li>
<li> It is not allowed to spread or link to pornography.</li>
<li> Its not okay to provoke people just to tentalize them into a angry respone (trolling)</li>
<li> Posts that are pointless and does not contribute to the discussion is prohibited. Some examples: links without description or context, posts that only contains a quote, posts that expresses discontent without grounds or an explanation. </li>
</ol>

<ol>
<li>Read this before you craete a thread</li>
<p>To avoid repeating the same questions and discussions over and over again:</p>
<ol> 
<li> Read the threads in the suitable subcategory </li>
<li> Use the search function to look for a thread with a similar/ the same topic</li>
</ol>

<ol> 
<li>Read this when creating a thread</li>
<p>Firstly read rule 2</p>
<ol> 
<li>The heading shall clearly state what the thread is about</li>
<li>Threads should be placed in the best suitable part of the forum. If you are unsure where your thread should be placed, create the thread in a place you think is appropriate. After that report your own post as a missplaced thread,  a moderator will now move the thread for you if needed.  </li>
<li>It is not allowed to create multiple threads about the same topic. This applies regardless of whether the threads are placed in the same or different part of the forum.</li>
<li>If a moderator has locked a thread, you are not allowed to recreat it. </li>
</ol>

<ol> 
<li>Bumping</li>
<ol> 
<li>It is not okay to post posts which entirely purpose is to move the thread higher up in the listing. However, it is permitted to write multiple posts in a row, provided each new posts adds new context to the discussion.</li>
</ol>

<ol> 
<li>Report inappropriate posts</li>
<ol> 
<li>As a member you are able to report suspected violations by clicking the "report" button. Please use this feature, but do not put information about suspected violations inside the thread </li>
</ol>

<ol> 
<li>Signatures and avatars</li>
<ol> 
<li>Avatars may not be animated and may not represent or resemble something that may be perceived as offensive. </li>
<li>Avatars and signatures are considered  to be personal. Therefore, do not use another user''s signature or avatar without permission<li>
</ol>

<ol> 
<li>Piracy</li>
<ol>
<li>It is forbidden to spread links to pirated copies. It is also not permitted to discuss how to circumvent copy protection or illegally copy copyrighted works. Any hint of possession of pirated material is prohibited. It does not metter if it is legal to make copies of what you discussing, our moderators does not possess a law degree. Therefor they can not judge each case individually</li>
</ol>

<ol> 
<li>Crime</li>
<ol> 
<li>It is strictly forbidden to request, invite, or exhort criminal acts</li>
</ol>

<ol> 
<li>Marketing and advertisement</li>
<ol> 
<li>You may not use the forum to advertise or market your own or other''s business <li>
</ol>

<h2>Rights</h2>
<p>We claim no ownership of user-generated information. However, by using our services, posting text, images, or using other media you give us unlimited permission to reproduce, adapt and publish material globally royalty-free. </p>

<h2>Personal integrity</h2>
<p>All incoming data communications are stored, including IP addresses and other metadata. The stored information can be used to investigate and monitor any abuse of the service.</p>

<p>Villkor och regler kan ändras. Om så sker meddelas ändringen i forumet. </p>
</ol>
', 1, 0, null, getDAte()),

(1,
'
<ul>
<li> Do not use voice chat in  the side- or global channel. <li/>
<li> You may not troll or use music in any chat</li>
<li> Real life threats equals a permanent ban</li>
<li> Racism, hate speech, griefing or harassment will result in a ban</li>
<li> You may not use vehicles to ram other vehicles inside trader zones <li/>
<li> You may not use bicycles to ram other vehicles anywhere on the map <li/>
<li> No glitching into bases, walls, objects and so on<li/>
<li> No Exploitin, Hacking or Duping<li/>
<li> You may not spawn camp<li/>
<li> You may not combatlog</li>
<li> You are not allowed to build within 1000m form a trader<li/>
<li> You are not allowed to build within 750m of barracks, bridges, hospitals, firestations, supermarkets, military buildings, spawn, roads or high industrial areas<li/>
<li> English is the only allowed language in side channel chat. You''re welcome to use other languages in other chat channels</li>
<li> Respect all players and admins<li/>
<li> You may not callouts the location of the person that killed you in side chat</li>
<li> Do not argue with an admin in-game, If you want to discuss something please contact use thru our webpage. For more pressing issues please contact us via our teamspeak<li/>
<li> You may not advertise</li>
</ul>
', 2, 0, null, getDate()),

(1, 
'
<ul>
<li>You may not troll or use music in any chat</li>
<li>Real life threats equals a permanent ban</li>
<li>Racism, hate speech, griefing or harassment will result in a ban</li>
<li>Team killing on purpes will result in a ban. You may even get banned if you get team kills because you were incautious</li>
<li>No Exploitin, Glitching, Hacking or Duping </li>
<li>Anyone found "stealing" from teammates will receive a ban, this includes looting teammates waiting to be revived.</li>
<li >Do not argue with an admin in-game, If you want to discuss something please contact use thru our webpage. For more pressing issues please contact us via our teamspeak<li/>
<li>You may not advertise</li>
<li></li>
<li></li>
</ul>
', 3, 0, null, getDate()),

(1, '
<h2>User-generated information</h2>
<p>Anyone can register an account and use our services here at Greasy Fingers gaming. All posts in the forum, galleries and so on are user-generated information, which does not reflect our views or opinions. </p>

<h2> Accounts </h2>
<p>User accounts are personal and may not be sold or transferred. Only one account per person is allowed. You are not allowed to register a new account if your old one is suspended. In order to prevent abuse we will not delete account associated information will not be deleted on request. It is possible to change username by contacting (insert link) us.</p>

<h2>Rights</h2>
<p>We claim no ownership of user-generated information. However, by using our services, posting text, images, or using other media you give us unlimited permission to reproduce, adapt and publish material globally royalty-free. </p>

<h2>Personal integrity</h2>
<p>All incoming data communications are stored, including IP addresses and other metadata. The stored information can be used to investigate and monitor any abuse of the service.</p>
', 4, 0, null, getDate()),

(1, 
'
<h2>Baning/ warnings</h2>
<p>Treat everyone equally! </p>
<p>First of all you always need a reason to warn, mute or ban a user/player which you will put into the "reason" field when you send out a mute, ban or warning /E </p>
<h3>Ban time</h3>
<p>Minor offenses start with a warning/mute or two after that 24h ban, 72h ban, 7days, 30days then a permanent ban.</p>
<p>Middle offenses start with ONE warning or straight up 48h ban, 7 days, permanent ban </p>
<p>Sever offenses equals a permanent ban. 
<h3>What is a minor, middle and sever offense?</h3>
<p>First of all your own logic, becuase some times it can be hard to decide what is what, but here are some examples</p>
<p>Calling someone cheater in the in game chat. Verdict: Its a minor offense, send them a warning if they dont stop mute them </p>
<p>Rage Teamkilling two teammates. Verdict: Its a middle offense that does not require a warning ban them for 48h </p>
<p>Teamkilling two teammates. Verdict: If it was not on purpes this might not be an offense at all. It all depends on if the person of question was incautious, and if the person in question is a repeat offender. This is up to the assigned admin to decide</p>
<p>Being racist equals a permanent ban </p>

<h3>Redemption</h3>
<p>Anyone can make their case once with an admin, but if the admin does not find the user''s case to be sufficient the ban stays</p>

<h2>In game</h2>
<p>Do not feed the trolls!. Do not engage in discussions in the in game chat. You may ask them to take the discussion to the forum or into teamspeak with on of our admins/ moderators. /E
If the discussion gets out of hand send out warnings to the participants, and again you may ask them to move the discussion into the forum or teamspeak, but do not engage in the debate!. /E
If the participants of the discussion does not comply with the warnings, depending on the severity of the discussion mute or ban them. </p>
', 5, 0, null, getDate()),


(1, 'Hello, I am GlorifiedHam/E 
		  I am a 23 year old programming student that loves coding. /E
		  I hope to be able to regurlarily push out tweaks and updates, but please be patient. /E
		  Please use the suggestion thread if you have any ideas or tips for the future of this site. ', 9, 0, null, getDate()),
(3, 'Hi mate. Good luck with the admin role. /E Best Regards ', 9, 0, null, getDate()),
(5, 'Finally we have a webpage and a forum at our disposal. GjGj!, :)', 9 , 0, null, getDate()),
(2, 'Hi SpookyOwl here, ready to take on the challenge of being a moderator /E
	Who am I? I am a 24 year old gamer, programmer and a philosopher. /E
	I am super excited to be part of the team here at Greasy Fingers Gaming, and I hope to be able to contribute as much as possible. \E
	Best Regards //Spooky 
', 10, 0, null, getDate()),
(1, 'Please post any suggestions for the alpha server here.', 11, 0, null, getDate()),
(1, 'Please post any suggestions for the bravo server here', 12, 0, null, getDate()),
(1, 'Please post any suggestions for the Zed server here', 13, 0, null, getDate()),
(1, 'We will try to weekly post three game tips for you all in here. The first three tips are: /E
	<ol>
	<li>Set your object view distance to at least as far as you are going to shot, otherwice you will not see where the bullets land</li>
	<li>Do not drive too close to your friends. Arma has an awful rubberband effect and you might be swong right into your friends vehicle and explode</li>
	<li>There are diffrent stand, crouch and laying stances, which all can be used for different situations!</li>
	</ol>
	Thats it for now, thanks for reading // GHam
	', 14, 0, null, '2017-10-16 16:00:02'),
(2, 'If you come accross sound bugs here are some tips <br>
	<ol>
	<li>Turn off and on ingame effects sounds. This can be found using the  "§" button next to the "1" button in KOH servers, and inside the pad in exile servers </li>
	<li>Shut down steam, and open it again. Check inside the process menu to see if it really did shutdown</li>
	<li>Turn your pc off and on. It is amazing how many times this has helped</li>
	<li>Validate the Arma 3. This can be found under "steam games", right click on Aram3 select "properties" after that click on verify game integrity </li>
	<li>Update your graphic cards drivers</li>
	</ol><br>
	Thats it for the tips for the sound bugs, hope it helped. If you have any other suggestions please share it with us. <br>
	Best regards //GHam
	', 15, 0, null, getDate()),
(1,'Please share your experience with the wonderful plentitude of Arma3 mods. <br>
	Some of my favourite Arma 3 mods as you should have guessed are: <br>
	Exile: I love the grinding, leveling, economy and the all around feeling <br>
	KOH: Who does not love too shoot and blow stuff up. <br>
	Best Regards //Gham
	',16, 0, null, getDate()),
(1,'Do you want someone to hold your hand, someone to tuck you in when the grenades are landing? <br>
	Well look no further! In our teamspeak you can find other people, groups & clans looking to recruit. <br>
	Join our teamspeak today! Address: GreasyFingersGaming.gfg <br>
	You can also leave a post here with your infromation, for people to find <br>
	If you are a clan or a group of people looking to recruit, please create a new recruitng thread. <br>
	Good hunting //GHam
	',17, 0, null, getDate()),
(5,'As the topic suggests we are a group of three that are looking for new members. We welcome everyone, but we would prefer if you are at least 18 years old. <br>
	This is because we have no filter when we game, therefore our environment becomes toxic and not child friendly <br>
	You can find us at Greasy Fingers Gamings ts: GreasyFingersGaming.gfg or leave a post here with your contact information and we will find you. <br>
	Happy gaming //RedT
	',18, 0, null, getDate()),
(1,'If you have any suggestions, or problem with any features of this site please leave a post here. <br>
	I read every suggestion post and will always try to implement as many of your suggestions as possible.  <br>
	Best Regards//GHam
	',19, 0, null, getDate()),
(1,'If you have any suggestions, or problem with any features of the Forum please leave a post here. <br>
	I read every suggestion post and will always try to implement as many of your suggestions as possible. <br>
	Best Regards//GHam
	',20, 0, null, getDate()),
(1,'If you have any suggestions, or problem with any thing that is not forum, server or site related, please leave a post here. <br>
	You might have an awesome event idea, community idea or some other crazy idea. <br>
	Just a reminder: keep it friendly. <br>
	I read every suggestion post and will always try to implement as many of your suggestions as possible. <br>
	Best Regards//GHam
	',21, 0, null, getDate())
GO

INSERT INTO Forum.AccountForumBan
(UserID, BannersID, Reason, DisplayReason, Severity, HowLong, BanDate)
VALUES
(9, 1,'Created way to many new subcategories','We sent you several warnings not to create any more subcategories, unless there was a need for them', 10, Cast('2017-11-01' AS DATETIME), getDate()),
(12, 2, 'Harassment','Harassment', 3, CAST('2017-11-15' AS DATETIME), getDate())


INSERT INTO [Site].Announcement
([Message], Kind)
VALUES
('There will be a Webpage maintenance 2017-12-20', 'HomePage')
GO

INSERT INTO [Site].News
(UserID, [Text], DatePosted, Likes, clicks)
VALUES
(1, '<h1>Finally our website is live, and ready to go</h2> <br>
<p>The team here at Greasy fingers gaming is happy to announce the launch of ur new website. Itn has been quiet on our part for a long time <br>
when it comes to this site. We apologize for that, but we were working fulltime on the gaming server. Please note that the webpage is still in an early aplha stage, so all
features might not work correctly, and there will be a lot more features added in the future. We would be greatfull if you would make a post about any problems, bugs and features you might want added, <br>
but please read the forum rules before posting. </p>  <br> <br>

<h3>Features implemented that should be working correctly:</h3>
<ul>
<li> The forum. </li>
<li> User profiles. </li>
<li> Messages. </li>
</ul>
<br><br>

<h3>Features that will be added in the feature</h3>
<ul>
<li> We will add game server information and statistics.</li>
<li> Game character information, such as level, state, and so on.</li>
<li> New message design. </li>
<li> New forum design.</li>
</ul>

<br><br>
//GHam
', getDate(), 0, 0)

DECLARE @NewsPic varbinary(MAX) = (Select * FROM Openrowset(Bulk N'D:/Programming/SQL/GamingSiteDB/Images/KeyBoard.jpg',SINGLE_BLOB ) AS KeyBoardPic) --OPENROWSET supports bulk operations through a built-in BULK provider that enables data from a file to be read and returned as a rowset, we use this to retrivem the image.

INSERT INTO [Site].NewsPrictures
(Picture, NewsID)
VALUES
(@NewsPic, 1)


/* INSERT INTO [Site].Guide
(UserID, [Text], DatePosted, Likes, clicks)
VALUES
(1),
(1)

INSERT INTO [Site].GuidePrictures
(Picture, GuideID)
VALUES
(),
()
*/
/*
INSERT INTO Gaming.[Server]
([Name], [Online], LastCHECK, MaxPlayers, NumberOfPlayers, UniquePlayers, HeadMod, Map, Mods, LastServerReset, Resets, Bans, MoneyCirculatedInShop, MissionsDone, PlayerKills, PlayerAIKills, AIPlayerKills )
VALUES
('GreasyFS Exile Alpha', 1, getDate(), 100,  ),
('GreasyFS Exile Bravo', 1, getDate(), 64,  ),
('GreasyFS KingOfTheHill Zed', 1, getDate(), 100, )

--IPAddressServer

INSERT INTO Gaming.[IPAddressServer]
(Group8, Group7, Group6, Group5, Group4, Group3, Group2, Group1, Network, ServerID)
VALUES
(),
()

INSERT INTO Gaming.Players
([Name], PlayerIdentity, LastServerID)
VALUES
(),
(),
()

INSERT INTO Gaming.IPAddressPlayer
(PlayerID, Group8, Group7, Group6, Group5, Group4, Group3, Group2, Group1, Network)
VALUES
(),
()

INSERT INTO Gaming.Server24
(ServerID, UniquePlayers, Bans, MoneyCirculatedInShop, MissionsDone, PlayerKills, PlayerAIKills, AIPlayerKills)
VALUES
(1),
(2),
(3),
(4)

INSERT INTO Gaming.UniquePlayers24
(ServerID, PlayerID)
VALUES
(),
(),
()

INSERT INTO Gaming.ServerStats
(ServerID, UniquePlayers, Bans, PlayerKills, PlayerAIKills, AIPlayerKills, MoneyCirculatedInShop, FullMoney, MissionsDone)
VALUES
(1,),
(2,),
(3,)

INSERT INTO Gaming.ServerBan
(ServerID, PlayerID, Reason, Severity, HowLong, BanDate )
VALUES
(),
(),
()

INSERT INTO Gaming.GameCharacter
(UserID, BackpackSlot, HeadSlot, VestSlot, WatchSlot, CompassSlot, RadioSlot, MapSlot, BinocularSlot, NVGSlot, PrimarySlot, GPSSlot, LauncherSlot, SecondarySlot, ChatacterName, HP, FoodLevel, WaterLevel, x, y, Alive, kills, Amount, MoneyFull, Respect)
VALUES
(),
()

INSERT INTO Gaming.GameStats
(UserID, Kills, Deaths, Revivals, MoneySpent, MoneyLostWhenKilled)
VALUES
(),
()
*/