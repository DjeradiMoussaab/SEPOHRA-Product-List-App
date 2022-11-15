//
//  ProductListViewModelTest.swift
//  SEPOHRA Product List AppTests
//
//  Created by Moussaab Djeradi on 11/11/2022.
//

import Foundation
import XCTest
import Combine
@testable import SEPOHRA_Product_List_App

class ProductViewModelTests : XCTestCase {
    
    private var productViewModel : ProductViewModel!
    private var subscription = Set<AnyCancellable>()

    override func setUp() {
        productViewModel = ProductViewModel(productService: ProductService())
    }
    
    func testGetProductList() {
        let testExpactation = XCTestExpectation(description: "it should get the list of all products")
        Task {
            await productViewModel.getProductList()
        }
        
        productViewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, 6)
                testExpactation.fulfill()
            }
            .store(in: &subscription)
    }
}
