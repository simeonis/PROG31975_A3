//
//  String+LoadImage.swift
//  Shae_Weather
//
//  Created by Shae Simeoni on 2021-11-10.
//

import SwiftUI

extension String {
    func load() -> UIImage {
        // Empty string
        if (self.count <= 0) { return UIImage() }
    
        do {
            let url = "https:" + self
            guard let url = URL(string: url) else { return UIImage() }
            
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
            print("Unable to convert URL to UIImage")
        }
        
        return UIImage()
    }
}
