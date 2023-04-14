//
//  LogInErrors.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 14/04/23.
//

import Foundation

enum LogInErrors: String, Error {
   
    // Field error
    case fieldsAreEmpty
    case emailIsEmpty
    case invalidEmail
    case passwordIsEmpty

    case passwordIsShort
    case passwordInvalid
    
    case wrongPassword
    case userNotFound
    
    func text() -> String {
        return NSLocalizedString("\(self)", comment: "")
    }
}
