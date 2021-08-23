//
//  RealityKit_TutorialApp.swift
//  RealityKit-Tutorial
//
//  Created by Taeeun Kim on 23.08.21.
//

import SwiftUI

@main
struct RealityKit_TutorialApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
