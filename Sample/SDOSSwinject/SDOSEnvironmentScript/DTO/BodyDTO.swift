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
}
