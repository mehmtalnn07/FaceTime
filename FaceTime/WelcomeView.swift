//
//  WelcomeView.swift
//  FaceTime
//
//  Created by Mehmet ALAN on 17.05.2024.
//

import UIKit

protocol WelcomeViewDelegate: AnyObject {
    func didTapSignIn(email: String?, password: String?)
    func didTapSignUp(email: String?, password: String?)
}

class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    enum State {
        case sign_in
        case sign_up
    }
    
    private var state: State = .sign_in
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.placeholder = "Eposta"
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        field.autocapitalizationType = .none
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Parola"
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let stateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hesap Oluştur", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(button)
        addSubview(stateButton)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        stateButton.addTarget(self, action: #selector(didTapStateButton), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [emailField, passwordField, button, stateButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            stateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapButton() {
        switch state {
        case .sign_in:
            delegate?.didTapSignIn(email: emailField.text, password: passwordField.text)
        case .sign_up:
            delegate?.didTapSignUp(email: emailField.text, password: passwordField.text)
        }
    }
    
    @objc private func didTapStateButton() {
        switch state {
        case .sign_in:
            state = .sign_up
            stateButton.setTitle("Giriş Yap", for: .normal)
            button.setTitle("Kayıt Ol", for: .normal)
        case .sign_up:
            state = .sign_in
            stateButton.setTitle("Hesap Oluştur", for: .normal)
            button.setTitle("Giriş Yap", for: .normal)
        }
    }
}
