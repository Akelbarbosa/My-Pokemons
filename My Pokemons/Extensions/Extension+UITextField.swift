//
//  Extension.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 11/04/23.
//

import Foundation
import UIKit

extension UITextField {
    func insertPaddingLeft(left: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
