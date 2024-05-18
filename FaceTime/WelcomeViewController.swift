//
//  ViewController.swift
//  FaceTime
//
//  Created by Mehmet ALAN on 17.05.2024.
//

import UIKit

class WelceomeViewController: UIViewController, WelcomeViewDelegate {
    
    override func loadView() {
        let view = WelcomeView()
        view.delegate = self
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FaceTime"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemGreen]
    }
    
    private func showAccount() {
        let vc = UINavigationController(rootViewController: AccountViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func didTapSignIn(email: String?, password: String?) {
        guard let email, let password else {
            let alert = UIAlertController(title: "Hatalı Giriş", message: "Lütfen eposta adresinizi ve şifrenizi giriniz", preferredStyle: .alert)
            alert.addAction(.init(title: "Tamam", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        AuthManager.shared.signIn(email: email, password: password) { [ weak self ] done in
            guard done else {
                return
            }
            DispatchQueue.main.async {
                self?.showAccount()
            }
        }
    }
    
    func didTapSignUp(email: String?, password: String?) {
        
        guard let email, let password else {
            let alert = UIAlertController(title: "Hatalı Giriş", message: "Lütfen eposta adresinizi ve şifrenizi giriniz", preferredStyle: .alert)
            alert.addAction(.init(title: "Tamam", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        AuthManager.shared.signUp(email: email, password: password) { [ weak self ] done in
            guard done else {
                return
            }
            DispatchQueue.main.async {
                self?.showAccount()
            }
        }
        
    }
    
}

