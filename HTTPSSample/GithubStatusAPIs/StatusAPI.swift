//
//  StatusAPI.swift
//  GithubStatusAPIs
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

struct StatusAPI {
    struct Page: Decodable {
        let id: String
        let name: String
        let url: URL
    }

    struct Response: Decodable {
       let page: Page
       let status: Status
    }

    struct Status: Decodable {
        let description: String
        let indicator: String
    }
}
