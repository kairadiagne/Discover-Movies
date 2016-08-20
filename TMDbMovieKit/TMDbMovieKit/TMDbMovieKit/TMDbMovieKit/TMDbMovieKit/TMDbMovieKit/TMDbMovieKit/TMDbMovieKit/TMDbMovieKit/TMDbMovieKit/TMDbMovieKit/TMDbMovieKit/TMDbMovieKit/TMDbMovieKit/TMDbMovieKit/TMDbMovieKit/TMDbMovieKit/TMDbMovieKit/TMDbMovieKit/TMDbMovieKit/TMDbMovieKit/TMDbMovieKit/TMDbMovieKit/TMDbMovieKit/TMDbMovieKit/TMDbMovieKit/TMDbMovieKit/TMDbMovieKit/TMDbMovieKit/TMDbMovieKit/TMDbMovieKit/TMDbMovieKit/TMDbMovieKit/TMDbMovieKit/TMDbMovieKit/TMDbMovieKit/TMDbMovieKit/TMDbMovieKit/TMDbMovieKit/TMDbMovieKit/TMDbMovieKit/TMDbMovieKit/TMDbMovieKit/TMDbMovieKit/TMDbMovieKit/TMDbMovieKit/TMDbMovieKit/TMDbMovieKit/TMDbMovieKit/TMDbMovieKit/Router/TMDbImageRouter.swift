//
//  TMDbImageRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum TMDbImageRouter {
    case BackDropSmall(path: String)
    case BackDropMedium(path: String)
    case BackdropLarge(path: String)
    case BackdropOriginal(path: String)
    case PosterSmall(path: String)
    case PosterMedium(path: String)
    case PosterLarge(path: String)
    case PosterOriginal(path: String)
    case ProfileSmall(path: String)
    case ProfileMedium(path: String)
    case ProfileLarge(path: String)
    case ProfileOriginal(path: String)
    
    public var url: NSURL? {
        switch self {
        case BackDropSmall(let path):
            return imageURL(path, size: "w300")
        case BackDropMedium(let path):
            return imageURL(path, size: "w780")
        case BackdropLarge(let path):
            return imageURL(path, size: "w1280")
        case BackdropOriginal(let path):
            return imageURL(path, size: "original")
        case PosterSmall(let path):
            return imageURL(path, size: "w185")
        case PosterMedium(let path):
            return imageURL(path, size: "w342")
        case PosterLarge(let path):
            return imageURL(path, size: "w500")
        case PosterOriginal(let path):
            return imageURL(path, size: "original")
        case ProfileSmall(let path):
            return imageURL(path, size: "w45")
        case ProfileMedium(let path):
            return imageURL(path, size: "w185")
        case ProfileLarge(let path):
            return imageURL(path, size: "h632")
        case ProfileOriginal(let path):
            return imageURL(path, size: "original")
        }
    }
    
    private func imageURL(path: String, size: String) -> NSURL? {
        var urlString = ""
        
        switch self {
        case .ProfileSmall(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .ProfileMedium(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .ProfileLarge(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .ProfileOriginal(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        default:
             urlString = "\(TMDbAPI.ImageBaseURL)\(size)/\(path)"
           
        }
        
        return NSURL(string: urlString) ?? nil
    }

}
