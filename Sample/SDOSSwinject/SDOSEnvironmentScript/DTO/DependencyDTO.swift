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
    var config: ConfigDTO?
}
