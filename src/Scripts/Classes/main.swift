//
//  main.swift
//  SDOSSwinjectScript
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
        return prefix(1).uppercased() + self.dropFirst()
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
    
    var generateFiles = [String]()
    var generateFilesValidate = [String]()
    
    
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
        let dependency = parseJSON()
        //generateFilelist(dependency: dependency)
        validateDependency(dependency: dependency)
        generateFile(dependency: dependency)
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

//MARK: - Validation
extension ScriptAction {
    func validateDependency(dependency: DependencyDTO) {
        
        validateInputSubdependency(rootDependency: dependency, dependency: dependency)
        
        let allDependenciesStr = reduceBody(dependency: dependency)
        var dictionaryDuplicateImplementation = [String: [(String, String, DependencyDTO, BodyDTO)]]()
        var dictionaryDuplicateHeaders = [String: [(String, String, DependencyDTO, BodyDTO)]]()
        
        allDependenciesStr.forEach {
            if let array = dictionaryDuplicateHeaders[$0.0] {
                dictionaryDuplicateHeaders[$0.0] = array + [$0]
            } else {
                dictionaryDuplicateHeaders[$0.0] = [$0]
            }
        }
        
        allDependenciesStr.forEach {
            if let array = dictionaryDuplicateImplementation[$0.1] {
                dictionaryDuplicateImplementation[$0.1] = array + [$0]
            } else {
                dictionaryDuplicateImplementation[$0.1] = [$0]
            }
        }
        
        dictionaryDuplicateImplementation = dictionaryDuplicateImplementation.compactMapValues{
            return $0.count == 1 ? nil : $0
        }
        
        if dictionaryDuplicateImplementation.count > 0 {
            dictionaryDuplicateImplementation.keys.forEach { key in
                var description = ""
                dictionaryDuplicateImplementation[key]?.forEach {
                    var name = "Root dependency"
                    if let n = $0.2.subdependencyOriginalName {
                        name = n
                    }
                    description = description + " See file \"\(name)\" with dependencyName \"\($0.3.dependencyName)\" and className \"\($0.3.className)\"."
                }
                print("warning: [SDOSSwinject] ➡️ Some dependencies generate same register implementation \"\(key)\". Consider remove only one. \(description)")
                print("")
            }
        }
        
        dictionaryDuplicateHeaders = dictionaryDuplicateHeaders.compactMapValues{
            return $0.count == 1 ? nil : $0
        }
        
        if dictionaryDuplicateHeaders.count > 0 {
            dictionaryDuplicateHeaders.keys.forEach { key in
                print("[SDOSSwinject] ➡️ Some dependencies generate same register header \"\(key)\"")
                dictionaryDuplicateHeaders[key]?.forEach {
                    var name = "Root dependency"
                    if let n = $0.2.subdependencyOriginalName {
                        name = n
                    }
                    print("\t🟥 In file \"\(name)\" with dependencyName \"\($0.3.dependencyName)\" and className \"\($0.3.className)\"")
                }
                print("")
            }
            exit(15)
        }
        print("")
    }
    
    func reduceBody(dependency: DependencyDTO) -> [(String, String, DependencyDTO, BodyDTO)] {
        var result = [(String, String, DependencyDTO, BodyDTO)]()
        if let body = dependency.body {
            result.append(contentsOf: body.compactMap({ ($0.registerHeader(dependency: dependency), $0.registerImplementation(dependency: dependency), dependency, $0)}))
        }
        dependency.dependenciesResolve?.forEach {
            if let subdependencyOriginalName = $0.subdependencyOriginalName, generateFilesValidate.contains(resolveFullPath(path: subdependencyOriginalName)) {
                return
            } else {
                result.append(contentsOf: reduceBody(dependency: $0))
                if let subdependencyOriginalName = $0.subdependencyOriginalName {
                    generateFilesValidate.append(resolveFullPath(path: subdependencyOriginalName))
                }
            }
        }
        return result
    }
    
    func validateInputSubdependency(rootDependency: DependencyDTO, dependency: DependencyDTO) {
        dependency.dependenciesResolve?.forEach {
            if let subdependencyOriginalName = $0.subdependencyOriginalName {
                checkSubdependencyInput(file: subdependencyOriginalName, fileContent: getPathsForFilelist(dependency: rootDependency).joined(separator: "\n"))
            }
            validateInputSubdependency(rootDependency: rootDependency, dependency: $0)
        }
    }
}

//MARK: - Generate File
extension ScriptAction {
    func generateFile(dependency: DependencyDTO) {
        let file = generateFileDependency(dependency: dependency)
        
        do {
            let num = countDependencies(dependency: dependency)
            print("Todo correcto: Se han generado \(num) dependencias")
            unlockFile(output)
            try file.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
            lockFile(output)
        } catch {
            print("Fallo durante la generación del fichero autogenerado. Comprueba que el fichero de entrada es correcto. Ruta de entrada: \"\(input!)\"")
            exit(1)
        }
    }
    
