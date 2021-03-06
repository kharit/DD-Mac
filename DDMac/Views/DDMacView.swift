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
    @EnvironmentObject var viewModel: DDMacApp
    
    var body: some View {
        VStack {
            HeaderView()
            Divider()
            NavigationFilterView()
            Divider()
            HStack(alignment: .top, spacing: 30.0) {
                SidebarView()
                    .frame(width: 300)
                    .padding()
                GeometryReader { metrics in
                    HStack {
                        PrimaryView()
                            .frame(width: metrics.size.width * 0.60)
                            .padding()
                        DetailView()
                            .frame(width: metrics.size.width * 0.40)
                            .padding()
                    }
                }
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
        DDMacView()
            .environmentObject(DDMacApp.initPreview())
        
    }
}
