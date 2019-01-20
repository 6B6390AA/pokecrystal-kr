	const_def 2 ; object constants
	const ROUTE35_YOUNGSTER1
	const ROUTE35_YOUNGSTER2
	const ROUTE35_LASS1
	const ROUTE35_LASS2
	const ROUTE35_YOUNGSTER3
	const ROUTE35_FISHER
	const ROUTE35_BUG_CATCHER
	const ROUTE35_SUPER_NERD
	const ROUTE35_OFFICER
	const ROUTE35_FRUIT_TREE
	const ROUTE35_POKE_BALL

Route35_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

TrainerBirdKeeperBryan:
	trainer BIRD_KEEPER, BRYAN, EVENT_BEAT_BIRD_KEEPER_BRYAN, BirdKeeperBryanSeenText, BirdKeeperBryanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperBryanAfterBattleText
	waitbutton
	closetext
	end

TrainerJugglerIrwin:
	trainer JUGGLER, IRWIN1, EVENT_BEAT_JUGGLER_IRWIN, JugglerIrwin1SeenText, JugglerIrwin1BeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_JUGGLER_IRWIN
	endifjustbattled
	opentext
	checkcellnum PHONE_JUGGLER_IRWIN
	iftrue Route35NumberAcceptedM
	checkevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext JugglerIrwinAfterBattleText
	buttonsound
	setevent EVENT_IRWIN_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	jump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_JUGGLER_IRWIN
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	trainertotext JUGGLER, IRWIN1, MEM_BUFFER_0
	scall Route35RegisteredNumberM
	jump Route35NumberAcceptedM

Route35AskNumber1M:
	jumpstd asknumber1m
	end

Route35AskNumber2M:
	jumpstd asknumber2m
	end

Route35RegisteredNumberM:
	jumpstd registerednumberm
	end

Route35NumberAcceptedM:
	jumpstd numberacceptedm
	end

Route35NumberDeclinedM:
	jumpstd numberdeclinedm
	end

Route35PhoneFullM:
	jumpstd phonefullm
	end

Route35RematchM:
	jumpstd rematchm
	end

TrainerCamperIvan:
	trainer CAMPER, IVAN, EVENT_BEAT_CAMPER_IVAN, CamperIvanSeenText, CamperIvanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperIvanAfterBattleText
	waitbutton
	closetext
	end

TrainerCamperElliot:
	trainer CAMPER, ELLIOT, EVENT_BEAT_CAMPER_ELLIOT, CamperElliotSeenText, CamperElliotBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperElliotAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerBrooke:
	trainer PICNICKER, BROOKE, EVENT_BEAT_PICNICKER_BROOKE, PicnickerBrookeSeenText, PicnickerBrookeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerBrookeAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerKim:
	trainer PICNICKER, KIM, EVENT_BEAT_PICNICKER_KIM, PicnickerKimSeenText, PicnickerKimBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerKimAfterBattleText
	waitbutton
	closetext
	end

TrainerBugCatcherArnie:
	trainer BUG_CATCHER, ARNIE1, EVENT_BEAT_BUG_CATCHER_ARNIE, BugCatcherArnieSeenText, BugCatcherArnieBeatenText, 0, .Script

.Script:
	writecode VAR_CALLERID, PHONE_BUG_CATCHER_ARNIE
	endifjustbattled
	opentext
	checkflag ENGINE_ARNIE
	iftrue .WantsBattle
	checkflag ENGINE_YANMA_SWARM
	iftrue .YanmaSwarming
	checkcellnum PHONE_BUG_CATCHER_ARNIE
	iftrue Route35NumberAcceptedM
	checkevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext BugCatcherArnieAfterBattleText
	buttonsound
	setevent EVENT_ARNIE_ASKED_FOR_PHONE_NUMBER
	scall Route35AskNumber1M
	jump .AskForNumber

.AskedAlready:
	scall Route35AskNumber2M
