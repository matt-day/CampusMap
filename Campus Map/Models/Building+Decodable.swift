//
//  Building+Decodable.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import Foundation

extension Building {
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case name
        case code = "opp_bldg_code"
        case photo
        case date = "year_constructed"
        case fav
        case plotted
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
        name = try values.decode(String.self, forKey: .name)
        code = try values.decode(Int.self, forKey: .code)
        photo = try values.decodeIfPresent(String.self, forKey: .photo) ?? ""
        date = try values.decodeIfPresent(Int.self, forKey: .date) ?? 0
        fav = try values.decodeIfPresent(Bool.self, forKey: .fav) ?? false
        plotted = try values.decodeIfPresent(Bool.self, forKey: .plotted) ?? false
    }
}
