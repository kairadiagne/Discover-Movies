//
//  Video+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import CoreData

public class Video: NSManagedObject {

    // MARK: Properties

    @NSManaged public var name: String
    @NSManaged public var size: String
    @NSManaged public var source: String
    @NSManaged public var type: String
    @NSManaged public var movie: Movie
    
    // MAKR: Initialize
    
    static func insert(into context: NSManagedObjectContext, video: TMDBVideo, movie: Movie) {
        let videoEntity = Video(context: context)
        videoEntity.name = video.name
        videoEntity.size = video.size
        videoEntity.source = video.source
        videoEntity.type = video.type
        videoEntity.movie = movie
    }
}
