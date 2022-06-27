# RaspberryPi-Lullaby

### Funcionalidades del projecto
1) Reproductor de la melodía "Duérmete niño, duérmete ya" utilizando dos arrays, uno que contiene las notas y otro su duración. [More info](https://github.com/MarkosHB/RaspberryPi-Lullaby/blob/main/Source%20Code/melodiaCuna.inc).

2) Encendido de leds síncrono con la melodía, de manera que cada vez que se acabe una estrofa se volvera a comenzar de izquierda a derecha (de los leds verdes a los rojos).
	- Esta decisión de diseño se debe a que los niños se relajarán más fácilmente si ven como los leds se apagan y encienden suavemente.
	- No es necesariamente un encendido secuencial, más bien es un intento de hacer un efecto de "barra de cargado" que se va llenando y vaciando.

3) Uso de los botones: 
	* **Botón1**. Se modifica el comportamiento de los leds para que se se enciendan y apaguen todos los leds a la vez con cada una de las notas que suenen.
	* **Botón2**. Se restablece el comportamiento descrito anteriormente en el punto dos. Se puede decir que el sistema arranca con este botón activado.

### Hardware empleado
  <img src='https://github.com/MarkosHB/RaspberryPi-Lullaby/blob/main/placa-de-expansion.jpg' width="350" height="350"> </img>
  <img src='https://github.com/MarkosHB/RaspberryPi-Lullaby/blob/main/raspberry-pi-3.jpg' width="350" height="350"> </img>
