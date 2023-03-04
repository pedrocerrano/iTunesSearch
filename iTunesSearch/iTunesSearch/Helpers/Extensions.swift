//
//  Extensions.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/3/23.
//

import Foundation

extension Int {
    func minutesAndSeconds() -> String {
        let minutes = self / 60000
        let seconds = self / 1000 % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}
