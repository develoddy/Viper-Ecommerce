//
//  EditAddressView.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 13/1/25.
//  
//

import Foundation
import UIKit

class EditAddressView: UIViewController {

    // MARK: Properties
    var presenter: EditAddressPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EditAddressView: EditAddressViewProtocol {
    // TODO: implement view output methods
}
