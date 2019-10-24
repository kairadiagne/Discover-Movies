//
//  KeychainWrapper.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 24/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation

/// Types confirming to `KeychainPasswordStoring` are can store an password in the keychain.
protocol KeychainPassswordStoring {

    /// Looks up a specific item in the users keychain.
    /// - Parameter server: The name of the server for which to retrieve the password.
    /// - Parameter account: The name of the account to which the password belongs.
    func readItem(server: String, account: String) throws -> String


    /// Adds or updates a item in the keychain.
    /// - Parameter password: The password to store in the keychain.
    /// - Parameter server: The name of the server for which to store the password.
    /// - Parameter account: The name of the account to which the password belongs.
    func addOrUpdateItem(_ password: String, server: String, account: String) throws


    /// Deletes a speicifc keychain item from
    /// - Parameter server: The name of the server for which to delete the password.
    /// - Parameter account: The name of the account to which the password belongs.
    func  deleteItem(server: String, account: String) throws
}

struct KeychainWrapper: KeychainPassswordStoring {

    enum Error: Swift.Error {

        /// Could not found any keychain item matching the server and the account.
        case noPassword

        /// Any other error that can occur while interfacing with the keychain.
        case generic
    }

    func readItem(server: String, account: String) throws -> String {
        var query = KeychainWrapper.keychainQuery(withService: server, account: account)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        guard status != errSecItemNotFound else {
            throw Error.noPassword
        }

        guard status == noErr else {
            throw Error.generic
        }

        guard let existingItem = queryResult as? [String : AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw Error.generic
        }

        return password
    }

    func addOrUpdateItem(_ password: String, server: String, account: String) throws {
        guard let encodedPassword = password.data(using: String.Encoding.utf8) else {
            throw Error.generic
        }

        do {
            // Check for an existing item in the keychain.
            try _ = readItem(server: server, account: account)

            // Update the existing item with the new password.
            var attributesToUpdate = [String : AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?

            let query = KeychainWrapper.keychainQuery(withService: server, account: account)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw Error.generic }
        }
        catch Error.noPassword {
            // Add new password item.
            var newItem = KeychainWrapper.keychainQuery(withService: server, account: account)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?

            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw Error.generic }
        }
    }

    func deleteItem(server: String, account: String) throws {
        let query = KeychainWrapper.keychainQuery(withService: server, account: account)
        let status = SecItemDelete(query as CFDictionary)

        guard status == noErr || status == errSecItemNotFound else {
            throw Error.generic
        }
    }

    // MARK: - Convenience

    static func keychainQuery(withService service: String, account: String, accessGroup: String? = nil) -> [String : AnyObject] {
        var query = [String : AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        query[kSecAttrAccount as String] = account as AnyObject?

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }

        return query
    }
}
