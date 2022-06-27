        .include  "inter.inc"
	.include "notas.inc"
	.include "melodiaCuna.inc"
	
bitson: .word 0
ledst: .word 0
patron: .word 0
cuenta: .word 1 
secuen:
/*Estrofa8*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/*Estrofa7*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000010000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/*Estrofa6*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/*Estrofa5*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000010000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/*Estrofa4*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/*Estrofa3*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000010000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 
	
/*Estrofa2*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000100000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo	
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde 

/* Estrofa1*/
/* guia bits    7654321098765432109876543210*/
	.word 0b0000000000000000001000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo & Led1 Rojo
	.word 0b0000000000000000010000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo & Led2 Rojo
	.word 0b0000000000100000000000000000 @Led6 Verde & Led5 Verde & Led4 Amarilllo & Led3 Amarillo
	.word 0b0000010000000000000000000000 @Led6 Verde & Led5 Verde
	.word 0b1000000000000000000000000000 @Led6 Verde  
	
indice: .word 0

.text

/* Agregamos vectores de interrupcion */
	ADDEXC 0x18, irq_handler
	ADDEXC 0x1c, fiq_handler
	 mrs r0, cpsr
	  mov r0, #0b11010011 @Modo SVC, FIQ&IRQ desact
	  msr spsr_cxsf, r0
	  add r0, pc, #4
	  msr ELR_hyp, r0
	  eret

/* Inicializo la pila en modos FIQ, IRQ y SVC */
	mov r0, # 0b11010001 @ Modo FIQ, FIQ & IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x4000
	mov r0, # 0b11010010 @ Modo IRQ, FIQ & IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x8000
	mov r0, # 0b11010011 @ Modo SVC, FIQ & IRQ desact
	msr cpsr_c, r0
	mov sp, # 0x8000000

/* Configuro GPIOs 4, 9, 10, 11, 17, 22 y 27 como salida */
	ldr r0, = GPBASE
	/*guia bits xx999888777666555444333222111000*/
	ldr r1, = 0b00001000000000000001000000000000
	str r1, [r0, #GPFSEL0]
	/*guia bits xx999888777666555444333222111000*/
	ldr r1, = 0b00000000001000000000000000001001
	str r1, [r0, #GPFSEL1]
	/*guia bits xx999888777666555444333222111000*/
	ldr r1, = 0b00000000001000000000000001000000
	str r1, [r0, #GPFSEL2]

/* Programo contador C1 y C3 para futura interrupcion */
	ldr r0, =STBASE
	ldr r1, [r0, #STCLO]
	add r1, # 2
	str r1, [r0, #STC1]
	add r1, #2
	str r1, [r0, #STC3]

/* Habilito interrupciones, local y globalmente */
/* Habilito C1 para IRQ */
	ldr r0, = INTBASE
	mov r1, #0b0010
	str r1, [r0, #INTENIRQ1]
	/*guia bits   xx999888777666555444333222111000*/
	mov r1, #0b00000000001000000000000000000000

/* Habilito C3 para FIQ */
	mov r1, #0b10000011
	str r1, [r0, #INTFIQCON]

/* Habilito interrupciones globalmente */
	mov r0, # 0b00010011 @ Modo SVC, FIQ & IRQ activo
	msr cpsr_c, r0

	ldr r1, =patron
	mov r2, #1
	mov r4, #2
	ldr r0, =GPBASE

bucle :	
	ldr r3,[r0,#GPLEV0] @Boton izquierdo GPIO2 
	/* guia bits 10987654321098765432109876543210*/
	ands r3,#0b00000000000000000000000000000100
	streq r2, [r1]

	ldr r3,[r0,#GPLEV0] @Boton derecho GPIO3
	/* guia bits 10987654321098765432109876543210*/
	ands r3,#0b00000000000000000000000000001000
	streq r4, [r1]
	
	b bucle

irq_handler :
	push { r0, r1, r2, r3, r4, r5, r6, r7 }

	ldr r0, = GPBASE
	ldr r6, =STBASE
	ldr r2, =patron

	ldr r1, [r2]
	cmp r1, #2 @Salta si r1 = 0 
	beq ledsBotonDerecho

ledsBotonIzquierdo:
	ldr r1, = cuenta
	/* Apago todos LEDs */
	/*guia bits 10987654321098765432109876543210*/
	ldr r2, = 0b00001000010000100000111000000000
	str r2, [r0, # GPCLR0]
	
	ldr r2, [r1] @ Leo variable cuenta
	subs r2, # 1 @ La decremento
	moveq r2, # NUMNOTAS @ Si es 0, volver a NUMNOTAS
	str r2, [r1] @ Escribo cuenta
	ldr r2, [r1, r2, LSL #2] @ Leo secuencia
	str r2, [r0, # GPSET0] @ Escribo secuencia en LEDs
	b altavoz
	
ledsBotonDerecho:
	ldr r1, =ledst
	ldr r2, [r1] @ Leo variable 
	eors r2, #1 @ Invierto bit 0 
	str r2, [r1] @ Escribo variable
	/*guia bits 10987654321098765432109876543210*/
        ldr r1, = 0b00001000010000100000111000000000
        streq	r1, [r0, #GPSET0] @ Enciendo LED
	strne	r1, [r0, #GPCLR0] @ Apago LED
	b altavoz

/*Duracion del altavoz*/
altavoz:
	ldr r3, =indice 
	ldr r5, =duratFS 
	ldr r7, [r3]
	add r7, #1 @ incremento el contador
	cmp r7, #NUMNOTAS @Compruebo: si es 36, entonces vuelve a 0
	moveq r7, #0
	ldr r4, [r5, r7, LSL #2]@ leo secuencia notas
	str r7, [r3] 

/* Reseteo estado interrupción de C1 */
	mov r2, # 0b0010
	str r2, [r6, # STCS]

/* Programo siguiente interrupción dependiendo de la duracion de la nota */
	ldr r2, [r6, #STCLO]
	add r2, r4
	str r2, [r6, #STC1]

/*  Desactivo  los  dos  flags  GPIO  pendientes  de  atención*/
	/*guia bits   10987654321098765432109876543210*/
	mov r1, #0b00000000000000000000000000001100
	str      r1, [r0, #GPEDS0]

/* Recupero registros y salgo */
	pop { r0, r1, r2, r3, r4, r5, r6, r7 }
	subs pc, lr, #4

/* Rutina de tratamiento de interrupción FIQ */
fiq_handler :
	ldr r8, = GPBASE
	ldr r9, = bitson
	ldr r11, =indice

/* Hago sonar altavoz invirtiendo estado de bitson */
	ldr r10, [r9]
	eors r10, #1
	str r10, [r9]

/* Leo notas y luego el elemento correspondiente en notaFS */
	ldr r9, [r11]
	ldr r10, =notaFS @Cargo nota correspondiente
	ldr r12, [ r10, r9, LSL # 2]

/* Pongo estado altavoz según variable bitson */
	mov r10, # 0b10000 @ GPIO 4 (altavoz)
	streq r10, [r8, #GPSET0]
	strne r10, [r8, #GPCLR0]

/* Reseteo estado interrupción de C3 */
saltoSilencio:
	ldr r8, = STBASE
	mov r10, #0b1000
	str r10, [r8, #STCS]

/* Programo retardo según valor leído en array */
	ldr r10, [r8, #STCLO]
	add r10, r12
	str r10, [r8, #STC3]

/* Salgo de la RTI */
	subs pc, lr, #4

