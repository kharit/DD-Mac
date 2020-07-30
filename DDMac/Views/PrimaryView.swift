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
    var currentFlow: Flow? {
        viewModel.data.flows.first(where: { $0.id == viewModel.currentFlowID })
    }
    
    var body: some View {
        ScrollView {
            if self.currentFlow != nil {
                HStack {
                    VStack(alignment: .leading) {
                        Text(self.currentFlow!.name)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            if self.viewModel.data.steps != [] {
                                ForEach(self.viewModel.data.steps) { step in
                                    addStepButton(step: step)
                                    ZStack {
                                        if self.viewModel.editing == step.id {
                                            StepEditView(step: step)
                                        } else {
                                            StepView(step: step)
                                        }
                                    }
                                }
                                addStepButton()
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

struct addStepButton: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step?
    @State private var showModal = false
    
    var body: some View {
        HStack {
            Spacer()
            Button("+") {
                self.showModal.toggle()
            }.sheet(isPresented: $showModal) {
                addStepView(beforeStep: self.step, showModal: self.$showModal)
                    .environmentObject(self.viewModel)
            }
                .buttonStyle(DefaultButtonStyle())
                .padding(.horizontal)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
    
}

struct addStepView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var beforeStep: Step?
    @State var step = Step.create()
    @State var message = ""
    @Binding var showModal: Bool
    
    var body: some View {
        VStack {
            Text(self.message)
                .foregroundColor(.red)
            Text("Adding a new Step")
                .font(.title)
            StepCreateView(step: self.$step)
            HStack(spacing: 20.0) {
                Button("Cancel") {
                        self.showModal.toggle()
                    }
                Button(
                    "Add",
                    action: {
                        if self.step.responsible != "" {
                            self.viewModel.addStep(self.step, before: self.beforeStep)
                            self.showModal = false
                        } else {
                            self.message = "Please fill the responsible"
                        }
                        // TODO: raise an error to the user?
                        // TODO: pressing enter should execute Save?
                    }
                )
            }
                .padding()
        }
            .padding(50.0)
    }
}


struct StepView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            ZStack {
                if self.viewModel.currentStepID == step.id {
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
            StepMetaView(step: step)
            Text(step.description)
                .font(.body)
                .allowsTightening(false)
                
        }
        .padding()
    }
}

struct StepMetaView: View {
    @EnvironmentObject var viewModel: DDMacApp
    var step: Step
    var responsible: Responsible {
        let index = viewModel.data.responsibles.firstIndex(where: { $0.id == step.responsible })!
        return viewModel.data.responsibles[index]
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 20.0) {
                Button(
                    "Edit",
                    action: { self.viewModel.edit(self.step.id) }
                )
                    .buttonStyle(DefaultButtonStyle())
                StepMetaSystemView(step: step)
                Spacer()
            }
            HStack(spacing: 20.0) {
                Text(responsible.name)
                Text(step.stepType)
                Spacer()
            }
        }
            .font(.system(size: 12.0))
            .foregroundColor(.secondary)
    }
}

struct StepMetaSystemView: View {
    @EnvironmentObject var viewModel: DDMacApp
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
            ForEach(systemsArray) { system in
                Text(system.name)
            }
        }
    }
}


struct PrimaryView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryView()
            .environmentObject(DDMacApp.initPreview())
    }
}
