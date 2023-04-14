//
//  LogInPresenter.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import Foundation
import Firebase

protocol LogInPresenterProtocolInput: AnyObject {
    func loginAuth(email: String?, password: String?)
    func goToSignUp()

}

protocol LogInPresenterProtocolOutput: AnyObject {
    func showError(on field: AuthField, withMessage message: String)
    func isLoading(status: Bool)
    func logInSuccess()
}

class LogInPresenter: LogInPresenterProtocolInput {
    private let interactor: LogInInteractorProtocolInput
    private let router: LogInRouterProtocol
    
    weak var output: LogInPresenterProtocolOutput?
    
    init(interactor: LogInInteractorProtocolInput, router: LogInRouterProtocol) {
        self.interactor = interactor
        self.router = router
        
    }
    
    func loginAuth(email: String?, password: String?) {
        output?.isLoading(status: true)
        
        Task {
            do {
                let credential = try validateDataFromField(email: email, password: password)
                await interactor.logIn(credentials: credential)
            } catch {
                let error = error as? LogInErrors
                handleError(error: error)
            }
        }
    }
    
    func goToSignUp() {
        router.goToSignUp()
    }
    
    private func validateDataFromField(email: String?, password: String?) throws -> LogInEntity {
        
        guard let email = email,
              let password = password, !email.isEmpty || !password.isEmpty
        else {
            throw LogInErrors.fieldsAreEmpty
        }
        
        guard !email.isEmpty else {
            throw LogInErrors.emailIsEmpty
        }
        
        guard email.isValidEmail() else {
            throw LogInErrors.invalidEmail
        }
        
        guard !password.isEmpty else {
            throw LogInErrors.passwordIsEmpty
        }
        
        guard password.count > 8 else {
            throw LogInErrors.passwordIsShort
        }
        
        return LogInEntity(email: email, password: password)

    }
    
    private func handleError(error: LogInErrors?) {
        output?.isLoading(status: false)
        guard let error = error else {return}
        let message = error.text()
        switch error {
        case .fieldsAreEmpty:
            output?.showError(on: .allFields, withMessage: message)
        case .emailIsEmpty:
            output?.showError(on: .email, withMessage: message)
        case .invalidEmail:
            output?.showError(on: .email, withMessage: message)
        case .passwordIsEmpty:
            output?.showError(on: .password, withMessage: message)
        case .passwordIsShort:
            output?.showError(on: .password, withMessage: message)
        case .passwordInvalid:
            output?.showError(on: .password, withMessage: message)
        case .wrongPassword:
            output?.showError(on: .password, withMessage: message)
        case .userNotFound:
            output?.showError(on: .email, withMessage: message)
        }
        
    }
}


////MARK: - Log in Interactor Output
extension LogInPresenter: LogInInteractorProtocolOutput {
    func logInSuccess(authData: User?) {
        output?.isLoading(status: false)
        output?.logInSuccess()
    }
    
    func logInError(error: NSError?) {
        guard let error = error else { return }
        output?.isLoading(status: false)
        switch AuthErrorCode.Code(rawValue: error.code) {
        case .wrongPassword:
            handleError(error: LogInErrors.wrongPassword)
        case .userNotFound:
            handleError(error: LogInErrors.userNotFound)
        default:
            print(error.localizedDescription)
            break
        }
    }
    



}
