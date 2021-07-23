//
//  APIServices.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import Foundation


class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    func getEpisode(url: String, completion: @escaping () -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, respose, error in
            guard let data = data, error == nil, let respose = respose as? HTTPURLResponse else { return }
            
            if respose.statusCode == 200 {
                do {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    print("CEDA-episodes: \(episode)")
                    completion() // TODO: CEDA - added competion
                } catch let error {
                    print("NetworkManager-Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
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
