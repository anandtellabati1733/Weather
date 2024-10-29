//
//  UIImageView.swift
//  Weather
//
//  Created by Anand on 10/29/24.
//
import UIKit

extension UIImageView {
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
