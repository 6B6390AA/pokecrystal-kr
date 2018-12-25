; Functions used in displaying and handling menus.

LoadMenuHeader::
	call CopyMenuHeader
	call PushWindow
	ret

CopyMenuHeader::
	ld de, wMenuHeader
	ld bc, wMenuHeaderEnd - wMenuHeader
	call CopyBytes
	ldh a, [hROMBank]
	ld [wMenuDataBank], a
	ret

StoreTo_wMenuCursorBuffer::
	ld [wMenuCursorBuffer], a
	ret

MenuTextBox::
	push hl
	call LoadMenuTextBox
	pop hl
	jp PrintText

; unused
	ret

LoadMenuTextBox::
	ld hl, .MenuHeader
	call LoadMenuHeader
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw vTiles0
	db 0 ; default option

MenuTextBoxBackup::
	call MenuTextBox
	call CloseWindow
	ret

LoadStandardMenuHeader::
	ld hl, .MenuHeader
	call LoadMenuHeader
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw 0
	db 1 ; default option

Call_ExitMenu::
	call ExitMenu
	ret

VerticalMenu::
	xor a
	ldh [hBGMapMode], a
	call MenuBox
	call UpdateSprites
	call PlaceVerticalMenuItems
	call ApplyTilemap
	call CopyMenuData
	ld a, [wMenuDataFlags]
	bit 7, a
	jr z, .cancel
	call InitVerticalMenuCursor
	call StaticMenuJoypad
	call MenuClickSound
	bit 1, a
	jr z, .okay
.cancel
	scf
	ret

.okay
	and a
	ret

GetMenu2::
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	ret

CopyNameFromMenu::
	push hl
	push bc
	push af
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	pop af
	call GetNthString
	ld d, h
	ld e, l
	call CopyName1
	pop bc
	pop hl
	ret

YesNoBox::
	lb bc, SCREEN_WIDTH - 6, 6

PlaceYesNoBox::
	jr _YesNoBox

PlaceGenericTwoOptionBox::
	call LoadMenuHeader
	jr InterpretTwoOptionMenu

_YesNoBox::
; Return nc (yes) or c (no).
	push bc
	ld hl, YesNoMenuHeader
	call CopyMenuHeader
	pop bc
; This seems to be an overflow prevention, but
; it was coded wrong.
;	ld a, b
;	cp SCREEN_WIDTH - 6
;	jr nz, .okay ; should this be "jr nc"?
;	ld a, SCREEN_WIDTH - 6
;	ld b, a

.okay
	ld a, b
	ld [wMenuBorderLeftCoord], a
	add 5
	ld [wMenuBorderRightCoord], a
	ld a, c
	ld [wMenuBorderTopCoord], a
	add 5
	ld [wMenuBorderBottomCoord], a
	call PushWindow

InterpretTwoOptionMenu::
	call VerticalMenu
	push af
	ld c, $f
	call DelayFrames
	call CloseWindow
	pop af
	jr c, .no
	ld a, [wMenuCursorY]
	cp 2 ; no
	jr z, .no
	and a
	ret

.no
	ld a, 2
	ld [wMenuCursorY], a
	scf
	ret

YesNoMenuHeader::
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 4, 15, 9
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 2
	db "예@"
	db "아니오@"

OffsetMenuHeader::
	call _OffsetMenuHeader
	call PushWindow
	ret

_OffsetMenuHeader::
	push de
	call CopyMenuHeader
	pop de
	ld a, [wMenuBorderLeftCoord]
	ld h, a
	ld a, [wMenuBorderRightCoord]
	sub h
	ld h, a
	ld a, d
	ld [wMenuBorderLeftCoord], a
	add h
	ld [wMenuBorderRightCoord], a
	ld a, [wMenuBorderTopCoord]
	ld l, a
	ld a, [wMenuBorderBottomCoord]
	sub l
	ld l, a
	ld a, e
	ld [wMenuBorderTopCoord], a
	add l
	ld [wMenuBorderBottomCoord], a
	ret

DoNthMenu::
	call DrawVariableLengthMenuBox
	call MenuWriteText
	call InitMenuCursorAndButtonPermissions
	call GetStaticMenuJoypad
	call GetMenuJoypad
	call MenuClickSound
	ret

SetUpMenu::
	call DrawVariableLengthMenuBox ; ???
	call MenuWriteText
	call InitMenuCursorAndButtonPermissions ; set up selection pointer
	ld hl, w2DMenuFlags1
	set 7, [hl]
	ret

DrawVariableLengthMenuBox::
	call CopyMenuData
	call GetMenuIndexSet
	call AutomaticGetMenuBottomCoord
	call MenuBox
	ret

MenuWriteText::
	xor a
	ldh [hBGMapMode], a
	call GetMenuIndexSet ; sort out the text
	call RunMenuItemPrintingFunction ; actually write it
	call SafeUpdateSprites
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a
	call ApplyTilemap
	pop af
	ldh [hOAMUpdate], a
	ret

AutomaticGetMenuBottomCoord::
	ld a, [wMenuBorderLeftCoord]
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld c, a
	ld a, [wMenuDataItems]
	add a
	inc a
	ld b, a
	ld a, [wMenuBorderTopCoord]
	add b
	ld [wMenuBorderBottomCoord], a
	ret

