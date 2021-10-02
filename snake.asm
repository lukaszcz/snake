        %include "unistd.asm"

        %assign TCGETS			05401h
        %assign TCSETSW			05403h
        %assign TIOCLINUX		0541ch
        %assign KDGKBMODE		04b44h
        %assign KDSKBMODE		04b45h
        %assign K_RAW			000h

        %assign ISTRIP			000400q
        %assign INLCR			000100q
        %assign IGNCR			000200q
        %assign ICRNL			000400q
        %assign IXON			002000q
        %assign IXOFF			010000q

        %assign ISIG			1
        %assign ICANON			2
        %assign ECHO			8

        %assign STDIN			0
        %assign STDOUT			1

        %assign O_RDWR			000002q
        %assign SEEK_SET		0
        %assign SEEK_CUR		1
        %assign SEEK_END		2

        %assign NOT32			0ffffffffh

        %assign STATE_OPEN		001h
        %assign STATE_TERMIOS_SAVED	002h
        %assign STATE_KBMODE_SAVED	004h

                                struc	ttermios
                                alignb	4
termios_input_flags:		resd	1
termios_output_flags:		resd	1
termios_control_flags:		resd	1
termios_local_flags:		resd	1
termios_line_discipline:	resb	1
termios_control_characters:	resb	64
                                endstruc

                                struc	tkbentry
                                alignb	4
kbentry_table:			resb	1
kbentry_index:			resb	1
kbentry_value:			resw	1
                                endstruc


        section	.data
                align	4
tty_state:	dd	0
error_msg:	db	"Error!", 10
error_msg_len:	dd	$ - error_msg

        section .bss
                        align	4
tty_termios_saved:	resb	ttermios_size
tty_kbmode_saved:	resd	1
tty_termios:		resb	ttermios_size
hex_number:		resd	1
character		resb	1

        section .text
        global _start
_start:
        mov	edx, tty_termios_saved
        mov	ecx, TCGETS
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
        test	eax, eax
        js near	error
        or	dword [tty_state], STATE_TERMIOS_SAVED

        ;;  save
        mov	edx, tty_kbmode_saved
        mov	ecx, KDGKBMODE
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
        test	eax, eax
        js near	error
        or	dword [tty_state], STATE_KBMODE_SAVED

        ;; set terminal values

        cld
        mov	ecx, ttermios_size
        mov	esi, tty_termios_saved
        mov	edi, tty_termios
        rep movsb
        and	dword [tty_termios + termios_input_flags], (NOT32 - (ISTRIP | INLCR | ICRNL | IGNCR | IXON | IXOFF))
        and	dword [tty_termios + termios_local_flags], (NOT32 - (ECHO | ICANON | ISIG))

        mov	edx, tty_termios
        mov	ecx, TCSETSW
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
        test	eax, eax
        js near	error

        mov	edx, K_RAW
        mov	ecx, KDSKBMODE
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
        test	eax, eax
        js near	error

        jmp snake

restore:
        test	dword [tty_state], STATE_TERMIOS_SAVED
        jz	.no_termios
        mov	edx, tty_termios_saved
        mov	ecx, TCSETSW
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
.no_termios:
        test	dword [tty_state], STATE_KBMODE_SAVED
        jz	.no_kbmode
        mov	edx, [tty_kbmode_saved]
        mov	ecx, KDSKBMODE
        mov	ebx, STDIN
        mov	eax, SYS_IOCTL
        int	80h
.no_kbmode:
        ret

exit:
        call	restore
        xor	eax, eax
        mov	ebx, eax
        inc	eax
        int	80h

error:
        mov	edx, [error_msg_len]
        mov	ecx, error_msg
        mov	ebx, STDOUT
        mov	eax, SYS_WRITE
        int	80h
        call	restore
        xor	eax, eax
        inc	eax
        mov	ebx, eax
        int	80h

