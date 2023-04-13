//
//  SignUpErrors.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 12/04/23.
//

import Foundation

enum SignUpErrors: String, Error {
    // Field error
    case fieldsAreEmpty// = "El campo está vacío."
    
    case emailIsEmpty// = "El campo de correo electrónico está vacío."
    case passwordIsEmpty// = "El campo de contraseña está vacío."
    case confirmPasswordIsEmpty// = "El campo de confirmación de contraseña está vacío."

    case invalidEmail// = "El correo electrónico ingresado es inválido."
    case passwordIsShort// = "La contraseña debe tener al menos 8 caracteres."
    case passwordsDifferent// = "Las contraseñas ingresadas no coinciden."
    
    // Firebase Error
    case emailExist// = "El correo electrónico ya esta registrado."
    
    func text() -> String {
        return NSLocalizedString("\(self)", comment: "")
    }
}

/*
 "sign_up" = "Sign Up";
 "confirm_password" = "Confirm Password";
 "sign_up_success" = "Sign Up Success"
 "account_create_success" = "Your account has been successfully created."

 "fields_are_empty" = "The field is empty."
 "email_is_empty" = "The email field is empty."
 "password_is_empty" = "The password field is empty."
 "confirm_password_is_empty" = "The confirm password field is empty."
 "invalid_email" = "The entered email is invalid."
 "password_is_short" = "The password must be at least 8 characters long."
 "passwords_different" = "The entered passwords do not match."
 "email_exist" = "The email is already registered."
 */
