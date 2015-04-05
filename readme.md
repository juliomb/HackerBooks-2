# Práctica de iOS Fundamentos KeepCoding

**Alumno:** Julio Martínez Ballester

**Fecha de entrega:** 05-04-2015

## HackerBooks

Lector de libros en PDF para iPhone/iPad.

##Cuestiones

###Procesado del JSON
*1 - Mira en la ayuda en método* **isKindOfClass:** *y como usarlo para saber qué te han devuelto exactamente. ¿Qué otros métodos similares hay? ¿En qué se distingue* **isMemberOfClass:** *?*

Se podría conseguir diferenciar si un objeto es de una clase o de otra de varias formas: 

- Usando el método **description** del objeto.
- Preguntado **respondsToSelector** con algún método exclusivo de esa clase.
- Incluso diferenciarlo de otras si implementa algún protocolo con **conformsToProtocol**


El método **isMemberOfClass** te devolvería verdadero **sólo** si es una instacia de la clase pasada por parámetro, con **isKindOfClass** también te devolvería verdadero si le pasas una de las clases de las que hereda el objeto.

<br>

###Tabla de libros

*2 - El ser o no favorito se indicará mediante una propiedad booleana de AGTBook y esto se debe de guardar en el sistema de ficheros y recuperar de alguna forma. Es decir, esa información debe de persistir de alguna manera cuando se cierra la App y cuando se abre.*
*¿Cómo harías eso? ¿Se te ocurre más de una forma de hacerlo? Explica la decisión de diseño que hayas tomado.* 

Para implementar esta funcionalidad he incluido un icono con forma de estrella en el *ViewController* de los libros. Si la estrella está vacía el libro, no es favorito; si está rellena, lo es.

Al pulsar sobre el icono, se ejecuta el método target/action asociado que modifica el modelo. El modelo simplemente añade un tag llamado *favorito* al su lista de tags, pone su propiedad booleana *isFavorite* a YES.

Para persistir los datos he creado un método llamado *updateLibraryWithBook* en un controlador diseñado para apilar todos estos métodos que no encajan muy bien en las clases ya creadas. Este método modifica el JSON almacenado sustituyendo únicamente el diccionario modificado por la nueva versión y vuelve a almacenarlo.

<br>

*3 - Cuando cambia el valor de la propiedad isFavorite de un AGTBook, la tabla deberá reflejar ese hecho. ¿Cómo lo harías? Es decir, ¿cómo enviarías información de un AGTBook a un AGTLibraryTableViewController? ¿Se te ocurre más de una forma de hacerlo? ¿Cual teparece mejor? Explica tu elección.*

La solución que he implementado es que al modificar su propiedad *isFavorite*, el modelo envía una notificación de que ha cambiado. Esta notificación es recogida por la tabla, que recarga sus datos para mostrar los cambios. A su vez, el *BookViewController* también recibe la notificación y modifica su icono de la estrella.

Podríamos hacer que el *BookViewController* modificase el mismo su icono al pulsar sobre la estrella, y que el *BookTableViewController* fuera delegado del modelo. Me he decantado por la primera opción porque normalmente se escogen las notificaciones para estos casos, ya que podría haber más controladores interesados en la información de que ha cambiado el modelo. Además nos cargaríamos el principio de "single responsability" si el método target/action modifica el modelo y la vista.

<br>

*4 - Para que la tabla se actualice, usa el métodoreloadData de UITableView. Esto hace que la tabla vuelva a pedir datos a su dataSource. ¿Es esto una aberración desde el punto de rendimiento (volver a cargar datos que en su mayoría ya estaban correctos)? Explica por qué no es así. ¿Hay una forma alternativa? ¿Cuando crees que vale la pena usarlo?*

No es un aberración por dos motivos:

- Sólo se cargan las celdas visibles y las más próximas.
- Se reusan las celdas ya creadas.

Podrías modificar sólo las celdas que han cambiado, pero resulta más tedioso y complejo. Vale la pena usar el método cuando cambia el modelo de la tabla.


### Controlador de PDF: AGTSimplePDFViewController

*5 - Cuando el usuario cambia en la tabla el libro seleccionado, el AGTSimplePDFViewController debe de actualizarse. ¿Cómo lo harías?*

La tabla ya tiene de delegado al *BookViewController* así que no nos queda más remedio que usar notificaciones. Al seleccionar una nueva celda se envía la noticación, esta es recibida por el *SimplePDFViewController*, que carga el nuevo pdf.

## Comentarios
El controlador *DownloadController* lo he creado un poco siguiendo la filosofía de apilar toda la basura junta, ya que los métodos que contiene los veía encajar en ninguna de las clases. También he definido todas las constantes en el fichero *Settings.h*. ¿Son ambas buenas soluciones o se podría hacer algo más elegante?.