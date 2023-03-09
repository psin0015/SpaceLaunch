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
        navigationItem.title = StringConstants.astronautListTitle
        
        //Add astronaut list sort button and disable it until the list is downloaded
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action:  #selector(sortAstronautNames))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.accessibilityLabel = AccessibilityLabels.sortButton
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        //Setup the loading activity indicator
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.midX - Metrics.activityIndicatorWidth/2, y: view.frame.midY - Metrics.activityIndicatorHeight/2, width: Metrics.activityIndicatorWidth, height: Metrics.activityIndicatorHeight)
        activityView.accessibilityLabel = AccessibilityLabels.loadingAstronautList
        activityView.accessibilityIdentifier = AccessibilityIdentifier.loadingSpinnerIdentifier
        activityView.isAccessibilityElement = true
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
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        
        viewModel.onFetchAstronautsFailure = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert()
            }
        }
        
        viewModel.onAstronautListSort = { [weak self] in
            DispatchQueue.main.async {
                self?.astronautListTableView.reloadData()
            }
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: StringConstants.errorMessageTitle, message: StringConstants.errorMessageAstronautList, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: StringConstants.errorMessageAction, style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.activityView.stopAnimating()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func sortAstronautNames() {
        viewModel.sortAstronautNames()
    }
}

extension AstronautListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.astronauts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let astronautCell = tableView.dequeueReusableCell(withIdentifier: AstronautListCell.reuseIdentifier, for: indexPath) as! AstronautListCell
        astronautCell.accessibilityIdentifier = AccessibilityIdentifier.astronautCellIdentifier
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
