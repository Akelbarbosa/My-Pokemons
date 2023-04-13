//
//  ErrorMessageLabel.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 13/04/23.
//

import UIKit

class ErrorMessageLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = .red
        self.adjustsFontSizeToFitWidth = true
        self.font = .preferredFont(forTextStyle: .caption1)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
