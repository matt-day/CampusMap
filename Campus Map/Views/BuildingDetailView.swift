//
//  BuildingDetailView.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import SwiftUI

struct BuildingDetailView: View {
    @EnvironmentObject var manager : MapManager
    @Binding var building: Building?
    
    var body: some View {
            VStack{
                Text(building!.name)
                    .font(.title)
                    .bold()
                Image(building!.photo!)
                    .resizable()
                    .frame(width: 249, height: 167, alignment: .center)
            }
            .toolbar() {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {building!.fav.toggle()}, label: {
                        Image(systemName: building!.fav ? "heart.fill" : "heart")
                            .foregroundColor(Color.accentColor)
                    })
                }
            }

    }
}

//struct BuildingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        @Binding var buildStandard = Building.standard
//        return BuildingDetailView(building: $buildStandard)
//            .environmentObject(MapManager())
//    }
//}
