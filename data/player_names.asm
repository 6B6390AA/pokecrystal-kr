ChrisNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 1, 10, TEXTBOX_Y
	dw .MaleNames
	db 1 ; ????
	db 0 ; default option

.MaleNames:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B ; flags
	db 5 ; items
	db "스스로 결정하다@"
MalePlayerNameArray:
	db "크리스@"
	db "MAT@"
	db "ALLAN@"
	db "JON@"
	db 3 ; displacement
	db "이름 후보@" ; title

KrisNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 1, 10, TEXTBOX_Y
	dw .FemaleNames
	db 1 ; ????
	db 0 ; default option

.FemaleNames:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B ; flags
	db 5 ; items
	db "스스로 결정하다@"
FemalePlayerNameArray:
	db "크리스@"
	db "AMANDA@"
	db "JUANA@"
	db "JODI@"
	db 3 ; displacement
	db "이름 후보@" ; title

