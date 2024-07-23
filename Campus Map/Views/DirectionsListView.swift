//
//  DirectionsListView.swift
//  Campus Map
//
//  Created by Matt Day on 2/28/22.
//

import SwiftUI

struct DirectionsListView: View {
    @EnvironmentObject var manager : DirectionsMapManager
    
    var body: some View {
        List {
            ForEach(manager.directionSteps, id: \.self) { step in
                Text(step)
            }
        }
    }
}

struct DirectionsListView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsListView()
    }
}
