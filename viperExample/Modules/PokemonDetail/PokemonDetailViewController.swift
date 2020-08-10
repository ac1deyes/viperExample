//
//  PokemonDetailViewController.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    
    var presenter: ViewToPresenterPokemonDetailProtocol?
    
    private let cellIdentifier = "PokemonDetailCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewDidDisappear()
    }
}

// MARK: - UITableViewDataSource

extension PokemonDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.textLabel?.text = presenter?.textLabelText(indexPath: indexPath)
        cell.detailTextLabel?.text = presenter?.detailTextLabelText(indexPath: indexPath)
        return cell
    }
}

// MARK: - PresenterToViewPokemonDetailProtocol

extension PokemonDetailViewController: PresenterToViewPokemonDetailProtocol {

    func onFetchPokemonSuccess() {
        tableView.reloadData()
    }
    
    func onFetchPokemonFailure(error: String) {
        errorLabel.text = error
    }
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func pokemonName(_ name: String?) {
        navigationItem.title = name
    }
}

// MARK: - SetupUI

extension PokemonDetailViewController {
    
    func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        tableView.tableFooterView = UIView()
    }
}
