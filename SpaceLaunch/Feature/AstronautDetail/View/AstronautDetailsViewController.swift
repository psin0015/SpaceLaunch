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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
