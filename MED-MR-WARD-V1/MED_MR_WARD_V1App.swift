//
//  MED_MR_WARD_V1App.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI

@main
@MainActor
struct MED_MR_WARD_V1App: App
{
    @State private var model = ImageTrackingModel()
    
    var body: some Scene
    {
        WindowGroup 
        {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") 
        {
            ImmersiveView()
                .environment(model)
        }
        
//        WindowGroup(id: "PatientSummary", for: UUID.self) { $uuid in
//            
//            PatientTabView(cotNumID: uuid!)
//                .frame(minWidth: 400, minHeight: 400)
//        }
//        .defaultSize(width: 400, height: 400)
//        .windowResizability(.contentMinSize)
        
        WindowGroup(id: "PatientSummary", for: String.self) { $string in
            
            PatientTabView(cotNumID: string!)
                .frame(minWidth: 400, minHeight: 400)
                .environment(model)
        }
        .defaultSize(width: 400, height: 400)
        .windowResizability(.contentMinSize)

        
        

    }
}
