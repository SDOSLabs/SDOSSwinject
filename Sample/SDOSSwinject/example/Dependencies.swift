//  This is a generated file, do not edit!
//  SDOSSwinject
//
//  Created by SDOS
//

import Swinject

typealias NavigationController = UINavigationController

extension Container {
    ///Register all dependencies: 10 dependencies
    func registerAllModuleCustom() {
		self.registerNavigationControllerModuleNombreCustomWithRootViewController()
		self.registerNewsRepositoryActionsModuleCustom()
		self.registerUseCaseNewsListModuleCustom()
		self.registerUseCaseNewsDetailModuleCustom()
		self.registerNewsListPresenterActionsModuleCustomWithDelegate()
		self.registerNewsListViewActionsModuleCustom()
		self.registerNewsListWireframeActionsModuleCustom()
		self.registerNewsDetailPresenterActionsModuleCustomWithDelegate()
		self.registerNewsDetailViewActionsModuleCustomWithItem()
		self.registerNewsDetailWireframeActionsModuleCustom()
	}
}

//Generate resolvers with 9 dependencies (1 skipped)
extension Resolver {
    func resolveNewsRepositoryActionsModuleCustom() -> NewsRepositoryActions {
        return (self as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "Module")!
    }
    func resolveUseCaseNewsListModuleCustom() -> UseCaseNewsList {
        return (self as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    func resolveUseCaseNewsDetailModuleCustom() -> UseCaseNewsDetail {
        return (self as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
    }
    func resolveNewsListPresenterActionsModuleCustom(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (self as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsListViewActionsModuleCustom() -> NewsListViewActions {
        return (self as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    func resolveNewsListWireframeActionsModuleCustom() -> NewsListWireframeActions {
        return (self as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    func resolveNewsDetailPresenterActionsModuleCustom(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (self as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsDetailViewActionsModuleCustom(item: NewsListVO) -> NewsDetailViewActions {
        return (self as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    func resolveNewsDetailWireframeActionsModuleCustom() -> NewsDetailWireframeActions {
        return (self as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 10 dependencies
extension Container {
    @discardableResult
    func registerNavigationControllerModuleNombreCustomWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }
    @discardableResult
    func registerNewsRepositoryActionsModuleCustom() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }
    @discardableResult
    func registerUseCaseNewsListModuleCustom() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    func registerUseCaseNewsDetailModuleCustom() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }
    @discardableResult
    func registerNewsListPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsListPresenterActions> {
        return self.register(NewsListPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsListPresenterDelegate) in NewsListPresenter(delegate: delegate) }
    }
    @discardableResult
    func registerNewsListViewActionsModuleCustom() -> ServiceEntry<NewsListViewActions> {
        return self.register(NewsListViewActions.self, name: "Module") { (r: Resolver) in NewsListViewController.init() }
    }
    @discardableResult
    func registerNewsListWireframeActionsModuleCustom() -> ServiceEntry<NewsListWireframeActions> {
        return self.register(NewsListWireframeActions.self, name: "Module") { (r: Resolver) in NewsListWireframe() }
    }
    @discardableResult
    func registerNewsDetailPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsDetailPresenterActions> {
        return self.register(NewsDetailPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsDetailPresenterDelegate) in NewsDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    func registerNewsDetailViewActionsModuleCustomWithItem() -> ServiceEntry<NewsDetailViewActions> {
        return self.register(NewsDetailViewActions.self, name: "Module") { (r: Resolver, item: NewsListVO) in NewsDetailViewController(item: item) }
    }
    @discardableResult
    func registerNewsDetailWireframeActionsModuleCustom() -> ServiceEntry<NewsDetailWireframeActions> {
        return self.register(NewsDetailWireframeActions.self, name: "Module") { (r: Resolver) in NewsDetailWireframe() }
    }

}

