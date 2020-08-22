//
//  StatusViewModel.swift
//  HTTPSSample
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import Combine

final class StatusViewModel: ObservableObject {
    @Published var status = "Hello, World!"
}
