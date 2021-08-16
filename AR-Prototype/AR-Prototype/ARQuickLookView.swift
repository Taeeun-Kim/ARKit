//
//  ARQuickLookView.swift
//  AR-Prototype
//
//  Created by Taeeun Kim on 16.08.21.
//

import SwiftUI
import QuickLook
import ARKit

struct ARQuickLookView: UIViewControllerRepresentable {
    // Properties: the file name (without extension), and whether we'll let
    // the user scale the preview content.
    var name: String
    var usdzURL: String?
    var allowScaling: Bool = true
    
    func makeCoordinator() -> ARQuickLookView.Coordinator {
        // The coordinator object implements the mechanics of dealing with
        // the live UIKit view controller.
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        // Create the preview controller, and assign our Coordinator class
        // as its data source.
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ controller: QLPreviewController,
                                context: Context) {
        // nothing to do here
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        let parent: ARQuickLookView
        private lazy var fileURL: URL = Bundle.main.url(forResource: parent.name, withExtension: "usdz")!

        init(_ parent: ARQuickLookView) {
            self.parent = parent
            super.init()
        }
        
        // The QLPreviewController asks its delegate how many items it has:
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        // For each item (see method above), the QLPreviewController asks for
        // a QLPreviewItem instance describing that item:
        func previewController(
            _ controller: QLPreviewController,
            previewItemAt index: Int
        ) -> QLPreviewItem {
            
            guard let fileURL = Bundle.main.url(forResource: parent.name, withExtension: "usdz") else {
                fatalError("Unable to load \(parent.name).usdz from main bundle")
            }
           
            print(fileURL)
            
            let item = ARQuickLookPreviewItem(fileAt: URL(fileURLWithPath: parent.usdzURL!))
            item.allowsContentScaling = parent.allowScaling
            return item
        }
        
        func documentDirectory() -> URL {
          let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
          return documentsDirectory
        }
    }
}
