//
//  SidebarView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 27.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct SidebarView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var currentProcess: DDProcess? {
        viewModel.data.processes.first(where: { $0.id == viewModel.currentProcessID })
    }
    
    var body: some View {
        ZStack {
            if self.currentProcess != nil {
                VStack(alignment: .leading) {
                    Text(self.currentProcess!.name)
                        .font(.headline)
                    VStack(alignment: .leading) {
                        if self.viewModel.data.flows != [] {
                            ForEach(self.viewModel.data.flows) { flow in
                                FlowView(viewModel: self.viewModel, flow: flow)
                            }
                            .font(.headline)
                        } else {
                            Text("There are no flows to display here.")
                        }
                    }
                        .padding()
                }
                    .padding()
                    .buttonStyle(LinkButtonStyle())
                    
            } else {
                Text("Please select a process in the navigation area")
            }
        }
    }
}

struct FlowView: View {
    @ObservedObject var viewModel: DDMacApp
    var flow: Flow
    
    var body: some View {
            ZStack {
                if self.viewModel.currentFlowID == flow.id {
                    Button(
                        flow.name,
                        action: { self.viewModel.chooseFlow(self.flow) }
                    ).foregroundColor(.primary)
                } else {
                    Button(
                        flow.name,
                        action: { self.viewModel.chooseFlow(self.flow) }
                    ).foregroundColor(.secondary)
                }
            }
        }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .environmentObject(DDMacApp.initPreview())
    }
}
