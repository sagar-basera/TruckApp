//
//  UIView+Ext.swift
//  TruckApp
//
//  Created by SAGAR SINGH on 01/04/24.
//

import UIKit

extension UIView {
    /// FUNCTION TO ADD SHADOW'S TO A VIEW.
    func addShadow(cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOpacity: Float, color: UIColor , shadowOffset: CGSize){
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = shadowOpacity
            layer.shadowColor = color.cgColor
            layer.shadowOffset = shadowOffset
        }
    
}
