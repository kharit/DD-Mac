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
    @State var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            TextField("Name", text: self.$step.name)
                .foregroundColor(.primary)
                .font(.title)
            StepEditMetaView(step: $step)
            TextField("Description", text: self.$step.description)
                .font(.body)
                .allowsTightening(false)
            // TODO: Change TextField to a TextEditor upon its release with Big Sur (or implement NSTextField if it is needed before)
        }
        .padding()
    }
}

struct StepEditMetaView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    @State var showModal = false
    var responsiblesSorted: [Responsible] {
        self.viewModel.data.responsibles.sorted(by: { $0.name < $1.name })
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20.0) {
                Button(
                    "Save",
                    action: { self.viewModel.updateStep(self.step) }
                    // TODO: pressing enter should execute Save?
                )
                    .buttonStyle(DefaultButtonStyle())
                StepEditMetaSystemsView(step: self.$step)
                Spacer()
            }
            HStack {
                Picker(selection: self.$step.responsible, label: Text("")) {
                    ForEach(responsiblesSorted) { responsible in
                        Text(responsible.name).tag(responsible.id)
                        // TODO: Add logic for adding Responsible
                    }
                }
                    .frame(maxWidth: 200.0)
                Button("New responsible") {
                    self.showModal.toggle()
                }.sheet(isPresented: $showModal) {
                    ResponsibleCreateView(showModal: self.$showModal, step: self.$step)
                        .environmentObject(self.viewModel)
                }
                Picker(selection: self.$step.stepType, label: Text("")) {
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
    @Binding var step: Step
    var sortedSystems: [System] {
        viewModel.data.systems.sorted(by: { $0.name < $1.name })
    }
    
    var body: some View {
        HStack(spacing: 10.0) {
            ForEach(sortedSystems) { system in
                StepEditSingleSystemView(step: self.$step, system: system)
            }
            Button("New system") {
                self.showModal.toggle()
            }.sheet(isPresented: $showModal) {
                SystemCreateView(showModal: self.$showModal, step: self.$step)
                    .environmentObject(self.viewModel)
            }
                .buttonStyle(LinkButtonStyle())
        }
    }
}

struct StepEditSingleSystemView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
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
                    action: {
                        let systemIndex = self.step.systems.firstIndex(of: self.system.id)!
                        self.step.systems.remove(at: systemIndex)
                }
                ).foregroundColor(.primary)
            } else {
                Button(
                    system.name,
                    action: {
                        self.step.systems.append(self.system.id)
                }
                ).foregroundColor(.secondary)
            }
        }
    }
}
