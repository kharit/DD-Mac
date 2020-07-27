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
            NavigationView {
                Sidebar()
                PrimaryView()
                DetailView()
            }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct Sidebar: View {
    var body: some View {
        List(1..<100) { i in
            Text("Row \(i)")
        }
        .listStyle(SidebarListStyle())
    }
}

struct PrimaryView: View {
    var body: some View {
        Text("Hellow World!")
    }
}

struct DetailView: View {
    var body: some View {
        Text("Hellow World!")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DDMacView(viewModel: DDMacApp())
    }
}