GetMenuIndexSet::
	ld hl, wMenuDataIndicesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wWhichIndexSet]
	and a
	jr z, .skip
	ld b, a
	ld c, -1
.loop
	ld a, [hli]
	cp c
	jr nz, .loop
	dec b
	jr nz, .loop

.skip
	ld d, h
	ld e, l
	ld a, [hl]
	ld [wMenuDataItems], a
	ret

RunMenuItemPrintingFunction::
	call MenuBoxCoord2Tile
	ld bc, 2 * SCREEN_WIDTH + 2
	add hl, bc
.loop
	inc de
	ld a, [de]
	cp -1
	ret z
	ld [wMenuSelection], a
	push de
	push hl
	ld d, h
	ld e, l
	ld hl, wMenuDataDisplayFunctionPointer
	call ._hl_
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop de
	jr .loop

._hl_
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

InitMenuCursorAndButtonPermissions::
	call InitVerticalMenuCursor
	ld hl, wMenuJoypadFilter
	ld a, [wMenuDataFlags]
	bit 3, a
	jr z, .disallow_select
	set START_F, [hl]

.disallow_select
	ld a, [wMenuDataFlags]
	bit 2, a
	jr z, .disallow_left_right
	set D_LEFT_F, [hl]
	set D_RIGHT_F, [hl]

.disallow_left_right
	ret

GetScrollingMenuJoypad::
	call ScrollingMenuJoypad
	ld hl, wMenuJoypadFilter
	and [hl]
	jr ContinueGettingMenuJoypad

GetStaticMenuJoypad::
	xor a
	ld [wMenuJoypad], a
	call StaticMenuJoypad

ContinueGettingMenuJoypad:
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit B_BUTTON_F, a
	jr nz, .b_start
	bit START_F, a
	jr nz, .b_start
	bit D_RIGHT_F, a
	jr nz, .d_right
	bit D_LEFT_F, a
	jr nz, .d_left
	xor a
	ld [wMenuJoypad], a
	jr .done

.d_right
	ld a, D_RIGHT
	ld [wMenuJoypad], a
	jr .done

.d_left
	ld a, D_LEFT
	ld [wMenuJoypad], a
	jr .done

.a_button
	ld a, A_BUTTON
	ld [wMenuJoypad], a

.done
	call GetMenuIndexSet
	ld a, [wMenuCursorY]
	ld l, a
	ld h, $0
	add hl, de
	ld a, [hl]
	ld [wMenuSelection], a
	ld a, [wMenuCursorY]
	ld [wMenuCursorBuffer], a
	and a
	ret

.b_start
	ld a, B_BUTTON
	ld [wMenuJoypad], a
	ld a, -1
	ld [wMenuSelection], a
	scf
	ret

PlaceMenuStrings::
	push de
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMenuSelection]
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

PlaceNthMenuStrings::
	push de
	ld a, [wMenuSelection]
	call GetMenuDataPointerTableEntry
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	call PlaceString
	ret

Unreferenced_Function1f9e::
	call GetMenuDataPointerTableEntry
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

MenuJumptable::
	ld a, [wMenuSelection]
	call GetMenuDataPointerTableEntry
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

GetMenuDataPointerTableEntry::
	ld e, a
	ld d, $0
	ld hl, wMenuDataPointerTableAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ret

ClearWindowData::
	ld hl, wWindowStackPointer
	call .bytefill
	ld hl, wMenuHeader
	call .bytefill
	ld hl, wMenuDataFlags
	call .bytefill
	ld hl, w2DMenuCursorInitY
	call .bytefill

	ldh a, [rSVBK]
	push af
	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	xor a
	ld hl, wWindowStackBottom
	ld [hld], a
	ld [hld], a
	ld a, l
	ld [wWindowStackPointer], a
	ld a, h
	ld [wWindowStackPointer + 1], a

	pop af
	ldh [rSVBK], a
	ret

.bytefill
	ld bc, $10
	xor a
	call ByteFill
	ret

MenuClickSound::
	push af
	and A_BUTTON | B_BUTTON
	jr z, .nosound
	ld hl, wMenuFlags
	bit 3, [hl]
	jr nz, .nosound
	call PlayClickSFX
.nosound
	pop af
	ret

PlayClickSFX::
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

MenuTextBoxWaitButton::
	call MenuTextBox
	call WaitButton
	call ExitMenu
	ret

Place2DMenuItemName::
	ldh [hBuffer], a
	ldh a, [hROMBank]
	push af
	ldh a, [hBuffer]
	rst Bankswitch

	call PlaceString
	pop af
	rst Bankswitch

	ret

_2DMenu::
	ldh a, [hROMBank]
	ld [wMenuData_2DMenuItemStringsBank], a
	farcall _2DMenu_
	ld a, [wMenuCursorBuffer]
	ret

InterpretBattleMenu::
	ldh a, [hROMBank]
	ld [wMenuData_2DMenuItemStringsBank], a
	farcall _InterpretBattleMenu
	ld a, [wMenuCursorBuffer]
	ret

InterpretMobileMenu::
	ldh a, [hROMBank]
	ld [wMenuData_2DMenuItemStringsBank], a
	farcall _InterpretMobileMenu
	ld a, [wMenuCursorBuffer]
	ret
