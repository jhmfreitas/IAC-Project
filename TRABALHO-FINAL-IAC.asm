gaming EQU 1              ;estado do jogo
LINHAINIT EQU 0           ;linha inicial do tetraminó
COLUNAINIT EQU 4          ;coluna inicial do tetraminó
CONTADOR EQU 2500H        ;endereço do contador
LINHACORR EQU 2600H       ;endereço de linha corrente
COLUNACORR EQU 2610H      ;coluna corrente
FIGURACORR EQU 2620H      ;figura corrente
FIGLIGADA EQU 2670H       ;endereço da flag da figura
APAGA EQU 2632H           ;endereço flag de apagar
MOV_VALIDO EQU 2640H      ;flag de movimento
TESTE EQU 2650H           ;flag do teste
BUFFER EQU 2660H          ;endereço que guarda a tecla premida
LEFT EQU 1H               ;tecla 1-move para a esquerda
ROTATE EQU 2H             ;tecla 2-roda o tetraminó
RIGHT EQU 3H              ;tecla 3-move para a direita
DOWN EQU 6H               ;tecla 6-move para baixo
ULTIMO EQU 2690H          ;endereço da ultima tecla
event_int1 EQU 2680H      ;endereço da flag de interrupção
ROTATECOUNTER EQU 26A0H   ;endereço do contador de rotaçoes
pontuacao EQU 26B0H       ;endereço onde está a pontuação
stop_mode EQU 26C0H       ;endereço do modo de jogo
pause_mode EQU 26D0H      ;endereço da flag de pausa
LINHA   EQU 8H            ;posição do bit correspondente à 1a linha (4) a testar
TOUT EQU 0C000H   	      ;endereço do porto de saida do teclado
TIN EQU 0E000H		      ;endereço do porto de entrada do teclado
DISP EQU 0A000H		      ;endereco do display
MULT EQU 4H			      ;valor necessário para a conversão de binario para hexadecimal
START EQU 0DH             ;tecla D- começa o jogo
PAUSA EQU 0EH             ;tecla E-pausa o jogo
STOP EQU 0FH              ;tecla F-acaba o jogo
GAME_OVER EQU 26E0H		  ;flag de game over
VICTORY EQU 26F0H		  ;flag de vitoria


PLACE 1500H

vic_table:
	WORD 0001H
	WORD 8000H
	WORD 0002H
	WORD 4000H
	WORD 0002H
	WORD 4000H
	WORD 0003H
	WORD 0C000H
	WORD 0002H
	WORD 4000H
	WORD 0002H
	WORD 4000H
	WORD 0002H
	WORD 4000H
	WORD 0000H
	WORD 0000H

	
WORD 0000H
WORD 0000H
WORD 0000H
WORD 0000H
WORD 0000H
WORD 0E73H
WORD 094AH
WORD 0E73H
WORD 0862H
WORD 0852H
WORD 084BH
WORD 0000H
WORD 05C8H
WORD 0120H
WORD 0120H
WORD 0120H
WORD 0120H
WORD 0120H
WORD 01C0H
WORD 0000H
WORD 0EF9H
WORD 1022H
WORD 1022H
WORD 0C23H
WORD 0222H
WORD 0222H
WORD 1C22H
WORD 0000H
WORD 0000H
WORD 0000H
WORD 0000H
select:
	WORD T
	WORD I
	WORD L
	WORD S
	
excecoes:	WORD 	int1		
		
T:
	WORD Talto
	WORD Tdto
	WORD Tbaixo
	WORD Tesq
	
I:
	WORD Ialto
	WORD Ibaixo
	WORD Ialto
	WORD Ibaixo

L:
	WORD Lalto
	WORD Ldto
	WORD Lbaixo
	WORD Lesq

S:
	WORD Salto
	WORD Sbaixo
	WORD Salto
	WORD Sbaixo
	
Talto:
	STRING 0,1,1,1
	STRING 0,0,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0
Tdto:
	STRING 0,0,0,1
	STRING 0,0,1,1 
	STRING 0,0,0,1
	STRING 0,0,0,0	

Tesq: 
	STRING 0,0,1,0
	STRING 0,0,1,1
	STRING 0,0,1,0
	STRING 0,0,0,0
	
Tbaixo:
	STRING 0,0,1,0
	STRING 0,1,1,1
	STRING 0,0,0,0
	STRING 0,0,0,0

Ialto:
	STRING 0,0,0,1 
	STRING 0,0,0,1
	STRING 0,0,0,1
	STRING 0,0,0,1 

Ibaixo:
	STRING 1,1,1,1
	STRING 0,0,0,0 
	STRING 0,0,0,0
	STRING 0,0,0,0



Lbaixo:
	STRING 0,0,0,1
	STRING 0,1,1,1
	STRING 0,0,0,0
	STRING 0,0,0,0
	
	
Ldto:
	STRING 0,0,1,0 
	STRING 0,0,1,0
	STRING 0,0,1,1
	STRING 0,0,0,0
	
Lalto: 
	STRING 0,1,1,1
	STRING 0,1,0,0
	STRING 0,0,0,0
	STRING 0,0,0,0
