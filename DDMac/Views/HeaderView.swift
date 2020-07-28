//
//  HeaderView.swift
//  DDMac
//
//  Created by Vasiliy Kharitonov on 04.07.2020.
//  Copyright © 2020 Kharit. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var body : some View {
        HStack {
            Text("User Name")
            Spacer()
            Picker(selection: .constant(1), label: Text("Project")) {
                Text("My project (direct)").tag(1)
                Text("New project").tag(2)
            }
            .frame(maxWidth: 400.0)
            Spacer()
            HStack {
                Text("RTF")
                Text("PDF")
                Text("EN")
            }
        }
        .padding(.all)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
