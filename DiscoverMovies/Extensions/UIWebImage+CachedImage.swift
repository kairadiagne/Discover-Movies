//
//  UIWebImage+CachedImage.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit
import SDWebImage

public extension SDWebImageManager {
    
    public func getImageFromCache(_ movie: Movie) ->UIImage? {
        guard let url = TMDbImageRouter.BackDropMedium(path: movie.backDropPath).url else { return nil}
        guard let key = SDWebImageManager.sharedManager().cacheKeyForURL(url) else { return nil }
        return SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key) ?? nil
    }
    
}
