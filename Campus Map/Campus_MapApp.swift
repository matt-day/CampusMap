//
//  Campus_MapApp.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI

@main
struct Campus_MapApp: App {
    @StateObject var manager = MapManager()
    @StateObject var managerDir = DirectionsMapManager()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(manager)
                .environmentObject(managerDir)
        }
        .onChange(of: scenePhase) { phase in
            switch phase{
            case .inactive:
                manager.buildingModel.save()
                break
            default:
                break
            }
        }
    }
}
