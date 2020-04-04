//
//  MovieCredit+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import CoreData

public class MovieCredit: NSManagedObject {

    // MARK: Properties

    @NSManaged public var creditIdentifier: String
    @NSManaged public var identifier: Int64
    @NSManaged public var posterPath: String
    @NSManaged public var releaseData: String
    @NSManaged public var title: String
}
