//
//  DirectionsMapManager.swift
//  Campus Map
//
//  Created by Matt Day on 3/1/22.
//

import Foundation
import MapKit

class DirectionsMapManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var buildingModel: BuildingModel
    @Published var region: MKCoordinateRegion
    let spanDelta = 0.01
    
    let locationManager : CLLocationManager
    var userTrackingMode :MKUserTrackingMode = .none
    @Published var showsUserLocation = false
    
    var locations : [MKMapItem] = []
    
    var directionSteps : [String] = []
    var routeTime: TimeInterval = 0
    var formattedTime: String = ""

    
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
    
        
    func fillLocations(fromIndex: Int, toIndex: Int) {
        locations = []
        if fromIndex == buildingModel.buildingList.count {
            locations.append(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))))
        } else {
            locations.append(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: buildingModel.buildingList[fromIndex].latitude, longitude: buildingModel.buildingList[fromIndex].longitude))))
        }
        if toIndex == buildingModel.buildingList.count {
            locations.append(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))))
        } else {
            locations.append(MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: buildingModel.buildingList[toIndex].latitude, longitude: buildingModel.buildingList[toIndex].longitude))))
        }
    }
    
    
    func provideDirections(source: MKMapItem, destination: MKMapItem){
        self.directionSteps = []
        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        request.transportType = .walking
        request.requestsAlternateRoutes = true
        let directions = MKDirections(request: request)
        
        directions.calculate { resp, error in
            guard (error == nil) else {return}
            let route = resp!.routes.first
            let eta = route?.expectedTravelTime
            
            self.routeTime = eta!
            
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.includesApproximationPhrase = true
            formatter.includesTimeRemainingPhrase = true
            formatter.allowedUnits = [.minute]
            
            self.formattedTime = formatter.string(from: self.routeTime)!
            
            for step in route!.steps {
                self.directionSteps.append(step.instructions)
            }            
        }
    }
    
    
    func updateLocationSpan() {
        if locations.isEmpty {
            return
        }
        
        var topLeftCoord = CLLocationCoordinate2D()
        topLeftCoord.latitude = buildingModel.centerCoord.latitude
        topLeftCoord.longitude = buildingModel.centerCoord.longitude

        var bottomRightCoord = CLLocationCoordinate2D()
        bottomRightCoord.latitude = buildingModel.centerCoord.latitude
        bottomRightCoord.longitude = buildingModel.centerCoord.longitude
        
        for location in locations {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, location.placemark.coordinate.longitude)
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, location.placemark.coordinate.latitude)
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, location.placemark.coordinate.longitude)
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, location.placemark.coordinate.latitude)
        }
        
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1
        
        
    }
    
    
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
    
    
}

extension MKMapItem: Identifiable {
    
}
