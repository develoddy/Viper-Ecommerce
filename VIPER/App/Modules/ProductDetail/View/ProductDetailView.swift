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


// MARK: - ProductDetailViewProtocol
extension ProductDetailView: ProductDetailViewProtocol {
    
    func updateUIList() {
        DispatchQueue.main.async {
            // Obtén el producto actual
           guard let product = self.presenter?.geProduct(), let relatedProducts = self.presenter?.getRelatedProducts() else {
               return
           }
            
            // Configura la imagen principal
            if let imageName = product.imagen {
                let imageUrl = URL(string: imageName)
                self.productDetailItemView.mainImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            } else {
                self.productDetailItemView.mainImageView.image = nil // O una imagen predeterminada
            }
            
            if let galerias = product.galerias {
                self.galerias = galerias
            }
            
            self.relatedProducts = relatedProducts
            
            self.productDetailItemView.thumbnailCollectionView.reloadData()
            self.productDetailItemView.relatedProductsCollectionView.reloadData()
        }
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
extension ProductDetailView: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productDetailItemView.thumbnailCollectionView {
            return galerias.count
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return relatedProducts.count
        }
        return 0
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
        if collectionView == productDetailItemView.thumbnailCollectionView {
            return CGSize(width: 80, height: 80)
        } else if collectionView == productDetailItemView.relatedProductsCollectionView {
            return CGSize(width: 100, height: 100)
        }
        return CGSize.zero
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


