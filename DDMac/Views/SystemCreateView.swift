//
//  SystemCreateView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 03.08.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct SystemCreateView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var showModal: Bool
    @State var system = System.create()
    @State var message = ""
    
    var body: some View {
        VStack {
            Text(self.message)
                .foregroundColor(.red)
            Text("Adding a new System")
                .font(.title)
            SystemCreateForm(system: self.$system)
            HStack(spacing: 20.0) {
                Button("Cancel") {
                        self.showModal.toggle()
                    }
                Button(
                    "Add",
                    action: {
                        self.viewModel.addSystem(self.system)
                        // TODO: pressing enter should execute Save?
                        self.showModal.toggle()
                    }
                )
            }
                .padding()
        }
            .padding(50.0)
    }
}

struct SystemCreateForm: View {
    @Binding var system: System
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            TextField("Name", text: self.$system.name)
                .foregroundColor(.primary)
                .font(.title)
        }
    }
}
