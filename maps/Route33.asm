	const_def 2 ; object constants
	const ROUTE33_POKEFAN_M
	const ROUTE33_LASS
	const ROUTE33_FRUIT_TREE

Route33_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

Route33LassScript:
	jumptextfaceplayer Route33LassText

TrainerHikerAnthony:
	trainer HIKER, ANTHONY2, EVENT_BEAT_HIKER_ANTHONY, HikerAnthony2SeenText, HikerAnthony2BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_HIKER_ANTHONY
	endifjustbattled
	opentext
	checkflag ENGINE_ANTHONY
	iftrue .Rematch
	checkflag ENGINE_DUNSPARCE_SWARM
	iftrue .Swarm
	checkcellnum PHONE_HIKER_ANTHONY
	iftrue .NumberAccepted
	checkevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext HikerAnthony2AfterText
	buttonsound
	setevent EVENT_ANTHONY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForPhoneNumber

.AskAgain:
	scall .AskNumber2
.AskForPhoneNumber:
	askforphonenumber PHONE_HIKER_ANTHONY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, HIKER, ANTHONY2
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext HikerAnthony2BeatenText, 0
	readmem wAnthonyFightCount
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
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
.Fight1:
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
.LoadFight0:
	loadtrainer HIKER, ANTHONY2
	startbattle
	reloadmapafterbattle
	loadmem wAnthonyFightCount, 1
	clearflag ENGINE_ANTHONY
	end

.LoadFight1:
	loadtrainer HIKER, ANTHONY1
	startbattle
	reloadmapafterbattle
	loadmem wAnthonyFightCount, 2
	clearflag ENGINE_ANTHONY
	end

.LoadFight2:
	loadtrainer HIKER, ANTHONY3
	startbattle
	reloadmapafterbattle
	loadmem wAnthonyFightCount, 3
	clearflag ENGINE_ANTHONY
	end

.LoadFight3:
	loadtrainer HIKER, ANTHONY4
	startbattle
	reloadmapafterbattle
	loadmem wAnthonyFightCount, 4
	clearflag ENGINE_ANTHONY
	end

.LoadFight4:
	loadtrainer HIKER, ANTHONY5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_ANTHONY
	end

.Swarm:
	writetext HikerAnthonyDunsparceText
	waitbutton
	closetext
	end

.AskNumber1:
	jumpstd asknumber1m
	end

.AskNumber2:
	jumpstd asknumber2m
	end

.RegisteredNumber:
	jumpstd registerednumberm
	end

.NumberAccepted:
	jumpstd numberacceptedm
	end

.NumberDeclined:
	jumpstd numberdeclinedm
	end

.PhoneFull:
	jumpstd phonefullm
	end

.RematchStd:
	jumpstd rematchm
	end

Route33Sign:
	jumptext Route33SignText

Route33FruitTree:
	fruittree FRUITTREE_ROUTE_33

HikerAnthony2SeenText:
	text "동굴을 지금 막 벗어났지만"
	line "아직 힘이 남아돌아!"
	done

HikerAnthony2BeatenText:
	text "오옷!"
	line "꼬마쪽이 힘이 넘치는군!"
	done

HikerAnthony2AfterText:
	text "등산가는 산에 있으면"
	line "힘이 100배 된다는 것이다!"
	done
	
HikerAnthonyDunsparceText:;TRANSLATED
	text"노고치를 잡아본 적이 있는가"

	para"나도 하나 잡긴 했네만"
	line"밝은 곳을 보고 있으면"
	cont"재미있는 얼굴을 하고 있지!"
	done

Route33LassText:;TRANSLATED
	text"하아 하아…"
	line"드디어 동굴에서 빠져나왔네"

	para"생각한 것보다 안쪽이"
	line"훨씬 넓어서"
	cont"전부 돌아보니 못하고"
	cont"힘들어서 나와버렸어"
	done
	
Route33SignText:
	text "이곳은 33번 도로"
	done

Route33_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event 11,  9, UNION_CAVE_1F, 3

	db 0 ; coord events

	db 1 ; bg events
	bg_event 11, 11, BGEVENT_READ, Route33Sign

	db 3 ; object events
	object_event  6, 13, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerAnthony, -1
	object_event 13, 16, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route33LassScript, -1
	object_event 14, 16, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route33FruitTree, -1
