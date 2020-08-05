//
//  HeaderView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var viewModel: DDMacApp
    @State var showNewProject = false
    @State var showManageData = false
    
    var body : some View {
        HStack(spacing: 30.0) {
            Picker(selection: .constant(1), label: Text("")) {
                Text("My project (direct)").tag(1)
            }
                .frame(maxWidth: 300.0)
            Button("New project") {
                self.showNewProject.toggle()
            }
                .buttonStyle(LinkButtonStyle())
                .sheet(isPresented: $showNewProject) {
                    ProjectCreateView(showModal: self.$showNewProject)
                        .environmentObject(self.viewModel)
                }
            Spacer()
            Button("Manage project data") {
                self.showManageData.toggle()
            }
                .sheet(isPresented: $showManageData) {
                    ManageDataView(showModal: self.$showManageData)
                        .environmentObject(self.viewModel)
                }
            Spacer()
//            HStack {
//                Text("RTF")
//                Text("PDF")
//                Text("EN")
//            }
        }
        .padding(.all)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
