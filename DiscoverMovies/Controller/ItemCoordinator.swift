//
//  ItemCoordinator.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 20-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import TMDbMovieKit

class ItemCoordinator<Item: ResponseJSONObjectSerializable> {
    
    weak var delegate: ItemCoordinatorDelegate!
    
    private(set) var page = 0
    private(set) var nextPage: Int? = 0
    private (set) var totalPages = 0
    private(set) var items: [Item] = []
    var inProgress = false
    
    func resetPagination() {
        page = 0
        nextPage = 0
        totalPages = 0
    }
    
    func clearAllItems() {
        items.removeAll()
    }
    
    func removeItemAtIndex(index: Int) {
        guard index > 0 && index < items.count else { return }
        items.removeAtIndex(index)
    }
    
    init() { }
    
    // MARK: - Pagination 
    
    func fetchNextPageIfNeeded(index: Int) {
        if !inProgress && nextPage != nil && (items.count - 5 == index) {
            fetchNextPage()
        }
    }
    
    func fetchNextPage() { }
    
    // MARK: - Handle Response
    
    typealias Response = (result: TMDbFetchResult<Item>?, error: NSError?)
    
    func handleResponse(response: Response) {
        inProgress = false
        guard response.error == nil else {
            self.delegate?.coordinatorDidReceiveError(response.error!)
            return
        }
        
        if let result = response.result {
            if result.items.count == 0 {
                resetPagination()
                clearAllItems()
                delegate?.coordinatorDidUpdateItems(nil)
            } else if result.items.count > 0 && result.page == 1 {
                page = result.page
                nextPage = result.nextPage
                totalPages = result.totalPages
                items = result.items
                delegate?.coordinatorDidUpdateItems(page)
            } else if result.items.count > 0 && result.page > 1 {
                page = result.page
                nextPage = result.nextPage
                totalPages = result.totalPages
                items.appendContentsOf(result.items)
                delegate?.coordinatorDidUpdateItems(page)
            }
        }
    }
    
}



