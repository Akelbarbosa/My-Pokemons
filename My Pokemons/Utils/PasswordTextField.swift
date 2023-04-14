//
//  PasswordTextField.swift
//  My Pokemons
//
//  Created by Akel Barbosa on 13/04/23.
//

import UIKit

class PasswordTextField: UITextField {
    var show: Bool = false {
        didSet {
            showPassword()
        }
    }
    
    var paddingImg = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 30))
    var eyeIcon = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        showPassword()
        
        self.layer.cornerRadius = .pi * 2
        self.backgroundColor = .tertiarySystemGroupedBackground
        self.font = .preferredFont(forTextStyle: .body)
 
        paddingImg.addSubview(eyeIcon)
        rightViewMode = .always
        rightView = paddingImg
        eyeIcon.addTarget(self, action: #selector(toggleEye), for: .touchUpInside)
    }
    
    @objc func toggleEye() {
        show.toggle()
    }
    
    private func showPassword() {
        if show {
            isSecureTextEntry = false
            eyeIcon.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            eyeIcon.tintColor = .systemGray
        } else {
            isSecureTextEntry = true
            eyeIcon.setImage(UIImage(systemName: "eye") , for: .normal)
            eyeIcon.tintColor = .systemGray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
