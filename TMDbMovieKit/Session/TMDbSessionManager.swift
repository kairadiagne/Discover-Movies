//
//  TMDbSessionManager.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 10/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public final class TMDbSessionManager {

    public enum Status {

        /// The user us signed in with a TMDB account
        case signedin

        /// The user choose not to sign in or is signed out.
        case publicMode

        /// The session state is unknown, present the user with options.
        case undetermined
    }
    
    private struct Constants {
        static let FreshInstallKey = "FreshInstallKey"
    }
    
    // MARK: - Properties

    public var status: Status {
        if sessionInfoStorage.sessionID != nil { return .signedin }
        if publicModeActivated { return .publicMode }
        return .undetermined
    }
    
    public var user: User? {
        return sessionInfoStorage.user
    }
    
    private let sessionInfoStorage: SessionInfoContaining
    
    // MARK: - Initialize

    public convenience init() {
        self.init(storage: SessionInfoStorage(keyValueStorage: UserDefaults.standard))
    }
    
    init(storage: SessionInfoStorage) {
        self.sessionInfoStorage = storage

        // Move to keychain
        // If this is the first lauch after a fresh install we clear the keychain to make sure there is no data from a previous install
        let freshInstall = UserDefaults.standard.bool(forKey: Constants.FreshInstallKey) == false
        
        if freshInstall {
            UserDefaults.standard.set(true, forKey: Constants.FreshInstallKey)
            sessionInfoStorage.clearUserData()
        }
    }

    // MARK: - API Key
    
    public static func registerAPIKey(_ key: String) {
        Configuration.configure(apiKey: key)
    }
    
    // MARK: - Signin Status

    func logOut() {
        NotificationCenter.default.post(name: Notification.Name.SessionManager.didLogOut, object: nil, userInfo: nil)
    }
    
    // MARK: - Public Mode
    
    private var publicModeActivated: Bool {
        return UserDefaults.standard.bool(forKey: "userIsInpublicMode")
    }

    public func activatePublicMode() {
        UserDefaults.standard.set(true, forKey: "userIsInpublicMode")
    }
    
    public func deactivatePublicMode() {
        UserDefaults.standard.set(false, forKey: "userIsInpublicMode")
    }
}

extension Notification.Name {
    struct SessionManager {
        static let didLogOut = Notification.Name(rawValue: "SessionManagerDidLogout")
    }
}
