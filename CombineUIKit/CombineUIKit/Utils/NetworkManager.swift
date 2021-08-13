//
//  APIServices.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import Foundation
import Combine

enum NetworkError: Error {
  case statusCode
  case decoding
  case invalidURL
  case other(Error)
  
  static func map(_ error: Error) -> NetworkError {
    return (error as? NetworkError) ?? .other(error)
  }
}

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    var subscriptions = Set<AnyCancellable>()
    
    /// Regular service
    func getEpisode(url: String, completion: @escaping () -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, respose, error in
            guard let data = data, error == nil, let respose = respose as? HTTPURLResponse else { return }
            if respose.statusCode == 200 {
                do {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    print("CEDA-episodes: \(episode)")
                    completion() // TODO: CEDA - added completion
                } catch let error {
                    print("NetworkManager-Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    /// Regular service
    func getEpisodes(url: String, completion: @escaping () -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, respose, error in
            guard let data = data, error == nil, let respose = respose as? HTTPURLResponse else { return }
            if respose.statusCode == 200 {
                do {
                    let episodes = try JSONDecoder().decode(Episode.self, from: data)
                    print("CEDA-episodes: \(episodes)")
                    completion() // TODO: CEDA - added competion
                } catch let error {
                    print("NetworkManager-Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
}

// MARK: - Combine module -
extension NetworkManager {
    
    /// Service with Combine
    func getEpisodeCombine(url: String) -> AnyPublisher<Episode, NetworkError> {
        guard let url = URL(string: url) else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                guard let httpURLResponse = response.response as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200 else {
                    throw NetworkError.statusCode
                }
                return response.data
            }
            .decode(type: Episode.self, decoder: JSONDecoder())
            .mapError { NetworkError.map($0) }
            .eraseToAnyPublisher()
    }
    
    /// Service with Combine
    func getEpisodesCombine(url: String) -> AnyPublisher<[Episode], NetworkError> {
        guard let url = URL(string: url) else { return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher() }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { response -> Data in
                guard let httpURLResponse = response.response as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200 else {
                    throw NetworkError.statusCode
                }
                return response.data
            }
            .decode(type: ArrayEpisodes.self, decoder: JSONDecoder())
            .tryMap { $0.episodes }
            .mapError { NetworkError.map($0) }
            .eraseToAnyPublisher()
    }
}
