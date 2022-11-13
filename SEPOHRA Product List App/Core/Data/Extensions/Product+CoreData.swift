//
//  Product+CoreData.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 31/10/2022.
//

import Foundation

extension Product {
    init(managedObject: ProductEntity) {
        self.name = managedObject.name ?? ""
        self.description = managedObject.productDescription ?? ""
        self.id = Int(managedObject.id)
        let brand = Brand(id: managedObject.brandID ?? "", name: managedObject.brand ?? "")
        self.brand = brand
        self.isSpecial = managedObject.isSpecial
        self.price = managedObject.price
        let image = Image(small: managedObject.image ?? "", large: "")
        self.image = image
        self.isProductSet = managedObject.isProductSet
    }
}

extension ProductEntity {
    convenience init(product: Product) {
        self.init(context: PersistenceManager.shared.context)
        self.setValue(product.id, forKey: "id")
        self.setValue(product.name, forKey: "name")
        self.setValue(product.description, forKey: "productDescription")
        self.setValue(product.brand.id, forKey: "brandID")
        self.setValue(product.brand.name, forKey: "brand")
        self.setValue(product.isSpecial, forKey: "isSpecial")
        self.setValue(product.image.small, forKey: "image")
        self.setValue(product.price, forKey: "price")
        self.setValue(product.isProductSet, forKey: "isProductSet")

    }
}
