//
//  Building.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import Foundation

struct Building: Identifiable, Decodable, Encodable {
    let latitude: Double
    let longitude: Double
    let name: String
    let code: Int
    let photo: String?
    let date: Int?
    var fav: Bool
    var plotted: Bool
    
    var id = UUID()
    
    static let standard = Building(latitude: 40.7964685139719, longitude: -77.8628317618596, name: "B", code: 12345, photo: "atherton", date: 2001, fav: false, plotted: true)
    static let standard2 = Building(latitude: 40.79550030, longitude: -77.85900170, name: "A", code: 12345, photo: "davey", date: 2001, fav: true, plotted: false)
}
