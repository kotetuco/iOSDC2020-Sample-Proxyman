//
//  StatusAPI.swift
//  GithubStatusAPIs
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

public struct StatusAPI {
    public static let urlString = "https://kctbh9vrtdwd.statuspage.io/api/v2/status.json"

    public struct Page: Decodable {
        public let id: String
        public let name: String
        public let url: URL
    }

    public struct Response: Decodable {
       public let page: Page
       public let status: Status
    }

    public struct Status: Decodable {
        public let description: String
        public let indicator: String
    }
}
