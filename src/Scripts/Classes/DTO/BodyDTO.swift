//
//  BodyDTO.swift
//  SDOSSwinjectExample
//
//  Created by Rafael Fernandez Alvarez on 18/03/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

struct BodyDTO: Decodable {
    var dependencyName: String
    var className: String
    var scope: String?
    var name: String?
    var arguments: [ArgumentDTO]?
    var accessLevel: String?
    var initName: String?
    var onlyRegister: Bool? = false
    var resolveNameSimple: Bool? = false
    
    /**
     Example result:
     func registerNavigationControllerModuleNombre() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
     }
     */
    func registerFunction(dependency: DependencyDTO) -> String {
        var result = ""
        
        result.append("""
                @discardableResult
                fileprivate func \(registerHeader(dependency: dependency)) -> \(registerReturn()) {
                    \(registerImplementation(dependency: dependency))
                }
            
            """
        )
        
        return result
    }
    
    /**
     Example result:
     registerNavigationControllerModuleNombre()
     */
    func registerHeader(dependency: DependencyDTO) -> String {
        var result = "register\(self.dependencyName)"
        if let name = dependency.config?.name {
            result.append(name.capitalizingFirstLetter())
        }
        if let name = self.name {
            result.append(name.capitalizingFirstLetter())
        }
        if let suffixName = dependency.config?.suffixName {
            result.append(suffixName.capitalizingFirstLetter())
        }
        if let arguments = arguments, arguments.count != 0 {
            result.append("With")
            arguments.forEach {
                result.append($0.name.capitalizingFirstLetter())
            }
        }
        result.append("()")
        return result
    }
    
    /**
     Example result:
     ServiceEntry<NavigationController>
     */
    func registerReturn() -> String {
        var result = ""
        result.append("ServiceEntry<\(self.dependencyName)>")
        return result
    }
    
    /**
     Example result:
     return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
     */
    func registerImplementation(dependency: DependencyDTO) -> String {
        var result = "return self.register(\(self.dependencyName).self"
        var nameFinal = ""
        if let name = dependency.config?.name {
            nameFinal.append(name.capitalizingFirstLetter())
        }
        if let name = self.name {
            nameFinal.append(name.capitalizingFirstLetter())
        }
        if !nameFinal.isEmpty {
            result.append(", name: \"\(nameFinal)\"")
        }
        result.append(") { (r: Resolver")
        if let arguments = self.arguments {
            result.append(", ")
            var arrayNames = [String]()
            for argument in arguments {
                arrayNames.append("\(argument.name): \(argument.type)")
            }
            result.append("\(arrayNames.joined(separator: ", "))")
        }
        result.append(") in \(self.className)")
        
        if let initName = initName {
            result.append(".\(initName)")
        }
        result.append("(")
        if let arguments = self.arguments {
            var arrayCalls = [String]()
            for argument in arguments {
                arrayCalls.append("\(argument.name): \(argument.name)")
            }
            result.append("\(arrayCalls.joined(separator: ", "))")
        }
        result.append(") }")
        if let scope = self.scope {
            result.append(".inObjectScope(.\(scope))")
        }
        return result
    }
    
    /**
     Example result:
     func resolveNavigationControllerModuleNombre(rootViewController: UIViewController) -> NavigationController {
        return resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
     }
     */
    func resolveFunction(dependency: DependencyDTO) -> String? {
        if let onlyRegister = onlyRegister, onlyRegister {
            return nil
        }
        var result = ""
        var accessLevel = ""
        if let globalAccessLevel = dependency.config?.globalAccessLevel {
            accessLevel = globalAccessLevel.isEmpty ? globalAccessLevel: globalAccessLevel + " "
        }
        if let dependencyAccessLevel = self.accessLevel {
            accessLevel = dependencyAccessLevel.isEmpty ? dependencyAccessLevel: dependencyAccessLevel + " "
        }
        result.append("""
                \(accessLevel)func \(resolveHeader(dependency: dependency)) -> \(resolveReturn()) {
                    \(resolveImplementation(dependency: dependency))
                }
            
            """
        )
        return result
    }
    
    /**
     Example result:
     resolveNavigationControllerModuleNombre(rootViewController: UIViewController)
     */
    func resolveHeader(dependency: DependencyDTO) -> String {
        var result = "resolve\(self.dependencyName)"
        if let resolveNameSimple = resolveNameSimple, resolveNameSimple {
        } else {
            if let name = dependency.config?.name {
                result.append(name.capitalizingFirstLetter())
            }
            if let name = self.name {
                result.append(name.capitalizingFirstLetter())
            }
            if let suffixName = dependency.config?.suffixName {
                result.append(suffixName.capitalizingFirstLetter())
            }
        }
        result.append("(")
        if let arguments = self.arguments {
            var arrayNames = [String]()
            for argument in arguments {
                var str = "\(argument.name): \(argument.type)"
                if let defaultValue = argument.defaultValue {
                    str = "\(str) = \(defaultValue)"
                }
                arrayNames.append(str)
            }
            result.append("\(arrayNames.joined(separator: ", "))")
        }
        result.append(")")
        return result
    }
    
    /**
     Example result:
     NavigationController
     */
    func resolveReturn() -> String {
        var result = ""
        result.append(self.dependencyName)
        return result
    }
    
    /**
     Example result:
     return resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
     */
    func resolveImplementation(dependency: DependencyDTO) -> String {
        var result = "return (\(dependency.subdependencyOriginalName == nil ? "resolver" : "resolver") as! Container).synchronize().resolve(\(self.dependencyName).self"
        var nameFinal = ""
        if let name = dependency.config?.name {
            nameFinal.append(name.capitalizingFirstLetter())
        }
        if let name = self.name {
            nameFinal.append(name.capitalizingFirstLetter())
        }
        if !nameFinal.isEmpty {
            result.append(", name: \"\(nameFinal)\"")
        }
        if let arguments = self.arguments {
            if arguments.count == 1 {
                result.append(", argument: ")
            } else {
                result.append(", arguments: ")
            }
            var arrayNames = [String]()
            for argument in arguments {
                arrayNames.append(argument.name)
            }
            result.append("\(arrayNames.joined(separator: ", "))")
        }
        result.append(")!")
        return result
    }
}
