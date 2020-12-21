//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency (${SRCROOT}/example/dependencies.json))

typealias NavigationController = UINavigationController


extension Container {
    ///Register all dependencies: 10 dependencies
    func registerAllModuleCustom() {
		self.registerNavigationControllerModuleNombreCustomWithRootViewController()
		self.registerNewsRepositoryActionsModuleNombreCustom()
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


//Generate variable to access resolvers (1 skipped)
extension Resolver {
    var dependencies: DependenciesResolver {
        return DependenciesResolver(resolver: self)
    }
}

//Generate resolvers with 9 dependencies (1 skipped)
struct DependenciesResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    func resolveNewsRepositoryActions() -> NewsRepositoryActions {
        return (resolver as! Container).synchronize().resolve(NewsRepositoryActions.self, name: "ModuleNombre")!
    }
    func resolveUseCaseNewsListModuleCustom() -> UseCaseNewsList {
        return (resolver as! Container).synchronize().resolve(UseCaseNewsList.self, name: "Module")!
    }
    func resolveUseCaseNewsDetailModuleCustom() -> UseCaseNewsDetail {
        return (resolver as! Container).synchronize().resolve(UseCaseNewsDetail.self, name: "Module")!
    }
    func resolveNewsListPresenterActionsModuleCustom(delegate: NewsListPresenterDelegate) -> NewsListPresenterActions {
        return (resolver as! Container).synchronize().resolve(NewsListPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsListViewActionsModuleCustom() -> NewsListViewActions {
        return (resolver as! Container).synchronize().resolve(NewsListViewActions.self, name: "Module")!
    }
    func resolveNewsListWireframeActionsModuleCustom() -> NewsListWireframeActions {
        return (resolver as! Container).synchronize().resolve(NewsListWireframeActions.self, name: "Module")!
    }
    func resolveNewsDetailPresenterActionsModuleCustom(delegate: NewsDetailPresenterDelegate) -> NewsDetailPresenterActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailPresenterActions.self, name: "Module", argument: delegate)!
    }
    func resolveNewsDetailViewActionsModuleCustom(item: NewsListVO) -> NewsDetailViewActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailViewActions.self, name: "Module", argument: item)!
    }
    func resolveNewsDetailWireframeActionsModuleCustom() -> NewsDetailWireframeActions {
        return (resolver as! Container).synchronize().resolve(NewsDetailWireframeActions.self, name: "Module")!
    }

}

//Generate registers with 10 dependencies
extension Container {
    @discardableResult
    fileprivate func registerNavigationControllerModuleNombreCustomWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
    }
    @discardableResult
    fileprivate func registerNewsRepositoryActionsModuleNombreCustom() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "ModuleNombre") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseNewsListModuleCustom() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseNewsDetailModuleCustom() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerNewsListPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsListPresenterActions> {
        return self.register(NewsListPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsListPresenterDelegate) in NewsListPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerNewsListViewActionsModuleCustom() -> ServiceEntry<NewsListViewActions> {
        return self.register(NewsListViewActions.self, name: "Module") { (r: Resolver) in NewsListViewController.init() }
    }
    @discardableResult
    fileprivate func registerNewsListWireframeActionsModuleCustom() -> ServiceEntry<NewsListWireframeActions> {
        return self.register(NewsListWireframeActions.self, name: "Module") { (r: Resolver) in NewsListWireframe() }
    }
    @discardableResult
    fileprivate func registerNewsDetailPresenterActionsModuleCustomWithDelegate() -> ServiceEntry<NewsDetailPresenterActions> {
        return self.register(NewsDetailPresenterActions.self, name: "Module") { (r: Resolver, delegate: NewsDetailPresenterDelegate) in NewsDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerNewsDetailViewActionsModuleCustomWithItem() -> ServiceEntry<NewsDetailViewActions> {
        return self.register(NewsDetailViewActions.self, name: "Module") { (r: Resolver, item: NewsListVO) in NewsDetailViewController(item: item) }
    }
    @discardableResult
    fileprivate func registerNewsDetailWireframeActionsModuleCustom() -> ServiceEntry<NewsDetailWireframeActions> {
        return self.register(NewsDetailWireframeActions.self, name: "Module") { (r: Resolver) in NewsDetailWireframe() }
    }

}

