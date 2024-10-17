//
//  HomeView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/22.
//  
//

import Foundation
import UIKit

class HomeView: UIViewController {

    // MARK: - PROPERTIES
    var presenter: HomePresenterProtocol?
    var homeItemView = HomeItemView()
    let cellSpacingHeight: CGFloat = 5
    
    
    // MARK: - LIFECICLY

    // VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Configura las acciones de los botones de la barra de filtros
        homeItemView.filterBarView.filterButton.addTarget(self, action: #selector(handleFilter), for: .touchUpInside)
        homeItemView.filterBarView.sortButton.addTarget(self, action: #selector(handleSort), for: .touchUpInside)
    }
    
    // VIEW DID LAYOUT SUB VIEWS
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeItemView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeItemView)

        // Configura el delegate y dataSource de homeUI	
        homeItemView.collectionView.dataSource = self
        homeItemView.collectionView.delegate = self
    
        // COMUNICO A MI VISTA CON EL PRESENTER
        presenter?.viewDidLoad()
    }
    
    // Función para cargar una imagen desde una URL
    /**private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }*/
    
    @objc func handleFilter() {
        // Acción para filtrar los productos
        presenter?.filterOptions()
    }
    
    @objc func handleSort() {
        // Acción para ordenar los productos
        print("Ordenar productos")
        
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.numberOfSections() ?? 0 // Asegúrate de que esto sea correcto
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Asegúrate de obtener el número de elementos desde el presenter
        return presenter?.numberOfItems(in: section) ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0: // Categorías
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
            if let item = presenter?.getItem(at: indexPath.item, in: indexPath.section) {
                if case let .categories(category) = item {
                    cell.configure(with: category)
                }
            }
            return cell
        case 1: // Productos
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as! ProductCell
            if let item = presenter?.getItem(at: indexPath.item, in: indexPath.section) {
                if case let .produtcs(product) = item {
                    cell.configure(with: product) // Pasar el objeto ProductModel
                }
            }
            return cell
        default:
            return UICollectionViewCell() // Manejo de error
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Deselect the item
        collectionView.deselectItem(at: indexPath, animated: true)

        // Comprobar si se trata de la sección de productos
        if indexPath.section == 1 {
            // Notificar al Presenter que se ha seleccionado un producto
            /// Pasa el discount de cero de momento
            presenter?.didSelectProduct(at: indexPath.item, at: 0)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 15
        // Verificar si es una celda de categoría o de producto
        if indexPath.section == 0 {
            // Celdas de categorías (por ejemplo, sección 0)
            return CGSize(width: width, height: 100) // Ajusta la altura para categorías
        } else {
            // Celdas de productos (otra sección)
            return CGSize(width: width, height: 300) // Ajusta la altura para productos
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Inset para la sección
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaciado vertical entre filas
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaciado horizontal entre celdas
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80) // Ajusta la altura del header
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! HeaderHomeView
        headerView.configure(with: UIImage(named: "logo-black"))
        return headerView // Ahora debería funcionar sin errores
    }*/

}



// MARK: - HOME VIEW PROTOCOL
extension HomeView: HomeViewProtocol {
    
    func updateUIList() {
        DispatchQueue.main.async {
            //self.homeUI.tableView.reloadData()
            print("Actualizando la UI...")
            self.homeItemView.collectionView.reloadData() // Asegúrate de que hay un método en HomeItemView para recargar datos
        }
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.homeItemView.activityIndicator.startAnimating()
            UIView.animate(withDuration: 0.2, animations:  {
                self.homeItemView.collectionView.alpha = 0.0
            })
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            self.homeItemView.activityIndicator.stopAnimating()
            self.homeItemView.activityIndicator.hidesWhenStopped = true
            UIView.animate(withDuration: 0.2, animations: {
                self.homeItemView.collectionView.alpha = 1.0
            })
        }
    }
}
