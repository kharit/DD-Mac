//
//  StepEditView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 30.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

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
            StepEditMetaView(step: step)
            TextField("Description", text: $viewModel.model.displayData.steps[stepIndex].description)
                .font(.body)
                .allowsTightening(false)
            // TODO: Change TextField to a TextEditor upon its release with Big Sur (or implement NSTextField if it is needed before)
        }
        .padding()
    }
}

struct StepEditMetaView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20.0) {
                Button(
                    "Save",
                    action: { self.viewModel.saveStep(self.step) }
                    // TODO: pressing enter should execute Save?
                )
                    .buttonStyle(DefaultButtonStyle())
                StepEditMetaSystemsView(step: step)
                Spacer()
            }
            HStack {
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
                    .frame(maxWidth: 100.0)
                Spacer()
            }
        }
            .font(.system(size: 12.0))
    }
}

struct StepEditMetaSystemsView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @State var showModal = false
    var step: Step
    
    var systemsArray: [System] {
        var returnArray = [System]()
        for system in step.systems {
            let index = viewModel.data.systems.firstIndex(where: { $0.id == system })!
            returnArray.append(viewModel.data.systems[index])
        }
        return returnArray
    }
    
    var body: some View {
        HStack(spacing: 10.0) {
            ForEach(viewModel.data.systems) { system in
                StepEditSingleSystemView(step: self.step, system: system)
            }
            Button("Add new") {
                self.showModal.toggle()
            }.sheet(isPresented: $showModal) {
                SystemCreateView(showModal: self.$showModal)
                    .environmentObject(self.viewModel)
            }
                .buttonStyle(LinkButtonStyle())
        }
    }
}

struct StepEditSingleSystemView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    var system: System
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    var systemIndex: Int? {
        viewModel.data.steps[stepIndex].systems.firstIndex(of: system.id)
    }
    var systemIsOn: Bool {
        if step.systems.contains(system.id) {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            if systemIsOn {
                Button(
                    system.name,
                    action: { self.systemDeactivate() }
                ).foregroundColor(.primary)
            } else {
                Button(
                    system.name,
                    action: { self.systemActivate() }
                ).foregroundColor(.secondary)
            }
        }
    }

    func systemDeactivate() {
        viewModel.model.displayData.steps[stepIndex].systems.remove(at: systemIndex!)
    }
    
    func systemActivate() {
        viewModel.model.displayData.steps[stepIndex].systems.append(self.system.id)
        viewModel.model.displayData.steps[stepIndex].systems.sort()
    }
}
