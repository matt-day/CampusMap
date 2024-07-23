//
//  MapManager.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import Foundation
import MapKit

class MapManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var buildingModel: BuildingModel
    @Published var region: MKCoordinateRegion
    let spanDelta = 0.01
    
    let locationManager : CLLocationManager
    var userTrackingMode : MKUserTrackingMode = .none
    @Published var showsUserLocation = false

    
    override init() {
        let buildingModel = BuildingModel()
        let center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: buildingModel.centerCoord.latitude, longitude: buildingModel.centerCoord.longitude)
        let span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        region = MKCoordinateRegion(center: center, span: span)
        self.buildingModel = buildingModel
        
        locationManager = CLLocationManager()
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    var buildings : [Building] = []
    
    
    var plottedBuildings : [Building] {buildingModel.buildingList.filter({$0.plotted})}
    var favBuildings : [Building] {buildingModel.buildingList.filter({$0.fav})}
    
    
    func displayBuildings() -> [Building] {
        buildings = plottedBuildings + favBuildings
        return buildings
    }
    
    func annotImage(building: Building) -> String {
        if building.fav {
            return "star.circle"
        } else {
            return "building.columns.fill"
        }
    }
    
    func resetPlot() {
        for i in buildingModel.buildingList.indices {
            buildingModel.buildingList[i].plotted = false
        }
    }
    
    
    
    func findFavToToggle(building: inout Building) {
        building.fav.toggle()
    }
    
    
    
    @Published var favoriteFlag: Bool = true
    
    func visFav() {
        if favoriteFlag {
            buildings = plottedBuildings + favBuildings
            favoriteFlag.toggle()
        } else {
            buildings = plottedBuildings
            favoriteFlag.toggle()
        }
    }
    
    func centerOnUserLocation() {
        region.center = locationManager.location!.coordinate
    }
    
}
