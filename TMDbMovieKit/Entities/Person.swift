//
//  PersonInfo.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-01-17.
//  Copyright © 2017 Kaira Diagne. All rights reserved.
//

import Foundation

public struct Person: DictionarySerializable {
    
    // MARK: - Types
    
    public enum Gender: Int {
        case man = 1
        case woman = 2
    }
    
    // MARK: - Properties
    
    public let personID: Int
    public let imdbID: String
    public let name: String
    public let birthDay: String
    public var deathDay: String?
    public let birthPlace: String
    public let biography: String
    public let gender: Gender
    public let adult: Bool
    public let profilePath: String
    
    // MARK: - Initialize
    
    public init?(dictionary dict: [String : AnyObject]) {
        guard let personID = dict["id"] as? Int,
            let imdbID = dict["imdb_id"] as? String,
            let name = dict["name"] as? String,
            let birthDay = dict["birthday"] as? String,
            let deathDay = dict["deathday"] as? String,
            let birthPlace = dict["place_of_birth"] as? String,
            let biography = dict["biography"] as? String,
            let genderRaw = dict["gender"] as? Int,
            let gender = Gender(rawValue: genderRaw),
            let adult = dict["adult"] as? Bool,
            let profilePath = dict["profile_path"] as? String else {
                return nil
        }
        
        self.personID = personID
        self.imdbID = imdbID
        self.name = name
        self.birthDay = birthDay
        self.deathDay = deathDay
        self.birthPlace = birthPlace
        self.biography = biography
        self.gender = gender
        self.adult = adult
        self.profilePath = profilePath
    }
    
    public func dictionaryRepresentation() -> [String : AnyObject] {
        return [:]
    }

}

//{
//    "adult": false,
//    "also_known_as": [],
//    "biography": "John Barry Humphries, AO, CBE (born 17 February 1934) is an Australian comedian, satirist, dadaist, artist, author and character actor, perhaps best known for his on-stage and television alter egos Dame Edna Everage, a Melbourne housewife and \"gigastar\", and Sir Les Patterson, Australia's foul-mouthed cultural attaché to the Court of St. James's.\n\nHe is a film producer and script writer, a star of London's West End musical theatre, an award-winning writer and an accomplished landscape painter. For his delivery of dadaist and absurdist humour to millions, biographer Anne Pender described Humphries in 2010 as not only the most significant theatrical figure of our time … [but] the most significant comedian to emerge since Charlie Chaplin. Humphries' characters, especially Dame Edna Everage, have brought him international renown, and he has appeared in numerous films, stage productions and television shows. Originally conceived as a dowdy Moonee Ponds housewife who caricatured Australian suburban complacency and insularity, Edna has evolved over four decades to become a satire of stardom, the gaudily dressed, acid-tongued, egomaniacal, internationally feted Housewife Gigastar, Dame Edna Everage. Humphries' other major satirical character creation was the archetypal Australian bloke Barry McKenzie, who originated as the hero of a comic strip about Australians in London (with drawings by Nicholas Garland) which was first published in Private Eye magazine.\n\nThe stories about \"Bazza\" (Humphries' nickname, as well as an Australian term of endearment for the name Barry) gave wide circulation to Australian slang, particularly jokes about drinking and its consequences (much of which was invented by Humphries), and the character went on to feature in two Australian films, in which he was portrayed by Barry Crocker. Humphries' other satirical characters include the \"priapic and inebriated cultural attaché\" Sir Les Patterson, who has \"continued to bring worldwide discredit upon Australian arts and culture, while contributing as much to the Australian vernacular as he has borrowed from it\", gentle, grandfatherly \"returned gentleman\" Sandy Stone, iconoclastic 1960s underground film-maker Martin Agrippa, Paddington socialist academic Neil Singleton, sleazy trade union official Lance Boyle, high-pressure art salesman Morrie O'Connor and failed tycoon Owen Steele.  Description above from the Wikipedia article Barry Humphries, licensed under CC-BY-SA, full list of contributors on Wikipedia.",
//    "birthday": "1934-02-17",
//    "deathday": "",
//    "gender": 2,
//    "homepage": "",
//    "id": 22,
//    "imdb_id": "nm0402032",
//    "name": "Barry Humphries",
//    "place_of_birth": "Camberwell, Melbourne, Australia",
//    "popularity": 0.040791,
//    "profile_path": "/ccJHmzU8wzOe4sAmeVeScu5mygl.jpg"
//}
