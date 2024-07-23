//
//  DirectionsMapView.swift
//  Campus Map
//
//  Created by Matt Day on 3/1/22.
//

import SwiftUI
import MapKit

struct DirectionsMapView: View {
    @EnvironmentObject var manager : DirectionsMapManager
    
    @State var userTrackingMode : MapUserTrackingMode = .follow
    @State var tabVisible : Bool = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: manager.showsUserLocation, userTrackingMode: $userTrackingMode, annotationItems: manager.locations, annotationContent: menuFor(location:))
                .ignoresSafeArea(.all)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: DirectionsListView()) {
                            Image(systemName: "list.number")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: {tabVisible.toggle()}, label: {
                            Image(systemName: tabVisible ? "forward.fill" : "forward")
                                .foregroundColor(Color.accentColor)
                        })
                    }
                }
                VStack {
                    Spacer()
                    Text(manager.formattedTime)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .background(Color(.black))
                    
                    if tabVisible {
                        TabView {
                            ForEach(manager.directionSteps.indices, id: \.self) { i in
                                Text(manager.directionSteps[i])
                                    .frame(width: 350, height: 50, alignment: .center)
                                    .background(Color(.blue))
                                    .tabItem {
                                        Text("\(i)")
                                            .font(.system(size: 30, weight: .bold, design: .rounded))
                                    }

                            }
                        }
                        .frame(width: 350, height: 150, alignment: .center)
                    }
                }
        }
    }
}


extension DirectionsMapView {
    
    func menuFor(location: MKMapItem) -> some MapAnnotationProtocol {
            
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.placemark.coordinate.latitude, longitude: location.placemark.coordinate.longitude)) {
            
            if !((location.placemark.coordinate.longitude == manager.locationManager.location?.coordinate.longitude) && (location.placemark.coordinate.latitude == manager.locationManager.location?.coordinate.latitude)){
                Image(systemName: "flag.fill")
                    .scaleEffect(1.5)
            }
        }
    }
}

struct DirectionsMapView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsMapView()
    }
}
