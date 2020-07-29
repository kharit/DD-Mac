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
    @EnvironmentObject var viewModel: DDMacApp
    
    var body: some View {
        ScrollView {
            if viewModel.currentFlow != nil {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.currentFlow!.name)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            if self.viewModel.data.steps != [] {
                                ForEach(self.viewModel.data.steps) { step in
                                    if self.viewModel.editing == step.id {
                                        StepEditView(step: step)
                                            .environmentObject(self.viewModel)
                                    } else {
                                        StepView(step: step)
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
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            ZStack {
                if self.viewModel.currentStep == step {
                    Button(
                        step.name,
                        action: { self.viewModel.chooseStep(self.step) }
                    ).foregroundColor(.primary)
                        .font(.title)
                } else {
                    Button(
                        step.name,
                        action: { self.viewModel.chooseStep(self.step) }
                    ).foregroundColor(.secondary)
                    .font(.title)
                }
            }
            StepMetaView(viewModel: viewModel, step: step)
            Text(step.description)
                .font(.body)
                .allowsTightening(false)
                
        }
        .padding()
    }
}

struct StepMetaView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    var responsible: Responsible {
        let index = viewModel.data.responsibles.firstIndex(where: { $0.id == step.responsible })!
        return viewModel.data.responsibles[index]
    }
    
    var body: some View {
        HStack(spacing: 20.0) {
            Button(
                "Edit",
                action: { self.viewModel.edit(self.step.id) }
            )
                .buttonStyle(DefaultButtonStyle())
            Text(responsible.name)
            Text(step.stepType)
            Spacer()
        }
            .font(.system(size: 12.0))
            .foregroundColor(.secondary)
    }
}

struct StepEditView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            TextField("Name", text: $viewModel.model.displayData.steps[stepIndex].name)
                .foregroundColor(.primary)
                .font(.title)
            StepEditMetaView(viewModel: viewModel, step: step)
            TextField("Description", text: $viewModel.model.displayData.steps[stepIndex].description)
                .font(.body)
                .allowsTightening(false)
                
        }
        .padding()
    }
}

struct StepEditMetaView: View {
    @ObservedObject var viewModel: DDMacApp
    var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    
    var body: some View {
        HStack(spacing: 20.0) {
            Button(
                "Save",
                action: { self.viewModel.save(self.step.id) }
                // TODO: pressing enter should execute Save?
            )
                .buttonStyle(DefaultButtonStyle())
            Picker(selection: $viewModel.model.displayData.steps[stepIndex].responsible, label: Text("")) {
                ForEach(self.viewModel.data.responsibles) { responsible in
                    Text(responsible.name).tag(responsible.id)
                    // TODO: Add logic for adding Responsible
                }
                Text("Add new responsible").tag("AddNewResponsible")
            }
                .frame(maxWidth: 200.0)
            Picker(selection: $viewModel.model.displayData.steps[stepIndex].stepType, label: Text("")) {
                Text(StepType.Automatic.rawValue).tag(StepType.Automatic.rawValue)
                Text(StepType.Manual.rawValue).tag(StepType.Manual.rawValue)
                Text(StepType.OutOfSystem.rawValue).tag(StepType.OutOfSystem.rawValue)
            }
                .frame(maxWidth: 200.0)
            Spacer()
        }
            .font(.system(size: 12.0))
    }
}

struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView()
            .environmentObject(DDMacApp())
    }
}
