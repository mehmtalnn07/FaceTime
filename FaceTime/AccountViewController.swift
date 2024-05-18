//
//  AccountViewController.swift
//  FaceTime
//
//  Created by Mehmet ALAN on 17.05.2024.
//

import Combine
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI
import UIKit

class AccountViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()
    
    private var activeCallView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "FaceTime"
        view.backgroundColor = .systemGreen
        
        let signOutButton = UIBarButtonItem(title: "Çıkış Yap", style: .done, target: self, action: #selector(signOut))
                signOutButton.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .normal)
                navigationItem.leftBarButtonItem = signOutButton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Arama Yap", style: .done, target: self, action: #selector(joinCall))
        
    }
    
    @objc private func signOut() {
        let alert = UIAlertController(title: "Çıkış Yap", message: "Emin misin?", preferredStyle: .alert)
        alert.addAction(.init(title: "İptal", style: .cancel))
        alert.addAction(.init(title: "Çıkış Yap", style: .destructive, handler: { _ in
            AuthManager.shared.signOut()
            let vc = UINavigationController(rootViewController: WelceomeViewController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    @objc private func joinCall() {
        guard let callViewModel = CallManager.shared.callViewModel else {
            return
        }
        callViewModel.joinCall(callType: .default, callId: "call id")
        
        //callViewModel.startCall(callType: .default, callId: UUID().uuidString, members: [] )
        showCallUI()
    }
    
    private func listenForIncomingCalls() {
        guard let callViewModel = CallManager.shared.callViewModel else {
            return
        }
        callViewModel.$callingState.sink { [ weak self ] newState in
            switch newState {
            case .incoming(_):
                DispatchQueue.main.async {
                    self?.showCallUI()
                }
            case .idle:
                DispatchQueue.main.async {
                    self?.hideCallUI()
                }
            default:
                break
            }
        }
        .store(in: &cancellables)
    }
    
    private func showCallUI() {
        guard let callViewModel = CallManager.shared.callViewModel else {
            return
        }
        let callVC = CallViewController.make(with: callViewModel)
        view.addSubview(callVC.view)
        callVC.view.bounds = view.bounds
        activeCallView = callVC.view
    }
    
    private func hideCallUI() {
        activeCallView?.removeFromSuperview()
    }

}
