//
//  RequestErrorType.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 18/10/2022.
//

import Foundation
enum RequestErrorType : Error {
    case DecodingError
    case invalideURL
    case invalideResponse
    case unauthorized
    case unknown
    
    var message : String {
        switch self {
        case .DecodingError:
            return "Decoding Error"
        case .invalideURL:
            return "Invalide URL"
        case .invalideResponse:
            return "Invalide Response"
        case .unauthorized:
            return "Access Denied"
        case .unknown:
            return "Unkown Error"
        }
    }
}

