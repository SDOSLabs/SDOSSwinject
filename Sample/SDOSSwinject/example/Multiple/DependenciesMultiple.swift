//  This is a generated file, do not edit!
//  SDOSSwinject
//  Created by SDOS
//
import Swinject

//MARK: - Root dependency (${SRCROOT}/example/Multiple/Dependencies.json))


extension Container {
    ///Register all dependencies: 1 dependencies
    func registerAllModuleCustom() {
		self.registerAllEvent()
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


//Generate variable to access resolvers
extension Resolver {
    var event: EventResolver {
        return EventResolver(resolver: self)
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

