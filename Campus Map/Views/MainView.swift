//
//  MainView.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject var manager : MapManager
    
    var disableCenter : Bool {
        manager.region.center.latitude == manager.locationManager.location?.coordinate.latitude && manager.region.center.longitude == manager.locationManager.location?.coordinate.longitude
    }
    
    var body: some View {
        NavigationView {
            CampusMapView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: BuildingListView()) {
                            Image(systemName: "list.number")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: {manager.resetPlot()}, label: {
                            Image(systemName: "clear.fill")
                                .foregroundColor(Color.accentColor)
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: {manager.visFav()}, label: {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.accentColor)
                        })
                    }
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: {
                            manager.centerOnUserLocation()
                        }, label: {
                            Image(systemName: "location.north")
                                .foregroundColor(Color.accentColor)
                        })
                            .disabled(disableCenter)
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: DirectionsPickView()) {
                            Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                        }
                    }
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(MapManager())
    }
}
