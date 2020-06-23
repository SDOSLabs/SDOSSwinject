## [HEAD]

- Add new parameter named "dependencies". This parameter allow link against other dependencies .json files and generate an access to resolvers mor clean
- Add feature for support xcfilelist in input files. This is for indicate all .json files of subdependencies that affects to the generated file
- Add support for multilevel dependencies in son files

## [1.2.0 News parameters - override register](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.2.0)

- Añadidos nuevos parámetros al json de generación para facilitar el sobrescribir el registro de una dependencia: 
  - `config.suffixName`: Añade un sufijo al nombre de todos los métodos autogenerados. Esto es útil cuando se quiere sobrescribir un registro de dependencias con un nuevo fichero .json. Esta propiedad no afecta al registro ni la resolución de la dependencia` 
  - `body.onlyRegister`: Indica que sólo se debe crear el método de registro para esta dependencia. Esto es útil cuando estemos sobrescribiendo el registro de la dependencia en un nuevo fichero .json, por lo que la resolución de la dependencia ya estaría creada

## [1.1.0 Naming and default values](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.1.0)

- Modificado el nombre del registro del método de las dependencias. Ahora incluye los nombres de los parámetros para que sean métodos únicos
- Añadido nuevo parámetro para poner un valor por defecto a los argumentos de las dependencias

## [1.0.6 Validate input and output files](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.6)

- Se ha arreglado un error por el que la validación de los inputs y output files no funcionaban correctamente si la ruta contenia "../"
- Arreglado mensaje de log incorrecto

## [1.0.5 Validate input and output files](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.5)

- Se ha arreglado un error por el que la validación de los inputs y output files no funcionaban correctamente si la ruta contenia "../"

## [1.0.4 Custom init y validate input and output files](https://github.com/SDOSLabs/SDOSSwinject.git/tree/v1.0.4)

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
