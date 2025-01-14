//
//  SaleAddressResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 14/1/25.
//

import Foundation

struct SaleAddressResponse: Codable {
    let addressClient: [SaleAddressModel]
    
    enum CodingKeys: String, CodingKey {
        case addressClient = "address_client"
    }
}