Lesq :
	STRING 0,0,1,1
	STRING 0,0,0,1
	STRING 0,0,0,1
	STRING 0,0,0,0


Salto:
	STRING 0,0,1,0
	STRING 0,0,1,1
	STRING 0,0,0,1
	STRING 0,0,0,0
Sbaixo:
	STRING 0,0,1,1
	STRING 0,1,1,0
	STRING 0,0,0,0
	STRING 0,0,0,0

mascaras: 
	STRING 80H
	STRING 40H
	STRING 20H
	STRING 10H
	STRING 8H
	STRING 4H
	STRING 2H
	STRING 1H



MONSTRO:
		STRING 1, 0, 1, 0
		STRING 0, 1, 0, 0
		STRING 1, 0, 1, 0
		STRING 0, 0, 0, 0




PLACE 0H
	MOV SP, 4000H			; inicializa SP
	MOV BTE, excecoes       ; incializa BTE
	MOV R10, 1				; inicializa r10 a 1
	MOV R11, 0				; inicializa r11 a 0
	EI0						; liga a interrupçao 0
	EI						; liga as interrupçoes
	;CALL startup
	
loop5:	
	CALL gerador			; chama a rotina gerador
	CALL TECLADO			; idem para a roina TECLADO
	CALL control
	
	MOV R1, stop_mode       ;move o endereço da flag do modo de jogo para R1(0-parado,1-iniciado)
	MOVB R2,[R1]             ;move a flag para R2
	MOV R3, gaming          ;move o valor do estado do jogo para R3
	CMP R2, R3              ;compara a flag com o estado do jogo
	JNZ loop5               ;se forem iguais salta para o loop principal
	
	CALL TETRA				; idem para a rotina TETRA
	CALL Cleaner			; falta game over
	JMP loop5				; volta a correr o ciclo principal
	
coluna:
	MOV R1, 0				; inicializar r1 com o valor da primeira linha a escrever
	MOV R2, 12				; inicializar r2 com o valor da coluna onde queremos delimitar a area de jogo
	MOV R5, 32				; inicializar r5 com o valor da linha onde vai ser desenhado o ultimo pixel
ciclocol:
	CALL escrevepixel		; chama a rotina escrevepixel para desenhar a coluna
	ADD R1, 1				; incrementa r1 de modo a desenhar-mos na proxima linha
	SUB R5, 1				; atualizar r5 com o valor de linhas que ainda faltam
	JNZ ciclocol			; se ainda não acabou de escrever a area de jogo vai escrever mais um pixel
	RET	                    ; retorna ao sitio onde foi chamada
	

control:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	MOV R0, BUFFER          ;move o endereço da tecla premida para R0
	MOVB R1, [R0]           ;move a tecla premida para R1
	MOV R3, START           ;move a tecla do start para R3
	CMP R1, R3              ;verifica se foi essa a tecla premida
	JZ Start                ;se for,salta para a rotina de start
	MOV R3, PAUSA	        ;move a tecla da pausa para R3
	CMP R1, R3             ;verifica se foi essa a tecla premida
	JZ Pausa               ;se for,salta para a de pausa
	MOV R3, STOP            ;move a tecla do stop para R3
	CMP R1, R3              ;verifica se foi essa a tecla premida
	JZ Stop                 ;se for,salta para a rotina de stop
	
	
Start:
	;MOV R0, stop_mode      ;move o endereço do estado para R0
	;MOV R1, [R0]           ;lê o endereço
	;CMP R1, gaming         ;compara com o estado
	;JZ fim_control         ;se for diferente retorna
	CALL all_reset          ;inicializa todo o jogo com tudo a 0
	MOV R0, pontuacao
	MOV R1, 0
	MOV [R0], R1
	CALL DISPLAY
	CALL coluna
	MOV R0, gaming
	MOV R1, stop_mode
	MOVB [R1], R0
	JMP test_end
	
Pausa:
	MOV R1, pause_mode      ;move o endereço do estado de pausa para R1
	MOV R0, [R1]            ;move a flag de pausa para R0
	MOV R1, gaming          ;move o estado de jogo para R1
	CMP R0, R1              ;compara com a flag
	JZ tira_pausa           ;se forem iguais o jogo inicia
	MOV R2, stop_mode
	MOVB R3, [R2]
	CMP R3, R11
	JZ test_end
	MOV R1, pause_mode
	MOVB [R1], R10
	MOVB [R2], R11 
	;DI0
	;DI1
	;DI
	JMP test_end
tira_pausa:
	MOV R1, pause_mode    ;move o endereço de flag de pausa
	MOVB [R1], R11        ;move 0 para endereço de R1(R11=0)
	MOV R1, stop_mode
	MOVB [R1], R10
	;EI0
	;EI1
	;EI
	JMP test_end
	
Stop:                     ;acaba o jogo
	CALL LIMPA_PS
	;CALL startup
	MOV R1, stop_mode
	MOV [R1], R11
	JMP test_end
	

