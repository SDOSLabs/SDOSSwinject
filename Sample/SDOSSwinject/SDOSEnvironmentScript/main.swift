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
    var disableInputOutputFilesValidation = false
    var unlockFiles = false
    
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
        validateInputOutput()
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
        
        let parameter3 = ConsoleParameter(numArgs: 0, option: "--disable-input-output-files-validation") { values in
            self.disableInputOutputFilesValidation = true
            return true
        }
        parameters.append(parameter3)
        
        let parameter4 = ConsoleParameter(numArgs: 0, option: "--unlock-files") { values in
            self.unlockFiles = true
            return true
        }
        parameters.append(parameter4)
        
    }
    
    func printUsage() {
        print("Los valores validos son los siguientes")
        print("-i ruta del fichero de entrada. Debe ser un .json")
        print("-o ruta del fichero de salida. Debe incluir el nombre del fichero a generar")
        print("--disable-input-output-files-validation Deshabilita la validación de los inputs y outputs files. Usar sólo para dar compatibilidad a Legacy Build System")
        print("--unlock-files Indica que los ficheros de salida no se deben bloquear en el sistema")
        exit(1)
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
            let num = dependency.body?.count ?? 0
            print("Todo correcto: Se han generado \(num) dependencias")
            unlockFile(output)
            try file.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
            lockFile(output)
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
        var accessLevel = ""
        if let globalAccessLevel = config?.globalAccessLevel {
            accessLevel = globalAccessLevel.isEmpty ? globalAccessLevel: globalAccessLevel + " "
        }
        if let registerAllAccessLevel = config?.registerAllAccessLevel {
            accessLevel = registerAllAccessLevel.isEmpty ? registerAllAccessLevel: registerAllAccessLevel + " "
        }
        result.append("""
            extension Container {
                ///Register all dependencies: \(items.count) dependencies
                \(accessLevel)func registerAll\(name)() {

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
            result.append(item.resolveFunction(globalName: config?.name, globalAccessLevel: config?.globalAccessLevel))
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
            result.append(item.registerFunction(globalName: config?.name, globalAccessLevel: config?.globalAccessLevel))
        }
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Validate Input/Outputs files
extension ScriptAction {
    enum TypeParams: String {
        case INPUT
        case OUTPUT
    }
    
    func validateInputOutput() {
        guard !disableInputOutputFilesValidation else {
            return
        }
        checkInput(params: parseParams(type: .INPUT), sources: [self.input])
        checkOutput(params: parseParams(type: .OUTPUT), sources: [self.output])
    }
    
    func parseParams(type: TypeParams) -> [String] {
        var params = [String]()
        if let numString = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_FILE_COUNT"] {
            if let num = Int(numString) {
                for i in 0...num {
                    if let param = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_FILE_\(i)"] {
                        params.append(param)
                    }
                }
            }
        }
        return params
    }
    
    func checkInput(params: [String], sources: [String]) {
        checkInputOutput(params: params, sources: sources, message: "Build phase Intput Files does not contain")
    }
    
    func checkOutput(params: [String], sources: [String]) {
        checkInputOutput(params: params, sources: sources, message: "Build phase Output Files does not contain")
    }
    
    func checkInputOutput(params: [String], sources: [String], message: String) {
        for source in sources {
            var arrayComponents: [String] = source.components(separatedBy: "/").reversed()
            var numComponentsToDelete = 0
            arrayComponents = arrayComponents.compactMap { item -> String? in
                if item == ".." {
                    numComponentsToDelete += 1
                    return nil
                } else {
                    if numComponentsToDelete != 0 {
                        numComponentsToDelete -= 1
                        return nil
                    } else {
                        return item
                    }
                }
            }
            let realSource: String = arrayComponents.reversed().joined(separator: "/")
            if !params.contains(realSource) {
                print("[SDOSEnvironment] - \(message) '\(source.replacingOccurrences(of: pwd, with: "${SRCROOT}"))'.")
                exit(7)
            }
        }
    }
}

//MARK: - Lock files
extension ScriptAction {
    func unlockFile(_ path: String) {
        if FileManager.default.fileExists(atPath: path) {
            shell("chmod", "644", path)
        }
    }
    
    func lockFile(_ path: String) {
        guard !unlockFiles else {
            return
        }
        if FileManager.default.fileExists(atPath: path) {
            shell("chmod", "444", path)
        }
    }
    
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}

//MARK: - Start script
ScriptAction().start(args: CommandLine.arguments)
