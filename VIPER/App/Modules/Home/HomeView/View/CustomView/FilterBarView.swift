//
//  FilterBarView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 8/10/24.
//

import UIKit

class FilterBarView: UIView {
    
    let sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ordenar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filtrar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        backgroundColor = UIColor.systemBackground
        addSubview(sortButton)
        addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 40),
            sortButton.widthAnchor.constraint(equalToConstant: 100),
            sortButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            filterButton.heightAnchor.constraint(equalToConstant: 40),
            filterButton.widthAnchor.constraint(equalToConstant: 100),
            filterButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            filterButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

