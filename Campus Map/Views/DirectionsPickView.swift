//
//  DirectionsPickView.swift
//  Campus Map
//
//  Created by Matt Day on 3/1/22.
//

import SwiftUI
import MapKit

struct DirectionsPickView: View {
    @EnvironmentObject var manager : DirectionsMapManager
    @State var start: Int? = nil
    @State var end: Int? = nil
    
    @State private var mapReady : Bool = false
    @State private var plotOff : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("From:")
                Spacer()
                Picker("From: ", selection: $start) {
                    Text("Choose").tag(nil as Int?)
                    Text("Current Location").tag(manager.buildingModel.buildingList.count as Int?)
                    ForEach(manager.buildingModel.buildingList.indices, id:\.self){ index in
                        Text(manager.buildingModel.buildingList[index].name).tag(index as Int?)
                    }
                }
            }
            HStack {
                Text("To:")
                Spacer()
                Picker("From: ", selection: $end) {
                    Text("Choose").tag(nil as Int?)
                    Text("Current Location").tag(manager.buildingModel.buildingList.count as Int?)
                    ForEach(manager.buildingModel.buildingList.indices, id:\.self){ index in
                        Text(manager.buildingModel.buildingList[index].name).tag(index as Int?)
                    }
                }
            }
            Spacer()
            Button("Plot Route", action: {
                manager.fillLocations(fromIndex: start!, toIndex: end!)
                manager.updateLocationSpan()
                manager.provideDirections(source: manager.locations.first!, destination: manager.locations.last!)
                mapReady = true
            })
                .disabled((start == nil || end == nil))
            Spacer()
            NavigationLink(destination: DirectionsMapView()) {
                    Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
            }
                .disabled(!mapReady)
        }
    }
}

//struct DirectionsPickView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionsPickView()
//    }
//}
