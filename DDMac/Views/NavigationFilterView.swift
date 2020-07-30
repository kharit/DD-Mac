//
//  NavigationFilterView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct NavigationFilterView: View {
    @EnvironmentObject var viewModel: DDMacApp
    
    var body: some View {
        HStack {
            Spacer()
            SolutionFilterView(viewModel: viewModel)
            Spacer()
            TagFilterView(viewModel: viewModel)
            Spacer()
            ProcessFilterView(viewModel: viewModel)
            Spacer()
        }
            .font(.headline)
            .padding(.all)
    }
}

struct SolutionFilterView: View {
    @ObservedObject var viewModel: DDMacApp
    
    var body: some View {
        HStack {
            Text("Solutions")
                .padding(.horizontal)
            VStack(alignment: .leading) {
                if self.viewModel.data.solutions != [] {
                    ForEach(self.viewModel.data.solutions) { solution in
                        SolutionView(viewModel: self.viewModel, solution: solution)
                    }
                        .buttonStyle(LinkButtonStyle())
                } else {
                    Text("There are no solutions to display here.")
                }
            }
        }
    }
}

struct SolutionView: View {
    @ObservedObject var viewModel: DDMacApp
    var solution: Solution
    
    var body: some View {
        ZStack {
            if self.viewModel.currentSolutionID == solution.id {
                Button(
                    solution.name,
                    action: { self.viewModel.chooseSolution(self.solution) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    solution.name,
                    action: { self.viewModel.chooseSolution(self.solution) }
                ).foregroundColor(.secondary)
            }
        }
    }
}

//struct SolutionToggle : View {
//    @ObservedObject var viewModel: DDMacApp
//
//    var body: some View {
//        List(viewModel.solutions, selection: $viewModel.currentSolution) { solution in
//            Text(solution.name)
//        }
//    }
//}

struct TagFilterView: View {
    @ObservedObject var viewModel: DDMacApp
    
    var body: some View {
        HStack {
            Text("Tags")
                .padding(.horizontal)
            VStack(alignment: .leading) {
                if self.viewModel.data.tags != [] {
                    ForEach(self.viewModel.data.tags) { tag in
                        TagView(viewModel: self.viewModel, tag: tag)
                    }
                        .buttonStyle(LinkButtonStyle())
                } else {
                    Text("There are no solutions to display here.")
                }
            }
        }
    }
}

struct TagView: View {
    @ObservedObject var viewModel: DDMacApp
    var tag: Tag
    
    var body: some View {
        ZStack {
            if self.viewModel.currentTagID == tag.id {
                Button(
                    tag.name,
                    action: { self.viewModel.chooseTag(self.tag) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    tag.name,
                    action: { self.viewModel.chooseTag(self.tag) }
                ).foregroundColor(.secondary)
            }
        }
    }
}

struct ProcessFilterView: View {
    @ObservedObject var viewModel: DDMacApp
    
    var body: some View {
        HStack {
            Text("Processes")
                .padding(.horizontal)
            VStack(alignment: .leading) {
                if self.viewModel.data.processes != [] {
                    ForEach(self.viewModel.data.processes) { process in
                        ProcessView(viewModel: self.viewModel, process: process)
                    }
                        .buttonStyle(LinkButtonStyle())
                } else {
                    Text("There are no processes to display here.")
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ProcessView: View {
    @ObservedObject var viewModel: DDMacApp
    var process: DDProcess
    
    var body: some View {
        ZStack {
            if self.viewModel.currentProcessID == process.id {
                Button(
                    process.name,
                    action: { self.viewModel.chooseProcess(self.process) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    process.name,
                    action: { self.viewModel.chooseProcess(self.process) }
                ).foregroundColor(.secondary)
            }
        }
    }
}

struct NavigationFilterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFilterView()
            .environmentObject(DDMacApp.initPreview())
    }
}
