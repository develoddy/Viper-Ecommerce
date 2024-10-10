//
//  ProductDetailView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit

class ProductDetailView: UIViewController {

    // MARK: Properties
    var presenter: ProductDetailPresenterProtocol?
    
    // Instanciar la vista personalizada
    private let productDetailItemView = ProductDetailItemView()
    
    // Miniaturas de las imágenes
    private let thumbnails = ["image1", "image2", "image3", "image4"]
    
    // Datos para productos relacionados
    private let relatedProducts = ["related1", "related2", "related3", "related4"]

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Configurar CollectionView delegates
        productDetailItemView.thumbnailCollectionView.delegate = self
        productDetailItemView.thumbnailCollectionView.dataSource = self
        productDetailItemView.thumbnailCollectionView.reloadData()
        
        productDetailItemView.relatedProductsCollectionView.delegate = self
        productDetailItemView.relatedProductsCollectionView.dataSource = self
        productDetailItemView.relatedProductsCollectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Establecer el frame de la vista personalizada para que ocupe toda la vista principal
        productDetailItemView.frame = view.bounds
        productDetailItemView.scrollView.frame = view.bounds
        
    }
    
    private func setupView() {
        title = "Detalle del producto"
        view.backgroundColor = .systemBackground
        
        // Añadir la vista personalizada a la vista principal
        view.addSubview(productDetailItemView)
        
        presenter?.viewDidLoad()
    }
}

extension ProductDetailView: ProductDetailViewProtocol {
    // TODO: implement view output methods
}

// MARK: - UICollectionViewDelegate
extension ProductDetailView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ///return thumbnails.count
        if collectionView == productDetailItemView.thumbnailCollectionView {
            return thumbnails.count
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return relatedProducts.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /**let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
        cell.configure(with: thumbnails[indexPath.item])
        return cell*/
        
        if collectionView == productDetailItemView.thumbnailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
            cell.configure(with: thumbnails[indexPath.item])
            return cell
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedProductCell.identifier, for: indexPath) as! RelatedProductCell
            cell.configure(with: relatedProducts[indexPath.item]) // Asegúrate de que el método `configure` esté implementado en RelatedProductCell
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        ///return CGSize(width: 80, height: 80)
        if collectionView == productDetailItemView.thumbnailCollectionView {
            return CGSize(width: 80, height: 80)
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return CGSize(width: 100, height: 100) // Ajusta el tamaño según sea necesario
        }
        return CGSize.zero
    }
    
    // Handle thumbnail selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///let selectedImageName = thumbnails[indexPath.item]
        ///productDetailItemView.mainImageView.image = UIImage(named: selectedImageName)
        if collectionView == productDetailItemView.thumbnailCollectionView {
            let selectedImageName = thumbnails[indexPath.item]
            productDetailItemView.mainImageView.image = UIImage(named: selectedImageName)
        }
        // Puedes agregar lógica adicional para los productos relacionados si lo deseas
    }
}

