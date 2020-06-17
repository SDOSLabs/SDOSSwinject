- [SDOSSwinject](#sdosswinject)
  - [Introducción](#introducción)
  - [Instalación](#instalación)
    - [Cocoapods](#cocoapods)
  - [Cómo se usa](#cómo-se-usa)
    - [Errores comunes](#errores-comunes)
    - [Registro de dependencias](#registro-de-dependencias)
    - [Resolución de dependencias](#resolución-de-dependencias)
    - [Estructura del fichero generado](#estructura-del-fichero-generado)
  - [JSON](#json)
  - [Dependencias](#dependencias)
  - [Referencias](#referencias)

# SDOSSwinject

- Enlace confluence: https://kc.sdos.es/x/RQPLAQ
- Changelog: https://github.com/SDOSLabs/SDOSSwinject/blob/master/CHANGELOG.md

## Introducción
SDOSSwinject es un script que parsea un JSON para generar código Swift para el registro y la resolución de dependencias con la librería Swinject. Se ha optado por esta solución ya que el registro y la resolución de dependencias son implementaciones separadas pero que necesitan ser consecuentes (para un registro sólo hay un tipo de resolución). La implementación manual podía contener errores que son impercetibles en tiempo de compilación y haría que las aplicaciones fallaran en tiempo de ejecución.

## Instalación

### Cocoapods

Usaremos [CocoaPods](https://cocoapods.org).

Añadir el  "source" al `Podfile`:
```ruby
source 'https://github.com/SDOSLabs/cocoapods-specs.git'
```

Añadir la dependencia al `Podfile`:

```ruby
pod 'SDOSSwinject', '~>2.0.0' 
```

## Cómo se usa

Para hacer uso de la librería se debe lanzar un script durante la compilación que generará el fichero `.swift` con el registro y la resolución de dependencias que deberá añadirse al proyecto. Para ello hay que seguir los siguientes pasos:

1. Crear los fichero `Dependencies.json`, `UI.json`, `BL,json` y `Repository.json` en la ruta `${SRCROOT}/main/resources/dependencies` a Xcode. Estos ficheros **no se debe incluir al target** ya que no es necesario que se incluya en el binario de la aplicación. Copiar el siguiente código en cada uno para crear un fichero básico:

*Dependencies.json*
```json
{
    "dependencies": [
        "UI.json",
        "BL.json",
        "Repository.json"
    ]
}
```

*UI.json*
```json
{
    "headers": [
        "typealias NavigationController = UINavigationController"
    ],
    "body": [
        {
            "dependencyName": "NavigationController",
            "className": "UINavigationController",
            "arguments": [
                {
                    "name": "rootViewController",
                    "type": "UIViewController"
                }
            ]
        }]
}
```

*BL.json*
```json
{
    "body": [
        ]
}
```

*Repository.json*
```json
{
    "body": [
        ]
}
```

Nota: Esta estructura es la que sugerimos desde el departamento. Podríamos trabajar úncamente con un fichero `.json`, tal y como hacíamos en versiones anteriores de la librería. Esta estructura nos permite la separación de las dependencias en diferentes ficheros, permitiendo un nivel de ordenación más claro.

2. Crear el fichero `Dependencies.xcfilelist` en la ruta `${SRCROOT}/main/resources/dependencies` a Xcode. Este fichero **no se debe incluir al target** ya que no es necesario que se incluya en el binario de la aplicación. Deberá tener el siguiente contenido:
```bash
#===================================
${SRCROOT}/main/resources/dependencies/Repository.json
${SRCROOT}/main/resources/dependencies/BL.json
${SRCROOT}/main/resources/dependencies/UI.json
#===================================
```
Este fichero habrá que modificarlo si añadimos nuevos ficheros `.json` de dependencias

3. En Xcode: Seleccionar el proyecto, elegir el TARGET, selccionar la pestaña de `Build Phases` y pulsar en añadir `New Run Script Phase` en el icono de **`+`** arriba a la izquierda
4. Arrastrar el nuevo `Run Script` justo antes de `Compile Sources`
5. (Opcional) Renombrar el script a `SDOSSwinject - Create dependencies`
6. Copiar el siguiente script:
    ```sh
    "${PODS_ROOT}/SDOSSwinject/src/Scripts/SDOSSwinject" -i "${SRCROOT}/main/resources/dependencies/Dependencies.json" -o "${SRCROOT}/main/resources/generated/DependenciesGenerated.swift"
    ```
    <sup><sub>Los valores del script pueden cambiarse en función de las necesidades del proyecto</sup></sub>
7. Añadir la siguiente líneas al apartado `Input Files`. **No poner comillas**:
   - `${SRCROOT}/main/resources/dependencies/Dependencies.json`
8. Añadir la siguiente líneas al apartado `Input File Lists`. **No poner comillas**:
   - `${SRCROOT}/main/resources/dependencies/Dependencies.xcfilelist`
9. Añadir la siguiente líneas al apartado `Output File`. **No poner comillas**:
   - `${SRCROOT}/main/resources/generated/DependenciesGenerated.swift`
10. Compilar el proyecto. Esto generará el fichero en la ruta del paso anterior y deberá ser incluido al target del proyecto

Además de estos pasos el script tiene otros parámetros que pueden incluirse en base a las necesidades del proyecto:

|Parámetro|Obligatorio|Descripción|Ejemplo|
|---------|-----------|-----------|-----------|
|`-i [fichero.json]`|[x]|Ruta del fichero de entrada. Debe ser un .json | `${SRCROOT}/main/resources/dependencies/Dependencies.json`|
|`-o [fichero.swift]`|[x]|Ruta del fichero de salida. Debe incluir el nombre del fichero a generar|`${SRCROOT}/main/resources/generated/DependenciesGenerated.swift`|
|`--disable-input-output-files-validation`||Deshabilita la validación de los inputs y outputs files. Usar sólo para dar compatibilidad a `Legacy Build System` |
|`--unlock-files`||Indica que los ficheros de salida no se deben bloquear en el sistema|

La ejecución del script genera un fichero `.swift` que contiene todos los registros del gestor de dependencias y sus resoluciones. **Estas funciones las debe invocar el desarrollador cuando sea necesario**.

### Errores comunes

Para la correcta utilización de la librería es muy importante que el script que declaremos en el `Build Phases` tenga correctamente los valores `Input Files`, `Input File Lists` y `Output File`. Estos valores indican cuales son los ficheros de que el script debe tomar como datos de entrada (`Input`) y cuales son los ficheros que genera (`Output`). Si estos valores no está correctamente seteados la ejecución del script podrá dar un error indicando que falta alguno y sugiriendo que hay que añadir para solucionar el problema

### Registro de dependencias

El fichero `.swift` contiene todos los registros de las dependencias incluidas en el/los ficheros `.json`. El desarrollador debe registrarlas manualmente durante la inicialización del gestor de dependencias. Lo puede hacer de forma individual o registrando todas con la siguiente función:
```js
let container = Container()
container.registerAll()
```
Una forma de disponer del gestor de dependencias completo sería la siguiente
```js
import Foundation
import Swinject

struct Dependency {
    private init() { }
    static let injector: Container = {
        let container = Container()
        container.registerAll()
        
        return container
    }()
}
```

De esta forma con la llamada `Dependency.injector` obtenemos el objeto con todas las dependencias registradas y disponibles para resolver.

### Resolución de dependencias

Al incluir el nuevo concepto de dependencias anidadas dentro de los `.json` de dependencias hay un cambio a la hora de resolver las dependencias dependiendo si son declaradas en el fichero root (`Dependencies.json`) o en una dependencia hija (cualquier dependencia que esté contenida dentro de `Dependencies.json`)

- **Resolución desde el fichero root**. En este caso la dependencia se crea directamente en una extensión de la clase `Resolver` de la librería `Swinject`, lo que nos permite usar el objeto `injector` para acceder a la resolución:
```js
Dependency.injector.resolveNavigationController(rootViewController: UIViewController())
```
Este es el mismo caso que en versiones anteriores de la librería

- **Resolución desde una dependencia hija**. En este caso la dependencia se crea en un `struct` nuevo que se nombrará como el fichero `.json` seguido de la palabra `Resolver` (Para el fichero `UI.json` se creará un `struct` llamado `UIResolver`). También se creará una variable computada en una extensión de la clase `Resolver` para que podamos acceder a la resolución de la dependencia:
```js
Dependency.injector.UI.resolveNavigationController(rootViewController: UIViewController())
```
En el ejemplo que tratamos en está documentación la resolución será como se indica en este segundo caso

### Estructura del fichero generado

Cuando tenemos las dependencias definidas en los diferentes ficheros `.json` se crea la siguiente estructura dentro del fichero de generación:

```js

//========================================================

//Dependencia Root

// - Extension de la clase "Container" con un método con todos los registros de dependencias (tanto propias como hijas). Este método  en la dependencia Root contendrá TODOS los registros, por lo que será el único necesario para registrar todas las dependencias.

// - Extensión de la clase "Resolver" con la resolución de las dependencias definidas en el fichero (no dependencias hijas)

// - Extensión de la clase "Container" con el registro de las dependencias definidas en el fichero (no dependencias hijas)

//========================================================


//Dependencias hijas - Se repite por cada dependencia hija de forma recursiva

// - Extension de la clase "Container" con un método con todos los registros de dependencias (tanto propias como hijas)

// - Extensión de la clase "Resolver" con la creación de una variable computada que tendrá el nombre del fichero .json

// - Nuevo struct con el nombre del fichero .json seguido del sufijo "Resolver" que contendrá la resolución de las dependencias definidas en el fichero (no dependencias hijas)

// - Extensión de la clase "Container" con el registro de las dependencias definidas en el fichero (no dependencias hijas)

//========================================================

```

## JSON

La librería se apoya en un JSON para generar el código `.swift`. Este JSON tiene la siguiente estructura

```json
{
    "config": {
        "name": "string",
        "globalAccessLevel": "string",
        "registerAllAccessLevel": "string",
        "suffixName": "string"
    },
    "dependencies": [
        "string"
    ],
    "headers": [
        "string"
    ],
    "body": [
        {
            "dependencyName": "string",
            "className": "string",
            "name": "string",
            "scope": "string",
            "accessLevel": "string",
            "initName": "string",
            "onlyRegister": bool,
            "arguments": [
                {
                    "name": "string",
                    "type": "string",
                    "defaultValue": "string"
                }
            ]
        }]
}
```

|Parámetro|Obigatorio|Descripción|Ejemplo|
|---------|----------|-----------|-------|
|`config`||Apartado de configuración general de las dependencias||
|`config.name`||Nombre que se usará como sufijo de todo el código autogenerado. El uso más común es generar ficheros de dependencias diferentes por modúlos. Esta propiedad forma parte del registro y la resolución de la dependencia, ya que se añade como identificador de la misma|`Event`|
|`config.globalAccessLevel`||Nivel de acceso que se utilizará por defecto para los métodos de registro y resolución de dependencias|`public`|
|`config.registerAllAccessLevel`||Nivel de acceso que se utilizará para el método registerAll. Tiene prioridad sobre `config.globalAccessLevel`|`public`|
|`config.suffixName`||Añade un sufijo al nombre de todos los métodos autogenerados. Esto es útil cuando se quiere sobrescribir un registro de dependencias con un nuevo fichero .json. Esta propiedad no afecta al registro ni la resolución de la dependencia|`Custom`|
|`headers`||Array de strings que se incluiran al inicio del fichero generado. Se usará para realizar imports de librerías o crear `typealias`.|`typealias NavigationController = UINavigationController`|
|`dependencies`||Array de strings que son rutas relativas hacia desde el propio fichero hacía otros ficheros `.json` de dependencias.|`BL.json` o `./BL.json` (Los dos casos son iguales)|
|`body`|[x]|Array de objetos. Cada uno de ellos es la definición de una dependencia. **Este array se ampliará cuando se añadan nuevas dependencias**||
|`body.dependencyName`|[x]|Tipo de la dependencia a injectar. Por lo general será un protocolo|`NavigationController`|
|`body.className`|[x]|Nombre de la clase que se debe inicializar al solicitar la dependencia. Esta clase deberá contener un método init con los parámetros indicados en el valor `body.arguments`|`UINavigationController`|
|`body.name`||Nombre especifico para el registro de la dependencia. Este parámetro nos permite crear varios registros a la misma dependencia sin que se solapen los nombres de los métodos. Es útil cuando queremos registrar varias veces la misma dependencia con diferentes argumentos|`Test`|
|`body.scope`||Ámbito de resolución de la dependencia. Estos ámbitos son los [definidos en la librería Swinject](https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md). Valores disponibles: `transient`, (default) `graph`, `container`, `weak`|`container`|
|`body.accessLevel`||Nivel de acceso que se utilizará para los métodos de registro y resolución de la dependencia. Tiene prioridad sobre `config.globalAccessLevel`|`public`|
|`body.initName`||Indica el nombre del método que deberá llamarse para inicializar la clase |`shared`|
|`body.onlyRegister`||Indica que sólo se debe crear el método de registro para esta dependencia. Esto es útil cuando estemos sobrescribiendo el registro de la dependencia en un nuevo fichero .json, por lo que la resolución de la dependencia ya estaría creada|`true`|
|`body.arguments`||Array de argumentos que serán usados para el registro y la resolución de la dependencia||
|`body.arguments.name`|[x]|Nombre del argumento. Deberá coincidir con el nombre del argumento en su init|`rootViewController`|
|`body.arguments.type`|[x]|Tipo del argumento|`UIViewController`|
|`body.arguments.defaultValue`||Valor por defecto del argumento|`UIViewController.init()`|

## Dependencias
* [Swinject](https://github.com/Swinject/Swinject) - >= 2.6

## Referencias
* https://github.com/SDOSLabs/SDOSSwinject

