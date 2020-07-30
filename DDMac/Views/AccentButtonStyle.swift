//
//  AccentButtonStyle.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 30.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI

// TODO: Create a blue button similar to standard one
struct AccentButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.accentColor : Color.white)
            .background(configuration.isPressed ? Color.white : Color.accentColor)
            .cornerRadius(6.0)
            .padding()
    }
}
