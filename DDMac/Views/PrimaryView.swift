//
//  PrimaryView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 27.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct PrimaryView: View {
    @ObservedObject var viewModel: DDMacApp
    
    var body: some View {
        ZStack {
            if viewModel.currentFlow != nil {
                VStack(alignment: .leading) {
                    Text(viewModel.currentFlow!.name[self.viewModel.lang] ?? "[No translation]")
                        .font(.largeTitle)
                    ForEach(self.viewModel.data.steps) { step in
                        StepView(viewModel: self.viewModel, step: step)
                    }
                }
                    .padding()
                    .buttonStyle(LinkButtonStyle())
                    
            } else {
                Text("Please select a flow in the sidebar area")
            }
        }
    }
}

struct StepView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                if self.viewModel.currentStep == step {
                    Button(
                        step.name[self.viewModel.lang] ?? "[No translation]",
                        action: { self.viewModel.chooseStep(self.step) }
                    ).foregroundColor(.primary)
                        .font(.title)
                } else {
                    Button(
                        step.name[self.viewModel.lang] ?? "[No translation]",
                        action: { self.viewModel.chooseStep(self.step) }
                    ).foregroundColor(.secondary)
                    .font(.title)
                }
            }
            Text(step.description[self.viewModel.lang] ?? "[No translation]")
        }
        .padding()
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(viewModel: DDMacApp())
    }
}
