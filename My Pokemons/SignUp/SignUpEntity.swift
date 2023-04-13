//
//  SignUpEntity.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 12/04/23.
//

import Foundation

struct SignUpEntity: AuthFieldProtocol {
    var email: String
    var password: String
    var confirmPassword: String
    
    var fields: [AuthField] {
        return [.email, .password, .confirmPassword, .allFields]
     }
}
