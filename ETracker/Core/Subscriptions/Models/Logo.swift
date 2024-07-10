//
//  Logo.swift
//  ETracker
//
//  Created by Ancel Dev account on 10/7/24.
//

import Foundation
import SwiftUI

extension Subscription {
    enum Logo: String, Codable, CaseIterable, Identifiable {
        case applemusic = "Apple Music"
        case disneyplus = "Disney Plus"
        case netflix = "Netflix"
        case spotify = "Spotify"
        case youtubemusic = "Youtube Music"
        
        var id: String {
            self.rawValue
        }
        
        var logoImage: Image {
            Image(self.rawValue)
        }
    }
}
