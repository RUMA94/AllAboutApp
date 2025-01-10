//
//  Extensions+UIViewController.swift
//  AllAboutAppsAssissment
//
//  Created by Moaaz Ahmed Fawzy Taha on 25/01/2022.
//

import Foundation

extension UIViewController {
    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
