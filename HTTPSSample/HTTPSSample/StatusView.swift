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
        ZStack(alignment: .top) {
            NavigationView {
                Text(viewModel.status)
                    .navigationBarTitle("Github Status", displayMode: .inline)
            }
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(viewModel: StatusViewModel())
    }
}
