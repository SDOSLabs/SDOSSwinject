//
//  NewsDetailVO.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class NewsDetailVO {
    let itemBO: NewsBO
    
    public init(with itemBO: NewsBO) {
        self.itemBO = itemBO
    }
}
