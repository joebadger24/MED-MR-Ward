//
//  ImmersiveView.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View 
{
    @Environment(ImageTrackingModel.self) var model
    @Environment(\.openWindow) var openWindow
    
    @State private var patient1ID = UUID()
    @State private var patient2ID = UUID()
    @State private var entityToPatientID: [Entity: UUID] = [:]
    
    var body: some View
    {
        let e1 = model.setupContentEntity1()
        let e2 = model.setupContentEntity2()
        
        RealityView { content in
            e1.name = "Cot1"
            e2.name = "Cot2"
            content.add(e1)
            content.add(e2)
        }
        .gesture(SpatialTapGesture().targetedToEntity(e1).onEnded({ value in
            openWindow(id: "PatientSummary", value: e1.name)
        }))
        .gesture(SpatialTapGesture().targetedToEntity(e2).onEnded({ value in
            openWindow(id: "PatientSummary", value: e2.name)
        }))
        .task {
            await model.runSession()
        }
        .task {
            await model.processImageTrackingUpdates()
        }
        .task {
            await model.monitorSessionEvents()
        }
    }
}

#Preview(immersionStyle: .mixed) 
{
    ImmersiveView()
        .environment(ImageTrackingModel())
}
