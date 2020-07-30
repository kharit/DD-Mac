//
//  CreatingStep.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 30.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct StepCreateView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            TextField("Name", text: self.$step.name)
                .foregroundColor(.primary)
                .font(.title)
            StepCreateMetaView(step: self.$step)
            TextField("Description", text: self.$step.description)
                .font(.body)
                .allowsTightening(false)
            // TODO: Change TextField to a TextEditor upon its release with Big Sur (or implement NSTextField if it is needed before)
        }
    }
}

struct StepCreateMetaView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
    var stepIndex: Int {
        viewModel.data.steps.firstIndex(where: { $0.id == step.id })!
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20.0) {
                StepCreateMetaSystemsView(step: self.$step)
                Spacer()
            }
            HStack {
                Picker(selection: self.$step.responsible, label: Text("")) {
                    ForEach(self.viewModel.data.responsibles) { responsible in
                        Text(responsible.name).tag(responsible.id)
                        // TODO: Add logic for adding Responsible
                    }
                    Text("Add new responsible").tag("AddNewResponsible")
                }
                    .frame(maxWidth: 200.0)
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

struct StepCreateMetaSystemsView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
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
                StepCreateSingleSystemView(step: self.$step, system: system)
            }
            Button(
                "Add new",
                action: { self.viewModel.addSystem() }
                // TODO: pressing enter should execute Save?
            )
                .buttonStyle(LinkButtonStyle())
        }
    }
}

struct StepCreateSingleSystemView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var step: Step
    var system: System
    var systemIndex: Int? {
        self.step.systems.firstIndex(of: system.id)
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
                )
                    .foregroundColor(.primary)
                    .buttonStyle(LinkButtonStyle())
            } else {
                Button(
                    system.name,
                    action: { self.systemActivate() }
                )
                    .foregroundColor(.secondary)
                    .buttonStyle(LinkButtonStyle())
            }
        }
    }

    func systemDeactivate() {
        self.step.systems.remove(at: systemIndex!)
    }
    
    func systemActivate() {
        self.step.systems.append(self.system.id)
        self.step.systems.sort()
    }
}
