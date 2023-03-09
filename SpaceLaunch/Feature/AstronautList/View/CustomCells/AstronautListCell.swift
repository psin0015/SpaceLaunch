//
//  AstronautListCell.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 8/3/2023.
//

import UIKit

class AstronautListCell: UITableViewCell {
    static let reuseIdentifier = "astronautListCell"
    
    @IBOutlet weak var astronautListImageView: UIImageView!
    @IBOutlet weak var astronautListName: UILabel!
    @IBOutlet weak var astronautListNationality: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindViewWith(viewModel: AstronautViewModel) {
        let astronaut = viewModel.astronaut
        
        astronautListName.text = astronaut.name
        astronautListNationality.text = astronaut.nationality
        
        ImageDownloadClient.shared.setImage(from: astronaut.profileImageThumbnail, placeholderImage: nil) { [weak self] image in
            self?.astronautListImageView.image = image
        }
    }
}
