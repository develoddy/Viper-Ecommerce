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
    
    var currentColumns: Int = 2 // Valor inicial de columnas
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Suscribirse a los cambios en el modo de columnas
        NotificationCenter.default.addObserver(self, selector: #selector(handleColumnModeChange), name: .didChangeColumnMode, object: nil)
        
        // Configura las acciones de los botones de la barra de filtros
        homeItemView.filterBarView.sortButton.addTarget(self, action: #selector(handleSort), for: .touchUpInside)
        homeItemView.filterBarView.oneColumnButton.addTarget(self, action: #selector(showOneColumn), for: .touchUpInside)
        homeItemView.filterBarView.twoColumnButton.addTarget(self, action: #selector(showTwoColumns), for: .touchUpInside)
        homeItemView.filterBarView.threeColumnButton.addTarget(self, action: #selector(showThreeColumns), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeItemView.frame = view.bounds
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(homeItemView)

        homeItemView.collectionView.dataSource = self
        homeItemView.collectionView.delegate = self
    
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    @objc private func handleColumnModeChange() {
        currentColumns = homeItemView.filterBarView.selectedColumnMode
        homeItemView.collectionView.reloadData()
    }
    
    deinit {
        // Remover el observador al eliminar la vista
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleSort() {
        // Acción para filtrar los productos
        presenter?.filterOptions()
    }
    
    @objc func showOneColumn() {
        currentColumns = 1
        homeItemView.filterBarView.selectedColumnMode = currentColumns
        homeItemView.collectionView.collectionViewLayout.invalidateLayout()
        homeItemView.collectionView.reloadData()
    }

    @objc func showTwoColumns() {
        currentColumns = 2
        homeItemView.filterBarView.selectedColumnMode = currentColumns
        homeItemView.collectionView.collectionViewLayout.invalidateLayout()
        homeItemView.collectionView.reloadData()
    }

    @objc func showThreeColumns() {
        currentColumns = 3
        homeItemView.filterBarView.selectedColumnMode = currentColumns
        homeItemView.collectionView.collectionViewLayout.invalidateLayout()
        homeItemView.collectionView.reloadData()
    }
}

// MARK: - HOME VIEW PROTOCOL
extension HomeView: HomeViewProtocol {

    func updateUIList() {
        DispatchQueue.main.async {
            print("Actualizando la UI...")
            self.homeItemView.collectionView.reloadData()
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
    
    func onError(_ error: Error) {
        print("Error in View fetching Home: \(error.localizedDescription)")
    }
}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Asegúrate de obtener el número de elementos desde el presenter
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        if let item = presenter?.getItem(at: indexPath.item) {
            let showDetails = homeItemView.filterBarView.selectedColumnMode != 3 // Ocultar detalles si son 3 columnas
            cell.configure(with: item, showDetails: showDetails)
    
            // Establecer la altura de la imagen según la lógica deseada
            let imageHeight: CGFloat
            switch homeItemView.filterBarView.selectedColumnMode {
            case 1:
                imageHeight = 450 // Altura para 1 columna
            case 2:
                imageHeight = 250 // Altura para 2 columnas
            case 3:
                imageHeight = 125 // Altura para 3 columnas
            default:
                imageHeight = 250 // Altura predeterminada
            }
            cell.setImageHeight(imageHeight) // Llama al método para establecer la altura
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Comprobar si se trata de la sección de productos
        if indexPath.section == 0 {
            // Notificar al Presenter que se ha seleccionado un producto
            presenter?.didSelectProduct(at: indexPath.item, at: 0)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calcula el ancho de la celda dividiendo el ancho del UICollectionView entre 2, restando los espacios
        let padding: CGFloat = 10
        let collectionViewWidth = collectionView.frame.width - padding * 2
        ///let numberOfColumns = homeItemView.filterBarView.selectedColumnMode // Este valor será 1, 2, o 3 según el botón pulsado
        // Dividimos el ancho del UICollectionView por el número de columnas
        let width = collectionViewWidth / CGFloat(currentColumns) /// Este valor será 1, 2, o 3 según el botón pulsado
        var height: CGFloat = 0
        
        switch currentColumns {
        case 1:
            // Actualiza para 1 columna
            height = 500
        case 2:
            // Actualiza para 2 columnas
            height = 300
        case 3:
            // Actualiza para 3 columnas
            height = width
        default:
            break
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Espaciado desde los bordes del UICollectionView
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaciado vertical entre filas
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaciado horizontal entre celdas
    }
}
