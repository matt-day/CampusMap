//
//  CampusMapView.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI
import MapKit

struct CampusMapView: View {
    @EnvironmentObject var manager : MapManager
    
    @State var selectedBuilding : Building?
    @State var showDetails = false
    @State var userTrackingMode : MapUserTrackingMode = .follow

    var body: some View {
        VStack {
            NavigationLink(destination: BuildingDetailView(building: $selectedBuilding), isActive: $showDetails, label: {EmptyView()})
            
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: manager.showsUserLocation, userTrackingMode: $userTrackingMode, annotationItems: manager.displayBuildings() , annotationContent: menuFor(building:))
                .ignoresSafeArea(.all)
        }
    }
}

extension CampusMapView {
    
    func menuFor(building: Building) -> some MapAnnotationProtocol {
            
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)) {
            
            Image(systemName: manager.annotImage(building: building))
                .scaleEffect(1.5)
                .contextMenu {
                    Button(action: {
                        self.selectedBuilding = building
                        self.showDetails = true

                    }, label: {
                        Label(building.name, systemImage: "info")
                    })
                }
        }
    }

}



struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
            .environmentObject(MapManager())
    }
}
