//
//  SDWebImage+CachedImage.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 11/05/16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SDWebImage

extension SDWebImageManager {
    
    func cachedImageForURL(url: NSURL) -> UIImage? {
        if cachedImageExistsForURL(url) {
            let key = SDWebImageManager.sharedManager().cacheKeyForURL(url)
            return SDImageCache.sharedImageCache().imageFromDiskCacheForKey(key)
        }
        return nil
    }
    
}


