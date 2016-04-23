//
//  ResponseJSONObjectSerializable.swift
//  DiscoverMovies
//
//  Created by Kaira Diagne on 13-04-16.
//  Copyright © 2016 Kaira Diagne. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    init?(json: SwiftyJSON.JSON)
}
