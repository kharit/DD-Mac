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
    @ObservedObject var viewModel: DDMacApp
    
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
                ForEach(self.viewModel.data.solutions) { solution in
                    SolutionView(viewModel: self.viewModel, solution: solution)
                }
                    .buttonStyle(LinkButtonStyle())
            }
        }
    }
}

struct SolutionView: View {
    @ObservedObject var viewModel: DDMacApp
    var solution: Solution
    
    var body: some View {
        ZStack {
//            SolutionToggle(viewModel: viewModel)
            if self.viewModel.currentSolution == solution {
                Button(
                    solution.name[self.viewModel.lang] ?? "[No translation]",
                    action: { self.viewModel.chooseSolution(self.solution) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    solution.name[self.viewModel.lang] ?? "[No translation]",
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
//            Text(solution.name[self.viewModel.lang] ?? "[No translation]")
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
                ForEach(self.viewModel.data.tags) { tag in
                    TagView(viewModel: self.viewModel, tag: tag)
                }
                    .buttonStyle(LinkButtonStyle())
            }
        }
    }
}

struct TagView: View {
    @ObservedObject var viewModel: DDMacApp
    var tag: Tag
    
    var body: some View {
        ZStack {
            if self.viewModel.currentTag == tag {
                Button(
                    tag.name[self.viewModel.lang] ?? "[No translation]",
                    action: { self.viewModel.chooseTag(self.tag) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    tag.name[self.viewModel.lang] ?? "[No translation]",
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
                ForEach(self.viewModel.data.processes) { process in
                    ProcessView(viewModel: self.viewModel, process: process)
                }
                    .buttonStyle(LinkButtonStyle())
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
            if self.viewModel.currentProcess == process {
                Button(
                    process.name[self.viewModel.lang] ?? "[No translation]",
                    action: { self.viewModel.chooseProcess(self.process) }
                ).foregroundColor(.primary)
            } else {
                Button(
                    process.name[self.viewModel.lang] ?? "[No translation]",
                    action: { self.viewModel.chooseProcess(self.process) }
                ).foregroundColor(.secondary)
            }
        }
    }
}

struct NavigationFilterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationFilterView(
            viewModel: DDMacApp()
        )
    }
}
