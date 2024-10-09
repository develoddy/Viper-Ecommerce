//
//  BCApiError.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation


enum BCApiError: Error {
    case emptyEmail
    case emptyPassword
    case unknown(String)
}
