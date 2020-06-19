//
//  NewsDetailPresenter.swift
//
//  Created by Rafael Fernandez Alvarez on 12/06/2020.
//  Archivo creado usando la plantilla VIPER por SDOS http://www.sdos.es/
//

import UIKit
import PromiseKit

/*
 Dependency register JSON
 
 {
    "dependencyName": "NewsDetailPresenterActions",
    "className": "NewsDetailPresenter",
    "arguments": [
        {
            "name": "delegate",
            "type": "NewsDetailPresenterDelegate"
        }
    ]
 }
 */

protocol NewsDetailPresenterDelegate: UIViewController {
    func loadUI()
    func showError(_ error: Error)
    func showCenterLoader()
    func hideCenterLoader()
    func itemsLoaded(items: [NewsDetailVO])
}

protocol NewsDetailPresenterActions: BasePresenterActions {
    init(delegate: NewsDetailPresenterDelegate)
    
    var items: [NewsDetailVO]? { get }
    
    func viewDidLoad()
}

class NewsDetailPresenter: BasePresenter {
    unowned var delegate: NewsDetailPresenterDelegate
    private lazy var useCaseNewsDetail: UseCaseNewsDetail = {
        Dependency.injector.dependencies.news.newsDetail.newsBL.resolveUseCaseNewsDetail()
    }()
    private lazy var wireframe: NewsDetailWireframeActions = {
        Dependency.injector.dependencies.news.newsDetail.resolveNewsDetailWireframeActions()
    }()
    
    var items: [NewsDetailVO]?
    
    required init(delegate: NewsDetailPresenterDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    //MARK: - FilePrivate methods
    
}

extension NewsDetailPresenter: NewsDetailPresenterActions {
    func viewDidLoad() {
        delegate.loadUI()
        firstly { [weak self] () -> Promise<[NewsBO]> in
            guard let self = self else { throw PMKError.cancelled }
            self.delegate.showCenterLoader()
            return useCaseNewsDetail.execute()
            }.map { (items: [NewsBO]) in
                items.map { NewsDetailVO(with: $0) }
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
    
}