;; ***********************************************************

        %assign Q_PRESSED	10h
        %assign MAX_X		80
        %assign MAX_Y		25
        %assign SEGMENT_UP	1
        %assign SEGMENT_DOWN	2
        %assign SEGMENT_LEFT	3
        %assign SEGMENT_RIGHT	4
        %assign HEAD		5
        %assign RED		40h
        %assign	GREEN		20h
        %assign BLUE		10h
        %assign BLACK		00h

        section .data
key:		db 0
screen:		times (MAX_X * MAX_Y) db 0
head_x:		db 14
head_y:		db 0
tail_x:		db 0
tail_y:		db 0
moves_left:     db 10
fdvcsa:		dd 0
vcsa2:		db "/dev/vcsa2", 0

;;; screen format: 0 - empty, nonzero - snake, 1 - next segment up,
;;;  2 - down, 3 - left, 4 - right, 5 - head

        section .text
snake:
        ;; open console for writing
        mov	ecx, O_RDWR
        mov	ebx, vcsa2
        mov	eax, SYS_OPEN
        int	80h
        test	eax, eax
        js	error
        mov	[fdvcsa], eax

        ;; init screen
        cld
        mov     ecx, 14
        mov     edi, screen
        mov	al, 4
        rep	stosb
        mov	byte [edi], 5
        mov	ebx, 14
        xor     ecx, ecx
        mov	al, BLUE
        call	setbkg
        mov	ebx, 13
.loop:
        push	ebx
        xor     ecx, ecx
        mov	al, GREEN
        call	setbkg
        pop	ebx
        dec	ebx
        jns	.loop

        ;; play
.play:
        ;; check if the snake can move, if not exit
        movzx	ebx, byte [head_x]
        movzx	ecx, byte [head_y]
        inc     ecx
        call	check_empty
        test	eax, eax
        jnz	.read
        sub	ecx, 2
        call	check_empty
        test	eax, eax
        jnz	.read
        inc     ecx
        inc	ebx
        call	check_empty
        test	eax, eax
        jnz     .read
        sub	ebx, 2
        call	check_empty
        test	eax, eax
        jnz	.read
        ;; can't move - exit
        jmp	exit_snake
.read:
        mov     edx, 1
        mov     ecx, key
        mov     ebx, STDIN
        mov     eax, SYS_READ
        int     80h
        mov	bl, [key]
        cmp	bl, 0E0h
        je	.read_arrow
        test	bl, 80h
        jnz	.read		; ignore break codes
.no_ignore:
        ;; make the head blue
        movzx	ebx, byte [head_x]
        movzx	ecx, byte [head_y]
        mov	al, BLUE
        call	setbkg
        ;; interpret the key pressed
        mov	bl, [key]
        cmp	bl, Q_PRESSED
        je near	exit_snake
        jmp	.read
.read_arrow:
        mov     edx, 1
        mov     ecx, key
        mov     ebx, STDIN
        mov     eax, SYS_READ
        int     80h
        test	byte [key], 80h
        jnz	.read		; ignore break codes
        ;; make the head blue
        movzx	ebx, byte [head_x]
        movzx	ecx, byte [head_y]
        mov	al, BLUE
        call	setbkg
        ;; interpret the key pressed
        mov	bl, [key]
        ;; dl = delta x, dh = delta y
        xor     edx, edx
        cmp	bl, 4bh         ; left
        jne	.ll1
        mov	dl, -1
        push	SEGMENT_LEFT
        jmp	.move
.ll1:	cmp	bl, 4dh		; right
        jne	.ll2
        mov	dl, 1
        push	SEGMENT_RIGHT
        jmp     .move
.ll2:	cmp	bl, 48h		; up
        jne	.ll3
        mov	dh, -1
        push	SEGMENT_UP
        jmp	.move
.ll3:	cmp	bl, 50h		; down
        jne	.read
        mov	dh, 1
        push    SEGMENT_DOWN
