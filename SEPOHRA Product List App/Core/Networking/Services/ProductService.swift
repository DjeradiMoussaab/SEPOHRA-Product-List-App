//
//  ProductService.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 2/11/2022.
//

import Foundation
import UIKit

struct ProductService: APIService {
    
    private let api: API
    
    init(_ api: API = API()) {
        self.api = api
    }
    /// func that serves the api call, returning a decoded Data with generic type T
    func perform<T:Decodable>(_ endpoint: Endpoint) async throws -> T {
        let jsonDecoder = JSONDecoderHelper()
        let requestURL = try endpoint.generateRequestURL()
        let response = try await api.makeRequest(requestURL)
        let decodedResponse: T = try jsonDecoder.decode(response)
        return decodedResponse
    }
    
    func perform(from url: URL) async throws -> UIImage {
        let data = try await api.makeRequest(from: url)
        guard let image = UIImage(data: data) else { throw RequestErrorType.DecodingError }
        return image
    }
}

