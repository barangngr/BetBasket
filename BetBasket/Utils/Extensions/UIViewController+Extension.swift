//
//  UIViewController+Extension.swift
//  BetBasket
//
//  Created by Baran Gungor on 24.03.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ message: String, title: String = "Warning", okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okey", style: .default, handler: okAction)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setNavColors(_ backgroundColor: UIColor, textColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: textColor]
        
        navigationController?.navigationBar.tintColor = textColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func setNavBackButton(_ text: String = "") {
        let backButton = UIBarButtonItem()
        backButton.title = text
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func showActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        activityIndicator.color = .gray
        activityIndicator.tag = 544
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.layer.zPosition = 999
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.viewWithTag(544) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

