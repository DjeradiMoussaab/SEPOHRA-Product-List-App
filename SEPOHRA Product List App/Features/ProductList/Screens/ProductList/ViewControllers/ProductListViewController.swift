//
//  ProductListViewController.swift
//  SEPOHRA Product List App
//
//  Created by Moussaab Djeradi on 19/10/2022.
//

import Foundation
import UIKit
import Combine

class ProductListViewController: UIViewController {
    
    private var productListViewModel = ProductViewModel()
    private var collectionView : UICollectionView!
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Product>
    private var dataSource: DataSource?

    private var subscription = Set<AnyCancellable>()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)


    }
    
    override func viewDidLoad() {
        navigationItem.title = "SEPHORA"
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        self.configureDataSource()
        handleData()
        Task {
            await productListViewModel.getProductList()
        }
    }

}

// MARK: - COMPOSITIONAL LAYOUT

extension ProductListViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let section = Section.allCases[sectionIndex]
            switch section {
            case .simple:
                return self.createSimpleBrandSectionLayout()
            case .special:
                return self.createSpecialBrandSectionLayout()
            }
        }
        return layout
    }
    
    private func createSpecialBrandSectionLayout() -> NSCollectionLayoutSection {
        
        /* create sizes for items and groups. */
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let groupeSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5), heightDimension: .absolute(200))

        /* create item and group. */
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupeSize, subitems: [item])
        
        /* create the section. */
        let specialBrandSection = NSCollectionLayoutSection(group: group)
        specialBrandSection.orthogonalScrollingBehavior = .continuous
        return specialBrandSection
    }
    
    
    private func createSimpleBrandSectionLayout() -> NSCollectionLayoutSection {
        
        /* create sizes for items and groups. */
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let groupeSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))

        /* create item and group. */
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupeSize, subitems: [item])
        
        /* create the section. */
        let simpleBrandSection = NSCollectionLayoutSection(group: group)
        return simpleBrandSection
    }
}

// MARK: - Create DataSource

extension ProductListViewController {
    
    private func configureDataSource() {
        
        let productCellRegistration = UICollectionView.CellRegistration<ProductListCell, Product> { (cell, indexPath, product) in
            cell.configureCell(product: product)
            Task { [weak self]  in
                guard let self = self else { return }
                let image = await  self.productListViewModel.download(imageURL: product.image.small)
                cell.productImage.image = image
            }
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView, indexPath, product) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: productCellRegistration, for: indexPath, item: product)
        }
        
    }
    
    private func applySnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)

        Section.allCases.forEach { section in
            switch section {
            case .simple:
                let items = productListViewModel.products.filter { !$0.isSpecial }
                snapshot.appendItems(items, toSection: .simple)
            case .special:
                let items = productListViewModel.products.filter { $0.isSpecial }
                snapshot.appendItems(items, toSection: .special)
            }
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func handleData() {
        
        productListViewModel
            .currentState
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .success:
                    self.configureDataSource()
                    self.applySnapshot()
                case .failure:
                    print("failed")
                case .loading:
                    print("loading..")

                }
            }
            .store(in: &subscription)
    }
}
