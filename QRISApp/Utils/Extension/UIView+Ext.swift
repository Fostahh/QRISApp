//
//  UIView+Ext.swift
//  QRISApp
//
//  Created by Mohammad Azri on 03/04/24.
//

import UIKit

extension UIView {
    func stopLoading() {
        subviews.compactMap { $0 as? LoadingView }.forEach { loadingView in
            loadingView.stopAnimating()
        }
    }
}
