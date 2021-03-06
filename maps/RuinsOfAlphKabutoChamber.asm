	const_def 2 ; object constants
	const RUINSOFALPHKABUTOCHAMBER_RECEPTIONIST
	const RUINSOFALPHKABUTOCHAMBER_SCIENTIST

RuinsOfAlphKabutoChamber_MapScripts:
	db 2 ; scene scripts
	scene_script .CheckWall ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, .HiddenDoors

.CheckWall:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue .OpenWall
	end

.OpenWall:
	prioritysjump .WallOpenScript
	end

.DummyScene:
	end

.HiddenDoors:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue .WallOpen
	changeblock 4, 0, $2e ; closed wall
.WallOpen:
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse .FloorClosed
	return

.FloorClosed:
	changeblock 2, 2, $01 ; left floor
	changeblock 4, 2, $02 ; right floor
	return

.WallOpenScript:
	pause 30
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 20
	pause 30
	playsound SFX_STRENGTH
	changeblock 4, 0, $30 ; open wall
	reloadmappart
	earthquake 50
	setscene SCENE_FINISHED
	closetext
	end

RuinsOfAlphKabutoChamberReceptionistScript:
	jumptextfaceplayer RuinsOfAlphKabutoChamberReceptionistText

RuinsOfAlphKabutoChamberPuzzle:
	refreshscreen
	setval UNOWNPUZZLE_KABUTO
	special UnownPuzzle
	closetext
	iftrue .PuzzleComplete
	end

.PuzzleComplete:
	setevent EVENT_RUINS_OF_ALPH_INNER_CHAMBER_TOURISTS
	setevent EVENT_SOLVED_KABUTO_PUZZLE
	setflag ENGINE_UNLOCKED_UNOWNS_A_TO_K
	setevent EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
	setmapscene RUINS_OF_ALPH_INNER_CHAMBER, SCENE_RUINSOFALPHINNERCHAMBER_STRANGE_PRESENCE
	earthquake 30
	showemote EMOTE_SHOCK, PLAYER, 15
	changeblock 2, 2, $18 ; left hole
	changeblock 4, 2, $19 ; right hole
	reloadmappart
	playsound SFX_STRENGTH
	earthquake 80
	applymovement PLAYER, RuinsOfAlphKabutoChamberSkyfallTopMovement
	playsound SFX_KINESIS
	waitsfx
	pause 20
	warpcheck
	end

RuinsOfAlphKabutoChamberScientistScript:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .AllUnownCaught
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue .WallOpen
	checkevent EVENT_SOLVED_KABUTO_PUZZLE
	iffalse .PuzzleIncomplete
	writetext UnknownText_0x589b8
	buttonsound
.PuzzleIncomplete:
	writetext UnknownText_0x588f5
	waitbutton
	closetext
	turnobject RUINSOFALPHKABUTOCHAMBER_SCIENTIST, UP
	end

.WallOpen:
	writetext UnknownText_0x5897c
	waitbutton
	closetext
	end

.AllUnownCaught:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphKabutoChamberAncientReplica:
	jumptext RuinsOfAlphKabutoChamberAncientReplicaText

RuinsOfAlphKabutoChamberDescriptionSign:
	jumptext RuinsOfAlphKabutoChamberDescriptionText

RuinsOfAlphKabutoChamberWallPatternLeft:
	opentext
	writetext RuinsOfAlphKabutoChamberWallPatternLeftText
	setval UNOWNWORDS_ESCAPE
	special DisplayUnownWords
	closetext
	end

RuinsOfAlphKabutoChamberWallPatternRight:
	checkevent EVENT_WALL_OPENED_IN_KABUTO_CHAMBER
	iftrue .WallOpen
	opentext
	writetext RuinsOfAlphKabutoChamberWallPatternRightText
	setval UNOWNWORDS_ESCAPE
	special DisplayUnownWords
	closetext
	end

