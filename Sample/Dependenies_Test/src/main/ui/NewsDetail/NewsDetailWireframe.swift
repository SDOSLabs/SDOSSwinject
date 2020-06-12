//
//  NewsDetailWireframe.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsDetailWireframeActions",
    "className": "NewsDetailWireframe"
 }
 */

protocol NewsDetailWireframeActions: BaseWireframeActions {
    //func navigateToView(from navigationController: UINavigationController)
}

class NewsDetailWireframe: BaseWireframe {
    
}

extension NewsDetailWireframe: NewsDetailWireframeActions {
    /*
    func navigateToView(from navigationController: UINavigationController) {
        navigationController.pushViewController(Dependency.injector.<#resolveViewController#>, animated: true)
    }
    */
}
