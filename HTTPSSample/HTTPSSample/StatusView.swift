//
//  StatusView.swift
//  HTTPSSample
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import Combine
import SwiftUI

struct StatusView: View {
    @ObservedObject var viewModel: StatusViewModel

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Status API Response")
                        .font(.title)
                    HStack(alignment: .top) {
                        Text(viewModel.status)
                            .font(.body)
                        Spacer()
                    }
                }
                Spacer()
                VStack(alignment: .center) {
                    Button(action: {
                        self.viewModel.fetch()
                    }) {
                        Text("Reload")
                            .font(.title)
                    }
                    .disabled(viewModel.loading)
                }
            }
            .padding()
            .navigationBarTitle("Github Status", displayMode: .inline)
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(viewModel: StatusViewModel())
    }
}
