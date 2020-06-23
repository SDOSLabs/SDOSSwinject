//
//  AppliveryService.swift
//  TestApplivery
//
//  Created by Rafael Fernandez Alvarez on 05/04/2020.
//  Copyright © 2020 SDOS. All rights reserved.
//

import UIKit
import SDOSPluggableApplicationDelegate
#if canImport(Applivery)
import Applivery
#endif

class AppliveryService: NSObject, ApplicationService {
    static let shared = AppliveryService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if canImport(Applivery)
        if let token = Bundle.main.object(forInfoDictionaryKey: "SDOSAPPLIVERY_TOKEN") as? String {
            Applivery.shared.start(token: token, appStoreRelease: false)
        }
        #endif
        return true
    }
}
