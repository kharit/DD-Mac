//
//  ManageSolutions.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.08.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct ManageSolutions: View {
    @EnvironmentObject var viewModel: DDMacApp
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Solutions")
                .font(.headline)
            ForEach(self.viewModel.data.solutions) { solution in
                ManageSingleSolution(solution: solution)
            }
        }
            .frame(minWidth: 400)
    }
}

struct ManageSingleSolution: View {
    @EnvironmentObject var viewModel: DDMacApp
    @State var solution: Solution
    @State var currentlyEditing = false
    
    var body: some View {
        ZStack {
            if currentlyEditing {
                EditSingleSolution(solution: self.$solution, currentlyEditing: self.$currentlyEditing)
            } else {
                ViewSingleSolution(solution: self.$solution, currentlyEditing: self.$currentlyEditing)
            }
        }
    }
}

struct ViewSingleSolution: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var solution: Solution
    @Binding var currentlyEditing: Bool
    
    var body: some View {
        HStack {
            Button("Edit") {
                self.currentlyEditing = true
            }
            Text(solution.name)
            Spacer()
        }
    }
}

struct EditSingleSolution: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var solution: Solution
    @Binding var currentlyEditing: Bool
    @State var showModal = false
    
    var body: some View {
        HStack {
            Button("Save") {
                self.viewModel.updateSolution(self.solution)
                self.currentlyEditing = false
            }
            TextField("Name", text: self.$solution.name)
            Button("Delete") {
                self.showModal = true
            }
                .foregroundColor(.red)
                .sheet(isPresented: $showModal) {
                    DeleteSolution(solution: self.$solution, showModal: self.$showModal)
                        .environmentObject(self.viewModel)
                }
        }
    }
}

struct DeleteSolution: View {
    @EnvironmentObject var viewModel: DDMacApp
    @Binding var solution: Solution
    @Binding var showModal: Bool
    
    var body: some View {
        VStack   {
            Text("Are you sure?")
                .font(.title)
            Text("Deleting a solution will also remove all subsequent objects like processes, flows and steps that are not assigned to another solution")
            HStack(spacing: 100.0) {
                Button("Cancel") {
                    self.showModal = false
                }
                Button("Delete") {
                    self.viewModel.deleteSolution(self.solution)
                    self.showModal = false
                }
                    .foregroundColor(.red)
            }
        }
            .padding(50.0)
    }
}
