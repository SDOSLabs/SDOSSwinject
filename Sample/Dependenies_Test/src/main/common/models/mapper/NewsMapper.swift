//
//  NewsMapper.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

extension NewsDTO {
    func toBO() -> NewsBO {
        return NewsBO(dto: self)
    }
}

extension NewsBO {
    init(dto item: NewsDTO) {
        
    }
}
