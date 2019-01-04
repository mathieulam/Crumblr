//
//  UIView+extension.swift
//  Crumblr
//
//  Created by Mathieu Lamvohee on 1/4/19.
//  Copyright © 2019 Mathieu Lamvohee. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
