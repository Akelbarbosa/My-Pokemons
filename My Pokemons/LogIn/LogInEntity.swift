//
//  LogInEntity.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import Foundation

protocol AuthFieldProtocol {
    var email: String { get set }
    var password: String { get set }
    var fields: [AuthField] { get }
}


enum AuthField {
    case email
    case password
    case confirmPassword
    case allFields
}

//enum SignUpFieldsEnum {
//    case email
//    case password
//    case confirmPassword
//}


struct LogInEntity: AuthFieldProtocol {
    var email: String
    var password: String
    
    var fields: [AuthField] {
        return [.email, .password, .allFields]
    }
    
}


