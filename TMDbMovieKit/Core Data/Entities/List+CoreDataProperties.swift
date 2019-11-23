//
//  List+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var page: Int64
    @NSManaged public var resultCount: Int64
    @NSManaged public var totalPages: Int64
    @NSManaged public var type: Int64
    @NSManaged public var pages: NSOrderedSet?
}

// MARK: Generated accessors for pages
extension List {

    @objc(insertObject:inPagesAtIndex:)
    @NSManaged public func insertIntoPages(_ value: Page, at idx: Int)

    @objc(removeObjectFromPagesAtIndex:)
    @NSManaged public func removeFromPages(at idx: Int)

    @objc(insertPages:atIndexes:)
    @NSManaged public func insertIntoPages(_ values: [Page], at indexes: NSIndexSet)

    @objc(removePagesAtIndexes:)
    @NSManaged public func removeFromPages(at indexes: NSIndexSet)

    @objc(replaceObjectInPagesAtIndex:withObject:)
    @NSManaged public func replacePages(at idx: Int, with value: Page)

    @objc(replacePagesAtIndexes:withPages:)
    @NSManaged public func replacePages(at indexes: NSIndexSet, with values: [Page])

    @objc(addPagesObject:)
    @NSManaged public func addToPages(_ value: Page)

    @objc(removePagesObject:)
    @NSManaged public func removeFromPages(_ value: Page)

    @objc(addPages:)
    @NSManaged public func addToPages(_ values: NSOrderedSet)

    @objc(removePages:)
    @NSManaged public func removeFromPages(_ values: NSOrderedSet)
}
