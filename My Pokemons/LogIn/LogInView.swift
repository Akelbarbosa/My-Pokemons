//
//  LogInView.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 10/04/23.
//

import UIKit

class LogInView: UIViewController {
    
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
    
    private var emailField: UITextField = {
        let field = UITextField()
        field.textContentType = .emailAddress
        field.autocorrectionType = .yes
        field.keyboardType = .emailAddress
        field.placeholder = NSLocalizedString("email", comment: "")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var passwordField: UITextField = {
        let field = UITextField()
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.placeholder = NSLocalizedString("password", comment: "")
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("log_in", comment: ""), for: .normal)
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
        
        
        stackField.addArrangedSubview(emailField)
        emailField.layer.cornerRadius = .pi * 2
        emailField.backgroundColor = .tertiarySystemGroupedBackground
        emailField.font = .preferredFont(forTextStyle: .body)
        emailField.insertPaddingLeft(left: 5)
        emailField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        emailField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        emailField.textContentType = .oneTimeCode
        
        emailField.delegate = self
        
        stackField.addArrangedSubview(passwordField)
        passwordField.layer.cornerRadius = .pi * 2
        passwordField.backgroundColor = .tertiarySystemGroupedBackground
        passwordField.font = .preferredFont(forTextStyle: .body)
        passwordField.insertPaddingLeft(left: 5)
        passwordField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        passwordField.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        passwordField.delegate = self
        
        stackField.addArrangedSubview(logInButton)
        logInButton.layer.cornerRadius = .pi * 2
        logInButton.backgroundColor = .systemGreen
        logInButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        logInButton.heightAnchor.constraint(lessThanOrEqualToConstant: 55).isActive = true
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: -
    @objc func signUpButtonAction() {
        presenter.tappedSignUp()
    }
}

//MARK - Extension UITextField

extension LogInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Extension Output Presenter
extension LogInView: LogInPresenterProtocolOutput {
    
}



