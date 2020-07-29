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
        ScrollView {
            if viewModel.currentFlow != nil {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.currentFlow!.name[self.viewModel.lang] ?? "[No translation]")
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            if self.viewModel.data.steps != [] {
                                ForEach(self.viewModel.data.steps) { step in
                                    if self.viewModel.editing == step.id {
                                        StepEditView(viewModel: self.viewModel, step: step)
                                    } else {
                                        StepView(viewModel: self.viewModel, step: step)
                                    }
                                }
                            } else {
                                Text("There are no steps to display here.")
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                    .padding()
                    .buttonStyle(LinkButtonStyle())
                    
            } else {
                HStack {
                    Text("Please select a flow in the sidebar area")
                    Spacer()
                }
            }
        }
    }
}

struct StepView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
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
            StepMetaView(viewModel: viewModel, step: step)
            Text(step.description[self.viewModel.lang] ?? "[No translation]")
                .font(.body)
                .allowsTightening(false)
                
        }
        .padding()
    }
}

struct StepMetaView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        HStack(spacing: 20.0) {
            Text(viewModel.data.responsibles[step.responsible]?.name[self.viewModel.lang] ?? "[No translation or no responsible found]")

            Text(step.stepType)
            Button(
                "Edit",
                action: { self.viewModel.edit(self.step.id) }
            )
                .buttonStyle(DefaultButtonStyle())
            Spacer()
        }
            .font(.system(size: 12.0))
            .foregroundColor(.secondary)
    }
}

struct StepEditView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
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
            StepMetaView(viewModel: viewModel, step: step)
            Text(step.description[self.viewModel.lang] ?? "[No translation]")
                .font(.body)
                .allowsTightening(false)
                
        }
        .padding()
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView(viewModel: DDMacApp())
    }
}
