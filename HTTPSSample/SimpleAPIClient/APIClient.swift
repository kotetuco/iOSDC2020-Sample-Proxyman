//
//  APIClient.swift
//  SimpleAPIClient
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

public final class APIClient {
    public enum APIError: Error {
        case networkError(Error)
        case httpErrorResonse(Int)
        case invalidURLResponse
        case invalidResponseBody
    }

    public static let shared: APIClient = APIClient()

    private init() {}

    public func jsonRequest(with url: URL,
                            timeoutInterval: TimeInterval,
                            _ completion: @escaping (Result<Data, APIError>) -> Void) {
        let request = URLRequest(url: url)
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidURLResponse))
                return
            }

            let validStatuses = (200...209) + [304]
            guard validStatuses.contains(httpResponse.statusCode) else {
                completion(.failure(.httpErrorResonse(httpResponse.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponseBody))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
}
