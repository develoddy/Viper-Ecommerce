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
        view.backgroundColor = .clear
        return view
    }()
    
    public let filterBarView: FilterBarView = {
        let view = FilterBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    public let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.minimumLineSpacing = 10
       layout.minimumInteritemSpacing = 10
       // Configura los insets de la sección
       layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       
       return collectionView
   }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupActivityIndicator()
        configureHeader()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(headerView)
        addSubview(filterBarView)
        addSubview(collectionView)
        
        // Configura las restricciones para headerView
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100) // Altura fija
        ])
        
        // Configura las restricciones para filterBarView
        NSLayoutConstraint.activate([
            filterBarView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            filterBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filterBarView.heightAnchor.constraint(equalToConstant: 50) // Altura fija
        ])
        
        // Configura las restricciones para collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: filterBarView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor) // Ocupa el resto de la vista
        ])
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        //No necesitas registrar HeaderHomeView aquí ya que no es un header de sección
        ///collectionView.register(HeaderHomeView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }

    private func setupActivityIndicator() {
        addSubview(activityIndicator)

        // Centra el activityIndicator en la vista
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 20),  // Ancho específico
            activityIndicator.heightAnchor.constraint(equalToConstant: 20)  // Alto específico
        ])
    }
    
    private func configureHeader() {
        // Configura el logo aquí, asegúrate de que la imagen esté en tus assets
        headerView.configure(with: UIImage(named: "logo-black"))
    }
}

