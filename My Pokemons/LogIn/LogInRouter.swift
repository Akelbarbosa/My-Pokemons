//
//  LogInRouter.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import Foundation
import UIKit


protocol LogInRouterProtocol: AnyObject {
    var singUpRouter: SignUpRouterProtocol? { get }
    
    func createModule() -> UIViewController?
    func goToSignUp()
}

class LogInRouter: LogInRouterProtocol {
    var view: LogInView?
    var singUpRouter: SignUpRouterProtocol?
    
    func createModule() -> UIViewController? {
        singUpRouter = SignUpRouter()
        
        let interactor = LogInInteractor()
        let presenter = LogInPresenter(interactor: interactor, router: self)
        view = LogInView(presenter: presenter)
        
        presenter.output = view
        
        return view
    }
    
    func goToSignUp() {
       
        guard let view = self.view else { return }
        singUpRouter?.createModule(fromView: view)
    }
}
