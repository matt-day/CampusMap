//
//  MapManager+CLLocation.swift
//  Campus Map
//
//  Created by Matt Day on 2/28/22.
//

import Foundation
import CoreLocation

extension MapManager {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            showsUserLocation = true
            locationManager.startUpdatingLocation()
            userTrackingMode = .follow
        default:
            locationManager.stopUpdatingLocation()
            showsUserLocation = false
            userTrackingMode = .none
        }
    }
    
    // Learned to do topleft and bottomright from mikina on github zoomToFitMapAnnotations
    func updateSpan() {
        if buildings.isEmpty {
            return
        }
        
        var topLeftCoord = CLLocationCoordinate2D()
        topLeftCoord.latitude = buildingModel.centerCoord.latitude
        topLeftCoord.longitude = buildingModel.centerCoord.longitude

        var bottomRightCoord = CLLocationCoordinate2D()
        bottomRightCoord.latitude = buildingModel.centerCoord.latitude
        bottomRightCoord.longitude = buildingModel.centerCoord.longitude
        
        for building in buildings {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, building.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, building.latitude)

            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, building.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, building.latitude)
        }
        
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1
        
        
    }
}
