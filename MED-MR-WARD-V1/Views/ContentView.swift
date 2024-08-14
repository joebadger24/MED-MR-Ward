//
//  ContentView.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View 
{

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View 
    {
        NavigationStack
        {
            VStack
            {
                HStack
                {
                    Text("MED-MR-WARD")
                        .font(.system(size: 36, weight: .medium))
                        .padding(.leading, 40)
                    
                    Spacer()
                    
                    HStack
                    {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading)
                        {
                            Text("User Name")
                                .font(.system(size: 25))
                            
                            Text("Doctor")
                                .font(.system(size: 20))
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.trailing, 40)
                }
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .background(.gray)
                .borderBottom(width: 2, color: .black)
                
                Spacer()

                Toggle("Start Image Tracking", isOn: $showImmersiveSpace)
                    .font(.title)
                    .frame(width: 360)
                    .padding(24)
                    .glassBackgroundEffect()
                
                Text("NOTE: Close this window after starting image tracking!")
                    .padding(20)
                
                Spacer()
            }
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task {
                    if newValue {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            fallthrough
                        @unknown default:
                            immersiveSpaceIsShown = false
                            showImmersiveSpace = false
                        }
                    } else if immersiveSpaceIsShown {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) 
{
    ContentView()
}
