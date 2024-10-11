//
//  ProductDetailView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//  
//

import Foundation
import UIKit
import SDWebImage

class ProductDetailView: UIViewController {

    // MARK: Properties
    var presenter: ProductDetailPresenterProtocol?
    
    // Instanciar la vista personalizada
    private let productDetailItemView = ProductDetailItemView()
    
    // Miniaturas de las imágenes
    private var galerias: [GaleriaModel] = []
    
    // Datos para productos relacionados
    private var relatedProducts: [ProductModel] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionViews()
        presenter?.viewDidLoad()
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
        view.addSubview(productDetailItemView)
    }
    
    // Configurar CollectionView delegates
    private func configureCollectionViews() {
        productDetailItemView.thumbnailCollectionView.delegate = self
        productDetailItemView.thumbnailCollectionView.dataSource = self
        productDetailItemView.thumbnailCollectionView.reloadData()
        
        productDetailItemView.relatedProductsCollectionView.delegate = self
        productDetailItemView.relatedProductsCollectionView.dataSource = self
        productDetailItemView.relatedProductsCollectionView.reloadData()
    }
}


// MARK: - ProductDetailViewProtocol
extension ProductDetailView: ProductDetailViewProtocol {
    
    func updateUIList() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // Obtén el producto actual
            guard let product = self.presenter?.geProduct(), 
                  let relatedProducts = self.presenter?.getRelatedProducts() else {
               return
            }
            self.configureUI(with: product, relatedProducts: relatedProducts)
        }
    }
    
    private func configureUI(with product: ProductModel, relatedProducts: [ProductModel]) {
        if let imageName = product.imagen, let imageUrl = URL(string: imageName) {
            productDetailItemView.mainImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        } else {
            productDetailItemView.mainImageView.image = nil
        }

        productDetailItemView.titleLabel.text = product.title
        productDetailItemView.priceLabel.text = String(format: "$%.2f", product.priceUsd ?? 0)
        productDetailItemView.descriptionLabel.text = product.description
        self.galerias = product.galerias ?? []
        self.relatedProducts = relatedProducts

        productDetailItemView.thumbnailCollectionView.reloadData()
        productDetailItemView.relatedProductsCollectionView.reloadData()
    }

    func startActivity() {
        /**DispatchQueue.main.async {
            self.homeItemView.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.homeItemView.collectionView.alpha = 0.0
            })
        }*/
    }
    
    func stopActivity() {
        /**DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.homeItemView.activityIndicator.stopAnimating()
            self.homeItemView.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.homeItemView.collectionView.alpha = 1.0
            })
        }*/
    }
}



// MARK: - UICollectionViewDelegate
extension ProductDetailView: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /**if collectionView == productDetailItemView.thumbnailCollectionView {
            return galerias.count
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return relatedProducts.count
        }
        return 0*/
        return collectionView == productDetailItemView.thumbnailCollectionView ? galerias.count : relatedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productDetailItemView.thumbnailCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCell.identifier, for: indexPath) as! ThumbnailCell
            let galeria = galerias[indexPath.item] // Obtener el modelo de galería correspondiente
            cell.configure(with: galeria) // Pasar el modelo de galería a la celda
            return cell
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedProductCell.identifier, for: indexPath) as! RelatedProductCell
            let relatedProduct = relatedProducts[indexPath.item] // Obtener el modelo de producto relacionado correspondiente
            cell.configure(with: relatedProduct) // Pasar el modelo de producto relacionado a la celda
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /**if collectionView == productDetailItemView.thumbnailCollectionView {
            return CGSize(width: 80, height: 80)
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return CGSize(width: 200, height: 250)
        }
        return CGSize.zero*/
        return collectionView == productDetailItemView.thumbnailCollectionView ? CGSize(width: 80, height: 80) : CGSize(width: 200, height: 250)
    }
    
    // Handle thumbnail selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productDetailItemView.thumbnailCollectionView {
            if let selectedImageName = galerias[indexPath.item].imagen {
                ///print("--> Handle galerias selection: \(selectedImageName)")
                let imageUrl = URL(string: selectedImageName)
                self.productDetailItemView.mainImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            } else {
                self.productDetailItemView.mainImageView.image = nil // O una imagen predeterminada
            }
        }
    }
}


