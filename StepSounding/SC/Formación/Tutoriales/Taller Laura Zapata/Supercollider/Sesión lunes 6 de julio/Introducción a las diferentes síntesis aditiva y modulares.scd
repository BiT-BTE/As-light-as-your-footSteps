//SÍNTESIS ADITIVA





{SinOsc.ar(440,0,1)+SinOsc.ar(110,0,1)}.scope




el concepto de síntesis aditiva nace en la edad media gracias a la búsqueda tímbrica en los órganos tubulares.

La síntesis aditiva se constituyó como uno de los primeros métodos para la búsqueda de espectros sonoros más ricos.


en resumidas cuentas la síntesis aditiva es la sumatoria de ondas, donde, entre más ondas sumadas más rico es el espectro armónico. En sentido estricto podemos sumar cualquier tipo de onda.



//SÍNTESIS MODULARES






La modulación refiere al fenómeno acústico que dada dos señales de onda, una varía de acuerdo a las características de la segunda y como resultado se obtiene un nuevo tipo de onda.

A la primera onda se le denomina portadora y la segunda moduladora, a la onda resultante, señal modulada. Esta síntesis permite enriquecer el sonido.

Dependiendo de cómo se conectan el portador y el modulador, hay una variedad de métodos de uso común.

La síntesis de modulación es fácil de implementar, proporcionando atajos computacionalmente eficientes a espectros dinámicos complejos. Los métodos también tienen sus propios sonidos únicos, que pueden ser musicalmente útiles.

En este tutorial usaré algunas interfaz GUI para darle controles a los parámetros de la síntesis; Esto se debe a que podemos tener más de 2 controles. A su debido tiempo, aprenderemos más sobre la construcción de GUI.





En anillo

{SinOsc.ar(440,0,1)*SinOsc.ar(110,0,1,0)}.scope


AM

{SinOsc.ar(440,0,SinOsc.ar(110,0,1))}.scope


FM

{SinOsc.ar(440+SinOsc.ar(110,0,1),0,1)}.scope

