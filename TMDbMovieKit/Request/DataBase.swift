//
//  DataStore.swift
//  TappApp
//
//  Created by Kaira Diagne on 23-01-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import RealmSwift

enum DataBaseError: Error {
    case error(Error)
    case generic
}

protocol RealmDataBaseProtocol {
    typealias Completion = (DataBaseError?) -> Void
    var mainRealm: Realm { get }
    var writeQueue: DispatchQueue { get }
    func writeAsync<T: ThreadConfined>(obj: T, writeBlock: @escaping ((Realm, T)) -> Void, completion: Completion?)
    func addOrUpdate(object: Object, refresh: Bool, completion: Completion?)
    func delete<T: Object>(object: T, refresh: Bool, completion: Completion?)
}

final class DataBase: RealmDataBaseProtocol {

    // MARK: - Properties

    static let shared = DataBase()

    private(set) var writeQueue = DispatchQueue(label: "nl.tappapp.realm.write", attributes: [])

    // swiftlint:disable:next force_try
    private(set) var mainRealm = try! Realm()

    // MARK: - Generic

    func writeAsync<T: ThreadConfined>(obj: T,
                                       writeBlock: @escaping ((Realm, T)) -> Void,
                                       completion: Completion?) {

        // If object is already managed by a realm create a thread safe reference
        var wrappedObj: ThreadSafeReference<T>?
        if obj.realm != nil {
            wrappedObj = ThreadSafeReference(to: obj)
        }

        writeQueue.async {
            autoreleasepool {
                do {
                    let realm = try Realm()

                    // Resolve threadsafe reference or default to unmanaged objet
                    guard let obj = wrappedObj != nil ? realm.resolve(wrappedObj!) : obj else {
                        DispatchQueue.main.async {
                            completion?(.generic)
                        }
                        return
                    }

                    realm.beginWrite()
                    writeBlock((realm, obj))
                    try realm.commitWrite()

                    DispatchQueue.main.async {
                        completion?(nil)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion?(.error(error))
                    }
                }
            }
        }
    }

    // MARK: - Add

    func addOrUpdate(object: Object,
                     refresh: Bool,
                     completion: Completion?) {

        writeAsync(obj: object, writeBlock: { realm, object in
            realm.add(object, update: true)

        }, completion: { error in
            if refresh {
                self.mainRealm.refresh()
            }
            completion?(error)
        })
    }
    
    // TODO: - addOrUpdateObjects

    // MARK: - Delete

    func delete<T: Object>(object: T,
                           refresh: Bool,
                           completion: Completion?) {

        writeAsync(obj: object, writeBlock: { realm, object  in
            realm.delete(object)

        }, completion: { error in
            if refresh {
                self.mainRealm.refresh()
            }

            completion?(error)
        })
    }
}
