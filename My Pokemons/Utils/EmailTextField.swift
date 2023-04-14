//
//  EmailTextField.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 13/04/23.
//

import UIKit

class EmailTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.keyboardType = .emailAddress
        self.textContentType = .oneTimeCode
        self.layer.cornerRadius = .pi * 2
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.font = .preferredFont(forTextStyle: .body)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
