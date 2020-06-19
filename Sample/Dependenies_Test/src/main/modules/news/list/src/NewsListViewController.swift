//
//  NewsListViewController.swift
//
//  Created by Rafael Fernandez Alvarez on 18/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSLoader


/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsListViewActions",
    "className": "NewsListViewController"
 }
 */

protocol NewsListViewActions: BaseViewActions, NewsListPresenterDelegate {
    
}

class NewsListViewController: BaseViewController {
    private lazy var presenter: NewsListPresenterActions = {
        Dependency.injector.dependencies.news.newsList.resolveNewsListPresenterActions(delegate: self)
    }()
    
    //MARK: - Init
    
    required override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Last line
        self.presenter.viewDidLoad()
    }
    
    //MARK: - Custom methods
    
    @IBAction func actionNavigate() {
        presenter.goToDetail()
    }

}

extension NewsListViewController: NewsListViewActions {
    
}

extension NewsListViewController: NewsListPresenterDelegate {
    func loadUI() {
        
    }
    
    func itemsLoaded(items: [NewsListVO]) {
        //Do stuff
    }
    
    func showError(_ error: Error) {
        
    }
    
    func showCenterLoader() {
        //LoaderManager.showLoader(LoaderManager.loader(withType: LoaderTypeIndeterminateCircular, in: view))
    }
    
    func hideCenterLoader() {
        //LoaderManager.hideLoaders(of: view)
    }
}
