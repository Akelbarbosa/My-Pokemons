//
//  SignUpRouter.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 11/04/23.
//

import Foundation
import UIKit

protocol SignUpRouterProtocol {
    var rootView: UIViewController? { get }
    func createModule(fromView: UIViewController?)
    func goToMainView()
}

class SignUpRouter: SignUpRouterProtocol {
    var rootView: UIViewController?
    
    func createModule(fromView: UIViewController?) {
        let interactor = SignUpInteractor(manager: ManagerFirebase.shared)
        let presenter = SignUpPresenter(interactor: interactor, router: self)
        let view = SignUpView(presenter: presenter)
        
        presenter.output = view
        interactor.output = presenter
        rootView = fromView
        fromView?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToMainView() {
        guard let viewController = rootView else {return}
        viewController.navigationController?.popViewController(animated: true)
    }
    
}
