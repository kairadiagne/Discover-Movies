//
//  Mock+APIRequest.swift
//  TMDbMovieKitTests
//
//  Created by Kaira Diagne on 12/10/2019.
//  Copyright © 2019 Kaira Diagne. All rights reserved.
//

import Mocker
@testable import TMDbMovieKit

extension Mock {

    internal init(apiRequest: ApiRequest, statusCode: Int, data: Data) throws {
        let urlRequest = try apiRequest.asURLRequest()
        self.init(url: urlRequest.url!, dataType: Mock.DataType.json, statusCode: statusCode, data: [HTTPMethod(rawValue: apiRequest.method.rawValue)!: data], additionalHeaders: apiRequest.headers)
    }
}
