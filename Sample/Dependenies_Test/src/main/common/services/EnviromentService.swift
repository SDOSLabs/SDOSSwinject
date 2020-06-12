//
//  EnviromentService.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
import SDOSEnvironment

class EnviromentService: NSObject, ApplicationService {
    static let shared = EnviromentService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SDOSEnvironment.configure(activeLogging: true)
        return true
    }
}
