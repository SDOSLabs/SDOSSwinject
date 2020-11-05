//
//  ArgumentDTO.swift
//  SDOSSwinjectExample
//
//  Created by Rafael Fernandez Alvarez on 18/03/2019.
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation

struct ArgumentDTO: Decodable {
    var name: String
    var type: String
    var defaultValue: String?
    
}
