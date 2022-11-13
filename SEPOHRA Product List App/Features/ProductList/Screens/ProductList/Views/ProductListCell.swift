//
//  ProductListCell.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 19/10/2022.
//

import Foundation
import UIKit

class ProductListCell: UICollectionViewCell {
    static var identifier: String { String(describing: ProductListCell.self) }
    
    public var isSpecial: Bool? {
        didSet {
            if let isSpecial = isSpecial {
                isSpecialIcon.image = isSpecial ? UIImage(named: "starOn.png") : UIImage(named: "starOff.png")
            }
        }
    }
    
    let container: UIView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        //v.layer.cornerRadius = 8.0
        v.layer.borderWidth = 1.0
        v.layer.borderColor = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.00).cgColor
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.7
        v.layer.shadowOffset = CGSize.zero
        v.layer.shadowRadius = 4
        v.layer.shadowPath = UIBezierPath(rect: v.bounds).cgPath
        return v
    }()
    
    let productImage: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 8.0
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.contentMode = .scaleToFill
        v.image = UIImage(named: "imagePlaceHolder.png")
        v.clipsToBounds = true
        return v
    }()
    
    let isSpecialIcon: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        return v
    }()
    
    let productName: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .darkText
        v.font = .boldSystemFont(ofSize: 16)
        v.textAlignment = .left
        return v
    }()
    
    let productDescription: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .darkGray
        v.font = .boldSystemFont(ofSize: 12)
        v.textAlignment = .left
        return v
    }()
    
    let productPrice: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .darkGray
        v.font = .boldSystemFont(ofSize: 16)
        v.textAlignment = .left
        v.textColor = UIColor(red: 0.44, green: 0.78, blue: 0.99, alpha: 1.00)
        return v
    }()
    
    let productBrand: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.textColor = .darkText
        v.font = .boldSystemFont(ofSize: 16)
        v.textAlignment = .left
        return v
    }()
    
    let separator: UIView = {
        let separator = UIView(frame: .zero)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .black
        return separator
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by:  UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .black
        addSubview(container)
        container.addSubview(productName)
        container.addSubview(productImage)
        container.addSubview(productPrice)
        container.addSubview(productBrand)
        container.addSubview(productDescription)
        container.addSubview(isSpecialIcon)
        addSubview(separator)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([

            productImage.topAnchor.constraint(equalTo: container.topAnchor),
            productImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            productImage.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            productImage.heightAnchor.constraint(equalToConstant: 120),
            
            productBrand.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            productBrand.leadingAnchor.constraint(equalTo: isSpecialIcon.trailingAnchor, constant: 8),
            
            isSpecialIcon.heightAnchor.constraint(equalToConstant: 16),
            isSpecialIcon.widthAnchor.constraint(equalToConstant: 16),
            isSpecialIcon.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            isSpecialIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            
            productName.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8),
            productName.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            productName.heightAnchor.constraint(equalToConstant: 20),
            
            productPrice.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 8),
            productPrice.leadingAnchor.constraint(equalTo: productName.trailingAnchor, constant: 16),
            productPrice.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            productDescription.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 8),
            productDescription.heightAnchor.constraint(equalToConstant: 20),
            productDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            productDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            productDescription.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: separator.topAnchor),
            
            
            separator.topAnchor.constraint(equalTo: container.bottomAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 16),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor)

        ])
    }
    
    func configureCell(product: Product) {
        productName.text = product.name
        productBrand.text = product.brand.name
        productBrand.text = product.brand.name
        productPrice.text = product.price.description + "$"
        productName.text = product.name
        productDescription.text = product.description
        isSpecial = product.isSpecial
    }
}
