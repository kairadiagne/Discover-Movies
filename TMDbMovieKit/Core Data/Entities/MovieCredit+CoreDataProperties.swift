//
//  MovieCredit+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension MovieCredit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCredit> {
        return NSFetchRequest<MovieCredit>(entityName: "MovieCredit")
    }

    @NSManaged public var creditIdentifier: String?
    @NSManaged public var identifier: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var releaseData: String?
    @NSManaged public var title: String?

}
