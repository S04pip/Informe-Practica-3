.data
	TensionControl: .word 0
	TensionEstado: .word 0
	TensionSistol: .word 0
	TensionDiastol: .word 0
	sistolMax: .word 181
	diastolMax: .word 121
	msjSistol: .asciiz "Tension sistol: "
	msjDiastol: .asciiz "\nTension Diasol: "
	fin: .asciiz "fin"
.text
.globl main
main:
	jal controlador_tension
	
	li $v0,4
	la $a0, msjSistol	#imrpime mensaje indicando el tipo de tension
	syscall
	
	li $v0,1
	lw $a0, TensionSistol	#imprime la tension sistolica
	syscall
	
	li $v0,4
	la $a0, msjDiastol	#imrpime mensaje indicando el tipo de tension
	syscall
	
	li $v0,1
	lw $a0, TensionDiastol	#imprime la tension sistolica
	syscall
	
	li $v0,10
	syscall

controlador_tension:
	li $t0,1
	sw $t0,TensionControl #inicia la medicion
	
	li $v0, 42		#calcula la tension sistolica
	lw $a1, sistolMax	#en un rango de 0 a 180
	syscall
	
	sw $a0, TensionSistol	#guarda el valor de la tension sistolica
	
	li $v0, 42		#calcula la tension diastolica
	lw $a1, diastolMax	#en un rango de 0 a 120
	syscall
	
	sw $a0, TensionDiastol		#guarda el valor de la tension diastolica
	
	lw $v0,TensionSistol		#carga el valor de la tension sistolica en $v0
	lw $v1,TensionDiastol		#carga el valor de la tension diastolica en $v1
	
	sw $t0,TensionEstado		#los resultados estan listos
	
	jr $ra
	