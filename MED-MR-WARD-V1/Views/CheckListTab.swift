//
//  CheckListTab.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI

struct CheckListTab: View 
{
    var patientID: Int
    
    @State private var timer1: Int = 1043
    @State private var timer2: Int = 2039
    @State private var timer3: Int = 2703
    @State private var timer4: Int = 4320
    
    var body: some View
    {
        VStack
        {
            Text("Cot \(patientID) Baby Check List")
                .padding(.top, 20)
                .font(.largeTitle)
            
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 2)
                .padding(.horizontal, 40)
            
            VStack
            {
                keyTimerPairCheckList(keyString: "Obs Round", remainingTime: $timer1)
                keyTimerPairCheckList(keyString: "Disconnect Ventilator", remainingTime: $timer2)
                keyTimerPairCheckList(keyString: "Weight Check", remainingTime: $timer3)
                keyTimerPairCheckList(keyString: "Ultrasound", remainingTime: $timer4)
                
                Spacer()
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
        }
    }
}

#Preview (windowStyle: .automatic)
{
    CheckListTab(patientID: 1)
}

struct keyTimerPairCheckList: View
{
    var keyString: String
    @Binding var remainingTime: Int
    @State private var timer: Timer?
    
    var body: some View
    {
        HStack
        {
            Text(keyString)
                .font(.system(size: 20))
            Spacer()
            Text(formattedTime(remainingTime))
                .font(.system(size: 20, weight: .bold))
                .onAppear{
                    startTimer()
                }
                            
            
        }
        .padding(.bottom, 10)
    }
    
    private func startTimer() 
    {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 0 
            {
                remainingTime -= 1
            } 
            else
            {
                timer?.invalidate()
            }
           }
       }

    private func formattedTime(_ totalSeconds: Int) -> String
    {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        
        if minutes > 59
        {
            let hours = minutes / 60
            let newMinutes = minutes % 60
            return String(format: "%02d:%02d:%02d", hours, newMinutes, seconds)
        }
        else
        {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
