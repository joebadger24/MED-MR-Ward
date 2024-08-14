//
//  Extensions.swift
//  MED-MR-WARD-V1
//
//  Created by Joe Badger on 16/07/2024.
//

import Foundation
import SwiftUI

extension View
{
    func borderRight(width: CGFloat, color: Color) -> some View
    {
        self.overlay(Rectangle().frame(width: width)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: .trailing))
    }
    
    func borderLeft(width: CGFloat, color: Color) -> some View
    {
        self.overlay(Rectangle().frame(width: width)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: .leading))
    }
    
    func borderTop(width: CGFloat, color: Color) -> some View
    {
        self.overlay(Rectangle().frame(height: width)
            .foregroundColor(color)
            .frame(maxHeight: .infinity, alignment: .top))
    }
    
    func borderBottom(width: CGFloat, color: Color) -> some View
    {
        self.overlay(Rectangle().frame(height: width)
            .foregroundColor(color)
            .frame(maxHeight: .infinity, alignment: .bottom))
    }
}
