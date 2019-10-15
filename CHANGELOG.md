## [HEAD]

- Se ha añadido un nuevo parámetro para definir el nombre del método init que se debe invocar al resolver la dependencia
- Se ha arreglado un error por el que la validación de los inputs y output files no funcionaban correctamente si la ruta contenia "../"

## [1.0.3 Niveles de acceso](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.3)

- Se han añadido nuevos parámetros para permitir definir los niveles de acceso de los métodos de registro y resolución de las dependencias, tanto a nivel global como para una dependencia específica

## [1.0.2 Documentación](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.2)

- Modificada la forma de bloquear los ficheros. Ahora les quita el permiso de escritura

## [1.0.1 Documentación](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.1)

- Cambios en la documentación

## [1.0.0 Documentación](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.0)

- Documentación de la librería

## [0.9.4 Implementado código de error al imprimir la ayuda](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v0.9.4)

- Cuando imprimimos la ayuda ahora el script finalizará con un código de error para parar la ejecución de los comandos

## [0.9.3 Añadido soporte para el nuevo Build System](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v0.9.3)

- Se ha añadido soporte para el nuevo Build System. Ahora es necesario poner las rutas correctas en los campos input files y output files
- Se han añadido nuevos parámetros para dar soporte al Legacy Build System. El parámetro --disable-input-output-files-validation elimina la validación de los input files y output files
- Por defecto los ficheros generados se bloquean en el sistema. Si se quiere que no se bloqueen se debe poner el parámetro --unlock-files

## [0.9.2 Eliminación de ficheros innecesarios](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v0.9.2)

- Se han eliminado ficheros innecesarios (Corrección)

## [0.9.1 Eliminación de ficheros innecesarios](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v0.9.1)

- Se han eliminado ficheros innecesarios

## [0.9.0 Primera versión de la librería](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v0.9.0)

- Primera versión de la librería
