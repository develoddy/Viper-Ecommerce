//
//  FileModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

// Modelo de File utilizando Codable
struct FileModel: Codable {
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
}

// Ejemplo de inicialización del modelo File
let exampleFile = FileModel(
    id: 1,
    idFile: 101,
    type: "image",
    hash: "abc123hash",
    url: "https://example.com/file.png",
    filename: "file.png",
    mimeType: "image/png",
    size: 2048,
    width: 1920,
    height: 1080,
    dpi: 300,
    status: "uploaded",
    created: 1694000400,
    thumbnailUrl: "https://example.com/file_thumbnail.png",
    previewUrl: "https://example.com/file_preview.png",
    visible: true,
    isTemporary: false,
    message: nil,
    optionVarietyId: 10
)
