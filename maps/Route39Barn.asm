	const_def 2 ; object constants
	const ROUTE39BARN_TWIN1
	const ROUTE39BARN_TWIN2
	const ROUTE39BARN_MOOMOO

Route39Barn_MapScripts:
	db 0 ; scene scripts

	db 0 ; callbacks

Route39BarnTwin1Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route39BarnTwinMoomooIsSickText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN1, RIGHT
	end

.FeedingMooMoo:
	writetext Route39BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN1, RIGHT
	end

Route39BarnTwin2Script:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .FeedingMooMoo
	writetext Route39BarnTwinMoomooIsSickText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN2, LEFT
	end

.FeedingMooMoo:
	writetext Route39BarnTwinWereFeedingMoomooText
	waitbutton
	closetext
	turnobject ROUTE39BARN_TWIN2, LEFT
	end

MoomooScript:
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue .HappyCow
	writetext MoomooWeakMooText
	setval MILTANK
	special PlaySlowCry
	buttonsound
	writetext Route39BarnItsCryIsWeakText
	checkevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	iftrue .GiveBerry
	waitbutton
	closetext
	end

.GiveBerry:
	buttonsound
	writetext Route39BarnAskGiveBerryText
	yesorno
	iffalse .Refused
	checkitem BERRY
	iffalse .NoBerriesInBag
	takeitem BERRY
	readmem wMooMooBerries
	addval 1
	writemem wMooMooBerries
	ifequal 3, .ThreeBerries
	ifequal 5, .FiveBerries
	ifequal 7, .SevenBerries
	writetext Route39BarnGaveBerryText
	waitbutton
	closetext
	end

.ThreeBerries:
	writetext Route39BarnGaveBerryText
	buttonsound
	writetext Route39BarnLittleHealthierText
	waitbutton
	closetext
	end

.FiveBerries:
	writetext Route39BarnGaveBerryText
	buttonsound
	writetext Route39BarnQuiteHealthyText
	waitbutton
	closetext
	end

.SevenBerries:
	playmusic MUSIC_HEAL
	writetext Route39BarnGaveBerryText
	pause 60
	buttonsound
	special RestartMapMusic
	writetext Route39BarnTotallyHealthyText
	waitbutton
	closetext
	setevent EVENT_HEALED_MOOMOO
	end

.NoBerriesInBag:
	writetext Route39BarnNoBerriesText
	waitbutton
	closetext
	end

.Refused:
	writetext Route39BarnRefusedBerryText
	waitbutton
	closetext
	end

.HappyCow:
	writetext MoomooHappyMooText
	cry MILTANK
	waitbutton
	closetext
	end

Route39BarnTwinMoomooIsSickText:
	text "튼튼이가 힘이 없어……"
	line "나무열매를 많이 먹이지 않으면……"
	done

Route39BarnTwinWereFeedingMoomooText:
	text "튼튼이에게 먹이를 주고있어!"
	done

MoomooWeakMooText:
	text "밀탱크『…… 밀탱"
	done

Route39BarnItsCryIsWeakText:
	text "울음소리에 힘이 없어……"
	done

MoomooHappyMooText:
	text "밀탱크『밀 탱-!"
	done

Route39BarnAskGiveBerryText:
	text "밀탱크에게 나무열매를 주겠습니까?"
	done

Route39BarnGaveBerryText:
	text "<PLAYER>는(은)"
	line "나무열매를 먹였다!"
	done

Route39BarnLittleHealthierText:
	text "밀탱크는"
	line "약간 건강을 되찾았다!"
	done

Route39BarnQuiteHealthyText:
	text "밀탱크는"
	line "거의 건강을 되찾았다!"
	done

Route39BarnTotallyHealthyText:
	text "밀탱크는"
	line "매우 건강해졌다!"
	done

Route39BarnNoBerriesText:
	text "<PLAYER>는(은)"
	line "나무열매를 가지고있지 않다"
	done

Route39BarnRefusedBerryText:
	text "<PLAYER>는(은) 나무열매를"
	line "주지않았기에 밀탱크는"
	cont "슬픈 눈빛을 하고있다……"
	done

Route39Barn_MapEvents:
	db 0, 0 ; filler

	db 2 ; warp events
	warp_event  3,  7, ROUTE_39, 1
	warp_event  4,  7, ROUTE_39, 1

	db 0 ; coord events

	db 0 ; bg events

	db 3 ; object events
	object_event  2,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin1Script, -1
	object_event  4,  3, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route39BarnTwin2Script, -1
	object_event  3,  3, SPRITE_TAUROS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MoomooScript, -1
