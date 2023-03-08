//
//  AstronautDetailsViewController.swift
//  SpaceLaunc
//
//  Created by Prashant Singh on 8/3/2023.
//

import UIKit

class AstronautDetailsViewController: UIViewController {

    @IBOutlet weak var astronautDetailImageView: UIImageView!
    @IBOutlet weak var astronautName: UILabel!
    @IBOutlet weak var astronautNationality: UILabel!
    @IBOutlet weak var astronautDateOfBirth: UILabel!
    @IBOutlet weak var astronautBio: UITextView!
    var astronautId: Int?
    
    let activityView = UIActivityIndicatorView(style: .large)
    private let viewModel: AstronautDetailsViewModel = AstronautDetailsDefaultViewModel(networkService: DefaultNetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchAstronautDetails()
        bindViewModelEvent()
    }
    
    func setupView() {
        navigationItem.title = "Astronaut Details"
        
        //Setup the loading activity indicator
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50)
        activityView.accessibilityIdentifier = "loadingSpinner"
        activityView.startAnimating()
        self.view.addSubview(activityView)

    }
    
    func fetchAstronautDetails() {
        guard let astronautId = astronautId else { return }
        viewModel.fetchAstronautDetail(astronautId: astronautId)
    }
    
    func bindViewModelEvent() {
        viewModel.onFetchAstronautDetailsSucceed = { [weak self] in
            DispatchQueue.main.async {
                self?.setAstronautDetails()
            }
        }
    }
    
    func setAstronautDetails() {
        if let astronautDetail = viewModel.astronautDetail {
            astronautName.text = astronautDetail.name
            astronautNationality.text = astronautDetail.nationality
            astronautDateOfBirth.text = astronautDetail.dateOfBirth
            astronautBio.text = astronautDetail.bio
            astronautDetailImageView.accessibilityLabel = "An image of \(astronautDetail.name)"
            ImageDownloadClient.shared.setImage(from: astronautDetail.profileImage, placeholderImage: nil) { [weak self] image in
                self?.astronautDetailImageView.image = image
                self?.activityView.stopAnimating()
            }
        }
    }
    
}
