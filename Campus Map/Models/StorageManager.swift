//
//  StorageManager.swift
//  Campus Map
//
//  Created by Matt Day on 2/23/22.
//

import Foundation

class StorageManager {
    var buildingsNew = [Building]()
    var buildings : [Building]
    let filename = "buildings"
    let fileInfo : FileInfo
        
    init() {
        
        fileInfo = FileInfo(for: filename)
        
        if fileInfo.exists{
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: fileInfo.url)
                buildingsNew = try decoder.decode([Building].self, from: data)
                buildings = buildingsNew.sorted {
                    $0.name < $1.name
                }
            } catch {
                print(error)
                buildings = []
            }
            
            return
        }
        
        let bundle = Bundle.main
        let url = bundle.url(forResource: filename, withExtension: ".json")!
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            buildingsNew = try decoder.decode([Building].self, from: data)
            buildings = buildingsNew.sorted {
                $0.name < $1.name
            }
        } catch {
            print(error)
            buildings = []
        }
        
        
        // I used these to test the favorite functionality
        // You are able to see favorite buildings on the map when intitialized as a favorite
        
//        buildingsNew.append(Building.standard)
//        buildingsNew.append(Building.standard2)//
//        buildings = buildingsNew.sorted {
//            $0.name < $1.name
//        }
        
    }
    
    func save(buildings:[Building]){
        do {
            let encoder = JSONEncoder()
            let data    = try encoder.encode(buildings)
            try data.write(to: fileInfo.url)
        } catch {
            print(error)
        }
    }
    
}
