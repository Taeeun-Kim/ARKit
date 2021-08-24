//
//  PlacementSettings.swift
//  RealityKit-Tutorial
//
//  Created by Taeeun Kim on 23.08.21.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    // When the user selects a model in BrowseView, this property is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // When the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            
            print("Setting comfirmedModel to \(model.name)")
        }
    }
    
    // This property retains cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
}

//var myProperty: Int = 10{
//   didSet(oldVal){
//      //myProperty의 값이 변경된 직후에 호출, oldVal은 변경 전 myProperty의 값
//   }
//   willSet(newVal){
//      //myProperty의 값이 변경되기 직전에 호출, newVal은 변경 될 새로운 값
//   }
//}
