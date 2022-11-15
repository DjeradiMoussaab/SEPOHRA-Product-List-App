//
//  EndpointMock.swift
//  SEPOHRA Product List AppTests
//
//  Created by Moussaab Djeradi on 15/11/2022.
//

import Foundation
import XCTest
@testable import SEPOHRA_Product_List_App


enum ProductEndpointMock: Endpoint {
    case getProductList
}

extension ProductEndpointMock {
    
    var path: String {
        guard let path = Bundle.main.path(forResource: "Resources/Products", ofType: "json") else {
            fatalError(RequestErrorType.invalideURL.message)
        }
        return path
    }
}