test_end:
	MOV R4, VICTORY
	MOV R5, [R4]
	CMP R5, 0
	;JNZ victory
	MOV R4, GAME_OVER
	MOV R5, [R4]
	CMP R5, 0
	;JNZ game_over
		
fim_control:
	POP R3
	POP R2
	POP R1
	POP R0
	RET

victory:
	CALL LIMPA_PS
	CALL vic_screen
	MOV R1, stop_mode
	MOV [R1], R11
	JMP fim_control

game_over:
	CALL LIMPA_PS
	CALL gover_screen
	MOV R1, stop_mode
	MOV [R1], R11
	JMP fim_control
	
startup:	
	CALL tetris
	CALL waits
	CALL start_screen
	RET

vic_screen:
	MOV R2, vic_table
	CALL screen_fill
	RET

gover_screen:
	MOV R2, gover_tab
	CALL screen_fill
	RET

tetris:
	MOV R2, tet_table
	CALL screen_fill
	RET	

start_screen:
	MOV R2, start_table
	CALL screen_fill
	RET
	
screen_fill:		;R2 TABELA DO ECRA
	PUSH R0
	PUSH R1
	PUSH R2
	MOV R0, 8000H
	MOV R1, 807EH
ciclo_fill:
	MOV [R0], R2
	CMP R0, R2
	JZ fim_fill
	ADD R0, 2
	ADD R2, 2
	JMP ciclo_fill
	POP R2
	POP R1
	POP R0
	RET
	
waits:
	PUSH R0
	MOV R0, 500
	SUB R0, 1
	JNZ menos
	POP R0
	RET
	
	
;* -- TETRA ----------------------------------------------------------------
;* 
;* Descrição: Rotina que controla a geracao, movimento e colisao dos tetraminos
;*
;* Parâmetros: --
;* Retorna:  --  
;* Destrói: --   		
TETRA:						
	PUSH R0					; para nao mexer no valor de r0	
	PUSH R1					; idem para r1
	MOV R0, FIGLIGADA		; move o endereço de FIGLIGADA para r0
	MOV R1, [R0]			; move o seu conteudo para r1
	AND R1, R1				; para verficar se não existem figuras ligadas, ou seja, se r1 é 0 
	JZ spawncall			; se for vai gerar mais tetraminos
	CALL move				; chama a rotina move para verificar se o tetramino tem que mover
	POP R1					; restora r1
	POP R0					; idem para r0
	RET						; retorna para o sitio onde foi chamada
spawncall:					; no caso de ter que gerar mais tetraminos
	CALL spawn				; chama a rotina que vai gerar tetraminos
	POP R1					; restora r1
	POP R0					; idem para r0
	RET						; retorna para o sitio onde foi chamada

;* -- spawn ----------------------------------------------------------------
;* 
;* Descrição: Rotina que chama um tetramino aleatorio
;*
;* Parâmetros: 
;* Retorna: --
;* Destrói: --
spawn:						 
	PUSH R0					; para nao mexer no valor de r0	
	PUSH R1					; para nao mexer no valor de r1	
	PUSH R2					; para nao mexer no valor de r2	
	PUSH R3					; para nao mexer no valor de r3	
	PUSH R4					; para nao mexer no valor de r4	
	PUSH R5					; para nao mexer no valor de r5	
	PUSH R6					; para nao mexer no valor de r6	
	PUSH R7					; para nao mexer no valor de r7	
	PUSH R8					; para nao mexer no valor de r8	
	PUSH R9					; para nao mexer no valor de r9
	MOV R1, LINHAINIT		; coloca os enderecos das variaveis em registos
	MOV R2, COLUNAINIT		;
	CALL get_random			; chama a rotina que obtem um numero aleatorio
	MOV R4, 0000H			; *********************************** substituir r11 por r4
	MOV R8, select			; move para r8 a tabela dos tetraminos
	SHL R3, 1				; multiplicamos o numero aleatorio por 2 (as tabelas andam de dois em dois)
	ADD R8, R3				; seleciona um tetramino
	MOV R7, [R8]			; move para r7 o endereco do tetramino
	CALL peca				; chama a rotina que decide se vai desenhar a peca
	MOV R0, LINHACORR		; coloca os enderecos das varias variaveis em registos
	MOV R6, COLUNACORR
	MOV R8, FIGURACORR
	MOV R9, FIGLIGADA
	MOV R3, ROTATECOUNTER
	MOV [R3], R4			; coloca os conteudos dos enderecos em registos
	MOV [R8], R7	
	MOV [R0], R1
	MOV [R6], R2
	MOV [R9], R10
	POP R9					; restora r9
	POP R8					; idem para r8
	POP R7					; idem para r7
	POP R6					; idem para r6
	POP R5					; idem para r5
	POP R4					; idem para r4
	POP R3					; idem para r3
	POP R2					; idem para r2
	POP R1					; idem para r1
	POP R0					; idem para r0
	RET						; retorna para o sitio onde foi chamado

