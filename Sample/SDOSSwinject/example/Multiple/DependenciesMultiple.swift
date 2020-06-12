//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency


extension Container {
///Register all dependencies: 2 dependencies
    func registerAllModuleCustom() {

		self.registerAllUIModuleCustom()
		self.registerAllBLModuleCustom()
	}
}

//MARK: - UI.json dependency
typealias NavigationController = UINavigationController


extension Container {
///Register all dependencies: 7 dependencies
    internal func registerAllUIModuleCustom() {
		self.registerNavigationControllerModuleNombreCustomWithRootViewController()
		self.registerNewsListPresenterActionsModuleCustomWithDelegate()
		self.registerNewsListViewActionsModuleCustom()
		self.registerNewsListWireframeActionsModuleCustom()
		self.registerNewsDetailPresenterActionsModuleCustomWithDelegate()
		self.registerNewsDetailViewActionsModuleCustomWithItem()
		self.registerNewsDetailWireframeActionsModuleCustom()
	}
}

//Generate variable to access resolvers
extension Resolver {
    var UI: UIResolver {
        return UIResolver(resolver: self)
    }
}

//Generate resolvers with 7 dependencies for dependency file UI.json
internal struct UIResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    internal func resolveNavigationControllerModuleNombreCustom(rootViewController: UIViewController = UIViewController()) -> NavigationController {
        return (resolver as! Container).synchronize().resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
    }
    internal func resolveNewsListPresenterActionsModuleCustom(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (resolver as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsListViewActionsModuleCustom() -> NewsListViewActions {
        return (resolver as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    internal func resolveNewsListWireframeActionsModuleCustom() -> NewsListWireframeActions {
        return (resolver as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    internal func resolveNewsDetailPresenterActionsModuleCustom(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsDetailViewActionsModuleCustom(item: NewsListVO) -> NewsDetailViewActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    internal func resolveNewsDetailWireframeActionsModuleCustom() -> NewsDetailWireframeActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 7 dependencies
extension Container {
    @discardableResult
    internal func registerNavigationControllerModuleNombreCustomWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }
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
///Register all dependencies: 3 dependencies
    func registerAllBLModuleCustom() {
		self.registerUseCaseNewsListModuleCustom()
		self.registerUseCaseNewsDetailModuleCustom()

		self.registerAllRepositoryModule()
	}
}

//Generate variable to access resolvers
extension Resolver {
    var BL: BLResolver {
        return BLResolver(resolver: self)
    }
}

//Generate resolvers with 2 dependencies for dependency file BL.json
struct BLResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    func resolveUseCaseNewsListModuleCustom() -> UseCaseNewsList {
        return (resolver as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    func resolveUseCaseNewsDetailModuleCustom() -> UseCaseNewsDetail {
        return (resolver as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
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

//Generate variable to access resolvers
extension Resolver {
    var Repository: RepositoryResolver {
        return RepositoryResolver(resolver: self)
    }
}

//Generate resolvers with 1 dependencies for dependency file ./Repository.json
struct RepositoryResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    func resolveNewsRepositoryActionsModule() -> NewsRepositoryActions {
        return (resolver as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "Module")!
    }

}

//Generate registers with 1 dependencies
extension Container {
    @discardableResult
    func registerNewsRepositoryActionsModule() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }

}

