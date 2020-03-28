//
//  Video+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

public class Video: NSManagedObject {

    // MARK: Properties

    @NSManaged public var name: String
    @NSManaged public var size: String
    @NSManaged public var source: String
    @NSManaged public var type: String
    @NSManaged public var movie: Movie
}