;* -- move ----------------------------------------------------------------
;* 
;* Descrição: Rotina que testa se e necessario mover o tetramino
;*
;* Parâmetros: --
;* Retorna:  --  
;* Destrói: --   
move:
	PUSH R0					; para nao mexer no valor de r0	
	PUSH R1					; para nao mexer no valor de r1	
	PUSH R2					; para nao mexer no valor de r2		
	PUSH R3					; para nao mexer no valor de r3	
	PUSH R4					; para nao mexer no valor de r4	
	PUSH R5					; para nao mexer no valor de r5	
	PUSH R6					; para nao mexer no valor de r6	
	PUSH R7					; para nao mexer no valor de r7	
	PUSH R8					; para nao mexer no valor de r8	
	PUSH R9					; para nao mexer no valor de r9
	MOV R0, LINHACORR		; move os enderecos das variaveis para registos
	MOV R6, COLUNACORR
	MOV R8, FIGURACORR
	MOV R5, BUFFER
	MOV R1, [R0]			; move os conteudos das variaveis para registos
	MOV R2, [R6]
	MOV R7, [R8]
	MOVB R4, [R5]
	MOV R9, ULTIMO
	MOV R8, [R9]
	CMP R4, R8				; compara os conteudos de BUFFER e ULTIMO
	JZ 	int_down			; no caso de serem iguais nao mover o tetramino
	MOV R9, LEFT			
	CMP R4, R9				; comparar o valor da tecla premida para verificar se e a de mover para a esquerda
	JZ moveleft				; saltar para a mover o tetramino para a esquerda se for possivel
	MOV R9, RIGHT			
	CMP R4, R9				; comparar o valor da tecla premida para verificar se e a de mover para a direita
	JZ moveright			; saltar para a mover o tetramino para a direita se for possivel
	MOV R9, DOWN			
	CMP R4, R9				; comparar o valor da tecla premida para verificar se e a de mover para baixo
	JZ movedown				; saltar para a mover o tetramino para baixo se for possivel
	MOV R9, ROTATE
	CMP R4, R9				; comparar o valor da tecla premida para verificar se e a de rodar o tetramino
	JZ rotate				; saltar para a rodar o tetramino se for possivel
	JMP int_down			; nenhuma tecla premida
	
	
moveleft:					; move a tetramino para a esquerda se for possivel
	CALL apaga_peca			; apaga o tetramino corrente
	SUB R2, 1				; decrementa a coluna corrente para desenhar o tetramino um pixel a esquerda
	MOV R5, TESTE			; coloca o endereco de TESTE em r5
	MOVB [R5], R10			; atualiza a variavel TESTE para ficar a 1
	CALL peca				; chama a rotina para desenhar a peca
	MOV R5, TESTE			; coloca o endereco de TESTE de volta em r5
	MOVB [R5], R11			; atualiza a variavel de TESTE a 0
	MOV R5, MOV_VALIDO		; coloca o endereco da variavel em r5
	MOV R6, [R5]			; coloca o conteudo da variavel em r6
	AND R6, R6
	JZ NOPE_ESQ				; se o movimento nao for valido reescreve a peca onde estava antes
	CALL peca				; desenha a peca no sitio novo
	MOV R0, COLUNACORR		; atualiza o valor da COLUNACORR com o valor da coluna onde foi escrito o tetramino
	MOV [R0], R2			
	MOV R0, ULTIMO			
	MOV R9, 1H				
	MOV [R0], R9			; atualiza a variavel ULTIMO (ultima tecla a ser pressionada) com 1 (tecla de mover para a esquerda)
	JMP int_down			; ja nao tem que desenhar mais tetraminos
NOPE_ESQ:					; nao pode mover o tetramino para a esquerda
	ADD R2, 1				; atualiza COLUNACORR para o valor que tinha antes de ser pedido para mover
	CALL peca				; volta a desenhar a peca no mesmo sitio
	JMP int_down			; acabou de desenhar a peca

	
	
moveright:					; move o tetramino para a direita se for possivel
	CALL apaga_peca			
	ADD R2, 1
	MOV R5, TESTE
	MOVB [R5], R10
	CALL peca
	MOV R5, TESTE
	MOVB [R5], R11
	MOV R5, MOV_VALIDO
	MOV R6, [R5]
	AND R6, R6
	JZ NOPE_DIR
	CALL peca
	MOV R0, COLUNACORR
	MOV [R0], R2
	MOV R0, ULTIMO
	MOV R9, 3H
	MOV [R0], R9
	JMP int_down
NOPE_DIR:						; nao pode mover o tetramino para a direita
	SUB R2, 1
	CALL peca
	JMP int_down

int_down:						; ja acabou de mover o que tinha que mover e vai testar a interrupcao
	MOV R5, event_int1			; coloca o endereco de event_int1 em r5
	MOV R4, [R5]				; coloca em r4 o conteudo de event_int1 (0 ou 1)
	AND R4, R4
	JZ fim_move					; se a flag event_int1 for 0 nao pode descer
	MOV [R5], R11				; atualiza a flag para 0
	JMP movedown				; vai descer o tetramino
	JMP fim_move				; nao voltar a descer
	
