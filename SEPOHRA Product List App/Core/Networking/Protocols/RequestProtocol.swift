//
//  RequestProtocol.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 18/10/2022.
//

import Foundation
protocol RequestProtocol {
    
    var path: String { get }
    var requestType: RequestType { get }
    func generateRequestURL() throws -> URLRequest
}


extension RequestProtocol {
    
    func generateRequestURL() throws -> URLRequest {

        var urlComponents = URLComponents()
        urlComponents.scheme = APIConstants.scheme
        urlComponents.host = APIConstants.host
        urlComponents.path = path

        guard let url = urlComponents.url else { throw RequestErrorType.invalideURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
