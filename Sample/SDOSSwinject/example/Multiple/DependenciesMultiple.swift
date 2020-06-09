//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency

typealias NavigationController = UINavigationController


extension Container {
///Register all dependencies: 1 dependencies
func registerAllModuleCustom() {
		self.registerNavigationControllerModuleNombreCustomWithRootViewController()

		self.registerAllUIModuleCustom()
		self.registerAllBLModuleCustom()
	}
}

//Generate resolvers with 1 dependencies
extension Resolver {
    func resolveNavigationControllerModuleNombreCustom(rootViewController: UIViewController = UIViewController()) -> NavigationController {
        return (self as! Container).synchronize().resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
    }

}

//Generate registers with 1 dependencies
extension Container {
    @discardableResult
    func registerNavigationControllerModuleNombreCustomWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }

}

//MARK: - UI.json dependency


extension Container {
///Register all dependencies: 6 dependencies
internal func registerAllUIModuleCustom() {
		self.registerNewsListPresenterActionsModuleCustomWithDelegate()
		self.registerNewsListViewActionsModuleCustom()
		self.registerNewsListWireframeActionsModuleCustom()
		self.registerNewsDetailPresenterActionsModuleCustomWithDelegate()
		self.registerNewsDetailViewActionsModuleCustomWithItem()
		self.registerNewsDetailWireframeActionsModuleCustom()
	}
}

//Generate resolvers with 6 dependencies
extension Resolver {
    internal func resolveNewsListPresenterActionsModuleCustom(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (self as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsListViewActionsModuleCustom() -> NewsListViewActions {
        return (self as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    internal func resolveNewsListWireframeActionsModuleCustom() -> NewsListWireframeActions {
        return (self as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    internal func resolveNewsDetailPresenterActionsModuleCustom(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (self as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsDetailViewActionsModuleCustom(item: NewsListVO) -> NewsDetailViewActions {
        return (self as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    internal func resolveNewsDetailWireframeActionsModuleCustom() -> NewsDetailWireframeActions {
        return (self as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 6 dependencies
extension Container {
    @discardableResult
    internal func registerNewsListPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsListPresenterActions> {
        return self.register(NewsListPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsListPresenterDelegate) in NewsListPresenter(delegate: delegate) }
    }
    @discardableResult
    internal func registerNewsListViewActionsModuleCustom() -> ServiceEntry<NewsListViewActions> {
        return self.register(NewsListViewActions.self, name: "Module") { (r: Resolver) in NewsListViewController.init() }
    }
    @discardableResult
    internal func registerNewsListWireframeActionsModuleCustom() -> ServiceEntry<NewsListWireframeActions> {
        return self.register(NewsListWireframeActions.self, name: "Module") { (r: Resolver) in NewsListWireframe() }
    }
    @discardableResult
    internal func registerNewsDetailPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsDetailPresenterActions> {
        return self.register(NewsDetailPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsDetailPresenterDelegate) in NewsDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    internal func registerNewsDetailViewActionsModuleCustomWithItem() -> ServiceEntry<NewsDetailViewActions> {
        return self.register(NewsDetailViewActions.self, name: "Module") { (r: Resolver, item: NewsListVO) in NewsDetailViewController(item: item) }
    }
    @discardableResult
    internal func registerNewsDetailWireframeActionsModuleCustom() -> ServiceEntry<NewsDetailWireframeActions> {
        return self.register(NewsDetailWireframeActions.self, name: "Module") { (r: Resolver) in NewsDetailWireframe() }
    }

}

//MARK: - BL.json dependency


extension Container {
///Register all dependencies: 2 dependencies
func registerAllBLModuleCustom() {
		self.registerUseCaseNewsListModuleCustom()
		self.registerUseCaseNewsDetailModuleCustom()

		self.registerAllRepositoryModule()
	}
}

//Generate resolvers with 2 dependencies
extension Resolver {
    func resolveUseCaseNewsListModuleCustom() -> UseCaseNewsList {
        return (self as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    func resolveUseCaseNewsDetailModuleCustom() -> UseCaseNewsDetail {
        return (self as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
    }

}

//Generate registers with 2 dependencies
extension Container {
    @discardableResult
    func registerUseCaseNewsListModuleCustom() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    func registerUseCaseNewsDetailModuleCustom() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }

}

//MARK: - ./Repository.json dependency


extension Container {
///Register all dependencies: 1 dependencies
func registerAllRepositoryModule() {
		self.registerNewsRepositoryActionsModule()
	}
}

//Generate resolvers with 1 dependencies
extension Resolver {
    func resolveNewsRepositoryActionsModule() -> NewsRepositoryActions {
        return (self as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "Module")!
    }

}

//Generate registers with 1 dependencies
extension Container {
    @discardableResult
    func registerNewsRepositoryActionsModule() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }

}

