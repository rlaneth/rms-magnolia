SCREEN_Y          equ 2
SCREEN_X          equ 2
SCREEN_HEIGHT     equ 10
SCREEN_WIDTH      equ 76

SCREEN_ATTR_TITLE equ DEFAULT_ATTR_TITLE

SCREEN_MAIN       db 'Ol', 0xA0, ', maker!', 0x00, 0x0A,
                  db 'Esta ', 0x82, ' uma plataforma de aplicativos ',
                  db 'para BIOS! Ela foi desenvolvida pela ', 0x0A,
                  db 'Miralium Research com o apoio do Rio Maker ',
                  db 'Space e lan', 0x87, 'ada em dom', 0xA1, 'nio ',
                  db  0x0A, 'p', 0xA3, 'blico sob o nome Magnolia.',
                  db  0x0A, 0x0A,
                  db 'Saiba mais e contribua com o projeto atrav',
                  db  0x82, 's da p', 0xA0, 'gina no GitHub:', 0x0A,
                  db 'https://github.com/miraliumre/magnolia',
                  db  0x00

SCREEN_GAMES      db 'Jogos', 0x00, 0x0A,
                  db 'Explore jogos simples e divertidos que ',
                  db 'voc', 0x88, ' pode rodar diretamente aqui!', 0x00

SCREEN_TOOLS      db 'Ferramentas', 0x00, 0x0A,
                  db 'Este menu oferece utilit', 0xA0, 'rios ',
                  db 'projetados para auxiliar com tarefas de ', 0x0A,
                  db 'desenvolvimento e diagn', 0xA2, 'stico.', 0x00

draw_screen:
    pusha
    
    prepare_area SCREEN_Y, SCREEN_X, SCREEN_HEIGHT, SCREEN_WIDTH

    xor bh, bh
    mov bl, SCREEN_ATTR_TITLE

    .title_loop:
        lodsb
        test al, al
        jz .update_cursor
        call write_a
        jmp .title_loop

    .update_cursor:
        add dh, 1
        call set_cursor_position

    .text_loop:
        lodsb
        test al, al
        jz .break
        cmp al, 0x0A
        je .update_cursor
        mov ah, 0x0E
        xor bh, bh
        int 0x10
        jmp .text_loop

    .break:
        popa
        ret