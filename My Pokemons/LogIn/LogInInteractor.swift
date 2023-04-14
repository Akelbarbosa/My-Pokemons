//
//  LogInInteractor.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import Foundation
import Firebase

protocol LogInInteractorProtocolInput {
    var manager: ManagerFirebase? { get }
    func logIn(credentials: LogInEntity) async
    func saveDataAuth()
}

protocol LogInInteractorProtocolOutput: AnyObject {

    func logInSuccess(authData: User?)
    func logInError(error: NSError?)
}

class LogInInteractor: LogInInteractorProtocolInput {
    weak var output: LogInInteractorProtocolOutput?
    var manager: ManagerFirebase?
    
    init(output: LogInInteractorProtocolOutput? = nil, manager: ManagerFirebase? = nil) {
        self.manager = manager
    }
    
    func logIn(credentials: LogInEntity) async {
        do {
            let authData = try await manager?.loginAuth(credential: credentials)
            output?.logInSuccess(authData: authData?.user)
        } catch {
            output?.logInError(error: error as NSError)
        }
    }
    
    func saveDataAuth()  {
        
    }
    
}