    func countDependencies(dependency: DependencyDTO) -> Int {
        var result = 0
        
        result += dependency.body?.count ?? 0
        dependency.dependenciesResolve?.forEach {
            result += countDependencies(dependency: $0)
        }
        
        return result
    }
    
    func generateFileDependency(dependency: DependencyDTO, parentDependency: DependencyDTO? = nil) -> String {
        var file = ""
        file.append(generateComment(dependency: dependency))
        file.append(generateHeaders(dependency: dependency))
        file.append(generateAllRegister(dependency: dependency))
        file.append(generateResolver(dependency: dependency, parentDependency: parentDependency))
        file.append(generateRegister(dependency: dependency))
        dependency.dependenciesResolve?.forEach {
            if let subdependencyOriginalName = $0.subdependencyOriginalName, generateFiles.contains(resolveFullPath(path: subdependencyOriginalName)) {
                return
            } else {
                file.append(generateFileDependency(dependency: $0, parentDependency: dependency))
                if let subdependencyOriginalName = $0.subdependencyOriginalName {
                    generateFiles.append(resolveFullPath(path: subdependencyOriginalName))
                }
            }
        }
        
        return file
    }
    
    func generateComment(dependency: DependencyDTO) -> String {
        var result = ""
        var srcRoot = ""
        if let root = ProcessInfo.processInfo.environment["SRCROOT"] {
            srcRoot = root
        }
        if let subdependencyOriginalName = dependency.subdependencyOriginalName {
            var filePath = ""
            if resolvePath(path: subdependencyOriginalName).hasPrefix("/") {
                filePath = resolvePath(path: subdependencyOriginalName)
            } else {
                filePath = NSString(string: input).deletingLastPathComponent
                filePath = "\(resolvePath(path: NSString(string: input).deletingLastPathComponent))/\(subdependencyOriginalName)"
            }
            filePath = filePath.replacingOccurrences(of: srcRoot, with: "${SRCROOT}")
            result.append(contentsOf: """
                //MARK: - \(filePath) dependency
                
                """)
        } else {
            
            result.append(contentsOf: """
                //  This is a generated file, do not edit!
                //  \(fileName)
                //  Created by SDOS
                //
                import Swinject
                
                //MARK: - Root dependency (\(resolvePath(path: input).replacingOccurrences(of: srcRoot, with: "${SRCROOT}"))))
                
                
                """)
        }
        return result
    }
    
    func generateSubComment(file: String) -> String {
        var result = ""
        result.append(contentsOf: "//==========================================\n")
        result.append(contentsOf: "// Based on \(file) file\n")
        result.append(contentsOf: "\n")
        return result
    }
    
    func generateSubFooter(file: String) -> String {
        var result = ""
        result.append(contentsOf: "//==========================================\n")
        result.append(contentsOf: "\n")
        return result
    }
}

//MARK: - JSON
extension ScriptAction {
    func parseJSON(file: String? = nil) -> DependencyDTO {
        var filePath: String = input
        if let file = file {
            if resolvePath(path: file).hasPrefix("/") {
                filePath = resolvePath(path: file)
            } else {
                filePath = NSString(string: input).deletingLastPathComponent
                filePath = "\(filePath)/\(file)"
            }
        }
        do {
            let url = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            var dependency = try! decoder.decode(DependencyDTO.self, from: data)
            dependency.saveDependenciesResolve(dependencies: dependency.dependencies?.map({
                var subPath = ""
                if let file = file, !resolvePath(path: $0).hasPrefix("/") {
                    subPath = NSString(string: file).deletingLastPathComponent
                    if !subPath.isEmpty {
                        subPath = subPath + "/"
                    }
                }
                var d = parseJSON(file: subPath + $0)
                d.saveSubdependencyOriginalName(subdependencyOriginalName: resolvePath(path: subPath + $0, expandVariables: false))
                return d
            }))
            
            return dependency
        } catch {
            print("[SDOSSwinject] 🟥 Fallo durante el tratamiento del JSON. Comprueba que el fichero de entrada es correcto. Ruta de entrada: \"\(filePath)\"")
            exit(1)
        }
    }
}

//MARK: - Generate filelist
extension ScriptAction {
    func generateFilelist(dependency: DependencyDTO) {
        guard let output = output else { return }
        let result = getPathsForFilelist(dependency: dependency).joined(separator: "\n")
        if !result.isEmpty {
            let filelistOutput = "\(output).files"
            do {
                unlockFile(output)
                try result.write(to: URL(fileURLWithPath: filelistOutput), atomically: true, encoding: .utf8)
                lockFile(output)
            } catch {
                print("Fallo durante la generación del fichero .files en la ruta \(filelistOutput).")
                exit(2)
            }
        }
    }
    
