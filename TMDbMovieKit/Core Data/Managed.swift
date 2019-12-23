//
//  Managed.swift
//  TMDbMovieKit
//
//  Created by Kaira Diagne on 06/12/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Foundation
import CoreData

protocol Managed: class, NSFetchRequestResult {
    static var entityName: String { get }
}

extension Managed where Self: NSManagedObject {

    static var entityName: String {
        return String(describing: self)
    }

    static func defaultFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest<Self>(entityName: entityName)
    }

    static func fetchSingleObject(in context: NSManagedObjectContext, configure: (NSFetchRequest<Self>) -> Void) -> Self? {
        let result = fetch(in: context) { request in
            configure(request)
            request.fetchLimit = 2
        }

        switch result.count {
        case 0:
            return nil
        case 1:
            return result[0]
        default:
            fatalError("Returned multiple objects, expected max 1")
        }
    }

    static func fetch(in context: NSManagedObjectContext, configurationBlock: (NSFetchRequest<Self>) -> Void = { _ in }) -> [Self] {
        let request = Self.defaultFetchRequest()
        configurationBlock(request)
        return try! context.fetch(request)
    }
}
