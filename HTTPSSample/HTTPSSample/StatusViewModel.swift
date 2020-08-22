//
//  StatusViewModel.swift
//  HTTPSSample
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import Combine
import Foundation
import GithubStatusAPIs
import SimpleAPIClient

final class StatusViewModel: ObservableObject {
    @Published var status = "Getting status..."
    @Published var disabled = false

    init() {
        fetch()
    }

    func fetch() {
        disabled = true
        status = "Getting status..."
        guard let url = URL(string: StatusAPI.urlString) else {
            status = "Invalid URL."
            disabled = false
            return
        }

        // ゆっくり通信内容を確認するため、タイムアウト時間を長めに設定しておく(300s)
        APIClient.shared.jsonRequest(with: url, timeoutInterval: 300) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(rawBody):
                    do {
                        let reponse = try JSONDecoder().decode(StatusAPI.Response.self, from: rawBody)
                        self.status = "\(reponse.status.description)"
                    } catch {
                        self.status = "Parse error occured:\(error)"
                    }
                case let .failure(error):
                    self.status = "Error occured:\(error)"
                }
                self.disabled = false
            }
        }
    }
}
