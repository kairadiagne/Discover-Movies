//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

    // MARK: Properties

    @NSManaged public var backdropPath: String?
    @NSManaged public var genres: NSObject?
    @NSManaged public var identifier: Int64
    @NSManaged public var overview: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var cast: NSOrderedSet?
    @NSManaged public var crew: NSOrderedSet?
    @NSManaged public var pages: NSSet?
    @NSManaged public var trailers: NSSet?

}
