//
//  DiscountModel.swift
//  VIPER
//
//  Created by Eddy Donald Chinchay Lujan on 7/10/24.
//

import Foundation

struct DiscountModel: Codable {
    let id: Int
    let typeCampaign: Int
    let typeDiscount: Int
    let discount: Float
    let startDate: String // Puedes usar Date si prefieres
    let endDate: String // Puedes usar Date si prefieres
    let startDateNum: Int64
    let endDateNum: Int64
    let state: Int
    let typeSegment: Int

    enum CodingKeys: String, CodingKey {
        case id
        case typeCampaign = "type_campaign"
        case typeDiscount = "type_discount"
        case discount
        case startDate = "start_date"
        case endDate = "end_date"
        case startDateNum = "start_date_num"
        case endDateNum = "end_date_num"
        case state
        case typeSegment = "type_segment"
    }
}

