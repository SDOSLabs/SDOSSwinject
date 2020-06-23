//
//  VIPERBaseClass.swift
//  Dependenies_Test
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import SDOSFirebase

@objc class BaseRepository: NSObject {
    
}

@objc class BaseInteractor : NSObject {
    
}

@objc class BasePresenter : NSObject {
    
}

@objc class BaseViewController : UIViewController {
    
    //MARK: - Init
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Firebase
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SDOSFirebase.setScreenName(forInstance: self)
    }
}

@objc class BaseWireframe: NSObject {
    
}
