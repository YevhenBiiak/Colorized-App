//
//  UITextField+.swift
//  Colorized App
//
//  Created by Евгений Бияк on 24.07.2022.
//

import UIKit

extension UITextField {
    enum KeyboardToolbarButtonPosition { case left, right }
    func addKeyboardToolbarButton(_ button: UIBarButtonItem, position: KeyboardToolbarButtonPosition) {
        if let toolbar = inputAccessoryView as? UIToolbar, let toolbarItems = toolbar.items {
            
            switch position {
            case .right: toolbar.items = toolbarItems + [UIBarButtonItem.flexibleSpace(), button]
            case .left: toolbar.items = [button, UIBarButtonItem.flexibleSpace()] + toolbarItems }
            
        } else {
            let toolbar = UIToolbar()
            self.inputAccessoryView = toolbar
            toolbar.sizeToFit()
            
            switch position {
            case .right: toolbar.items = [UIBarButtonItem.flexibleSpace(), button]
            case .left: toolbar.items = [button] }
        }
    }
}
