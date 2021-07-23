//
//  EpisodesController.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import UIKit

class EpisodesController: UIViewController {
    
    // MARK: - Private properties -
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.allowsSelection = false
        tableView.allowsSelectionDuringEditing = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    
    // MARK: - Lifecycle -
    override func loadView() {
        super.loadView()
        addViews()
        setUpConstraint()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Private methods -
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -30),
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
}

// MARK: - UITableViewDelegate -
extension EpisodesController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource -
extension EpisodesController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
