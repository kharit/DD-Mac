//
//  DetailView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 28.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI
import DDCore

struct DetailView: View {
    @ObservedObject var viewModel: DDMacApp
    
    var body: some View {
        ZStack {
            if viewModel.currentStep != nil {
                VStack(alignment: .leading) {
                    Text(viewModel.currentStep!.name[self.viewModel.lang] ?? "[No translation]")
                        .font(.title)
                    ForEach(self.viewModel.data.techSteps) { techStep in
                        TechStepView(viewModel: self.viewModel, techStep: techStep)
                    }
                }
                    .padding()
                    .buttonStyle(LinkButtonStyle())
                    
            } else {
                Text("Please select a step in the primary area")
            }
        }
    }
}

struct TechStepView: View {
    @ObservedObject var viewModel: DDMacApp
    var techStep: TechStep

    var body: some View {
        VStack(alignment: .leading) {
            Text(techStep.name[self.viewModel.lang] ?? "[No translation]")
            .font(.headline)
            Text(techStep.description[self.viewModel.lang] ?? "[No translation]")
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DDMacApp())
    }
}
