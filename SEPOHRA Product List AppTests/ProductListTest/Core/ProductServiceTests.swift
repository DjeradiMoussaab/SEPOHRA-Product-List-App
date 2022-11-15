//
//  ProductServiceTests.swift
//  SEPOHRA Product List AppTests
//
//  Created by Moussaab Djeradi on 15/11/2022.
//

import XCTest
@testable import SEPOHRA_Product_List_App

class ProductServiceTests: XCTestCase {
    
    private var productService : APIService!
    
    override func setUp()  {
        self.productService = ProductService(APIMock())
    }

    override func tearDown()  {
        self.productService = nil
    }

    func testPerformRequest() async {

        let testExpactation = XCTestExpectation(description: "it should perfome the request to get the list of all products")
        do {
            let products: [Product] =  try await productService.perform(ProductEndpointMock.getProductList)
            XCTAssertEqual(products.first!.name, "Kit bain fleur de coton")
            testExpactation.fulfill()
        } catch {
            XCTFail("Error")
        }
        wait(for: [testExpactation], timeout: 1)
        
    }

    
    func testPerformImageDonwlowd() async {
        let testExpactation = XCTestExpectation(description: "it should perfome the request to get the image")
        
        guard let imageUrl = Bundle(for: type(of: self)).url(forResource: "testingImage", withExtension: "png") else {
            XCTFail(RequestErrorType.invalideURL.message)
            return
        }
        do {
            let image = try await productService.perform(from: imageUrl)
            XCTAssertNotNil(image)
            testExpactation.fulfill()
        } catch {
            XCTFail("Error")
        }
        wait(for: [testExpactation], timeout: 1)
        
    }


}
