BattleCommand_FuryCutter:
; furycutter

	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyFuryCutterCount

.go
	ld a, [wAttackMissed]
	and a
	jp nz, ResetFuryCutterCount

	inc [hl]

; Damage capped at 3 turns' worth (4x).
	ld a, [hl]
	ld b, a
	cp 3
	jr c, .checkdouble
	ld b, 2

.checkdouble
	dec b
	ret z

; Double the damage
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .checkdouble

; No overflow
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

ResetFuryCutterCount:
	push hl

	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .reset
	ld hl, wEnemyFuryCutterCount

.reset
	xor a
	ld [hl], a

	pop hl
	ret
