//
//  ErrorDTO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import SDOSAlamofire
import SDOSKeyedCodable

struct ErrorDTO: GenericErrorDTO {
    
    mutating func map(map: KeyMap) throws {
        //try identifier <-> map["id"]
    }
    
    init(from decoder: Decoder) throws {
        try KeyedDecoder(with: decoder).decode(to: &self)
    }
}
