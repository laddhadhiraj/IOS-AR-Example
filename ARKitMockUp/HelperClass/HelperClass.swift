//
//  HelperClass.swift
//  Sourcely42
//
//  Created by Dhiraj Laddha on 27/10/18.
//  Copyright © 2018 Dhiraj Laddha. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class HelperClass: NSObject {
    var searchDoneBtnTap: (()-> Void) = {}
    
    class var sharedInstance: HelperClass {
        struct shared {
            static let instance = HelperClass()
        }
        return shared.instance
    }
    
    class func showAlertWithTitle(title : String, andMessage message:String, withOnlyOneButtonTitle btntitle:String, completion: @escaping (_ result: Bool) -> Void) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: btntitle, style: UIAlertAction.Style.default, handler:
        {Void in
            print("Alert Button \(btntitle) Click")
            completion(true)
        })
        alertController.addAction(okAction)
        return alertController
    }
    
    class func showAlertWithTitleTwoOption(title : String, andMessage message:String, withFirstButtonTitle btnFirst:String, andButtonSecondButtonTitle btnSecond:String, completion: @escaping (_ result: Bool) -> Void) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let firstAction = UIAlertAction(title: btnFirst, style: UIAlertAction.Style.default, handler:
        {Void in
            completion(false)
        })
        
        let secondAction = UIAlertAction(title: btnSecond, style: UIAlertAction.Style.default, handler:
        {Void in
            completion(true)
        })
        
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        return alertController
    }
}


extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector("statusBar")) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