movedown:						; move o tetramino para baixo se for possivel
	CALL apaga_peca
	ADD R1, 1
	MOV R5, TESTE
	MOVB [R5], R10
	CALL peca
	MOV R5, TESTE
	MOVB [R5], R11
	MOV R5, MOV_VALIDO
	MOV R6, [R5]
	AND R6, R6
	JZ NOPE_DOWN
	CALL peca
	MOV R0, LINHACORR
	MOV [R0], R1
	MOV R0, ULTIMO
	MOV R9, 6H
	MOV [R0], R9
	JMP int_down
	
	
	
NOPE_DOWN:							; nao pode mover o tetramino para baixo
	SUB R1, 1
	CALL peca
	MOV R2, FIGLIGADA
	MOV [R2], R11
	MOV R2, event_int1
	MOV [R2], R11
	JMP fim_move	
	
rotate:								; roda o tetramino se for possivel
	CALL apaga_peca
	MOV R9, ROTATECOUNTER
	MOV R0, [R9]
	MOV R9, 3
	CMP R0, R9
	JZ 	tras
	ADD R7, 2
	MOV R9, ROTATECOUNTER
	MOV R0, [R9]
	ADD R0, R10
	MOV [R9], R0
	JMP rotest

	
	
tras:	                             ;volta para o primeiro objeto da tabela
	MOV R9, ROTATECOUNTER
	MOV [R9], R11
	SUB R7, 6
rotest:	                             ;testa a rotação do objeto
	MOV R5, TESTE
	MOVB [R5], R10
	CALL peca
	MOV R5, TESTE
	MOVB [R5], R11
	MOV R5, MOV_VALIDO
	MOV R6, [R5]
	AND R6, R6                       ;verifica se o movimeto é válido
	JZ NOPE_ROT
PAINT:                               ;rotina que pinta o objeto se o movimento for válido
	CALL peca
	MOV R0, FIGURACORR
	MOV [R0], R7
	MOV R0, ULTIMO
	MOV R9, 2H
	MOV [R0], R9
	JMP int_down
NOPE_ROT:								; nao pode rodar o tetramino
	SUB R7, 2
	CALL peca
	JMP int_down	
	
	
fim_move:
	POP R9								; restora r9
	POP R8								; idem para r8
	POP R7								; idem para r7
	POP R6								; idem para r6
	POP R5								; idem para r5
	POP R4								; idem para r4
	POP R3								; idem para r3
	POP R2								; idem para r2
	POP R1								; idem para r1
	POP R0								; idem para r0
	RET									; retorna para o sitio onde foi chamado



;* -- peca ----------------------------------------------------------------
;* 
;* Descrição: Rotina escreve uma peca
;*
;* Parâmetros: 
;* Retorna:    
;* Destrói:    R7, R5, R4

peca:	
	PUSH R0								; para nao mexer no valor de r0	
	PUSH R1								; idem para r1
	PUSH R2								; idem para r2
	PUSH R3								; idem para r3
	PUSH R6								; idem para r6
	PUSH R8								; idem para r8
	PUSH R9								; idem para r9
	MOV R0, MOV_VALIDO					; coloca em r0 o endereco de MOV_VALIDO
	MOV R6, 1
	MOV [R0], R6						; atualiza MOV_VALIDO para 1
	MOV R0, 4							; inicializa r0 com o numero de colunas a desenhar
	MOV R6, 4							; inicializa r6 com o numero de linhas a desenhar
	MOV R3, [R7]						; coloca em r3 o valor do primeiro bit do tetramino
rot2:
	MOVB R5, [R3]						; coloca em r5 o valor do bit a escrever 
	CMP R5, R11							; se o bit for 0
	JZ skit								; saltar para skit, para nao escrever o pixel
	CALL escrevepixel					; se o bit for um escrever o pixel
	MOV R8, MOV_VALIDO					; colocar em r8 o endereco de MOV_VALIDO
	MOV R9, [R8]						; colocar em r9 o conteudo de MOV_VALIDO
	AND R9, R9							
	JZ fim_peca							; se for 0 nao pode mover

skit:	
	ADD R3, 1							; passar ao proximo bit do tetramino
	ADD R2, 1							; incrementar o numero da coluna a escrever agora
	SUB R0, 1							; retirar 1 ao numero de colunas que tem que escrever
	JNZ rot2							; se ainda nao escreveu as 4 colunas escrever a seguinte
	ADD R1, 1							; se ja escreveu as 4 colunas passa para escrever a proxima linha
	MOV R0, 4							; colocar as colunas a escrever de volta a 4
	SUB R2, 4							; colocar o numero da coluna que vai escrever agora de volta a 0
	SUB R6, 1							; decrementa o numero de linhas a desenhar
	JNZ rot2							; se ainda nao escreveu todas as 4 linhas continuar a escrever
fim_peca:	
	POP R9								; restora r9
	POP R8								; idem para r8
	POP R6								; idem para r6
	POP R3								; idem para r3
	POP R2								; idem para r2
	POP R1								; idem para r1
	POP R0								; idem para r0
	RET									; volta ao sitio onde foi chamada

	
	
	
