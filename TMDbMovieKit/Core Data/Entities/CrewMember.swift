//
//  CrewMember+CoreDataClass.swift
//  
//
//  Created by Kaira Diagne on 23/11/2019.
//
//

import CoreData

public class CrewMember: NSManagedObject {

    // MARK: Properties

    @NSManaged public var identifier: Int64
    @NSManaged public var creditIdentifier: String
    @NSManaged public var name: String
    @NSManaged public var job: String
    @NSManaged public var department: String
    @NSManaged public var profilePath: String?
    @NSManaged public var movies: NSSet
    
    // MARK: Initialize
    
    static func insert(into context: NSManagedObjectContext, crewMember: TMDBCrewMember, movie: Movie) -> CrewMember {
        let crewMemberEntity = CrewMember(context: context)
        crewMemberEntity.identifier = Int64(crewMember.identifier)
        crewMemberEntity.creditIdentifier = crewMember.creditID
        crewMemberEntity.name = crewMember.name
        crewMemberEntity.job = crewMember.job
        crewMemberEntity.department = crewMember.department
        crewMemberEntity.profilePath = crewMember.profilePath
        crewMemberEntity.addToMovies(movie)
        return crewMemberEntity
    }
}

// MARK: Generated accessors for movies
extension CrewMember {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}
