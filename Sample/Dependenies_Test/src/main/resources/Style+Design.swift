//
//  Style+Design.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import UIKit
import SDOSSwiftExtension

extension UIView {
    enum style {
        typealias View = UIView
        
        ///Apply with the next line: UIView.style.style1.apply(to: <#T##view#>)
        static var style1: Style<View> {
            return Style<View> {
                $0.backgroundColor = .blue
            }
        }
    }
}
