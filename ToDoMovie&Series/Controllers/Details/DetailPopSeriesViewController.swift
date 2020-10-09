//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DetailPopSeriesViewController: UIViewController {

    @IBOutlet weak var ivSerie: UIImageView!
    
    let vcDetailSeriesViewController = "DatailSeriesViewController"
    var series: ResultSeries
    var createdBy: [CreatedBy] = []
    var genre: [Genre] = []
    var networks: [Network] = []
    var season: [Season] = []
    var cardInfos: CardInfos?
    var cardViewController: OverlayViewController!
    var visualEffectView: UIVisualEffectView!
    var endCardHeight: CGFloat = 0
    var startCardHeight: CGFloat = 0
    var cardVisible = false
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Pop Series", preferredLargeTitle: true)
        setupImage()
        fetchDetailsSeries()
        cardInfos = CardInfos()
        cardInfos?.setupCard(mainView: self.view, infos: series)
    }
    
    required init(series: ResultSeries) {
        self.series = series
        super.init(nibName: vcDetailSeriesViewController, bundle: Bundle(for: DetailPopSeriesViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchDetailsSeries() {
        RequestAPI.loadPopularSeriesDetails(id: series.id!) { (series) in
            self.createdBy += series?.createdBy ?? []
            self.genre += series?.genres ?? []
            self.networks += series?.networks ?? []
            self.season += series?.seasons ?? []
        } onError: { (error) in
            print(error)
        }

    }
    
    func setupImage() {
        if let backdropPath = series.backdropPath {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
            do {
                let data = try Data(contentsOf: posterURL)
                self.ivSerie.image = UIImage(data: data)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
}
