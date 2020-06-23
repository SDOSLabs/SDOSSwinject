//
//  FLEXService.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
#if canImport(FLEX)
import FLEX
#endif

class FLEXService: NSObject, ApplicationService {
    static let shared = FLEXService()
    private override init() { }
    
    #if canImport(FLEX)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        return true
    }
    #endif
}

