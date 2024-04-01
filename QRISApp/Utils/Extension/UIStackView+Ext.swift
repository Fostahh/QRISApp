//
//  UIStackView+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 02/04/24.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
}

