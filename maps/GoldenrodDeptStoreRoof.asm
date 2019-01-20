	const_def 2 ; object constants
	const GOLDENRODDEPTSTOREROOF_CLERK
	const GOLDENRODDEPTSTOREROOF_POKEFAN_F
	const GOLDENRODDEPTSTOREROOF_FISHER
	const GOLDENRODDEPTSTOREROOF_TWIN
	const GOLDENRODDEPTSTOREROOF_SUPER_NERD
	const GOLDENRODDEPTSTOREROOF_POKEFAN_M
	const GOLDENRODDEPTSTOREROOF_TEACHER
	const GOLDENRODDEPTSTOREROOF_BUG_CATCHER

GoldenrodDeptStoreRoof_MapScripts:
	db 0 ; scene scripts

	db 2 ; callbacks
	callback MAPCALLBACK_TILES, .CheckSaleChangeBlock
	callback MAPCALLBACK_OBJECTS, .CheckSaleChangeClerk

.CheckSaleChangeBlock:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleIsOn
	return

.SaleIsOn:
	changeblock 0, 2, $3f ; cardboard boxes
	changeblock 0, 4, $0f ; vendor booth
	return

.CheckSaleChangeClerk:
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .ChangeClerk
	setevent EVENT_GOLDENROD_SALE_OFF
	clearevent EVENT_GOLDENROD_SALE_ON
	return

.ChangeClerk:
	clearevent EVENT_GOLDENROD_SALE_OFF
	setevent EVENT_GOLDENROD_SALE_ON
	return

GoldenrodDeptStoreRoofClerkScript:
	opentext
	pokemart MARTTYPE_ROOFTOP, 0
	closetext
	end

GoldenrodDeptStoreRoofPokefanFScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanFText

GoldenrodDeptStoreRoofFisherScript:
	faceplayer
	opentext
	writetext GoldenrodDeptStoreRoofFisherText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_FISHER, UP
	end

GoldenrodDeptStoreRoofTwinScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTwinText

GoldenrodDeptStoreRoofSuperNerdScript:
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdOhWowText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, UP
	opentext
	writetext GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText
	waitbutton
	closetext
	turnobject GOLDENRODDEPTSTOREROOF_SUPER_NERD, RIGHT
	end

GoldenrodDeptStoreRoofPokefanMScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofPokefanMText

GoldenrodDeptStoreRoofTeacherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofTeacherText

GoldenrodDeptStoreRoofBugCatcherScript:
	jumptextfaceplayer GoldenrodDeptStoreRoofBugCatcherText

Binoculars1:
	jumptext Binoculars1Text

Binoculars2:
	jumptext Binoculars2Text

Binoculars3:
	jumptext Binoculars3Text

PokeDollVendingMachine:
	jumptext PokeDollVendingMachineText

GoldenrodDeptStoreRoofPokefanFText:
	text"ふう!　つかれた！"

	para"たまにショッピングの　いきぬきに"
	line"おくじょうにあがって　くるのよ"
	done

GoldenrodDeptStoreRoofFisherText:
	text"なに?　べつにおとなが"
	line"むちゅうになっても　いいでしょ!"

	para"おれは　まいにち　かよって"
	line"にんぎょう　ぜんぶ　あつめるぞー!"
	done

GoldenrodDeptStoreRoofTwinText:
	text"たまにこの　ばしょで"
	line"やすうりしてる　ときが　あるよ"
	done

GoldenrodDeptStoreRoofSuperNerdOhWowText:
	text"おおっ　すげー!"
	done

GoldenrodDeptStoreRoofSuperNerdQuitBotheringMeText:
	text"ちょっと　じゃましないでよ!"
	done

GoldenrodDeptStoreRoofPokefanMText:
	text"どうしても　ほしいもんが　あるが"
	line"こづかいが　たりない…"

	para"ひたすら　ためた　きのみを"
	line"うってしまおうかな…"
	done

GoldenrodDeptStoreRoofTeacherText:
	text"あれも　これも　やすいわ!"
	line"もう　かいもの　しすぎちゃって"
	cont"りュックが　ぎゅうぎゅうよ"
	done

GoldenrodDeptStoreRoofBugCatcherText:
	text"ボクのポケモン　いざってときに"
	line"すぐ　まひしたり　どくに"
	cont"やられちゃうから"
	cont"なんでもなおし　かいにきたんだけど"
	cont"まだ　のこっているかな…"
	done

Binoculars1Text:
	text"ぼうえんきょうで　とおくが　みえる!"
	line"じぶんの　うちも　みえそう!"
	cont"あの　みどりのやねの　いえかな?"
	done

Binoculars2Text:
	text"あっ!　だれかと　だれかが"
	line"どうろで　しょうぶ　してる!"

	para"ポケモンが　はっぱを"
	line"いっぱい　とばしてる!"
	cont"みてたら　しょうぶしたくなってきた！"
	done

Binoculars3Text:
	text"おじさんが　つぎつぎと　つりあげた"
	line"たいりょうの　コイキングが"
	cont"いっせいにはねてる…"

	para"すごい　みずしぶきだ!"
	done

PokeDollVendingMachineText:
	text"おかねを　いれて　ハンドルをまわすと"
	line"ちいさい　ポケモンにんぎょうが"
	cont"でてくる　はんばいきだ!"

	para"でも　ほとんど　からっぽ…"
	done

GoldenrodDeptStoreRoof_MapEvents:
	db 0, 0 ; filler

	db 1 ; warp events
	warp_event 13,  1, GOLDENROD_DEPT_STORE_6F, 3

	db 0 ; coord events

	db 4 ; bg events
	bg_event 15,  3, BGEVENT_RIGHT, Binoculars1
	bg_event 15,  5, BGEVENT_RIGHT, Binoculars2
	bg_event 15,  6, BGEVENT_RIGHT, Binoculars3
	bg_event  3,  0, BGEVENT_UP, PokeDollVendingMachine

	db 8 ; object events
	object_event  1,  4, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofClerkScript, EVENT_GOLDENROD_SALE_OFF
	object_event 10,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanFScript, -1
	object_event  2,  1, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofFisherScript, -1
	object_event  3,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTwinScript, EVENT_GOLDENROD_SALE_ON
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofSuperNerdScript, EVENT_GOLDENROD_SALE_ON
	object_event  7,  0, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofPokefanMScript, EVENT_GOLDENROD_SALE_OFF
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofTeacherScript, EVENT_GOLDENROD_SALE_OFF
	object_event  1,  6, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStoreRoofBugCatcherScript, EVENT_GOLDENROD_SALE_OFF
