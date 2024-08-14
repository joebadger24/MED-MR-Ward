//
//  DevicesDetailTab.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI
import Charts

struct DevicesDetailTab: View 
{
    @Environment(\.presentationMode) var presentationMode
    
    @State private var data = [(0, 1.2), (2, 1.4), (3, 1.3), (4, 0), (5, 0), (6, 1.2), (7, 1.2), (8, 1.2)]
    
    var deviceName: String
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                HStack
                {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .padding(.leading, 40)
                .padding(.top, 20)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                .hoverEffect()
                
                Spacer()
                
                Text("\(deviceName)")
                    .padding(.top, 20)
                    .font(.largeTitle)
                
                Spacer()
                
                HStack
                {
                    Text("")
                }
                .padding(.horizontal, 40)
                
            }
            
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 2)
                .padding(.horizontal, 40)
            
            HStack
            {
                Text("Details:")
                    .font(.system(size: 25))
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            
            HStack
            {
                Text("One syringe pump is connected on the rack, which is providing 1.2mg/ml of dopamine.")
                    .font(.system(size: 20))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 10)
                Spacer()
            }
            
            HStack
            {
                Text("Readings:")
                    .font(.system(size: 25))
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            
            Chart
            {
                ForEach(data, id: \.0) { point in
                    LineMark(
                        x: .value("Time", point.0),
                        y: .value("Value", point.1)
                    )
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
            .foregroundColor(.red)
            .chartYScale(domain: 0...2)
            //.chartXAxis(.hidden)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview (windowStyle: .automatic)
{
    DevicesDetailTab(deviceName: "Syringe Pump")
}
