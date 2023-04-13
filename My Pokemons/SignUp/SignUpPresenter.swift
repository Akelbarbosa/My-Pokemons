//
//  SignUpPresenter.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 11/04/23.
//

import Foundation
import FirebaseAuth

protocol SignUpPresenterProtocolInput {
    
    func registerNewUser(email: String?, password: String?, confirmPassword: String?)
    func validateDataFromField(email: String?, password: String?, confirmPassword: String?) throws -> SignUpEntity
    func goToMainView()
    
}

protocol SignUpPresenterProtocolOutput: AnyObject {
    func sigupSuccess()
    func isLoading(status: Bool)
    
    func showError(on field: AuthField, withMessage message: String)
}

class SignUpPresenter: SignUpPresenterProtocolInput {
    
    weak var output: SignUpPresenterProtocolOutput?
    
    private var interactor: SignUpInteractorProtocolInput
    private var router: SignUpRouter
    
    init(interactor: SignUpInteractorProtocolInput, router: SignUpRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func registerNewUser(email: String?, password: String?, confirmPassword: String?) {
        output?.isLoading(status: true)
        Task {
            do {
                let credential = try validateDataFromField(email: email, password: password, confirmPassword: confirmPassword)
                await interactor.registerNewUser(credential: credential)

            } catch {
                let errorInField = error as? SignUpErrors
                handleError(error: errorInField )
                output?.isLoading(status: false)
            }
        }
    }
    
    func validateDataFromField(email: String?, password: String?, confirmPassword: String?) throws -> SignUpEntity {
        
        //Validacion que los campos no esten vacios
        guard let email = email,
              let password = password,
              let confirm = confirmPassword, !confirm.isEmpty || !email.isEmpty || !password.isEmpty
        else {
            throw SignUpErrors.fieldsAreEmpty
        }
        
        guard !email.isEmpty else {
            throw SignUpErrors.emailIsEmpty
        }
        
        guard email.isValidEmail() else {
            throw SignUpErrors.invalidEmail
        }
        
        guard !password.isEmpty else {
            throw SignUpErrors.passwordIsEmpty
        }
        
        guard password.count > 8 else {
            throw SignUpErrors.passwordIsShort
        }
        
        guard !confirm.isEmpty else {
            throw SignUpErrors.confirmPasswordIsEmpty
        }
        
        guard confirm == password else {
            throw SignUpErrors.passwordsDifferent
        }
        
        return SignUpEntity(email: email, password: password, confirmPassword: confirm)

    }

    private func handleError(error: SignUpErrors?) {
        guard let error = error else {return}
        let message = error.text()
        switch error {
        case .fieldsAreEmpty:
            output?.showError(on: .allFields, withMessage: message)
        case .emailIsEmpty:
            output?.showError(on: .email, withMessage: message)
        case .passwordIsEmpty:
            output?.showError(on: .password, withMessage: message)
        case .confirmPasswordIsEmpty:
            output?.showError(on: .confirmPassword, withMessage: message)
        case .invalidEmail:
            output?.showError(on: .email, withMessage: message)
        case .passwordIsShort:
            output?.showError(on: .password, withMessage: message)
        case .passwordsDifferent:
            output?.showError(on: .confirmPassword, withMessage: message)
        case .emailExist:
            output?.showError(on: .email, withMessage: message)
        }
    }
    
    func goToMainView() {
        router.goToMainView()
    }
    
}

//MARK: - Extension Output Interactor
extension SignUpPresenter: SignUpInteractorProtocolOutput  {
    func registerNewUserSuccess() {
        output?.isLoading(status: false)
        output?.sigupSuccess()
    }
    
    func registerNewUserFailure(error: NSError?) {
        guard let error = error else {return}
        output?.isLoading(status: false)
    
        switch AuthErrorCode.Code(rawValue: error.code) {
        case .emailAlreadyInUse:
            handleError(error: SignUpErrors.emailExist)
            
        case .invalidEmail:
            handleError(error: SignUpErrors.invalidEmail)
            
        default:
            print(error.localizedDescription)
            break
        }
        
    }
    
    
}
