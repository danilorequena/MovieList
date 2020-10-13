//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DetailPopSeriesViewController: UIViewController, Storyboaded {

    @IBOutlet weak var ivSerie: UIImageView!
    
    let vcDetailSeriesViewController = "DatailSeriesViewController"
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var cardInfos: CardInfos?
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Pop Series", preferredLargeTitle: true)
        setupImage()
        viewModel = DetailViewModel()
        viewModel?.fetchDetailsSeries(id: viewModel?.seriesPop?.id ?? 0)
        cardInfos = CardInfos()
        cardInfos?.setupCardMovies(mainView: self.view, infos: discoverMovies!)
    }
    
    required init(seriesPop: ResultSeries? = nil, seriesOnAir: ResultSeriesOnAir? = nil, discoverMovies: ResultDiscover? = nil ) {
        self.seriesPop = seriesPop
        self.seriesOnAir = seriesOnAir
        self.discoverMovies = discoverMovies
        super.init(nibName: vcDetailSeriesViewController, bundle: Bundle(for: DetailPopSeriesViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        if seriesPop?.backdropPath != nil {
            if let backdropPath = viewModel?.seriesPop?.backdropPath {
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.ivSerie.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else {
            if let backdropPath = discoverMovies?.backdropPath {
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
}
