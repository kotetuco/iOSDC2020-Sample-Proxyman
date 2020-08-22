//
//  ContentView.swift
//  HTTPSSample
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StatusView(viewModel: StatusViewModel())
                .tabItem {
                    VStack {
                        Image(systemName: "1.square.fill")
                        Text("Status")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
