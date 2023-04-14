//
//  SignUpInteractor.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 11/04/23.
//

import Foundation
import FirebaseAuth


protocol SignUpInteractorProtocolInput {
    var manager: ManagerFirebase { get }
    
    func registerNewUser(credential: SignUpEntity) async
}

protocol SignUpInteractorProtocolOutput: AnyObject {
    
    
    func registerNewUserSuccess()
    func registerNewUserFailure(error: NSError?)
}

class SignUpInteractor: SignUpInteractorProtocolInput {
    weak var output: SignUpInteractorProtocolOutput?
    var manager: ManagerFirebase
    
    init(manager: ManagerFirebase) {
        self.manager = manager
    }
    
    func registerNewUser(credential: SignUpEntity) async {
        do {
            try await manager.registerNewUser(credentials: credential)
            output?.registerNewUserSuccess()
        } catch  {
            output?.registerNewUserFailure(error: error as NSError)
        }
    }
    
    private func saveSessionData() {
        
    }
}
