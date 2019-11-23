//
//  Video+CoreDataProperties.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import Foundation
import CoreData

extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var name: String?
    @NSManaged public var size: String?
    @NSManaged public var source: String?
    @NSManaged public var type: String?
    @NSManaged public var movie: Movie?

}
