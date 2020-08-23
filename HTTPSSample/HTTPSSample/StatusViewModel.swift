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
    @Published var loading = false

    private var cancellables: Set<AnyCancellable> = []

    init() {
        fetch()
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }

    func fetch() {
        loading = true
        status = "Getting status..."

        guard let url = URL(string: StatusAPI.urlString) else {
            status = "Invalid URL."
            loading = false
            return
        }

        // ゆっくり通信内容を確認するため、タイムアウト時間を長めに設定しておく(300s)
        let publisher: AnyPublisher<StatusAPI.Response, Error> = APIClient.shared.jsonRequest(with: url, timeoutInterval: 300)
        publisher
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self]  result in
                switch result {
                case .finished:
                    break
                case let .failure(error):
                    self?.status = "Error occured: \(error)"
                }
                self?.loading = false
            }) { [weak self] response in
                self?.status = "\(response.status.description)"
            }
            .store(in: &cancellables)
    }
}
