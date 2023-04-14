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
    
    
    func registerNewUser(credentials: SignUpEntity) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: credentials.email, password: credentials.password)
        } catch {
            throw error
        }
    }
    
    func loginAuth(credential: LogInEntity) async throws -> AuthDataResult {
        do {
            let result = try await Auth.auth().signIn(withEmail: credential.email, password: credential.password)
            return result
        } catch  {
            throw error
        }
    }
}
