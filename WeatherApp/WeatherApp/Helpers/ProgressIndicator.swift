//
//  ProgressIndicator.swift
//  Weather
//
//  Created by Uma on 29/08/24..
//

import UIKit

protocol ActivityPresentable {
    func showActivity()
    func hideActivity()
}

extension ActivityPresentable where Self: UIViewController {
    func showActivity() {
        DispatchQueue.main.async {
            let activityView = UIView(frame: UIScreen.main.bounds)
            activityView.accessibilityIdentifier = "ActivityView"
            self.view.addSubview(activityView)
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
            overlayView.layer.cornerRadius = 8
            activityView.addSubview(overlayView)
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            activityView.addSubview(activityIndicator)
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                overlayView.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
                overlayView.centerYAnchor.constraint(equalTo: activityView.centerYAnchor),
                overlayView.widthAnchor.constraint(equalToConstant: 120),
                overlayView.heightAnchor.constraint(equalToConstant: 120),
                activityIndicator.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: activityView.centerYAnchor)
            ])
        }
    }
    
    func hideActivity() {
        DispatchQueue.main.async {
            self.view.subviews
                .filter { $0.accessibilityIdentifier == "ActivityView" }
                .first?.removeFromSuperview()
        }
    }
}
