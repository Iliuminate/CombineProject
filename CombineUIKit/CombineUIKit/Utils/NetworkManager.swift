//
//  APIServices.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import Foundation
import Combine

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
    func getEpisodeCombine(url: String, completion: @escaping () -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared
            .dataTaskPublisher(for: url)
            // --------------------------------------------------
            //.tryMap({ data, _ in
            //    try JSONDecoder().decode(Episode.self, from: data)
            //})
            // --------------------------------------------------
            .map(\.data)
            .decode(type: Episode.self, decoder: JSONDecoder())
            // --------------------------------------------------
            .sink(
                // receiveCompletion: (Subscribers.Completion<URLError>) -> Void)
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("CEDA-EPISODE: Retrieving data with error: \(error)")
                    case .finished: print("CEDA-EPISODE: finished")
                    }
                },
                // receiveValue: ((data: Data, response: URLResponse)) -> Void)
                receiveValue: { object in
                    print("CEDA-EPISODE: Objet: \(object)")
                })
            .store(in: &subscriptions)
    }
    
    /// Service with Combine // TODO: CEDA - need implemetation
    func getEpisodesCombine(url: String, completion: @escaping () -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared
            .dataTaskPublisher(for: url)
            // --------------------------------------------------
            //.tryMap({ data, _ in
            //    try JSONDecoder().decode(Episode.self, from: data)
            //})
            // --------------------------------------------------
            .map(\.data)
            .decode(type: Episode.self, decoder: JSONDecoder())
            // --------------------------------------------------
            .sink(
                // receiveCompletion: (Subscribers.Completion<URLError>) -> Void)
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error): print("CEDA-EPISODE: Retrieving data with error: \(error)")
                    case .finished: print("CEDA-EPISODE: finished")
                    }
                },
                // receiveValue: ((data: Data, response: URLResponse)) -> Void)
                receiveValue: { object in
                    print("CEDA-EPISODE: Objet: \(object)")
                })
            .store(in: &subscriptions)
    }
}
