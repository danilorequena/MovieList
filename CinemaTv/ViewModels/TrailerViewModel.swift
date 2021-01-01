//
//  TrailerViewModel.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 14/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import Foundation
import WebKit

protocol TrailerViewModelProtocol: AnyObject {
    func fetchVideo(videoKey: Int, media: String)
    func getTrailer(videoCode: String, webView: WKWebView)
}

protocol TrailerViewModelDelegate: AnyObject {
    func successTrailer()
    func errorTrailer()
}

class TrailerViewModel: TrailerViewModelProtocol {
    weak var delegate: TrailerViewModelDelegate?
    var videos: [ResultVideos] = []
    var videoCode: String?
    
    func fetchVideo(videoKey: Int, media: String) {
        let url = "https://api.themoviedb.org/3/\(media)/\(videoKey)/videos?api_key=ddf20e1d6a0147313cfd3b4ac419e373&language=en-US"
        RequestAPIMovies.loadVideos(url: url) { (videos) in
            if let videos = videos {
                self.videos += videos.results ?? []
                self.videoCode = videos.results?.first?.key
                self.delegate?.successTrailer()
//                self.getTrailer(videoCode: self.videoCode ?? "SmOUBXSVf24")
            }
        } onError: { (error) in
            self.delegate?.errorTrailer()
        }
    }
    
    func getTrailer(videoCode: String, webView: WKWebView) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoCode)") else { return }
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            webView.load(request)
        }
    }
}
