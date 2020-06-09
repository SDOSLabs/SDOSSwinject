//
//  DependencyDTO.swift
//  SDOSSwinjectExample
//
//  Created by Rafael Fernandez Alvarez on 18/03/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

struct DependencyDTO: Decodable {
    var body: [BodyDTO]?
    var headers: [String]?
    var dependencies: [String]?
    var config: ConfigDTO?
    
    var dependenciesResolve: [DependencyDTO]?
    var subdependencyOriginalName: String?
    
    mutating func saveDependenciesResolve(dependencies: [DependencyDTO]?) {
        self.dependenciesResolve = dependencies
    }
    
    mutating func saveSubdependencyOriginalName(subdependencyOriginalName: String?) {
        self.subdependencyOriginalName = subdependencyOriginalName
    }
    
    func registerAllHeader() -> String {
        var result = ""
        var name = ""
        if let subdependencyOriginalName = self.subdependencyOriginalName {
            name.append(subdependencyOriginalName.fileName.capitalizingFirstLetter())
        }
        if let n = config?.name {
            name.append(n)
        }
        if let suffixName = config?.suffixName {
            name.append(suffixName)
        }
        if let _ = self.body {
            result.append("registerAll\(name)()")
        }
        
        return result
    }
}

extension String {
    var fileName: String {
        return (self as NSString).lastPathComponent.components(separatedBy: ".").first ?? self
    }
}
