//
//  Decoder.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 20/10/2022.
//

import UIKit

protocol Decoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

class JSONDecoderHelper: Decoder {
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        guard let decodedData = try? jsonDecoder.decode(T.self, from: data) else {        throw RequestErrorType.DecodingError }
        return decodedData
    }
}
