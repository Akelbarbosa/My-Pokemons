//
//  SignUpErrors.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 12/04/23.
//

import Foundation

enum SignUpErrors: String, Error {
   
    // Field error
    case fieldsAreEmpty
    
    case emailIsEmpty
    case passwordIsEmpty
    case confirmPasswordIsEmpty

    case invalidEmail
    case passwordIsShort
    case passwordsDifferent
    
    // Firebase Error
    case emailExist
    
    func text() -> String {
        return NSLocalizedString("\(self)", comment: "")
    }
}
