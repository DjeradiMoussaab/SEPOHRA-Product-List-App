//
//  ProductService.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 20/10/2022.
//

import Foundation
import UIKit

protocol APIService {
    func perform<T:Decodable>(_ endpoint: Endpoint) async throws -> T
    func perform(from url: URL) async throws -> UIImage
}
