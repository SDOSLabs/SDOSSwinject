//
//  NewsListPresenter.swift
//
//  Created by Rafael Fernandez Alvarez on 18/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import PromiseKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsListPresenterActions",
    "className": "NewsListPresenter",
    "arguments": [
        {
            "name": "delegate",
            "type": "NewsListPresenterDelegate"
        }
    ]
 }
 */

protocol NewsListPresenterDelegate: UIViewController {
    func loadUI()
    func showError(_ error: Error)
    func showCenterLoader()
    func hideCenterLoader()
    func itemsLoaded(items: [NewsListVO])
}

protocol NewsListPresenterActions: BasePresenterActions {
    init(delegate: NewsListPresenterDelegate)
    
    var items: [NewsListVO]? { get }
    
    func viewDidLoad()
    func goToDetail()
}

class NewsListPresenter: BasePresenter {
    unowned var delegate: NewsListPresenterDelegate
    private lazy var useCaseNewsList: UseCaseNewsList = {
        Dependency.injector.dependencies.news.newsList.newsBL.resolveUseCaseNewsList()
    }()
    private lazy var wireframe: NewsListWireframeActions = {
        Dependency.injector.dependencies.news.newsList.resolveNewsListWireframeActions()
    }()
    private lazy var wireframeNewsDetail: NewsDetailWireframeActions = {
        Dependency.injector.dependencies.news.newsList.newsDetail.resolveNewsDetailWireframeActions()
    }()
    
    var items: [NewsListVO]?
    
    required init(delegate: NewsListPresenterDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension NewsListPresenter: NewsListPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        firstly { [weak self] () -> Promise<[NewsBO]> in
            guard let self = self else { throw PMKError.cancelled }
            self.delegate.showCenterLoader()
            return useCaseNewsList.execute()
            }.map { (items: [NewsBO]) in
                items.map { NewsListVO(with: $0) }
            }.done { [weak self] items in
                guard let self = self else { throw PMKError.cancelled }
                self.items = items
                self.delegate.itemsLoaded(items: items)
            }.catch { [weak self] error in
                guard let self = self else { return }
                self.delegate.showError(error)
            }.finally { [weak self] in
                guard let self = self else { return }
                self.delegate.hideCenterLoader()
        }
    }
    
    func goToDetail() {
        if let navigationController = delegate.navigationController {
            wireframeNewsDetail.navigate(from: navigationController)
        }
    }
}
