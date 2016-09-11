//
//  TMDbImageRouter.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 17-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation

public enum TMDbImageRouter {
    case backDropSmall(path: String)
    case backDropMedium(path: String)
    case backdropLarge(path: String)
    case backdropOriginal(path: String)
    case posterSmall(path: String)
    case posterMedium(path: String)
    case posterLarge(path: String)
    case posterOriginal(path: String)
    case profileSmall(path: String)
    case profileMedium(path: String)
    case profileLarge(path: String)
    case profileOriginal(path: String)
    
    public var url: URL? {
        switch self {
        case .backDropSmall(let path):
            return imageURL(path, size: "w300")
        case .backDropMedium(let path):
            return imageURL(path, size: "w780")
        case .backdropLarge(let path):
            return imageURL(path, size: "w1280")
        case .backdropOriginal(let path):
            return imageURL(path, size: "original")
        case .posterSmall(let path):
            return imageURL(path, size: "w185")
        case .posterMedium(let path):
            return imageURL(path, size: "w342")
        case .posterLarge(let path):
            return imageURL(path, size: "w500")
        case .posterOriginal(let path):
            return imageURL(path, size: "original")
        case .profileSmall(let path):
            return imageURL(path, size: "w45")
        case .profileMedium(let path):
            return imageURL(path, size: "w185")
        case .profileLarge(let path):
            return imageURL(path, size: "h632")
        case .profileOriginal(let path):
            return imageURL(path, size: "original")
        }
    }
    
    fileprivate func imageURL(_ path: String, size: String) -> URL? {
        var urlString = ""
        
        switch self {
        case .profileSmall(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .profileMedium(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .profileLarge(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        case .profileOriginal(let path):
             urlString = "\(TMDbAPI.GravatarBaseURLString)\(size)/\(path)"
        default:
             urlString = "\(TMDbAPI.ImageBaseURL)\(size)/\(path)"
           
        }
        
        return URL(string: urlString) ?? nil
    }

}
