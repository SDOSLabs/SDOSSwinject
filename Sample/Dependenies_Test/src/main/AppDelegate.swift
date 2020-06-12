//
//  AppDelegate.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import UIKit
import SDOSPluggableApplicationDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    
    override var applicationServices: [ApplicationService] {
        return [
            EnviromentService.shared, //MUST BE FIRST
            FLEXService.shared,
            AppliveryService.shared,
            FirebaseService.shared,
            KeyboardService.shared,
            UserInterfaceService.shared
        ]
    }
}

