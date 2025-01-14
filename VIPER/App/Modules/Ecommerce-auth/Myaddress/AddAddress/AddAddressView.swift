//
//  AddAddressView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class AddAddressView: UIViewController {

    // MARK: Properties
    var presenter: AddAddressPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AddAddressView: AddAddressViewProtocol {
    // TODO: implement view output methods
}
