//
//  KeyboardService.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
import IQKeyboardManagerSwift

class KeyboardService: NSObject, ApplicationService {
    static let shared = KeyboardService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IQKeyboardManager.shared.enable = true
        return true
    }
}
