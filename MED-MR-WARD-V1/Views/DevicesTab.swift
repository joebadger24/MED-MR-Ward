//
//  DevicesTab.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI

struct DevicesTab: View 
{
    @Environment(\.openWindow) var openWindow
    var patientID: Int
    
    var body: some View
    {
        NavigationStack
        {
            VStack
            {
                Text("Cot \(patientID) Devices")
                    .padding(.top, 20)
                    .font(.largeTitle)
                
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height: 2)
                    .padding(.horizontal, 40)
                
                List
                {
                    NavigationLink(destination: DevicesDetailTab(deviceName: "Syringe Pump"))
                    {
                        Text("Syringe Pump")
                    }
                    NavigationLink(destination: DevicesDetailTab(deviceName: "Ventilator"))
                    {
                        Text("Ventilator")
                    }
                    NavigationLink(destination: DevicesDetailTab(deviceName: "Patient Monitor"))
                    {
                        Text("Patient Monitor")
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview (windowStyle: .automatic)
{
    DevicesTab(patientID: 1)
}