;* -- apaga_peca ----------------------------------------------------------------
;* 
;* Descrição: Rotina atualiza a flag APAGA a 1, apaga a peca e volta a coloca-la a 0
;*
;* Parâmetros: R1, R2: valores da linha e da coluna a escrever
;* Retorna:    
;* Destrói:    R0
apaga_peca:								
	MOV R0, APAGA						; move o endereco da flag para r0
	MOV [R0], R10						; poe a flag a 1 (valor de r10)
	CALL peca							; chama a rotina peca para a apagar
	MOV [R0], R11						; coloca a flag apaga de volta a 0 (valor de r11)
	RET									; retorna a onde foi chamada
	
escrevepixel:
	PUSH R0								; para nao mexer no valor de r0	
	PUSH R1								; idem para r1
	PUSH R2								; idem para r2
	PUSH R3								; idem para r3
	PUSH R4								; idem para r4
	PUSH R5								; idem para r5
	PUSH R6								; idem para r6
	PUSH R7								; idem para r7
	PUSH R8								; idem para r8
	PUSH R9								; idem para r9
	MOV R0, 8000H						; endereco do primeiro byte em r0
	MOV R9, 8							; inicializa r9 a 8 para a formula de obter o pixel
	MOV R8, 4							; inicializa r8 a 4 para a formula de obter o pixel
	MOV R6, R1							; copia o valor da linha para ser usado em teste
	MOV R3, R2							; copia o valor da coluna para ser usado em teste
	CALL FORM							; chama a rotina que faz a formula para obter o pixel a escrever
	MOD R2, R9							; calcula a posicao do bit dentro do byte
	ADD R0, R1
	MOV R4, mascaras
	ADD R2,R4
	MOV R7, TESTE
	MOVB R5, [R7]
	AND R5, R5
	JNZ teste                           ;testa se o movimento é possivel
	MOV R7, APAGA
	MOV R5, [R7]
	AND R5, R5
	JNZ apaga
	MOVB R7, [R0]
	MOVB R5, [R2]
	OR R7, R5
	MOVB [R0], R7
	JMP fim_pixel

apaga:                                   ;rotina para apagar os pixeis
	MOVB R3, [R0]
	MOVB R5, [R2]
	NOT R5
	AND R3, R5
	MOVB [R0], R3 
	JMP fim_pixel
teste:                                   ;testa os movimentos antes de serem excutados para que não haja sobreposição de peças
	MOV R7, 32
	CMP R7, R6 
	JZ NEXT
	MOV R7, 0
	CMP R3, R7
	JLT NOPE
	MOVB R7, [R0]
	MOVB R5, [R2]
	AND R7, R5
	JZ fim_pixel
	JMP NOPE
NEXT:
	MOV R5, FIGLIGADA
	MOV [R5], R11
NOPE:
	MOV R5, MOV_VALIDO
	MOV [R5], R11
	
fim_pixel: 									; restora os registos
	POP R9							
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET

	
;* -- FORM ----------------------------------------------------------------
;* 
;* Descrição: Rotina que obtem o byte a pintar
;*
;* Parâmetros: R1, R8, R9
;* Retorna:   R1
;* Destrói:   R1	
FORM:
	PUSH R2
	MUL R1, R8								; pega 
	DIV R2, R9								; divide 
	ADD R1, R2
	POP R2									; restora r2
	RET										; retorna para onde foi chamada



Cleaner:
	PUSH R0									; para nao mexer nos valores dos registos
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9
	MOV R0, FIGLIGADA						; coloca o endereco da variavel em r0
	MOV R1, [R0]							; coloca o conteudo da varivel em r1
	AND R1, R1								; ativa as flags
	JNZ end_cleaner							; se existirem figuras ligadas nao limpar
	MOV R0, 807CH							; colocar o endereco da ultima linha de jogo em r0
	MOV R2, 0FFF8H							; coloca em r2 o valor correspondente a uma linha completa
	MOV R5, 0008H							; coloca em r5 o valor correspondente a uma linha vazia (so com o bit da coluna)
	
cleancicle:
	MOV R4, [R0]							; coloca o byte da ultima linha de jogo em r4
	CMP R4, R2								; verifica se esta cheio
	JNZ test_zero							; se nao estiver vai verificar se estamos numa linha vazia
	CALL clear								; chama a rotina para uma linha de jogo completa
	MOV R8, pontuacao
	MOVB R9, [R8]
	ADD R9, 2
	MOVB [R8], R9
	CALL DISPLAY
	MOV R1, 8000H
	MOV [R1], R5
	JMP cleancicle							; volta a testar se a linha esta cheia
	
test_zero:	
	MOV R4, [R0]							; move para r4 o conteudo da ultima linha de jogo
	CMP R4, R5								; compara-o com uma linha vazia
	JZ end_cleaner							; se a linha estiver vazia sai da rotina 
	SUB R0, 4								; se nao estiver vazia vai verificar a linha acima
	MOV R4, 8000H
	CMP R4, R0
	JNZ cleancicle
	MOV R4, GAME_OVER
	MOV [R4], R10
	
end_cleaner:								; restaura os registos
	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0	
	RET
	
