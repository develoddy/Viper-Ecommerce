import UIKit

class HeaderHomeView: UICollectionReusableView {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar productos"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .gray
        searchBar.isTranslucent = true
        return searchBar
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView() {
        backgroundColor = .systemBackground
        ///addSubview(logoImageView)
        addSubview(searchBar)
        
        // Configura las restricciones para el searchBar
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 50), // Ajusta según sea necesario
            searchBar.heightAnchor.constraint(equalToConstant: 50) // Altura fija
        ])
    }
    
    func configure(with logo: UIImage?) {
        ///logoImageView.image = logo
    }
}
