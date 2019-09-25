//  This is a generated file, do not edit!
//  SDOSSwinject
//
//  Created by SDOS
//

import Swinject

typealias NavigationController = UINavigationController

extension Container {
    ///Register all dependencies: 10 dependencies
    func registerAllModule() {
		self.registerNavigationControllerModuleNombre()
		self.registerNewsRepositoryActionsModule()
		self.registerUseCaseNewsListModule()
		self.registerUseCaseNewsDetailModule()
		self.registerNewsListPresenterActionsModule()
		self.registerNewsListViewActionsModule()
		self.registerNewsListWireframeActionsModule()
		self.registerNewsDetailPresenterActionsModule()
		self.registerNewsDetailViewActionsModule()
		self.registerNewsDetailWireframeActionsModule()
	}
}

//Generate resolvers with 10 dependencies
extension Resolver {
    func resolveNavigationControllerModuleNombre(rootViewController: UIViewController) -> NavigationController {
        return (self as! Container).synchronize().resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
    }
    func resolveNewsRepositoryActionsModule() -> NewsRepositoryActions {
        return (self as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "Module")!
    }
    func resolveUseCaseNewsListModule() -> UseCaseNewsList {
        return (self as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    func resolveUseCaseNewsDetailModule() -> UseCaseNewsDetail {
        return (self as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
    }
    func resolveNewsListPresenterActionsModule(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (self as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsListViewActionsModule() -> NewsListViewActions {
        return (self as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    func resolveNewsListWireframeActionsModule() -> NewsListWireframeActions {
        return (self as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    func resolveNewsDetailPresenterActionsModule(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (self as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsDetailViewActionsModule(item: NewsListVO) -> NewsDetailViewActions {
        return (self as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    func resolveNewsDetailWireframeActionsModule() -> NewsDetailWireframeActions {
        return (self as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 10 dependencies
extension Container {
    @discardableResult
    func registerNavigationControllerModuleNombre() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }
    @discardableResult
    func registerNewsRepositoryActionsModule() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }
    @discardableResult
    func registerUseCaseNewsListModule() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    func registerUseCaseNewsDetailModule() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }
    @discardableResult
    func registerNewsListPresenterActionsModule() -> ServiceEntry<NewsListPresenterActions> {
        return self.register(NewsListPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsListPresenterDelegate) in NewsListPresenter(delegate: delegate) }
    }
    @discardableResult
    func registerNewsListViewActionsModule() -> ServiceEntry<NewsListViewActions> {
        return self.register(NewsListViewActions.self, name: "Module") { (r: Resolver) in NewsListViewController.init() }
    }
    @discardableResult
    func registerNewsListWireframeActionsModule() -> ServiceEntry<NewsListWireframeActions> {
        return self.register(NewsListWireframeActions.self, name: "Module") { (r: Resolver) in NewsListWireframe() }
    }
    @discardableResult
    func registerNewsDetailPresenterActionsModule() -> ServiceEntry<NewsDetailPresenterActions> {
        return self.register(NewsDetailPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsDetailPresenterDelegate) in NewsDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    func registerNewsDetailViewActionsModule() -> ServiceEntry<NewsDetailViewActions> {
        return self.register(NewsDetailViewActions.self, name: "Module") { (r: Resolver, item: NewsListVO) in NewsDetailViewController(item: item) }
    }
    @discardableResult
    func registerNewsDetailWireframeActionsModule() -> ServiceEntry<NewsDetailWireframeActions> {
        return self.register(NewsDetailWireframeActions.self, name: "Module") { (r: Resolver) in NewsDetailWireframe() }
    }

}

