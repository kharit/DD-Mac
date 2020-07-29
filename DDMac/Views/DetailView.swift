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
        ScrollView {
            if viewModel.currentStep != nil {
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.currentStep!.name)
                            .font(.title)
                        VStack {
                            if self.viewModel.data.techSteps != [] {
                                ForEach(self.viewModel.data.techSteps) { techStep in
                                    TechStepView(viewModel: self.viewModel, techStep: techStep)
                                }
                            } else {
                                Text("There are no technical steps to display here.")
                                    .padding()
                            }
                            
                        }
                    }
                }
                    .padding()
                    .buttonStyle(LinkButtonStyle())
                    
            } else {
                HStack {
                    Text("Please select a step in the primary area")
                    Spacer()
                }
            }
        }
    }
}

struct TechStepView: View {
    @ObservedObject var viewModel: DDMacApp
    var techStep: TechStep

    var body: some View {
        VStack(alignment: .leading) {
            Text(techStep.name)
            .font(.headline)
            Text(techStep.description)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DDMacApp())
    }
}
