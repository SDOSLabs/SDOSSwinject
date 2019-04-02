- [SDOSSwinject](#sdosswinject)
  - [Introducción](#introducci%C3%B3n)
  - [Instalación](#instalaci%C3%B3n)
    - [Cocoapods](#cocoapods)
  - [Cómo se usa](#c%C3%B3mo-se-usa)
  - [JSON](#json)
  - [Dependencias](#dependencias)
  - [Referencias](#referencias)

# SDOSSwinject

- Enlace confluence: https://kc.sdos.es/x/RQPLAQ

## Introducción
SDOSSwinject es un script que parsea un JSON para generar código Swift para el registro y la resolución de dependencias con la librería Swinject. Se ha optado por esta solución ya que el registro y la resolución de dependencias son implementaciones separadas pero que necesitan ser consecuentes (para un registro sólo hay un tipo de resolución). La implementación manual podía contener errores que son impercetibles en tiempo de compilación y haría que las aplicaciones fallaran en tiempo de ejecución.

## Instalación

### Cocoapods

Usaremos [CocoaPods](https://cocoapods.org). Hay que añadir la dependencia al `Podfile`:

```ruby
pod 'SDOSSwinject', '~>1.0.0' 
```

## Cómo se usa

Para hacer uso de la librería se debe lanzar un script durante la compilación que generará el fichero `.swift` con el registro y la resolución de dependencias que deberá añadirse al proyecto. Para ello hay que seguir los siguientes pasos:

1. Añadir el fichero `Dependencies.json` en la ruta `${SRCROOT}/main/resources/` a Xcode. Este fichero **no se debe incluir al target** ya que no es necesario que se incluya en el binario de la aplicación. Copiar el siguiente código para crear un fichero básico:
```json
{
    "config": {
        "name": null
    },
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
2. En Xcode: Seleccionar el proyecto, elegir el TARGET, selccionar la pestaña de `Build Phases` y pulsar en añadir `New Run Script Phase` en el icono de **`+`** arriba a la izquierda
3. Arrastrar el nuevo `Run Script` justo antes de `Compile Sources`
4. (Opcional) Renombrar el script a `SDOSSwinject - Create dependencies`
5. Copiar el siguiente script:
    ```sh
    "${PODS_ROOT}/SDOSSwinject/src/Scripts/SDOSSwinject" -i "${SRCROOT}/main/resources/Dependencies.json" -o "${SRCROOT}/main/resources/generated/DependenciesGenerated.swift"
    ```
    <sup><sub>Los valores del script pueden cambiarse en función de las necesidades del proyecto</sup></sub>
6. Añadir `${SRCROOT}/main/resources/Dependencies.json` al apartado `Input Files`
7. Añadir `${SRCROOT}/main/resources/generated/DependenciesGenerated.swift` al apartado `Output Files`
8.  Compilar el proyecto. Esto generará los ficheros en la ruta `${SRCROOT}/main/resources/generated/` que deberán ser incluidos en el proyecto.

Además de estos pasos el script tiene otros parámetros que pueden incluirse en base a las necesidades del proyecto:

|Parámetro                                |Descripción                                                                                                        |
|-----------------------------------------|-------------------------------------------------------------------------------------------------------------------|
|`--disable-input-output-files-validation`|Deshabilita la validación de los inputs y outputs files. Usar sólo para dar compatibilidad a `Legacy Build System` |
|`--unlock-files`                         |Indica que los ficheros de salida no se deben bloquear en el sistema                                               |

## JSON

La librería se apoya en un JSON para generar el código `.swift`. Este JSON tiene la siguiente estructura

```json
{
    "config": {
        "name": "string"
    },
    "headers": [
        "string"
    ],
    "body": [
        {
            "dependencyName": "string",
            "className": "string",
            "name": "string",
            "scope": "string",
            "arguments": [
                {
                    "name": "string",
                    "type": "string"
                }
            ]
        }]
}
```

|Parámetro|Descripción|Ejemplo|
|---------|-----------|-------|
|`config`|Apartado de configuración general de las dependencias||
|`config.name`|Nombre que se usará como sufijo de todo el código autogenerado. El uso más común es generar ficheros de dependencias diferentes por modúlos|`Event`|
|`headers`|Array de strings que se incluiran al inicio del fichero generado. Se usará para realizar imports de librerías o crear `typealias`.|`typealias NavigationController = UINavigationController`|
|`body`|Array de objetos. Cada uno de ellos es la definición de una dependencia. **Este array se ampliará cuando se añadan nuevas dependencias**||
|`body.dependencyName`|Tipo de la dependencia a injectar. Por lo general será un protocolo|`NavigationController`|
|`body.className`|Nombre de la clase que se debe inicializar al solicitar la dependencia. Esta clase deberá contener un método init con los parámetros indicados en el valor `body.arguments`|`UINavigationController`|
|`body.name`|Nombre especifico para el registro de la dependencia. Este parámetro nos permite crear varios registros a la misma dependencia sin que se solapen los nombres de los métodos. Es útil cuando queremos registrar varias veces la misma dependencia con diferentes argumentos|`Test`|
|`body.scope`|Ámbito de resolución de la dependencia. Estos ámbitos son los [definidos en la librería Swinject](https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md). Valores disponibles: `transient`, (default) `graph`, `container`, `weak`|`container`|
|`body.arguments`|Array de argumentos que serán usados para el registro y la resolución de la dependencia||
|`body.arguments.name`|Nombre del argumento. Deberá coincidir con el nombre del argumento en su init|`rootViewController`|
|`body.arguments.type`|Tipo del argumento|`UIViewController`|

## Dependencias
* [Swinject](https://github.com/Swinject/Swinject) - >= 2.6

## Referencias
* https://svrgitpub.sdos.es/iOS/SDOSSwinject