.move:
        add	dl, [head_x]
        add	dh, [head_y]
        movsx	ebx, dl
        movsx	ecx, dh
        call	check_empty
        test    eax, eax
        jz near .bad_move	; eax = 0 means not empty
        pop	eax             ; SEGMENT_XXX on the stack
        push    ebx
        push	ecx
        movzx	ebx, byte [head_x]
        movzx	ecx, byte [head_y]
        call	count_address
        mov	[screen + edi], al
        mov	[head_x], dl
        mov	[head_y], dh
        mov	al, GREEN
        call	setbkg
        pop	ecx
        pop	ebx
        call	count_address
        mov	byte [screen + edi], HEAD
        mov	al, BLUE
        call	setbkg
        dec	byte [moves_left]
        jz	.grow
        movzx	ebx, byte [tail_x]
        movzx	ecx, byte [tail_y]
        call	count_address
        xor	edx, edx
        mov	dl, byte [screen + edi]
        push    edx
        mov	byte [screen + edi], 0
        mov	al, BLACK
        call	setbkg
        movzx	ebx, byte [tail_x]
        movzx	ecx, byte [tail_y]
        pop	eax
        jmp	[.case_tab + eax * 4]
.case_up:
        dec     ecx
        jmp	.end_case
.case_down:
        inc	ecx
        jmp	.end_case
.case_left:
        dec	ebx
        jmp	.end_case
.case_right:
        inc	ebx
.end_case:
        mov	[tail_x], bl
        mov	[tail_y], cl
        jmp	.play
.grow:	mov	byte [moves_left], 10
        jmp	.play
.bad_move:
        ;; make the head red
        movzx	ebx, byte [head_x]
        movzx	ecx, byte [head_y]
        mov	al, RED
        call	setbkg
        jmp	.play

.case_tab:	dd error
                dd .case_up
                dd .case_down
                dd .case_left
                dd .case_right
                dd error

;;; edi := ebx + ecx * MAX_X; all registers saved (except edi)
count_address:
        push	eax
        push	edx
        push	ebx
        mov	ebx, MAX_X
        xor     edx, edx
        mov	eax, ecx
        mul	ebx
        pop	ebx
        pop	edx
        add	eax, ebx
        mov	edi, eax
        pop	eax
        ret

;;; ebx - x, ecx - y; result: eax = 0 if nonempty, 1 if empty
;;; all registers saved (except eax)
check_empty:
        xor	eax, eax
        push	edi
        test	ecx, ecx
        js	.not_empty
        test	ebx, ebx
        js	.not_empty
        cmp	ebx, MAX_X
        jge	.not_empty
        cmp	ecx, MAX_Y
        jge	.not_empty
        call	count_address
        cmp	byte [screen + edi], 0
        jne	.not_empty
        inc	eax
.not_empty:
        pop	edi
        ret

;;; sets background to the color in al at ebx:ecx screen coords;
;;; no registers saved
setbkg:
        mov	ebp, esp
        sub	esp, 4
        push	eax
        call	count_address
        mov	edx, SEEK_SET
        mov	ecx, edi
        shl	ecx, 1
        add	ecx, 5
        mov	ebx, [fdvcsa]
        mov	eax, SYS_LSEEK
        int	80h
        mov	edx, 1
        lea	ecx, [ebp - 4]
        mov	ebx, [fdvcsa]
        mov	eax, SYS_READ
        int	80h
        mov	edx, SEEK_CUR
        mov	ecx, -1
        mov	ebx, [fdvcsa]
        mov	eax, SYS_LSEEK
        int     80h
        pop	eax
        and	byte [ebp - 4], 0Fh
        or	[ebp - 4], al
        mov	edx, 1
        lea	ecx, [ebp - 4]
        mov	ebx, [fdvcsa]
        mov	eax, SYS_WRITE
        int	80h
        mov	esp, ebp
        ret

exit_snake:
        mov	ebx, [fdvcsa]
        mov	eax, SYS_CLOSE
        int	80h
        jmp	exit
