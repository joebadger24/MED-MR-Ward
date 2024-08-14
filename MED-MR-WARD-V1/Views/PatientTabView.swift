//
//  PatientTabView.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI

struct PatientTabView: View 
{
    @Environment(ImageTrackingModel.self) var model
    
    var cotNumID: String
    
    var body: some View
    {
        let patientID = cotNumID == "Cot1" ? 1 : 2
        
        TabView
        {
            
            SummaryTab(patientID: patientID)
                .tabItem { Label("Summary", systemImage: "person.crop.circle.fill")}
            
            DevicesTab(patientID: patientID)
                .tabItem { Label("Devices", systemImage: "chart.xyaxis.line")}
            
            CheckListTab(patientID: patientID)
                .tabItem { Label("Check List", systemImage: "checklist.rtl")}
        }
    }
}

#Preview(windowStyle: .automatic)
{
    PatientTabView(cotNumID: "Cot1")
        .frame(width: 400, height: 400)
        .environment(ImageTrackingModel())
}
