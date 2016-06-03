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
    
    // Returns the URL if the image does not exist in the cache
    
    public func getImageFromCache(movie: TMDbMovie) -> (image: UIImage?, url: NSURL?) {
        guard let path = movie.backDropPath, url = TMDbImageRouter.BackDropMedium(path: path).url else { return (nil, nil) }
        guard let key = SDWebImageManager.sharedManager().cacheKeyForURL(url) else { return (nil, url) }
        guard let image = SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key) else { return (nil, url) }
        return (image: image, url: nil)
    }
    
}