//
//  SceneDelegate.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSPluggableApplicationDelegate

@available(iOS 13.0, *)
class SceneDelegate: PluggableSceneDelegate {
    
    override var sceneServices: [SceneService] {
        return [
            UserInterfaceService.shared
        ]
    }
}
