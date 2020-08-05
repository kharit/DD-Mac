//
//  ManageDataView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.08.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct ManageDataView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var showModal: Bool
    @State var message = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                Text(self.message)
                    .foregroundColor(.red)
                VStack(alignment: .leading, spacing: 30.0) {
                    Text("Managing data")
                        .font(.title)
                    ManageSolutions()
                    
                }
                Button("Close") {
                    self.showModal.toggle()
                }
                    .padding()
            }
                .padding(50.0)
        }
    }
}

