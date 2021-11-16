//
//  NetworkManager.swift
//  CryptoTracker
//
//  Created by Yasser Tamimi on 16/11/2021.
//

import Foundation
import Combine

class NetworkManager {
    static let shard = NetworkManager()
    private init() { }

    func download(fromURL url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default)) // go to background thread
        .tryMap { output -> Data in // get the data
            guard
                let response = output.response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return output.data
        }
            .receive(on: DispatchQueue.main) // change back to main thread
        .eraseToAnyPublisher()
    }
}
