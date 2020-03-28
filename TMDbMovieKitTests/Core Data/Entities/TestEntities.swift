//
//  TestEntities.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 28/03/2020.
//  Copyright © 2020 Kaira Diagne. All rights reserved.
//

import CoreData
@testable import TMDbMovieKit

extension CrewMember {
    
    static func test(in context: NSManagedObjectContext) -> CrewMember {
        let crewMember = CrewMember(context: context)
        crewMember.identifier = 0
        crewMember.creditIdentifier = UUID().uuidString
        crewMember.name = "Test Member"
        crewMember.job = "Job"
        crewMember.department = "Department"
        crewMember.profilePath = UUID().uuidString
        return crewMember
    }
}

extension CastMember {
    
    static func test(in context: NSManagedObjectContext) -> CastMember {
        let castMember = CastMember(context: context)
        castMember.identifier = 0
        castMember.name = "Test Member"
        castMember.castIdentifier = 1
        castMember.character = "Character"
        castMember.order = 0
        castMember.profilePath = UUID().uuidString
        return castMember
    }
}

extension Video {
    
    static func test(in context: NSManagedObjectContext) -> Video {
        let video = Video(context: context)
        video.name = UUID().uuidString
        video.source = UUID().uuidString
        video.size = UUID().uuidString
        video.type = UUID().uuidString
        return video
    }
}
