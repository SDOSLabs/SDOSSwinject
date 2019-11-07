//
//  ConfigDTO.swift
//  SDOSSwinjectExample
//
//  Created by Rafael Fernandez Alvarez on 18/03/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

struct ConfigDTO: Codable {
    var name: String?
    var globalAccessLevel: String?
    var registerAllAccessLevel: String?
    var suffixName: String?
}
