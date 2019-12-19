//
//  UIViewControllerExtention.swift
//  Sourcely42
//
//  Created by Dhiraj Laddha on 26/10/18.
//  Copyright © 2018 Dhiraj Laddha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    @IBAction func popToViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    func isNavigationBarHidden(_ isShow: Bool) {
        self.navigationController?.setNavigationBarHidden(isShow, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func removeNavigationBarLine() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func showAlert(_ title: String, _ message: String) {
        self.present(HelperClass.showAlertWithTitle(title: title, andMessage: message, withOnlyOneButtonTitle: "Ok", completion: { (success) in
            
        }), animated: true, completion: nil)
    }
    

}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }

}
