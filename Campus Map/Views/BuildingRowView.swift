//
//  BuildingRowView.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI

struct BuildingRowView: View {
    @EnvironmentObject var manager : MapManager
    @Binding var building: Building
    
    var body: some View {
        HStack {
            Text(building.name)
            Spacer()
            Button(action: {
                building.plotted.toggle()
            }, label: {
                Image(systemName: building.plotted ? "pin.circle.fill" : "pin.circle")
                    .foregroundColor(Color.accentColor)
            })
        }
    }
}

struct BuildingRowView_Previews: PreviewProvider {
    static var previews: some View {
        @State var buildStandard = Building.standard
        return BuildingRowView(building: $buildStandard)
            .environmentObject(MapManager())
    }
}