.AskForNumber:
	askforphonenumber PHONE_BUG_CATCHER_ARNIE
	ifequal PHONE_CONTACTS_FULL, Route35PhoneFullM
	ifequal PHONE_CONTACT_REFUSED, Route35NumberDeclinedM
	trainertotext BUG_CATCHER, ARNIE1, MEM_BUFFER_0
	scall Route35RegisteredNumberM
	jump Route35NumberAcceptedM

.WantsBattle:
	scall Route35RematchM
	winlosstext BugCatcherArnieBeatenText, 0
	copybytetovar wArnieFightCount
	ifequal 4, .Fight4
	ifequal 3, .Fight3
	ifequal 2, .Fight2
	ifequal 1, .Fight1
	ifequal 0, .LoadFight0
.Fight4:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
.Fight3:
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
.Fight2:
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer BUG_CATCHER, ARNIE1
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 1
	clearflag ENGINE_ARNIE
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, ARNIE2
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 2
	clearflag ENGINE_ARNIE
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, ARNIE3
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 3
	clearflag ENGINE_ARNIE
	end

.LoadFight3:
	loadtrainer BUG_CATCHER, ARNIE4
	startbattle
	reloadmapafterbattle
	loadvar wArnieFightCount, 4
	clearflag ENGINE_ARNIE
	end

.LoadFight4:
	loadtrainer BUG_CATCHER, ARNIE5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ARNIE
	end

.YanmaSwarming:
	writetext BugCatcherArnieYanmaText
	waitbutton
	closetext
	end

TrainerFirebreatherWalt:
	trainer FIREBREATHER, WALT, EVENT_BEAT_FIREBREATHER_WALT, FirebreatherWaltSeenText, FirebreatherWaltBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherWaltAfterBattleText
	waitbutton
	closetext
	end

TrainerOfficerDirk:
	faceplayer
	opentext
	checktime NITE
	iffalse .NotNight
	checkevent EVENT_BEAT_OFFICER_DIRK
	iftrue .AfterBattle
	playmusic MUSIC_OFFICER_ENCOUNTER
	writetext OfficerDirkSeenText
	waitbutton
	closetext
	winlosstext OfficerDirkBeatenText, 0
	loadtrainer OFFICER, DIRK
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_OFFICER_DIRK
	closetext
	end

.AfterBattle:
	writetext OfficerDirkAfterBattleText
	waitbutton
	closetext
	end

.NotNight:
	writetext OfficerDirkPrettyToughText
	waitbutton
	closetext
	end

Route35Sign:
	jumptext Route35SignText

Route35TMRollout:
	itemball TM_ROLLOUT

Route35FruitTree:
	fruittree FRUITTREE_ROUTE_35

CamperIvanSeenText:
	text "라디오에서 여러 포켓몬의"
	line "정보를 수집하고 있으니까"
	cont "꽤 강할 것이라고 생각해"
	done

CamperIvanBeatenText:
	text "틀려먹었다!"
	done

CamperIvanAfterBattleText:
	text "라디오 방송의 음악을 듣고"
	line "야생 포켓몬이 건강해지거나"
	cont "얌전해지기도 한단다!"
	done

CamperElliotSeenText:
	text "좋-아! 여자친구에게"
	line "좋은 것을 구경이나 시켜줄까!"
	done

CamperElliotBeatenText:
	text "너……"
	line "좀 져줘……"
	done

CamperElliotAfterBattleText:
	text "여자친구에게 창피한 것을"
	line "보여줘버렸당……"
	done

PicnickerBrookeSeenText:
	text "내 남자친구 너무 약해서"
	line "의지 할 수 없구만……"
	done
	

PicnickerBrookeBeatenText:
	text "아 강하구나!"
	done
	
PicnickerBrookeAfterBattleText:
	text "남자친구보다 포켓몬쪽이"
	line "믿음직 스러운 것도 문제구나"
	done

PicnickerKimSeenText:
	text "너 포켓몬 체육관에 가고있니?"
	line "나도 그렇걸랑"
	done

PicnickerKimBeatenText:
	text "우-웅 이길 수 없구나"
	done