;* -- clear ----------------------------------------------------------------
;* 
;* Descrição: Rotina que limpa uma linha de jogo completa
;*
;* Parâmetros: 
;* Retorna:   
;* Destrói:   		
clear:
	PUSH R0									; para nao mexer nos valores de r0
	MOV [R0], R5							; limpa a linha cheia (mantendo a coluna)
	SUB R0, 4								; colocamos em r0 o endereco da linha acima
shift_down:
	MOV R7, [R0]							; move o conteudo da linha para r7
	MOV [R0], R5							; limpa a linha
	ADD R0, 4								; desce uma linha
	MOV [R0], R7							; escreve nessa linha o conteudo da anterior
	SUB R0, R5								; anda 2 linhas para cima (r5=8)
	MOV R7, [R0]							; move o conteudo da linha para r7
	AND R7, R5								; verifica se a linha esta limpa
	JNZ shift_down							; se nao estiver pode continuar a testar linhas (ainda existem linhas que contem tetraminos)
	POP R0									; restora r0
	RET										; volta para onde foi chamada

	
all_reset:                                  ;reinicia todos os parâmetros do jogo e todos os registos
	CALL LIMPA_PS
	MOV R0, 0
	MOV R1, LINHACORR
	MOV [R1], R0
	MOV R1, COLUNACORR
	MOV [R1], R0
	MOV R1, FIGURACORR
	MOV [R1], R0
	MOV R1, FIGLIGADA
	MOV [R1], R0
	MOV R1, APAGA
	MOV [R1], R0
	MOV R1, MOV_VALIDO
	MOV [R1], R0
	MOV R1, TESTE
	MOV [R1], R0
	MOV R1, BUFFER
	MOV [R1], R0
	MOV R1, ULTIMO
	MOV [R1], R0
	MOV R1, event_int1
	MOV [R1], R0
	MOV R1, ROTATECOUNTER
	MOV [R1], R0
	MOV R1, pontuacao
	MOV [R1], R0
	MOV R1, pause_mode
	MOV [R1], R0
	MOV R1, R0
	MOV R2, R0
	MOV R3, R0
	MOV R4, R0
	MOV R5, R0
	MOV R6, R0
	MOV R7, R0
	MOV R8, R0
	MOV R9, R0
	RET
	
DISPLAY:
	PUSH R0
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	MOV R0, pontuacao                        ;move o endereço da pontuação para o registo de R0
	MOVB R1, [R0]                            ;mover a pontuação para R1
	MOV R0, R1
	MOV R2, 10H
	MOV R3, 0AH
	MOV R5, 6H
	MOD R1, R2	
	CMP R1, R3
	JLT test_win
	ADD R0, R5
test_win:
	MOV R4, 99H
	CMP R0, R4
	JLT adds
	MOV R4, vitoria
	MOV [R4], R10
adds:	
	MOV R4, DISP
	MOVB [R4], R0
	MOV R1, pontuacao
	MOVB [R1], R0
	POP R5
	POP R4
	POP R3
	POP R2
	POP R1
	POP R0
	RET
	
	
LIMPA_PS:                               ;limpa todos os pixeis do ecrã
	PUSH R1
	PUSH R2
	PUSH R4
	MOV R2, 0H 
	MOV R1, 8000H                       ;coloca o primeiro endereço do ecrã em R1
	MOV R4, 807EH                       ;coloca o último endereço do ecrã em R1
ciclo_limpa:
	MOV [R1], R2
	CMP R1, R4
	JZ FIM
	ADD R1, 2
	JMP ciclo_limpa
FIM:
	POP R4
	POP R2
	POP R1
	RET	
	
	
;* -- gerador ----------------------------------------------------------------
;* 
;* Descrição: Rotina que serve de contador de vezes que o ciclo principal corre
;*
;* Parâmetros: CONTADOR - variavel que contem o numero de vezes que o ciclo principal corre 
;* Retorna:    CONTADOR
;* Destrói:    --	
gerador:
	PUSH R0				; para nao mexer no valor de r0	
	PUSH R1				; idem para r1	
	MOV R0, CONTADOR 	; R0 com o endereço de da variavel CONTADOR
	MOV R1, [R0] 		; R1 com o conteudo do endereço
	ADD R1, 1 			; incrementa o valor do contador
	MOV [R0], R1 		; move-o de volta para o endereço da variavel CONTADOR
	POP R1 				; restora o valor de r1
	POP R0				; idem para r0	
	RET					; retorna ao sítio onde foi chamada	

;* -- get_random ----------------------------------------------------------------
;* 
;* Descrição: Rotina que utiliza a variavel CONTADOR para gerar numeros pseudo-aleatorios entre 0 e 3, para escolher entre os tetraminos
;*
;* Parâmetros: --
;* Retorna:    R3 - valor aleatorio entre 0 e 3
;* Destrói:    R3		
get_random:										
	PUSH R1				; para nao mexer no valor de r1							
	MOV R1, CONTADOR	; move o endereço da variavel para r1 
	MOV R3, [R1]		; move o seu conteudo para R3
	MOV R1, 0003H		; mascara para retirar os 2 bits de menor peso
	AND R3, R1			; testa os 3 ultimos bits de R3, para obter um valor entre 0 e 3
	POP R1				; restora o valor de r1	
	RET					; retorna ao sítio onde foi chamada	
	

	
	
	
	
