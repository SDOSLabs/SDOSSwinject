//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency (${SRCROOT}/example/Multiple/Dependencies.json))


extension Container {
    ///Register all dependencies: 4 dependencies
    func registerAllModuleCustom() {
		self.registerUseCaseNewsList2ModuleCustom()

		self.registerAllUIModuleCustom()
		self.registerAllBLModuleCustom()
		self.registerAllEvent()
	}
}


//Generate variable to access resolvers
extension Resolver {
    var dependencies: DependenciesResolver {
        return DependenciesResolver(resolver: self)
    }
}

//Generate resolvers with 1 dependencies
struct DependenciesResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    var uI: UIResolver {
        return UIResolver(resolver: resolver)
    }
    var bL: BLResolver {
        return BLResolver(resolver: resolver)
    }
    var event: EventResolver {
        return EventResolver(resolver: resolver)
    }
    func resolveUseCaseNewsList2ModuleCustom() -> UseCaseNewsList2 {
        return (self as! Container).synchronize().resolve(UseCaseNewsList2.self, name: "Module")!
    }

}

//Generate registers with 1 dependencies
extension Container {
    @discardableResult
    fileprivate func registerUseCaseNewsList2ModuleCustom() -> ServiceEntry<UseCaseNewsList2> {
        return self.register(UseCaseNewsList2.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/UI.json dependency
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

//Generate resolvers with 7 dependencies
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
    fileprivate func registerNavigationControllerModuleNombreCustomWithRootViewController() -> ServiceEntry<NavigationController> {
        return self.register(NavigationController.self, name: "ModuleNombre") { (r: Resolver, rootViewController: UIViewController) in UINavigationController(rootViewController: rootViewController) }
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

//MARK: - ${SRCROOT}/example/Multiple/BL.json dependency

extension Container {
    ///Register all dependencies: 3 dependencies
    func registerAllBLModuleCustom() {
		self.registerUseCaseNewsListModuleCustom()
		self.registerUseCaseNewsDetailModuleCustom()

		self.registerAllRepositoryModule()
	}
}

//Generate resolvers with 2 dependencies
struct BLResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    var repository: RepositoryResolver {
        return RepositoryResolver(resolver: resolver)
    }
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
    fileprivate func registerUseCaseNewsListModuleCustom() -> ServiceEntry<UseCaseNewsList> {
        return self.register(UseCaseNewsList.self, name: "Module") { (r: Resolver) in UseCaseNews.List() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseNewsDetailModuleCustom() -> ServiceEntry<UseCaseNewsDetail> {
        return self.register(UseCaseNewsDetail.self, name: "Module") { (r: Resolver) in UseCaseNews.Detail() }.inObjectScope(.container)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/Repository.json dependency

extension Container {
    ///Register all dependencies: 1 dependencies
    func registerAllRepositoryModule() {
		self.registerNewsRepositoryActionsModule()
	}
}

//Generate resolvers with 1 dependencies
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
    fileprivate func registerNewsRepositoryActionsModule() -> ServiceEntry<NewsRepositoryActions> {
        return self.register(NewsRepositoryActions.self, name: "Module") { (r: Resolver) in NewsRepository() }.inObjectScope(.container)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/events/Event.json dependency

extension Container {
    ///Register all dependencies: 2 dependencies
    func registerAllEvent() {
		self.registerAllEventDetail()
		self.registerAllEventList()
	}
}

//Generate resolvers with 0 dependencies
struct EventResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    var eventDetail: EventDetailResolver {
        return EventDetailResolver(resolver: resolver)
    }
    var eventList: EventListResolver {
        return EventListResolver(resolver: resolver)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/events/detail/EventDetail.json dependency

extension Container {
    ///Register all dependencies: 5 dependencies
    func registerAllEventDetail() {
		self.registerEventDetailPresenterActionsWithDelegate()
		self.registerEventDetailViewActions()
		self.registerEventDetailWireframeActions()

		self.registerAllEventRepository()
		self.registerAllEventBL()
	}
}

//Generate resolvers with 3 dependencies
struct EventDetailResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    var eventRepository: EventRepositoryResolver {
        return EventRepositoryResolver(resolver: resolver)
    }
    var eventBL: EventBLResolver {
        return EventBLResolver(resolver: resolver)
    }
    func resolveEventDetailPresenterActions(delegate: EventDetailPresenterDelegate) -> EventDetailPresenterActions {
        return (resolver as! Container).synchronize().resolve(EventDetailPresenterActions.self, argument: delegate)!
    }
    func resolveEventDetailViewActions() -> EventDetailViewActions {
        return (resolver as! Container).synchronize().resolve(EventDetailViewActions.self)!
    }
    func resolveEventDetailWireframeActions() -> EventDetailWireframeActions {
        return (resolver as! Container).synchronize().resolve(EventDetailWireframeActions.self)!
    }

}

//Generate registers with 3 dependencies
extension Container {
    @discardableResult
    fileprivate func registerEventDetailPresenterActionsWithDelegate() -> ServiceEntry<EventDetailPresenterActions> {
        return self.register(EventDetailPresenterActions.self) { (r: Resolver, delegate: EventDetailPresenterDelegate) in EventDetailPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerEventDetailViewActions() -> ServiceEntry<EventDetailViewActions> {
        return self.register(EventDetailViewActions.self) { (r: Resolver) in EventDetailViewController.init() }
    }
    @discardableResult
    fileprivate func registerEventDetailWireframeActions() -> ServiceEntry<EventDetailWireframeActions> {
        return self.register(EventDetailWireframeActions.self) { (r: Resolver) in EventDetailWireframe() }
    }

}

//MARK: - ${SRCROOT}/example/Multiple/events/common/EventRepository.json dependency

extension Container {
    ///Register all dependencies: 1 dependencies
    func registerAllEventRepository() {
		self.registerEventRepositoryActions()
	}
}

//Generate resolvers with 1 dependencies
struct EventRepositoryResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    func resolveEventRepositoryActions() -> EventRepositoryActions {
        return (resolver as! Container).synchronize().resolve(EventRepositoryActions.self)!
    }

}

//Generate registers with 1 dependencies
extension Container {
    @discardableResult
    fileprivate func registerEventRepositoryActions() -> ServiceEntry<EventRepositoryActions> {
        return self.register(EventRepositoryActions.self) { (r: Resolver) in EventRepository() }.inObjectScope(.container)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/events/common/EventBL.json dependency

extension Container {
    ///Register all dependencies: 2 dependencies
    func registerAllEventBL() {
		self.registerUseCaseEventList()
		self.registerUseCaseEventDetail()
	}
}

//Generate resolvers with 2 dependencies
struct EventBLResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    func resolveUseCaseEventList() -> UseCaseEventList {
        return (resolver as! Container).synchronize().resolve(UseCaseEventList.self)!
    }
    func resolveUseCaseEventDetail() -> UseCaseEventDetail {
        return (resolver as! Container).synchronize().resolve(UseCaseEventDetail.self)!
    }

}

//Generate registers with 2 dependencies
extension Container {
    @discardableResult
    fileprivate func registerUseCaseEventList() -> ServiceEntry<UseCaseEventList> {
        return self.register(UseCaseEventList.self) { (r: Resolver) in UseCaseEvent.List() }.inObjectScope(.container)
    }
    @discardableResult
    fileprivate func registerUseCaseEventDetail() -> ServiceEntry<UseCaseEventDetail> {
        return self.register(UseCaseEventDetail.self) { (r: Resolver) in UseCaseEvent.Detail() }.inObjectScope(.container)
    }

}

//MARK: - ${SRCROOT}/example/Multiple/events/list/EventList.json dependency

extension Container {
    ///Register all dependencies: 5 dependencies
    func registerAllEventList() {
		self.registerEventListPresenterActionsWithDelegate()
		self.registerEventListViewActions()
		self.registerEventListWireframeActions()

		self.registerAllEventRepository()
		self.registerAllEventBL()
	}
}

//Generate resolvers with 3 dependencies
struct EventListResolver {
	private let resolver: Resolver
	fileprivate init(resolver: Resolver) { self.resolver = resolver }

    var eventRepository: EventRepositoryResolver {
        return EventRepositoryResolver(resolver: resolver)
    }
    var eventBL: EventBLResolver {
        return EventBLResolver(resolver: resolver)
    }
    func resolveEventListPresenterActions(delegate: EventListPresenterDelegate) -> EventListPresenterActions {
        return (resolver as! Container).synchronize().resolve(EventListPresenterActions.self, argument: delegate)!
    }
    func resolveEventListViewActions() -> EventListViewActions {
        return (resolver as! Container).synchronize().resolve(EventListViewActions.self)!
    }
    func resolveEventListWireframeActions() -> EventListWireframeActions {
        return (resolver as! Container).synchronize().resolve(EventListWireframeActions.self)!
    }

}

//Generate registers with 3 dependencies
extension Container {
    @discardableResult
    fileprivate func registerEventListPresenterActionsWithDelegate() -> ServiceEntry<EventListPresenterActions> {
        return self.register(EventListPresenterActions.self) { (r: Resolver, delegate: EventListPresenterDelegate) in EventListPresenter(delegate: delegate) }
    }
    @discardableResult
    fileprivate func registerEventListViewActions() -> ServiceEntry<EventListViewActions> {
        return self.register(EventListViewActions.self) { (r: Resolver) in EventListViewController.init() }
    }
    @discardableResult
    fileprivate func registerEventListWireframeActions() -> ServiceEntry<EventListWireframeActions> {
        return self.register(EventListWireframeActions.self) { (r: Resolver) in EventListWireframe() }
    }

}

