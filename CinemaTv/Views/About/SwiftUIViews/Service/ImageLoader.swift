//
//  ImageLoader.swift
//  CinemaTv
//
//  Created by Danilo Requena on 08/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation


final class ImageLoader: ObservableObject {
    @Published var downloadedData: Data?
    
    func downloadImage(url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, _, error  in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.downloadedData = data
            }
            
        }.resume()
    }
}
