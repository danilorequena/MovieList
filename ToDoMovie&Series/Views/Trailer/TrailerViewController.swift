//
//  TrailerViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 12/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var trailerWebView: WKWebView!
    var videos: [ResultVideos] = []
    var videoKey: ResultSeriesOnAir?
    var videoCode: String?
    let nib = "TrailerViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideo()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        getTrailer(videoCode: videoCode ?? "SmOUBXSVf24")
//    }
    
    required init(series: ResultSeriesOnAir) {
        self.videoKey = series
        super.init(nibName: nib, bundle: Bundle(for: TrailerViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchVideo() {
        let url = "https://api.themoviedb.org/3/tv/\(videoKey?.id ?? 24)/videos?api_key=ddf20e1d6a0147313cfd3b4ac419e373&language=en-US"
        RequestAPI.loadVideos(url: url) { (videos) in
            if let videos = videos {
                self.videos += videos.results ?? []
                self.videoCode = videos.results?.first?.key
                self.getTrailer(videoCode: self.videoCode ?? "SmOUBXSVf24")
            }
        } onError: { (error) in
            print(error)
        }

    }
    
    func getTrailer(videoCode: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoCode)") else { return }
        let request = URLRequest(url: url)
        DispatchQueue.main.async {
            self.trailerWebView.load(request)
        }
    }
}
