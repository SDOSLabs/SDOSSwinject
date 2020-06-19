//
//  NewsListWireframe.swift
//
//  Created by Rafael Fernandez Alvarez on 18/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsListWireframeActions",
    "className": "NewsListWireframe"
 }
 */

protocol NewsListWireframeActions: BaseWireframeActions {
    func navigate(from navigationController: UINavigationController)
}

class NewsListWireframe: BaseWireframe {
    
}

extension NewsListWireframe: NewsListWireframeActions {
    func navigate(from navigationController: UINavigationController) {
        navigationController.pushViewController(Dependency.injector.dependencies.news.newsList.resolveNewsListViewActions(), animated: true)
    }
}
