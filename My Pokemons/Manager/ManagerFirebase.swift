//
//  ManagerFirebase.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 12/04/23.
//

import Foundation
import Firebase
import FirebaseAuth

class ManagerFirebase {
    static let shared = ManagerFirebase()
    
    
    func registerNewUser(credentials: SignUpEntity) async throws ->  AuthDataResult {
        do {
            let result = try await Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
            return result
        } catch {
            throw error
        }
    }
}
