//
//  Model.swift
//  RealityKit-Tutorial
//
//  Created by Taeeun Kim on 23.08.21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chairs"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        // UIImage는 optional value임, 그러므로 default value 설정
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        print(filename)
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                
            } receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
            }

    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        // Tables
        let diningTable = Model(name: "testtt", category: .table, scaleCompensation: 0.32/100)
        let familyTable = Model(name: "testtt", category: .table, scaleCompensation: 0.32/100)
        
        self.all += [diningTable, familyTable]
        
        // Chairs
        let diningChair = Model(name: "testtt", category: .chair, scaleCompensation: 0.32/100)
        let eamesChairWhite = Model (name: "testtt", category: .chair, scaleCompensation:0.32/100)
        let eamesChairWoodgrain = Model (name: "testtt", category: .chair, scaleCompensation:0.32/100)
        let eamesChairBlackLeather = Model (name: "testtt",category: .chair, scaleCompensation: 0.32/100)
        let eamesChairBrownLeather = Model (name: "testtt", category: .chair, scaleCompensation: 0.32/100)
        
        self.all += [diningChair, eamesChairWhite, eamesChairWoodgrain, eamesChairBlackLeather, eamesChairBrownLeather]
        
        // Decor
        let cupSaucerSet = Model(name: "testtt", category: .decor)
        let teaPot = Model(name: "testtt", category: .decor)
        let flowerTulip = Model(name: "testtt", category: .decor)
        let plateSetDark = Model(name: "testtt", category: .decor, scaleCompensation:0.32/100)
        let plateSetLight = Model(name: "testtt", category: .decor, scaleCompensation:0.32/100)
        let pottedFloorPlant = Model(name: "testtt", category: .decor, scaleCompensation: 0.8)
        // Model is to scale but used scaleCompensation for aesthetic reasons (wanted the plant a little smaller).
        self.all += [cupSaucerSet, teaPot, flowerTulip, plateSetDark, plateSetLight, pottedFloorPlant]
        
        // Lights
        let floorLampClassic = Model(name: "testtt", category: .light, scaleCompensation: 0.01)
        let floorLampModern = Model(name: "testtt", category: .light, scaleCompensation:0.01)
        
        self.all += [floorLampClassic, floorLampModern]
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}
