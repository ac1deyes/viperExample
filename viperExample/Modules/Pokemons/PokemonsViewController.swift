//
//  ViewController.swift
//  viperExample
//
//  Created by Vladislav on 26.07.2020.
//  Copyright © 2020 VladislavNegoda. All rights reserved.
//

import UIKit

class PokemonsViewController: UIViewController {

    var presenter: ViewToPresenterPokemonsProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var footerActivityIndicatorView: UIActivityIndicatorView!
    

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    private var cellIdentifier = "PokemonCell"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @objc func refresh() {
        presenter?.refresh()
    }

}

// MARK: - UITableViewDataSource

extension PokemonsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
        cell.textLabel?.text = presenter?.textLabelText(indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PokemonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayRowAt(index: indexPath.row)
    }
}

// MARK: - PresenterToViewPokemonsProtocol

extension PokemonsViewController: PresenterToViewPokemonsProtocol {
    
    func onFetchPokemonsSuccess() {
        tableView.reloadData()
    }
    
    func onFetchPokemonsFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
    }
    
    func showActivityIndicator() {
        loadingActivityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        loadingActivityIndicatorView.stopAnimating()
    }
    
    func showFooterView() {
        footerActivityIndicatorView.startAnimating()
    }
    
    func hideFooterView() {
        footerActivityIndicatorView.stopAnimating()
    }
    
    func endRefreshing() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func enableRefresh() {
        refreshControl.isEnabled = true
    }
    
    func disableRefresh() {
        refreshControl.isEnabled = false
    }
    
    func deselectRowAt(row: Int) {
        tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
    
    
}

// MARK: - UI Setup

extension PokemonsViewController {
    func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        tableView.addSubview(refreshControl)
        navigationItem.title = "Pokemons"
        
    }
}