PicnickerKimAfterBattleText:
	text "체육관에서 받은 배지"
	line "너무 예쁘기 때문에 모으고 있어"
	done

BirdKeeperBryanSeenText:
	text "너 포켓몬을 잡을 때"
	line "어떤 볼을 사용하고 있니?"
	done
	
BirdKeeperBryanBeatenText:
	text "히야"
	line "스피드가 부족하구만"
	done

BirdKeeperBryanAfterBattleText:
	text "바로 도망치는 포켓몬이 있지?"
	line "그럴 때 도움이 되는 것은"
	cont "강집 할아버지의 스피드볼!"
	
	para "나 하얀 규토리를 발견하면은"
	line "강집 할아버지의 집에 가지고 가서"
	cont "특수한 볼을 만들어 달라고 할꺼야"
	done

JugglerIrwin1SeenText:
	text "보아라!"
	line "이 화려한 볼의 심판을!"
	done

JugglerIrwin1BeatenText:
	text "히익- 꼼짝도 못하겠다"
	done

JugglerIrwinAfterBattleText:
	text "내가 자랑하는 포켓몬으로"
	line "꼼짝못하게 만들려고 생각했는데"
	cont "너의 강함에 내가 꼼짝도 못하겠어"
	done

BugCatcherArnieSeenText:
	text "벌레포켓몬이 있다면"
	line "어떤 곳이든 찾아간다"
	done

BugCatcherArnieBeatenText:;TRANSLATED
	text"얼레-?"
	line"질 리가　없는데　말이야-"
	done

BugCatcherArnieAfterBattleText:
	text "내 소중한 콘팡은"
	line "공원의 곤충채집 대회에서"
	cont "우승했을 때의 포켓몬이란다"
	done

BugCatcherArnieYanmaText:;TRANSLATED
	text"대단해…　이렇게나 잔뜩"
	line"왕자리가 있다니!"

	para"감동해서　움직일 수가　없어!"
	done

FirebreatherWaltSeenText:
	text "이런 곳에서"
	line "불을 뿜는 연습을!"
	done

FirebreatherWaltBeatenText:
	text "아뜨뜨뜨"
	line "코끝이 타버렸다"
	done

FirebreatherWaltAfterBattleText:
	text "라디오로 포켓몬마치를 듣고 있으면"
	line "평상시보다 더 포켓몬이 튀어나온다"
	done

OfficerDirkSeenText:
	text "밤에는 위험이 가득하다!"
	done

OfficerDirkBeatenText:
	text "허허 이런이런"
	done

OfficerDirkAfterBattleText:
	text "밤은 밤이라서 즐거운 것이지"
	line "그럼 그다지 무리는 하지 말거라"
	done
	
OfficerDirkPrettyToughText:
	text "강해보이는 포켓몬이군"
	line "그렇다면 어디에 있던 안심이다"
	done

Route35SignText:
	text "이곳은 35번 도로"
	done

Route35_MapEvents:
	db 0, 0 ; filler

	db 3 ; warp events
	warp_event  9, 33, ROUTE_35_GOLDENROD_GATE, 1
	warp_event 10, 33, ROUTE_35_GOLDENROD_GATE, 2
	warp_event  3,  5, ROUTE_35_NATIONAL_PARK_GATE, 3

	db 0 ; coord events

	db 2 ; bg events
	bg_event  1,  7, BGEVENT_READ, Route35Sign
	bg_event 11, 31, BGEVENT_READ, Route35Sign

	db 11 ; object events
	object_event  4, 19, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperIvan, -1
	object_event  8, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperElliot, -1
	object_event  7, 20, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPicnickerBrooke, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerKim, -1
	object_event 14, 28, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerBirdKeeperBryan, -1
	object_event  2, 10, SPRITE_FISHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherWalt, -1
	object_event 16,  7, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherArnie, -1
	object_event  5, 10, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerJugglerIrwin, -1
	object_event  5,  6, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TrainerOfficerDirk, -1
	object_event  2, 25, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route35FruitTree, -1
	object_event 13, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route35TMRollout, EVENT_ROUTE_35_TM_ROLLOUT
