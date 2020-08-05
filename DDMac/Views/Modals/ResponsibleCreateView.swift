//
//  ResponsibleCreateView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 03.08.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct ResponsibleCreateView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var showModal: Bool
    @Binding var step: Step
    @State var responsible = Responsible.create()
    @State var message = ""
    
    var body: some View {
        VStack {
            Text(self.message)
                .foregroundColor(.red)
            Text("Adding a new Responsible")
                .font(.title)
            ResponsibleCreateForm(responsible: self.$responsible)
            HStack(spacing: 20.0) {
                Button("Cancel") {
                        self.showModal.toggle()
                    }
                Button(
                    "Add",
                    action: {
                        self.viewModel.addResponsible(self.responsible)
                        // TODO: pressing enter should execute Save?
                        self.step.responsible = self.responsible.id
                        self.showModal.toggle()
                    }
                )
            }
                .padding()
        }
            .padding(50.0)
    }
}

struct ResponsibleCreateForm: View {
    @Binding var responsible: Responsible
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            TextField("Name", text: self.$responsible.name)
                .foregroundColor(.primary)
                .font(.title)
        }
    }
}
