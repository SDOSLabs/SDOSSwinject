//
//  UserInterfaceService.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate

class UserInterfaceService: NSObject, ApplicationService, SceneService {
    static let shared = UserInterfaceService()
    private override init() { }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if #available(iOS 13.0, *) {} else {
            loadViewController(window: UIWindow(frame: UIScreen.main.bounds))
        }
        return true
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            loadViewController(window: UIWindow(windowScene: windowScene))
        }
    }
    
    //MARK: - Private methods
    
    private func loadViewController(window: UIWindow) {
        window.rootViewController = UIViewController() //TODO: Configure first ViewController
        window.makeKeyAndVisible()
        self.window = window
    }
}
