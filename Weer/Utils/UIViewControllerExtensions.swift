//
//  UIViewControllerExtensions.swift
//  Weer
//
//  Created by Artyom Jalilov on 24.08.21.
//

import Foundation
import UIKit

extension UIViewController {
    func loader() -> UIAlertController {
            let alert = UIAlertController(title: nil, message: "Update weather...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.large
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            return alert
        }
        
    func stopLoader(loader : UIAlertController) {
        DispatchQueue.main.async {
            loader.dismiss(animated: true, completion: nil)
        }
    }
    
    func alert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))        
        self.present(alert, animated: true, completion: nil)
        return alert
    }
}
