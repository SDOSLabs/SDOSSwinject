//
//  NewsDetailViewController.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import SDOSLoader


/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsDetailViewActions",
    "className": "NewsDetailViewController"
 }
 */

protocol NewsDetailViewActions: BaseViewActions, NewsDetailPresenterDelegate {
    
}

class NewsDetailViewController: BaseViewController {
    private lazy var presenter: NewsDetailPresenterActions = {
        Dependency.injector.news.newsDetail.resolveNewsDetailPresenterActions(delegate: self)
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

}

extension NewsDetailViewController: NewsDetailViewActions {
    
}

extension NewsDetailViewController: NewsDetailPresenterDelegate {
    func loadUI() {
        
    }
    
    func itemsLoaded(items: [NewsDetailVO]) {
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
