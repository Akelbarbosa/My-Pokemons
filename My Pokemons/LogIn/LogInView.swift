//
//  LogInView.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import UIKit

class LogInView: UIViewController {
    //MARK: - Variables
    var fieldWithError: [UITextField: UILabel] = [:]
    
    //MARK: - Initializers
    var presenter: LogInPresenterProtocolInput
    
    init(presenter: LogInPresenterProtocolInput) {
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
    
    // Fields 
    lazy var emailField = EmailTextField()
    lazy var passwordField = PasswordTextField()
    
    //Error Label
    lazy var emailErrorLabel = ErrorMessageLabel()
    lazy var passwordErrorLabel = ErrorMessageLabel()
    
    // Buttons
    private var logInButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = NSLocalizedString("log_in", comment: "")
        configuration.imagePadding = 10
        let button = UIButton()
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var signUpButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.title = NSLocalizedString("sign_up", comment: "")
        
        let button = UIButton()
        button.configuration = configure
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - UI Configurations
    private func configureUI() {
        
        // Content
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
        
        // Email Field
        stackField.addArrangedSubview(emailField)
        emailField.placeholder = NSLocalizedString("email", comment: "")
        emailField.insertPaddingLeft(left: 5)
        emailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        emailField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        emailField.textContentType = .oneTimeCode
        
        emailField.delegate = self
        
        // Email Error Label
        emailErrorLabel.isHidden = true
        stackField.addArrangedSubview(emailErrorLabel)
        
        
        // Password Field
        stackField.addArrangedSubview(passwordField)
        passwordField.placeholder = NSLocalizedString("password", comment: "")
        passwordField.insertPaddingLeft(left: 5)
        passwordField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        passwordField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        passwordField.delegate = self
        
        // Error Password Label
        passwordErrorLabel.isHidden = true
        stackField.addArrangedSubview(passwordErrorLabel)
        
        // Log In button
        stackField.addArrangedSubview(logInButton)
        logInButton.layer.cornerRadius = .pi * 2
        logInButton.configuration?.baseBackgroundColor = .systemGreen
        logInButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        logInButton.heightAnchor.constraint(lessThanOrEqualToConstant: 55).isActive = true
        
        logInButton.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        
        //Sign Up button
        stackField.addArrangedSubview(signUpButton)
        signUpButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        signUpButton.heightAnchor.constraint(lessThanOrEqualToConstant: 55).isActive = true
        
        signUpButton.addTarget(self, action: #selector(signUpButtonAction), for: .touchUpInside)
    }

    //MARK: - Main Controller Configuraton
    private func mainControllerConfiguration() {
        title = NSLocalizedString("log_in", comment: "")
        view.backgroundColor = .systemGroupedBackground
    }
    
    //MARK: - Life Cycle
    deinit{print("\(self) dealloc")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainControllerConfiguration()
        configureUI()
    }
        
    //MARK: - Actions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func logInButtonAction() {
        view.endEditing(true)
        presenter.loginAuth(email: emailField.text, password: passwordField.text)
    }
    
    @objc func signUpButtonAction() {
        view.endEditing(true)
        presenter.goToSignUp()
    }
    
}


//MARK: - Private Method
extension LogInView {
    
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
            self?.logInButton.configuration?.showsActivityIndicator = status
            self?.emailField.isUserInteractionEnabled = !status
            self?.passwordField.isUserInteractionEnabled = !status
            
        }
    }
    
    private func resetConfigurationField(key: UITextField? = nil) {
        guard let textField = key,
              let label = fieldWithError[textField]
        else {
            fieldWithError[emailField] = emailErrorLabel
            fieldWithError[passwordField] = passwordErrorLabel
            
            
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
}

//MARK - Extension UITextField
extension LogInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        resetConfigurationField(key: textField)
    }
}

//MARK: - Extension Output Presenter
extension LogInView: LogInPresenterProtocolOutput {
    func logInSuccess() {
        print("Sucesss")
    }
    
    
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
            
            
        case .allFields:
            fieldWithError[emailField] = emailErrorLabel
            fieldWithError[passwordField] = passwordErrorLabel
            
            showError(for: fieldWithError, withMessage: message)
            fieldWithError = [:]
        case .confirmPassword:
            break
        }
    }
}



