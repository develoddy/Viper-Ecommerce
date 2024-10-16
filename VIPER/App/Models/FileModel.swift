//
//  FileModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct FileModel: Codable {
    let id: Int
    let idFile: Int
    let type: String
    let hash: String
    let url: String?
    let filename: String
    let mimeType: String
    let size: Int
    let width: Int
    let height: Int
    let dpi: Int?
    let status: String
    let created: Int
    let thumbnailUrl: String
    let previewUrl: String
    let visible: Bool
    let isTemporary: Bool
    let message: String
    let optionVarietyId: Int
    let createdAt: String // Cambiado a String para poder decodificar la fecha
    let updatedAt: String // Cambiado a String para poder decodificar la fecha
    let varietyId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case idFile = "idFile"
        case type
        case hash
        case url
        case filename
        case mimeType = "mime_type"
        case size
        case width
        case height
        case dpi
        case status
        case created
        case thumbnailUrl = "thumbnail_url"
        case previewUrl = "preview_url"
        case visible
        case isTemporary = "is_temporary"
        case message
        case optionVarietyId
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case varietyId
    }
}


// Modelo de File utilizando Codable
/**struct FileModel: Codable {
    let id: Int?
    let idFile: Int
    let type: String
    let hash: String
    let url: String?
    let filename: String
    let mimeType: String
    let size: Int
    let width: Int
    let height: Int
    let dpi: Int?
    let status: String
    let created: Int
    let thumbnailUrl: String?
    let previewUrl: String?
    let visible: Bool
    let isTemporary: Bool
    let message: String?
    let optionVarietyId: Int

    enum CodingKeys: String, CodingKey {
        case id
        case idFile = "idFile"
        case type
        case hash
        case url
        case filename
        case mimeType = "mime_type"
        case size
        case width
        case height
        case dpi
        case status
        case created
        case thumbnailUrl = "thumbnail_url"
        case previewUrl = "preview_url"
        case visible
        case isTemporary = "is_temporary"
        case message
        case optionVarietyId = "optionVarietyId"
    }
}*/
