//
//  UIViewController+Extension.swift
//  SpaceLaunch
//
//  Created by Prashant Singh on 9/3/2023.
//
import UIKit

extension UIViewController {
    func showAlert(alertMessage : String) {
        let alert = UIAlertController(title: StringConstants.errorMessageTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)        
        alert.addAction(UIAlertAction(title: StringConstants.errorMessageAction, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
