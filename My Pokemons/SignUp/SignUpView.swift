//
//  SignUpView.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 11/04/23.
//

import UIKit

class SignUpView: UIViewController {
    //MARK: - Variables
    var fieldWithError: [UITextField: UILabel] = [:]
    
    //MARK: - Initializers
    var presenter: SignUpPresenterProtocolInput
    
    init(presenter: SignUpPresenterProtocolInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Views
    private let stackField: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //Fields
    lazy var emailField = EmailTextField()
    lazy var passwordField = PasswordTextField()
    lazy var confirmPasswordField = PasswordTextField()
    
    private var signUpButton: UIButton = {
        var configure = UIButton.Configuration.filled()
        configure.baseBackgroundColor = .systemGreen
        configure.imagePadding = 10
        configure.title = NSLocalizedString("sign_up", comment: "")
        let button = UIButton()
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Error Label
    lazy var emailErrorLabel = ErrorMessageLabel()
    lazy var passwordErrorLabel = ErrorMessageLabel()
    lazy var confirmPasswordErrorLabel = ErrorMessageLabel()

    
    
    //MARK: - UI Configurations
    private func configureUI() {
        
        // Stack Field
        view.addSubview(stackField)
        stackField.axis = .vertical
        stackField.distribution = .equalSpacing
        stackField.spacing = 10
        stackField.backgroundColor = .secondarySystemGroupedBackground
        stackField.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackField.isLayoutMarginsRelativeArrangement = true
        stackField.layer.cornerRadius = .pi * 2
        
        NSLayoutConstraint.activate([
            stackField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stackField.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.8)
        ])
              
        
        // Logo
        view.addSubview(logoImage)
        logoImage.image = UIImage(named: "pokemon-logo")
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.bottomAnchor.constraint(equalTo: stackField.topAnchor, constant: -10),
            
            logoImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            logoImage.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 0.5),
        ])

        logoImage.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        logoImage.heightAnchor.constraint(lessThanOrEqualToConstant: 110).isActive = true
        
        
        // Email
        stackField.addArrangedSubview(emailField)
        
        emailField.placeholder = NSLocalizedString("email", comment: "")
        emailField.insertPaddingLeft(left: 5)
        emailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        emailField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        emailField.textContentType = .oneTimeCode
        
        emailField.delegate = self
        
        // Error Email
        stackField.addArrangedSubview(emailErrorLabel)
        emailErrorLabel.isHidden = true
        
        // Password
        stackField.addArrangedSubview(passwordField)

        passwordField.placeholder = NSLocalizedString("password", comment: "")
        passwordField.insertPaddingLeft(left: 5)
        passwordField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        passwordField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        passwordField.delegate = self
        
        // Error Password
        passwordErrorLabel.isHidden = true
        stackField.addArrangedSubview(passwordErrorLabel)
        
        // Confirm Password
        stackField.addArrangedSubview(confirmPasswordField)
       
        confirmPasswordField.placeholder = NSLocalizedString("confirm_password", comment: "")
        confirmPasswordField.insertPaddingLeft(left: 5)
        confirmPasswordField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        confirmPasswordField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        confirmPasswordField.delegate = self
        
        // Error Confirm Password
        stackField.addArrangedSubview(confirmPasswordErrorLabel)
        confirmPasswordErrorLabel.isHidden = true
        
        
        // Sign Up
        stackField.addArrangedSubview(signUpButton)
        signUpButton.layer.cornerRadius = .pi * 2
        signUpButton.backgroundColor = .systemGreen
        signUpButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        signUpButton.heightAnchor.constraint(lessThanOrEqualToConstant: 55).isActive = true
        
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
    }
    
    //MARK: - Main Controller Configuraton
    private func mainControllerConfiguration() {
        title = NSLocalizedString("sign_up", comment: "")
        view.backgroundColor = .systemGroupedBackground
    }
    
    //MARK: - Life Cycle
    deinit {print("\(self) dealloc")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainControllerConfiguration()
        configureUI()

    }
    
    //MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func signUpButtonAction() {
        view.endEditing(true)
        presenter.registerNewUser(email: emailField.text, password: passwordField.text, confirmPassword: confirmPasswordField.text)
    }
        
}

//MARK: - Private Method
extension SignUpView {
    
    private func showError(for fields: [UITextField: UILabel], withMessage message: String) {
        for (textField, label) in fields {
            DispatchQueue.main.async {
                // Crea un label para mostrar el mensaje de error
                label.text = message
                label.isHidden = false
                
                
                // Configura el borde del textfield para que sea rojo
                textField.layer.borderWidth = 1.0
                textField.layer.borderColor = UIColor(ciColor: .red).cgColor
                
                // Hace vibrar el textfield
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = 0.05
                animation.repeatCount = 2
                animation.autoreverses = true
                animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5.0, y: textField.center.y))
                animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5.0, y: textField.center.y))
                textField.layer.add(animation, forKey: "position")
            }
        }
    }
    
    private func loadingAction(status: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.signUpButton.configuration?.showsActivityIndicator = status
            self?.emailField.isUserInteractionEnabled = !status
            self?.passwordField.isUserInteractionEnabled = !status
            self?.confirmPasswordField.isUserInteractionEnabled = !status
        }
    }
    
    private func resetConfigurationField(key: UITextField? = nil) {
        guard let textField = key,
              let label = fieldWithError[textField]
            else {
                fieldWithError[emailField] = emailErrorLabel
                fieldWithError[passwordField] = passwordErrorLabel
                fieldWithError[confirmPasswordField] = confirmPasswordErrorLabel
                
                fieldWithError.forEach { (key: UITextField, value: UILabel) in
                    key.layer.borderColor = .none
                    key.layer.borderWidth = 0.0
                    
                    value.text = ""
                    value.isHidden = true
                }
            
                fieldWithError = [:]
                return
        }

        textField.layer.borderColor = .none
        textField.layer.borderWidth = 0.0
        
        label.text = ""
        label.isHidden = true
        
        fieldWithError.removeValue(forKey: textField)
        
    }
    
    
    private func showStatusSignUpAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        let ok = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.presenter.goToMainView()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - UITextField Delegate
extension SignUpView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetConfigurationField(key: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: - Extension Output Presenter
extension SignUpView: SignUpPresenterProtocolOutput {
    func isLoading(status: Bool) {
        loadingAction(status: status)
    }
    
    
    func showError(on field: AuthField, withMessage message: String) {
        
        switch field {
        case .email:
            fieldWithError[emailField] = emailErrorLabel
            showError(for: fieldWithError, withMessage: message)
    
        case .password:
            fieldWithError[passwordField] = passwordErrorLabel
            showError(for: fieldWithError, withMessage: message)
            
        case .confirmPassword:
            fieldWithError[confirmPasswordField] = confirmPasswordErrorLabel
            showError(for: fieldWithError, withMessage: message)
            
        case .allFields:
            fieldWithError[emailField] = emailErrorLabel
            fieldWithError[passwordField] = passwordErrorLabel
            fieldWithError[confirmPasswordField] = confirmPasswordErrorLabel
            
            showError(for: fieldWithError, withMessage: message)
            fieldWithError = [:]
        }
    }
    
    func sigupSuccess() {
        DispatchQueue.main.async {[weak self] in
            self?.showStatusSignUpAlert(title:  NSLocalizedString("sign_up_success", comment: ""), message: NSLocalizedString("account_create_success", comment: ""))
        }
        
    }
}
