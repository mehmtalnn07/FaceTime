//
//  CallManager.swift
//  FaceTime
//
//  Created by Mehmet ALAN on 17.05.2024.
//

import Foundation
import StreamVideo
import StreamVideoUIKit
import StreamVideoSwiftUI

class CallManager {
    static let shared = CallManager()
    
    struct Constants {
        static let userToken = "getstream.io token"
    }
    
    private var video: StreamVideo?
    private var videoUI: StreamVideoUI?
    public private(set) var callViewModel: CallViewModel?
    
    struct UserCredentials {
        let user: User
        let token: UserToken
    }
    
    func setUp(email: String) {
        setUpCallViewModel()
        let credential = UserCredentials(user: .guest(email), token: UserToken(rawValue: Constants.userToken))
        let video = StreamVideo(apiKey: "your api key", user: credential.user, token: credential.token) {
            result in
            result(.success(credential.token))
        }
        let videoUI = StreamVideoUI(streamVideo: video)
        self.video = video
        self.videoUI = videoUI
    }
    
    private func setUpCallViewModel() {
        guard callViewModel == nil else { return }
        DispatchQueue.main.async {
            self.callViewModel = CallViewModel()
        }
    }
    
}
