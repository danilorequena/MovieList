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
    var videos: [ResultVideos] = []
    var videoKey: Int?
    var videoCode: String?
    let nib = "TrailerViewController"

    @IBOutlet weak var trailerWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideo()
    }
    
    required init(videoID: Int) {
        self.videoKey = videoID
        super.init(nibName: nib, bundle: Bundle(for: TrailerViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view != self.trailerWebView {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func fetchVideo() {
        let url = "https://api.themoviedb.org/3/tv/\(videoKey ?? 0)/videos?api_key=ddf20e1d6a0147313cfd3b4ac419e373&language=en-US"
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
