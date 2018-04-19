//
//  RealmRepository.swift
//  TappApp
//
//  Created by Kaira Diagne on 23-01-18.
//  Copyright © 2018 Kaira Diagne. All rights reserved.
//

import Foundation
import RealmSwift

enum RepositoryError: Error {
    case error(Error)
    case generic
}

typealias Completion = (RepositoryError?) -> Void

protocol RealmReading {
    func getObject<T: Object>(primaryKey: String) -> T?
    func getObjects<T: Object>() -> Results<T>
    func getObjects<T: Object>(filter: NSPredicate, sortedBy keyPath: String, ascending: Bool) -> Results<T>
}

protocol RealmWriting {
    func createOrUpdateObject(_ object: Object, completion: Completion?)
    func createOrUpdateObjects<T: Object>(_ objects: [T], completion: Completion?)
    func delete<T: Object>(object: T, completion: Completion?)
}

typealias RealmRepositoryType = RealmReading & RealmWriting

final class RealmRepository: RealmRepositoryType {

    // MARK: - Properties

    static let shared = RealmRepository()

    private(set) var writeQueue = DispatchQueue(label: "nl.tappapp.realm.write", attributes: [])

    // swiftlint:disable:next force_try
    private(set) var mainRealm = try! Realm()

    // MARK: - Write

    private func writeAsync<T: ThreadConfined>(obj: T,
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
    
    // MARK: - RealmReading
    
    func getObject<T: Object>(primaryKey: String) -> T? {
        return mainRealm.object(ofType: T.self, forPrimaryKey: primaryKey)
    }
    
    func getObjects<T: Object>() -> Results<T> {
        return mainRealm.objects(T.self)
    }
    
    func getObjects<T: Object>(filter predicate: NSPredicate, sortedBy keyPath: String, ascending: Bool) -> Results<T> {
        return mainRealm.objects(T.self).filter(predicate).sorted(byKeyPath: keyPath, ascending: ascending)
    }
    
    // MARK: - RealmWriting
    
    func createOrUpdateObject(_ object: Object, completion: Completion?) {
        writeAsync(obj: object, writeBlock: { realm, object in
            realm.add(object, update: true)
            
        }, completion: { error in
            completion?(error)
        })
    }
    
    func createOrUpdateObjects<T: Object>(_ objects: [T], completion: Completion?) {
        let list = RealmSwift.List<T>()
        list.append(objectsIn: objects)
    
        writeAsync(obj: list, writeBlock: { realm, objects in
            realm.add(objects, update: true)
            
        }, completion: { error in
            completion?(error)
        })
    }
    
    func delete<T: Object>(object: T, completion: Completion?) {
        writeAsync(obj: object, writeBlock: { realm, object  in
            realm.delete(object)

        }, completion: { error in
            completion?(error)
        })
    }
}
