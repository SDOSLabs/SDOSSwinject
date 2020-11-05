//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency (${SRCROOT}/example/dependenciesAccessLevel.json))

typealias NavigationController = UINavigationController


extension Container {
    ///Register all dependencies: 10 dependencies
    public func registerAllModule() {
		self.registerNavigationControllerModuleNombreWithRootViewController()
		self.registerNewsRepositoryActionsModule()
		self.registerUseCaseNewsListModule()
		self.registerUseCaseNewsDetailModule()
		self.registerNewsListPresenterActionsModuleWithDelegate()
		self.registerNewsListViewActionsModule()
		self.registerNewsListWireframeActionsModule()
		self.registerNewsDetailPresenterActionsModuleWithDelegate()
		self.registerNewsDetailViewActionsModuleWithItem()
		self.registerNewsDetailWireframeActionsModule()
	}
}


//Generate variable to access resolvers
internal extension Resolver {
    var dependenciesAccessLevel: DependenciesAccessLevelResolver {
        return DependenciesAccessLevelResolver(resolver: self)
    }
}

//Generate resolvers with 10 dependencies
internal struct DependenciesAccessLevelResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    internal func resolveNavigationControllerModuleNombre(rootViewController: UIViewController) -> NavigationController {
        return (self as! Container).synchronize().resolve(NavigationController.self, name: "ModuleNombre", argument: rootViewController)!
    }
    internal func resolveNewsRepositoryActionsModule() -> NewsRepositoryActions {
        return (self as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "Module")!
    }
    internal func resolveUseCaseNewsListModule() -> UseCaseNewsList {
        return (self as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    public func resolveUseCaseNewsDetailModule() -> UseCaseNewsDetail {
        return (self as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
    }
    internal func resolveNewsListPresenterActionsModule(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (self as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsListViewActionsModule() -> NewsListViewActions {
        return (self as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    internal func resolveNewsListWireframeActionsModule() -> NewsListWireframeActions {
        return (self as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    internal func resolveNewsDetailPresenterActionsModule(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (self as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    internal func resolveNewsDetailViewActionsModule(item: NewsListVO) -> NewsDetailViewActions {
        return (self as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    internal func resolveNewsDetailWireframeActionsModule() -> NewsDetailWireframeActions {
        return (self as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 10 dependencies
extension Container {
    @discardableResult
    fileprivate func registerNavigationControllerModuleNombreWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }
    @discardableResult
    fileprivate func registerNewsRepositoryActionsModule() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseNewsListModule() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseNewsDetailModule() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerNewsListPresenterActionsModuleWithDelegate() -> ServiceEntry<NewsListPresenterActions> {
        return self.register(NewsListPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsListPresenterDelegate) in NewsListPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerNewsListViewActionsModule() -> ServiceEntry<NewsListViewActions> {
        return self.register(NewsListViewActions.self, name: "Module") { (r: Resolver) in NewsListViewController() }
    }
    @discardableResult
    fileprivate func registerNewsListWireframeActionsModule() -> ServiceEntry<NewsListWireframeActions> {
        return self.register(NewsListWireframeActions.self, name: "Module") { (r: Resolver) in NewsListWireframe() }
    }
    @discardableResult
    fileprivate func registerNewsDetailPresenterActionsModuleWithDelegate() -> ServiceEntry<NewsDetailPresenterActions> {
        return self.register(NewsDetailPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsDetailPresenterDelegate) in NewsDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerNewsDetailViewActionsModuleWithItem() -> ServiceEntry<NewsDetailViewActions> {
        return self.register(NewsDetailViewActions.self, name: "Module") { (r: Resolver, item: NewsListVO) in NewsDetailViewController(item: item) }
    }
    @discardableResult
    fileprivate func registerNewsDetailWireframeActionsModule() -> ServiceEntry<NewsDetailWireframeActions> {
        return self.register(NewsDetailWireframeActions.self, name: "Module") { (r: Resolver) in NewsDetailWireframe() }
    }

}

