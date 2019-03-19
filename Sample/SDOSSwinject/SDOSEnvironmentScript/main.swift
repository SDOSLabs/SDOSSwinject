//
//  main.swift
//  SDOSEnvironmentScript
//
//  Created by Rafael Fernandez Alvarez on 27/02/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

let fileName = "SDOSSwinject"

extension String {
    func lowerCaseFirstLetter() -> String {
        return prefix(1).lowercased() + self.dropFirst()
    }
    
    mutating func lowerCaseFirstLetter() {
        self = self.lowerCaseFirstLetter()
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

class ScriptAction {
    var pwd: String!
    var input: String!
    var output: String!
    
    var parameters = [ConsoleParameter]()
    
    
    func start(args: [String]) {
        registerParameters()
        
        if managerArgs(args: args) {
            executeAction()
        } else {
            printUsage()
        }
    }
    
    func executeAction() {
        generateFile()
    }
    
    func registerParameters() {
        let parameter0 = ConsoleParameter(numArgs: 0) { values in
            self.pwd = FileManager.default.currentDirectoryPath
            return true
        }
        parameters.append(parameter0)
        
        let parameter1 = ConsoleParameter(numArgs: 1, option: "-i") { values in
            var result = values[1]
            if let pwd = self.pwd, !result.hasPrefix("/") {
                result = "\(pwd)/\(result)"
            }
            self.input = result
            return true
        }
        parameters.append(parameter1)
        
        let parameter2 = ConsoleParameter(numArgs: 1, option: "-o") { values in
            var result = values[1]
            if let pwd = self.pwd, !result.hasPrefix("/") {
                result = "\(pwd)/\(result)"
            }
            self.output = result
            return true
        }
        parameters.append(parameter2)
        
    }
    
    func printUsage() {
        print("Los valores validos son los siguientes")
        print("-i ruta del fichero de entrada. Debe ser un .json")
        print("-o ruta del fichero encriptado de salida. Debe incluir el nombre del fichero a generar")

    }
    
}

//MARK: - Manager arguments
extension ScriptAction {
    func managerArgs(args: [String]) -> Bool {
        var result = true
        
        var i = 0
        while (i < args.count) {
            var isCorrect = true
            let option = args[i]
            var consoleParameter: ConsoleParameter?
            if i == 0 {
                consoleParameter = getConsoleParameter(option: nil)
            } else {
                if(isArg(option: option)) {
                    consoleParameter = getConsoleParameter(option: option)
                }
            }
            
            if let consoleParameter = consoleParameter {
                var arrayValues = [String]()
                arrayValues.append(option)
                for _ in 0..<consoleParameter.numArgs {
                    i += 1
                    if i < args.count {
                        arrayValues.append(args[i])
                    } else {
                        isCorrect = false
                        break
                    }
                }
                
                if isCorrect {
                    isCorrect = consoleParameter.actionExecute(arrayValues)
                }
            } else {
                isCorrect = false
            }
            
            if !isCorrect {
                result = false
                break
            }
            i += 1
        }
        return result
    }
    
    func getConsoleParameter(option: String?) -> ConsoleParameter? {
        var result: ConsoleParameter? = nil
        
        for consoleParameter in parameters {
            if let option = option {
                if option == consoleParameter.option {
                    result = consoleParameter
                    break
                }
            } else if consoleParameter.option == nil {
                result = consoleParameter
                break
            }
        }
        return result
    }
    
    func isArg(option: String) -> Bool {
        var result = false
        if option.hasPrefix("-") {
            result = true
        }
        return result
    }
}

//MARK: - Generate File
extension ScriptAction {
    func generateFile() {
        var file = ""
        file.append(generateComment())
        let dependency = parseJSON()
        if let headers = dependency.headers {
            file.append(generateHeaders(config: dependency.config, headers: headers))
        }
        if let body = dependency.body {
            file.append(generateAllRegister(config: dependency.config, items: body))
            file.append(generateResolver(config: dependency.config, items: body))
            file.append(generateRegister(config: dependency.config, items: body))
        }
        
        do {
            try file.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
        } catch {
            print("Fallo durante la generación del fichero autogenerado. Comprueba que el fichero de entrada es correcto. Ruta de entrada: \"\(input!)\"")
            exit(1)
        }
        
    }
    
    func generateComment() -> String {
        var result = ""
        result.append(contentsOf: "//  This is a generated file, do not edit!\n")
        result.append(contentsOf: "//  \(fileName)\n")
        result.append(contentsOf: "//\n")
        result.append(contentsOf: "//  Created by SDOS\n")
        result.append(contentsOf: "//\n")
        result.append(contentsOf: "\n")
        result.append(contentsOf: "import Swinject\n")
        result.append(contentsOf: "\n")
        return result
    }
}

//MARK: - JSON
extension ScriptAction {
    func parseJSON() -> DependencyDTO {
        do {
            let url = URL(fileURLWithPath: input)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try! decoder.decode(DependencyDTO.self, from: data)
        } catch {
            print("Fallo durante el tratamiento del JSON. Comprueba que el fichero de entrada es correcto. Ruta de entrada: \"\(input!)\"")
            exit(1)
        }
    }
}

//MARK: - Generate Headers
extension ScriptAction {
    func generateHeaders(config: ConfigDTO?, headers: [String]) -> String {
        var result = ""
        for header in headers {
            result.append("\(header)\n")
        }
        result.append("\n")
        return result
    }
}

//MARK: - All Register
extension ScriptAction {
    func generateAllRegister(config: ConfigDTO?, items: [BodyDTO]) -> String {
        var result = ""
        var name = ""
        if let p = config?.name {
            name = p
        }
        result.append("""
            extension Container {
                ///Register all dependencies: \(items.count) dependencies
                func registerAll\(name)() {

            """)
        for item in items {
            result.append("\t\tself.\(item.registerHeader(globalName: config?.name))\n")
        }
        result.append("\t}")
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Resolver
extension ScriptAction {
    func generateResolver(config: ConfigDTO?, items: [BodyDTO]) -> String {
        var result = ""
        result.append("//Generate resolvers with \(items.count) dependencies\n")
        result.append("extension Resolver {\n")
        for item in items {
            result.append(item.resolveFunction(globalName: config?.name))
        }
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Register
extension ScriptAction {
    func generateRegister(config: ConfigDTO?, items: [BodyDTO]) -> String {
        var result = ""
        result.append("//Generate registers with \(items.count) dependencies\n")
        result.append("extension Container {\n")
        for item in items {
            result.append(item.registerFunction(globalName: config?.name))
        }
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Start script
ScriptAction().start(args: CommandLine.arguments)