;* -- TECLADO ----------------------------------------------------------------
;* 
;* Descrição: Rotina que varre o teclado a procura de teclas premidas
;*
;* Parâmetros: 
;* Retorna:    
;* Destrói:    
TECLADO:
	PUSH R0				; para nao mexer no valor de r0	
	PUSH R1				; para nao mexer no valor de r1
	PUSH R2				; para nao mexer no valor de r2	
	PUSH R3				; para nao mexer no valor de r3
	PUSH R5				; para nao mexer no valor de r5
	MOV  R1, LINHA      ; testar a linha 4 
    MOV  R3, TIN		; R3 com o endereço de entrada do periférico
	MOV	 R2, TOUT		; R2 com o endereço de saída do periférico
ciclo:				   	; ciclo principal do programa
    MOVB [R2], R1      	; escrever no periférico de saída
    MOVB R0, [R3]      	; ler do periférico de entrada
    AND  R0, R0        	; afectar as flags (MOVs não afectam as flags)
    JZ 	salto         	; nenhuma tecla premida
	CALL CONV		   	; chama a rotina se existir uma tecla premida
	
	JMP fimt		   	; salta de volta ao inicio para verificar se a tecla é premida continuamente(também serve de breakpoint)
salto:	
	SHR R1, 1		   	; muda a linha que vai ser lida
	JNZ ciclo			; repete o ciclo enquanto r1 nao chega a zero
	MOV R5, BUFFER		; move para r5 o endereço da varivel BUFFER
	MOV [R5], R11		; atualiza o conteudo da variavel BUFFER para 0 (valor do r11)
	MOV R5, ULTIMO		; move para r5 o endereço da variavel ULTIMO
	MOV [R5], R11		; atualiza o conteudo da variavel ULTIMO para 0 (valor do r11)
fimt:
	POP R5				; restora o valor de r5
	POP R3				; restora o valor de r3
	POP R2				; restora o valor de r2
	POP R1				; restora o valor de r1	
	POP R0				; restora o valor de r0
	RET					; retorna ao sítio onde foi chamada	
	
; *********************************************************************************
; * ROTINAS																		  *
; *********************************************************************************
		
;* -- CONV ----------------------------------------------------------------
;* 
;* Descrição: Rotina que converte a linha/coluna de binário para um valor de 0 a 3 
;*
;* Parâmetros: R0 e R1 - valores binarios de linha e coluna da tecla premida
;* Retorna:    R2 e R3 - valores entre 0 e 3 da linha e coluna da tecla premida 
;* Destrói:    --
	
	
CONV:				   	
	PUSH R1			   	; para nao mexer no valor de r1	
	PUSH R0			   	; idem para r0
	PUSH R2			   	; idem para r2
	MOV R2, 0		   	; reinicializar r2 a 0
	MOV R3, 0		   	; idem para r3
loop1:				   	; verifica a posicao do bit a 1 da linha
	SHR R1, 1		   	; move o valor da linha 1 bit para a direita
	JZ loop2		   	; se r1 for 0 salta para o ciclo seguinte
	ADD R2, 1		   	; adiciona 1 ao valor final da linha
	JMP loop1		   	; salta para o inicio do loop
loop2:				   	; verifica a posicao do bit a 1 da coluna
	SHR R0, 1		   	; move o valor da coluna 1 bit para a direita
	JZ fim			   	; se r0 for 0 salta para o final da rotina
	ADD R3, 1		   	; adiciona 1 ao valor final da coluna
	JMP loop2		   	; salta para o inicio do loop
fim:	
	CALL FORM_TECLADO	; chama a rotina que devolve o valor hexa da tecla
	MOV R2, BUFFER
	MOVB [R2], R3
	POP R2			   	; idem para r2
	POP R0			   	; idem para r0
	POP R1			   	; idem para r1
	RET					; retorna ao ciclo principal
	
;* -- FORM_TECLADO ----------------------------------------------------------------
;* 
;* Descrição: Rotina que os valores obtidos na função CONV e os transforma num único valor hexadecimal
;*
;* Parâmetros: R2 e R3 - valores entre 0 e 3 correspondentes à linha e coluna da tecla 
;* Retorna:    R3 - valor hexadecimal da tecla premida  
;* Destrói:    R2 e R3
	
FORM_TECLADO:					
	PUSH R8				; para nao mexer no valor de r8
	MOV R8, MULT		; permite utilizar o valor MULT na formula
	MUL R2, R8			; multiplica o valor da linha por 4 
	ADD R3, R2			; adiciona a linha e coluna, retornando o valor hexa da tecla
	POP R8				; restora o valor de r8
	RET					; retorna ao sítio onde foi chamada	
	
	
;**************************************	
	
int1:
	PUSH R0
	PUSH R1
	MOV R1,1
	MOV R0,event_int1    ;flag de ocorrencia da interrupção 1
	MOV [R0],R1
	POP R1
	POP R0
	RFE	

	
;*************************************************************



		