//
//  APIClient.swift
//  SimpleAPIClient
//
//  Created by kotetu on 2020/08/22.
//  Copyright © 2020 kotetu. All rights reserved.
//

import Combine

public final class APIClient {
    public enum APIError: Error {
        case timeout
        case offLine
        case unknownNetworkError(URLError)
        case httpErrorResonse(Int)
        case invalidURLResponse
    }

    public static let shared: APIClient = APIClient()

    private init() {}

    /// APIClientとして成功扱いとするステータスコード
    private static let validStatusCodes: [Int] = (200...209) + [304]

    public func jsonRequest<V>(with url: URL,
                               timeoutInterval: TimeInterval,
                               retryCount: Int = 0,
                               isCachedResponse: Bool = false) -> AnyPublisher<V, Error> where V: Decodable {
        let request = URLRequest(url: url,
                                 cachePolicy: isCachedResponse ? .returnCacheDataElseLoad : .reloadIgnoringCacheData,
                                 timeoutInterval: timeoutInterval)

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError{ APIClient.convert(from: $0) }
            .retry(retryCount)
            .tryMap({ element -> Data in
                guard let apiError = APIClient.convert(from: element.response, statusCodes: APIClient.validStatusCodes) else {
                    return element.data
                }
                throw apiError
            })
            .decode(type: V.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    private static func convert(from urlError: URLError) -> APIError {
        switch urlError.code {
        case .timedOut:
            return APIError.timeout
        case .notConnectedToInternet:
            return APIError.offLine
        default:
            break
        }
        return APIError.unknownNetworkError(urlError)
    }

    private static func convert(from response: URLResponse, statusCodes: [Int]) -> APIError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return APIError.invalidURLResponse
        }

        guard statusCodes.contains(httpResponse.statusCode) else {
            return APIError.httpErrorResonse(httpResponse.statusCode)
        }

        return nil
    }
}
