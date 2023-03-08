//
//  AstronautListViewController.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import UIKit

class AstronautListViewController: UIViewController {

    @IBOutlet weak var astronautListTableView: UITableView!
    let activityView = UIActivityIndicatorView(style: .large)
    private let viewModel: AstronautListViewModel = AstronautListDefaultViewModel(networkService: DefaultNetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchAstronautList()
        bindViewModelEvent()
    }
    
    func setupView() {
        
        astronautListTableView.dataSource = self
        astronautListTableView.delegate = self
        astronautListTableView.register(UINib.init(nibName: "AstronautListCell", bundle: nil), forCellReuseIdentifier: AstronautListCell.reuseIdentifier)
        navigationItem.title = "Astronaut List"
        
        //Setup the loading activity indicator
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50)
        activityView.accessibilityIdentifier = "loadingSpinner"
        activityView.startAnimating()
        self.view.addSubview(activityView)
        
        //Disable the user interaction until the astronaut list has been downloaded.
        astronautListTableView.isUserInteractionEnabled = false
    }
    
    func fetchAstronautList() {
        viewModel.fetchAstronauts()
    }
    
    func bindViewModelEvent() {
        viewModel.onFetchAstronautsSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.astronautListTableView.reloadData()
                self?.activityView.stopAnimating()
                self?.astronautListTableView.isUserInteractionEnabled = true
            }
        }
        
        viewModel.onFetchAstronautsFailure = { error in
            print("\(error)")
        }
    }
}

extension AstronautListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.astronauts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let astronautCell = tableView.dequeueReusableCell(withIdentifier: AstronautListCell.reuseIdentifier, for: indexPath) as! AstronautListCell
        
        let astronaut = viewModel.astronauts[indexPath.row]
        
        astronautCell.bindViewWith(
            viewModel: AstronautDefaultViewModel(
                astronaut: astronaut
            )
        )
        return astronautCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let astronautDetailsViewStoryboard = UIStoryboard(name: "AstronautDetailsViewController", bundle: nil)
        if let astronautDetailsViewController = astronautDetailsViewStoryboard.instantiateViewController(withIdentifier: "AstronautDetailsViewController") as? AstronautDetailsViewController {
            astronautDetailsViewController.astronautId = viewModel.astronauts[indexPath.row].id
            self.navigationController?.pushViewController(astronautDetailsViewController, animated: true)
        }        
    }
}
