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
        navigationItem.title = StringConstants.astronautDetailsTitle
        
        //Setup the loading activity indicator
        activityView.hidesWhenStopped = true
        activityView.frame = CGRect(x: view.frame.midX - Metrics.activityIndicatorWidth/2, y: view.frame.midY - Metrics.activityIndicatorHeight/2, width: Metrics.activityIndicatorWidth, height: Metrics.activityIndicatorHeight)
        activityView.accessibilityLabel = AccessibilityLabels.loadingAstronautDetails
        activityView.accessibilityIdentifier = AccessibilityLabels.loadingSpinnerIdentifier
        activityView.isAccessibilityElement = true
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
        
        viewModel.onFetchAstronautDetailsFailure = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert()
            }
        }
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: StringConstants.errorMessageTitle, message: StringConstants.errorMessageAstronautDetails, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: StringConstants.errorMessageAction, style: UIAlertAction.Style.default, handler: { [weak self] _ in
            self?.activityView.stopAnimating()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setAstronautDetails() {
        if let astronautDetail = viewModel.astronautDetail {
            astronautName.text = astronautDetail.name
            astronautNationality.text = astronautDetail.nationality
            astronautDateOfBirth.text = astronautDetail.dateOfBirth
            astronautBio.text = astronautDetail.bio
            astronautDetailImageView.isAccessibilityElement = true
            astronautDetailImageView.accessibilityLabel = "\(AccessibilityLabels.astronautImage) \(astronautDetail.name)"
            ImageDownloadClient.shared.setImage(from: astronautDetail.profileImage, placeholderImage: nil) { [weak self] image in
                self?.astronautDetailImageView.image = image
                self?.activityView.stopAnimating()
            }
        }
    }
}
