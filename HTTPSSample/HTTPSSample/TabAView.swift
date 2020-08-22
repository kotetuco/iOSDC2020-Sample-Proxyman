//
//  TabAView.swift
//  HTTPSSample
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import SwiftUI

struct TabAView: View {
    var body: some View {
        ZStack(alignment: .top) {
            NavigationView {
                Text("Hello, World!")
                    .navigationBarTitle("1st Tab", displayMode: .inline)
            }
        }
    }
}

struct TabAView_Previews: PreviewProvider {
    static var previews: some View {
        TabAView()
    }
}
