//
//  APIMock.swift
//  SEPOHRA Product List AppTests
//
//  Created by Moussaab Djeradi on 15/11/2022.
//

import Foundation
@testable import SEPOHRA_Product_List_App

final class APIMock: APIProtocol {
    

    func makeRequest(_ endpoint: Endpoint) async throws -> Data {
        let url = URL(fileURLWithPath: endpoint.path)
        guard let data = try? Data(contentsOf: url) else {
           throw RequestErrorType.invalideURL
        }
        return data
    }
    
    func makeRequest(from url: URL) async throws -> Data {
        guard let data = try? Data(contentsOf: url) else {
            throw RequestErrorType.invalideURL
        }
        return data
    }
    
    

}
