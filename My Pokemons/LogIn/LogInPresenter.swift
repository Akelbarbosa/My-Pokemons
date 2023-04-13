//
//  LogInPresenter.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import Foundation
import FirebaseAuth

protocol LogInPresenterProtocolInput: AnyObject {
    func loginAuth() async throws
    func tappedSignUp()
}

protocol LogInPresenterProtocolOutput: AnyObject {
    
}

class LogInPresenter: LogInPresenterProtocolInput {
    private let interactor: LogInInteractorInputProtocol
    private let router: LogInRouterProtocol
    
    weak var output: LogInPresenterProtocolOutput?
    
    init(interactor: LogInInteractorInputProtocol, router: LogInRouterProtocol) {
        self.interactor = interactor
        self.router = router
        
    }
    
    func loginAuth() async throws  {
        
    }
    
    func tappedSignUp() {
        router.goToSignUp()
    }
}
