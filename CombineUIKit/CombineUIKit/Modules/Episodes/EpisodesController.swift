//
//  EpisodesController.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import UIKit
import Combine

class EpisodesController: UIViewController {
    
    // MARK: - Private properties -
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        //tableView.allowsSelection = false
        //tableView.allowsSelectionDuringEditing = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    // MARK: - Public properties -
    var subscriptions = Set<AnyCancellable>()
    var episodes = CurrentValueSubject<[Episode], Never>([])
    
    // MARK: - Lifecycle -
    override func loadView() {
        super.loadView()
        addViews()
        setUpConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getEpisodes()
    }
    
    // MARK: - Private methods -
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: EpisodeCell.cellName, bundle: nil), forCellReuseIdentifier: EpisodeCell.cellName)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func getEpisodes() {
        NetworkManager.sharedInstance.getEpisodesCombine(url: "https://rickandmortyapi.com/api/episode")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { [unowned self] episodesList in
                episodes.send(episodesList)
                tableView.reloadData()
            })
            .store(in: &subscriptions)
    }
    
    private func navigate(indexPath: IndexPath) {
        guard let navigation = navigationController else { return }
        let controller = EpisodeDetailController()
        controller.episode = episodes.value[indexPath.row]
        navigation.pushViewController(controller, animated: true)
    }
}

// MARK: - UITableViewDelegate -
extension EpisodesController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigate(indexPath: indexPath)
    }
}

// MARK: - UITableViewDataSource -
extension EpisodesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.cellName, for: indexPath) as! EpisodeCell
        cell.configure(with: episodes.value[indexPath.row])
        return cell
    }
}
