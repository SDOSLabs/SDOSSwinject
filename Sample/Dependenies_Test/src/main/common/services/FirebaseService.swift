//
//  FirebaseService.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate
import SDOSFirebase
import SDOSEnvironment

class FirebaseService: NSObject, ApplicationService {
    static let shared = FirebaseService()
    private override init() { }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let filename = Bundle.main.object(forInfoDictionaryKey: "SDOSFIREBASE_CONFIG_FILENAME") as? String {
            SDOSFirebase.configure(options: SDOSFirebase.options(fileName: filename))
        }
        return true
    }
}
