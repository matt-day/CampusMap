//
//  BuildingListView.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI

struct BuildingListView: View {
    @EnvironmentObject var manager : MapManager
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        List {
            ForEach(manager.buildingModel.buildingList.indices, id:\.self) { index in
                BuildingRowView(building: $manager.buildingModel.buildingList[index])
            }
        }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                manager.updateSpan()
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
            })
    }
}

struct BuildingListView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingListView()
            .environmentObject(MapManager())
    }
}
