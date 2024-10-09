import UIKit

class HeaderHomeView: UICollectionReusableView {

    /**private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()*/
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        // Ajustar el tamaño del searchBar para que ocupe todo el ancho y esté más abajo
        searchBar.frame = CGRect(
            x: 10, // Margen izquierdo
            y: 45, // Posición vertical ajustada para moverlo más abajo dentro del header
            width: frame.width - 20, // Margen izquierdo y derecho de 10 puntos
            height: 50 // Altura del searchBar
        )
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        ///addSubview(logoImageView)
        addSubview(searchBar)
    }
    
    func configure(with logo: UIImage?) {
        ///logoImageView.image = logo
    }
}
