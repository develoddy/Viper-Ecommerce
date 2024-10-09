//
//  HomeUI.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 18/1/22.
//

import UIKit

class HomeItemView: UIView {
    
    private let headerView: HeaderHomeView = {
        let view = HeaderHomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let filterBarView: FilterBarView = {
        let view = FilterBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       //layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 15, height: 150)
       // Espaciado entre líneas e ítems
       layout.minimumLineSpacing = 10
       layout.minimumInteritemSpacing = 10
       
       // Configura los insets de la sección
       layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       
       return collectionView
   }()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActivityIndicator()
        configureHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Ajusta el frame del header
        headerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 100) // Altura fija para el header
        
        // Ajusta el frame de la barra de filtros
        filterBarView.frame = CGRect(x: 0, y: headerView.frame.maxY, width: frame.width, height: 50) // Altura fija para la barra de filtros
        
        // Ajusta el frame del collectionView
        collectionView.frame = CGRect(x: 0, y: filterBarView.frame.maxY, width: frame.width, height: frame.height - headerView.frame.height - filterBarView.frame.height)
        ///collectionView.frame = CGRect(x: 0, y: headerView.frame.maxY, width: frame.width, height: frame.height - headerView.frame.height)
                
        
        // Configura el frame del activityIndicator
        activityIndicator.center = center
    }

    private func setupView() {
        addSubview(headerView)
        addSubview(filterBarView)
        addSubview(collectionView)
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        //No necesitas registrar HeaderHomeView aquí ya que no es un header de sección
        ///collectionView.register(HeaderHomeView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
    }
    
    private func configureHeader() {
            // Configura el logo aquí, asegúrate de que la imagen esté en tus assets
            headerView.configure(with: UIImage(named: "logo-black"))
        }
}

