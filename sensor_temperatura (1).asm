.globl main
.data
	tempMax: .word 100	#rango de temp 0-99
	rngMax: .word 2		#rango sensor 0-1
	SensorControl: .word 0
	SensorEstado: .word 0
	SensorDatos: .word 0
	msj: .asciiz "Temperatura: "
	salto: .asciiz "\n"
	
.text
main:
	jal InicializarSensor		#inicializa sensor
	jal LeerTemperatura	#lee e imprime la temperatura
	
fin: 
	li $v0, 10
	syscall
	
InicializarSensor:
	li $v0, 42		#genera un numero aleatorio
	lw $a1,rngMax		#entre 0 y rngMax
	syscall			#guarda numero en $a0
	sw $a0,SensorEstado	#guarda el estado del senaor en el registro sensorEst
	jr $ra
	
LeerTemperatura:
	beqz $a0, error		#si ha ocurrido un error entonces imprime -1
	li $t0, 0x2		#si el sensorEst esta activado entonces se inicializa el sensorCtrl 
	sw $t0,SensorControl	#se inicializa sensorCtrol
	
	li $v0,42		#genera un numero aleatorio (para la temperatura)
	lw $a1, tempMax		#entre 0 y tempMax
	syscall
	sw $a0,SensorDatos	#guarda el valor de la temepratura en sensorDat
	
	move $t0,$a0		#guarda la temperatura en $t0
	li $v0,4
	la $a0,msj		#imprime mensaje de msj
	syscall
	
	move $a0,$t0		#se restaura el dato de la temperatura
	li $v0,1
	syscall
	
	li $v0, 4
	la $a0,salto		#imrpime salto de linea
	syscall
	
	li $a0,0
	li $v0,1		#imprime 0 ya que leyo el dato corectamente
	syscall
	
	jr $ra			#retorna al prom¿grama principal
	
	
	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
error:
	li $a0, -1		#imprime -1 ya que hubo un error
	sw $a0,SensorEstado
	li $v0, 1
	syscall
	j fin
