//
//  NewsListVO.swift
//
//  Created by Rafael Fernandez Alvarez on 18/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import Foundation

class NewsListVO {
    let itemBO: NewsBO
    
    public init(with itemBO: NewsBO) {
        self.itemBO = itemBO
    }
}
