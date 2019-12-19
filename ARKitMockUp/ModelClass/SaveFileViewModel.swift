//
//  SaveFileViewModel.swift
//  ARKitMockUp
//
//  Created by Dhiraj Laddha on 22/04/19.
//  Copyright © 2019 Dhiraj Laddha. All rights reserved.
//

import UIKit

class SaveFileViewModel: NSObject {

    // create share instance
    static let sharedInstance = SaveFileViewModel()
    
    // override the init and make it private so that another instance cannot be created.
    private override init() {}
}
