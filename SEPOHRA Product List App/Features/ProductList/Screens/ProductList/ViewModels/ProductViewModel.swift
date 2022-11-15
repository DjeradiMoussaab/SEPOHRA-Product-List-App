//
//  ProductViewModel.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 18/10/2022.
//

import Foundation
import UIKit
import Combine

final class ProductViewModel {
    
    var currentState =  CurrentValueSubject<State, Never>(.loading)

    private var productService : ProductService
    private var productEntityManager: ProductEntityManager
    
    init(productService: ProductService = ProductService()) {
        self.productService = productService
        self.productEntityManager = ProductEntityManager()
    }

    @Published var products: [Product] = [] {
        didSet {
            if !products.isEmpty {
                currentState.value = .success
                productEntityManager.save(model: products)
            } else {
                currentState.value = .failure
            }
        }
    }
    
    @MainActor
    func getProductList() async {
        
        if let productEntities = productEntityManager.fetchAll() {
            products = productEntities.map { productEntityManager.transform(entity: $0) }
        }
        
        do {
            products = try await productService.perform(ProductEndpoint.getProductList)
        } catch {
            products = []
        }
    }
    
    @MainActor
    func download(imageURL: String) async -> UIImage? {
        do {
            guard let url = URL(string: imageURL) else { throw RequestErrorType.invalideURL }
            return  try await productService.perform(from: url)
        } catch {
            return nil
        }
    }
}
