//
//  ProductRequest.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 18/10/2022.
//

import Foundation

enum ProductEndpoint: Endpoint {
    case getProductList
}

extension ProductEndpoint {
    var httpMethod: RequestType {
        switch self {
        case .getProductList:
            return .GET
        }
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var body: [String : String] {
        [:]
    }
    
    var path: String {
        switch self {
        case .getProductList:
            return APIConstants.productsPath
        }
    }
}



