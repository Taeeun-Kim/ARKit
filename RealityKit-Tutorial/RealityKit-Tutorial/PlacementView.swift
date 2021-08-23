//
//  PlacementView.swift
//  RealityKit-Tutorial
//
//  Created by Taeeun Kim on 23.08.21.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    var body: some View {
        HStack {
            Spacer()
            PlacementButton(systemIconName: "xmark.circle.fill") {
                print("Cancel Placement button pressed.")
                self.placementSettings.selectedModel = nil
            }
            Spacer()
            PlacementButton(systemIconName: "checkmark.circle.fill") {
                print("Confirm Placement button pressed.")
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                self.placementSettings.selectedModel = nil
            }
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct PlacementButton: View {
    let systemIconName: String
    let action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            Image(systemName: systemIconName)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 75, height: 75)
    }
}
