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
    var videoKey: Int?
    var media: String?
    let nib = "TrailerViewController"
    var viewmodel: TrailerViewModel?

    @IBOutlet weak var trailerWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = TrailerViewModel()
        viewmodel?.fetchVideo(videoKey: videoKey ?? 0, media: media ?? String())
        viewmodel?.delegate = self
    }
    
    required init(videoID: Int, media: String) {
        self.videoKey = videoID
        self.media = media
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
}

extension TrailerViewController: TrailerViewModelDelegate {
    func successTrailer() {
        viewmodel?.getTrailer(videoCode: viewmodel?.videoCode ?? "SmOUBXSVf24", webView: trailerWebView)
    }
    func errorTrailer() {
        
    }
}
