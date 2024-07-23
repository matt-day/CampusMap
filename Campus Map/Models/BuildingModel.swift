//
//  BuildingModel.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import Foundation

struct Coord {
    var latitude : Double
    var longitude : Double
}

struct BuildingModel {
    let manager : StorageManager
    var buildingList : [Building]
    let centerCoord = Coord(latitude: 40.7964685139719, longitude: -77.8628317618596)


    init() {
        manager = StorageManager()
        buildingList = manager.buildings
    }

    func save() {
        manager.save(buildings: buildingList)
    }
    
}
