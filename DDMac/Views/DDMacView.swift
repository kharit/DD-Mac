//
//  DDMacView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI

// View type (MVVM)
struct DDMacView: View {
    var viewModel: DDMacApp
    
    var body: some View {
        VStack {
            HeaderView()
            Divider()
            NavigationFilterView(viewModel: viewModel)
            Divider()
            HStack {
                Spacer()
                SidebarView(viewModel: viewModel)
                Spacer()
                PrimaryView(viewModel: viewModel)
                Spacer()
                DetailView(viewModel: viewModel)
                Spacer()
            }
                //TODO: create a navigation view insted of HStack
//            NavigationView {
//                SidebarView(viewModel: viewModel)
//                Divider()
//                PrimaryView()
//                Divider()
//                DetailView()
//            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DDMacView(viewModel: DDMacApp())
    }
}