    func getPathsForFilelist(dependency: DependencyDTO) -> [String] {
        var result = [String]()
        if let subdependencyOriginalName = dependency.subdependencyOriginalName {
            var path = "\(resolveFullPath(path: subdependencyOriginalName))"
            if let srcRoot = ProcessInfo.processInfo.environment["SRCROOT"] {
                path = path.replacingOccurrences(of: srcRoot, with: "${SRCROOT}")
            }
            result.append(path)
        }
        dependency.dependenciesResolve?.forEach {
            result.append(contentsOf: getPathsForFilelist(dependency: $0))
        }
        result = result.map {
            resolvePath(path: $0, expandVariables: false)
        }
        return Array(Set(result)).sorted { $0.lowercased() < $1.lowercased() }
    }
}

//MARK: - Generate Headers
extension ScriptAction {
    func generateHeaders(dependency: DependencyDTO) -> String {
        var result = ""
        if let headers = dependency.headers {
            for header in headers {
                result.append("\(header)\n")
            }
            result.append("\n")
        }
        return result
    }
}

//MARK: - All Register
extension ScriptAction {
    func generateAllRegister(dependency: DependencyDTO) -> String {
        var result = ""
        var name = ""
        if let p = dependency.config?.name {
            name = p
        }
        if let suffixName = dependency.config?.suffixName {
            name.append(suffixName)
        }
        var accessLevel = ""
        if let globalAccessLevel = dependency.config?.globalAccessLevel {
            accessLevel = globalAccessLevel.isEmpty ? globalAccessLevel: globalAccessLevel + " "
        }
        if let registerAllAccessLevel = dependency.config?.registerAllAccessLevel {
            accessLevel = registerAllAccessLevel.isEmpty ? registerAllAccessLevel: registerAllAccessLevel + " "
        }
        
        let dependenciesCount = dependency.dependenciesResolve?.count ?? 0
        let bodyCount = dependency.body?.count ?? 0
        
        result.append("""
        
        extension Container {
            ///Register all dependencies: \(bodyCount + dependenciesCount) dependencies
            \(accessLevel)func \(dependency.registerAllHeader()) {
        
        """)
        
        if let body = dependency.body {
            for item in body {
                result.append("\t\tself.\(item.registerHeader(dependency: dependency))\n")
            }
        }
        
        if let dependenciesResolve = dependency.dependenciesResolve {
            if dependenciesResolve.count > 0 && dependency.body?.count ?? 0 != 0 {
                result.append("\n")
            }
            dependenciesResolve.forEach {
                result.append("\t\tself.\($0.registerAllHeader())\n")
            }
        }
        result.append("\t}")
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Resolver
extension ScriptAction {
    func generateResolver(dependency: DependencyDTO, parentDependency: DependencyDTO?) -> String {
        var resultDependencies = ""
        var countTotal = 0
        if let body = dependency.body {
            for item in body {
                if let resolve = item.resolveFunction(dependency: dependency) {
                    resultDependencies.append(resolve)
                    countTotal = countTotal + 1
                }
            }
        }
        
        let globalAccessLevel: String
        if let str = dependency.config?.globalAccessLevel, !str.isEmpty {
            globalAccessLevel = str + " "
        } else {
            globalAccessLevel = ""
        }
        
        var result = ""
        if parentDependency == nil {
            guard let subdependencyNameResolver = dependency.structName(input: input), let subdependencyName = dependency.subdependencyVariableName(input: input) else { return "" }
            
            result.append("\n")
            result.append("//Generate variable to access resolvers")
            if let body = dependency.body, countTotal != body.count {
                result.append(" (\(body.count - countTotal) skipped)")
            }
            result.append("\n")
            result.append(globalAccessLevel)
            result.append("""
            extension Resolver {
                \(globalAccessLevel)var \(subdependencyName): \(subdependencyNameResolver) {
                    return \(subdependencyNameResolver)(resolver: self)
                }
            }
            
            
            """)
        }
        
        guard let subdependencyNameResolver = dependency.structName(input: input) else { return "" }
        
        result.append("//Generate resolvers with \(countTotal) dependencies")
        if let body = dependency.body, countTotal != body.count {
            result.append(" (\(body.count - countTotal) skipped)")
        }
        result.append("\n")
        result.append(globalAccessLevel)
        result.append("struct \(subdependencyNameResolver) {\n")
        result.append("\tprivate let resolver: Resolver\n")
        result.append("\tfileprivate init(resolver: Resolver) { self.resolver = resolver }\n")
        result.append("\n")
        dependency.dependenciesResolve?.forEach {
            guard let subdependencyNameResolver = $0.structName(), let subdependencyName = $0.subdependencyVariableName() else { return }
            result.append(globalAccessLevel)
            result.append("""
                var \(subdependencyName): \(subdependencyNameResolver) {
                    return \(subdependencyNameResolver)(resolver: resolver)
                }
            
            """)
        }
        result.append(contentsOf: resultDependencies)
        result.append("\n}\n\n")
        
        return result
    }
}

//MARK: - Register
extension ScriptAction {
    func generateRegister(dependency: DependencyDTO) -> String {
        var result = ""
        if let body = dependency.body {
            result.append("//Generate registers with \(body.count) dependencies\n")
            result.append("extension Container {\n")
            for item in body {
                result.append(item.registerFunction(dependency: dependency))
            }
            result.append("\n}\n\n")
        }
        
        return result
    }
}

//MARK: - Validate Input/Outputs files
extension ScriptAction {
    enum TypeParams: String {
        case INPUT_FILE
        case INPUT_FILE_LIST
        case OUTPUT_FILE
        case OUTPUT_FILE_LIST
    }
    
    func validateInputOutput() {
        guard !disableInputOutputFilesValidation else {
            return
        }
        checkInput(params: parseParams(type: .INPUT_FILE) + parseParams(type: .INPUT_FILE_LIST), sources: [self.input])
        checkOutput(params: parseParams(type: .OUTPUT_FILE) + parseParams(type: .OUTPUT_FILE_LIST), sources: [self.output])
    }
    
    func parseParams(type: TypeParams) -> [String] {
        var params = [String]()
        if let numString = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_COUNT"] {
            if let num = Int(numString) {
                for i in 0...num {
                    if let param = ProcessInfo.processInfo.environment["SCRIPT_\(type.rawValue)_\(i)"] {
                        if param.hasSuffix(".files") || param.hasSuffix(".xcfilelist") || type == .INPUT_FILE_LIST || type == .OUTPUT_FILE_LIST {
                            if let fileContent = try? String(contentsOfFile: param) {
                                fileContent.split(separator: "\n").map(String.init).forEach {
                                    if !$0.hasPrefix("#") {
                                        params.append(resolvePath(path: $0))
                                    }
                                }
                            }
                        } else {
                            params.append(resolvePath(path: param))
                        }
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
    
    func checkSubdependencyInput(file: String, fileContent: String) {
        var filePath = ""
        if resolvePath(path: file).hasPrefix("/") {
            filePath = resolvePath(path: file)
        } else {
            filePath = NSString(string: input).deletingLastPathComponent
            filePath = "\(filePath)/\(file)"
        }
        checkInputOutput(params: parseParams(type: .INPUT_FILE) + parseParams(type: .INPUT_FILE_LIST), sources: [resolvePath(path: filePath)], message: "Please create a file \".xcfilelist\" (also include it at the \"Input File Lists\") with the following content:\n\n#===================================\n\(fileContent)\n#===================================\n\nBuild phase Intput Files does not contain")
    }
    
    func checkInputOutput(params: [String], sources: [String], message: String) {
        for source in sources {
            let realSource = resolvePath(path: source)
            if !params.contains(realSource) {
                print("[SDOSSwinject] ➡️ \(message) '\(source.replacingOccurrences(of: pwd, with: "${SRCROOT}"))'.")
                exit(7)
            }
        }
    }
    
    func resolveFullPath(path: String) -> String {
        var realPath: String = ""
        if resolvePath(path: path).hasPrefix("/") {
            realPath = resolvePath(path: path)
        } else {
            realPath = NSString(string: input).deletingLastPathComponent
            realPath = resolvePath(path: "\(realPath)/\(path)")
        }
        return realPath
    }
    
    func resolvePath(path: String, expandVariables: Bool = true) -> String {
        var arrayComponents: [String] = path.components(separatedBy: "/").reversed()
        var numComponentsToDelete = 0
        arrayComponents = arrayComponents.compactMap { item -> String? in
            if item == ".." {
                numComponentsToDelete += 1
                return nil
            } else if item == "." {
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
        var result = arrayComponents.reversed().joined(separator: "/")
        if expandVariables {
            if let projectDir = ProcessInfo.processInfo.environment["PROJECT_DIR"] {
                result = result.replacingOccurrences(of: "${PROJECT_DIR}", with: projectDir).replacingOccurrences(of: "$PROJECT_DIR", with: projectDir).replacingOccurrences(of: "$(PROJECT_DIR)", with: projectDir)
            }
            
            if let srcRoot = ProcessInfo.processInfo.environment["SRCROOT"] {
                result = result.replacingOccurrences(of: "${SRCROOT}", with: srcRoot).replacingOccurrences(of: "$SRCROOT", with: srcRoot).replacingOccurrences(of: "$(SRCROOT)", with: srcRoot)
            }
        }
        
        return result
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
