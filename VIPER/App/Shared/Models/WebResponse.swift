//
//  WebResponse.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation
class WebResponse: NSObject {
    var respuestaJSON   : Any?
    var statusCode      : NSInteger?
    var dataResponse    : Data?
    var error           : NSError?
    var datosCabecera   : NSDictionary?
    var token           : NSString?
    var cookie          : NSString?
}
