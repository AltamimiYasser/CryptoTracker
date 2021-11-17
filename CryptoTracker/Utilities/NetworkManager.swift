//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation
import Combine

class NetworkManager {

    enum NetworkError: LocalizedError {
        case badURLResponse(url: URL)
        case Unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(let url):
                return "[🔥] Bad response from URL \(url)"
            case .Unknown:
                return "[⚠️] Unknown error occurred"
            }
        }
    }

    static let shard = NetworkManager()
    private init() { }

    func download(fromURL url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default)) // go to background thread
        .tryMap({ [self] in try handleURLResponse(output: $0, url: url) })
//            .tryMap(handleURLResponse)
        .receive(on: DispatchQueue.main) // change back to main thread
        .eraseToAnyPublisher()
    }

    // this if we want to make another download function
    func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }

    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
