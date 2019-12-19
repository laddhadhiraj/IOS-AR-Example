//
//  UIViewExtentions.swift
//  Sourcely42
//
//  Created by Dhiraj Laddha on 26/10/18.
//  Copyright © 2018 Dhiraj Laddha. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var vcornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var vborderWidth: CGFloat{
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var vborderColor: UIColor{
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }set{
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var vshadowColor:UIColor{
        get{
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }else{
                return UIColor.clear
            }
        }set{
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var vshadowRadius: CGFloat {
        get{
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var vshadowOffset: CGSize{
        get{
            return layer.shadowOffset
        }set{
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var vshadowOpacity: Float{
        get{
            return layer.shadowOpacity
        }set{
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var vmakeCircle:Bool {
        get{
            return true
        }set{
            if vmakeCircle{
                clipsToBounds = true
                layoutIfNeeded()
                layer.cornerRadius = frame.size.width / 2
            }
        }
    }
}