.WallOpen:
	opentext
	writetext RuinsOfAlphKabutoChamberWallHoleText
	waitbutton
	closetext
	end

RuinsOfAlphKabutoChamberSkyfallTopMovement:
	skyfall_top
	step_end

RuinsOfAlphKabutoChamberReceptionistText:
	text "유적의 방에 잘 오셨습니다!"

	para "아주 오래전의 사람이 그린"
	line "포켓몬의 그림이 있습니다!"
	cont "움직여봐 주세요"
	
	para "오른쪽은 그 포켓몬에 대한"
	line "설명이라고 말해지고 있습니다"

	para "뒤에 있는 과학자 분들은"
	line "새로발견된 문양을"
	cont "연구하고 있습니다"
	done
;_MOBILE 관련
UnknownText_0x588f5:
	text"요즘 이상한 모양이"
	line"여기 나타났어!"

	para"이상한데 말이야"
	line"좀 전까지는 없었는데…"

	para"너도 벽을 한 번 봐!"
	done

UnknownText_0x5897c:
	text"오오! 또 하나 발견!"
	line"지나갈 수 있는 구멍이 있어!"
	done

UnknownText_0x589b8:
	text"좀 전의 흔들림은 무서웠어!"
	line"근데 그런 것보다…"
	cont"여기 벽이 신경쓰여…"
	done

RuinsOfAlphKabutoChamberUnusedText:
; unused
	text"여기 벽에 있는 모양은"
	line"단어인 것 같다!"

	para"그리고… 저 석판은"
	line"뭔가의 신호 같은데…"

	para"저기서 포켓몬이 나올 거 같은"
	line"느낌은 드는데… 흐-음…"
	done

RuinsOfAlphKabutoChamberWallPatternLeftText:
	text"벽에 무늬가 있다!"
	done

RuinsOfAlphKabutoChamberUnownText:
; unused
	text "안농 문자다!"
	done

RuinsOfAlphKabutoChamberWallPatternRightText:
	text"벽에 무늬가 있다!"
	done

RuinsOfAlphKabutoChamberWallHoleText:
	text"벽에 큰 구멍이"
	line"뚫려있다!"
	done

RuinsOfAlphKabutoChamberAncientReplicaText:
	text "옛날의 포켓몬을"
	line "흉내내서 만들어낸 것"
	done

RuinsOfAlphKabutoChamberDescriptionText:
	text "바다 밑에 숨어서 등 뒤의"
	line "눈으로 주변을 보던 포켓몬"
	done

RuinsOfAlphKabutoChamber_MapEvents:
	db 0, 0 ; filler

	db 5 ; warp events
	warp_event  3,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  4,  9, RUINS_OF_ALPH_OUTSIDE, 2
	warp_event  3,  3, RUINS_OF_ALPH_INNER_CHAMBER, 4
	warp_event  4,  3, RUINS_OF_ALPH_INNER_CHAMBER, 5
	warp_event  4,  0, RUINS_OF_ALPH_KABUTO_ITEM_ROOM, 1

	db 0 ; coord events

	db 6 ; bg events
	bg_event  2,  3, BGEVENT_READ, RuinsOfAlphKabutoChamberAncientReplica
	bg_event  5,  3, BGEVENT_READ, RuinsOfAlphKabutoChamberAncientReplica
	bg_event  3,  2, BGEVENT_UP, RuinsOfAlphKabutoChamberPuzzle
	bg_event  4,  2, BGEVENT_UP, RuinsOfAlphKabutoChamberDescriptionSign
	bg_event  3,  0, BGEVENT_UP, RuinsOfAlphKabutoChamberWallPatternLeft
	bg_event  4,  0, BGEVENT_UP, RuinsOfAlphKabutoChamberWallPatternRight

	db 2 ; object events
	object_event  5,  5, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphKabutoChamberReceptionistScript, EVENT_RUINS_OF_ALPH_KABUTO_CHAMBER_RECEPTIONIST
	object_event  3,  1, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphKabutoChamberScientistScript, -1
