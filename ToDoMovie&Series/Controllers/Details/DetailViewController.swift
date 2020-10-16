//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboaded {

    @IBOutlet weak var imgBackdrop: UIImageView!
    
    weak var coordinator: DetailCoordinator?
    
    let vcDetailSeriesViewController = "DatailSeriesViewController"
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var cardInfos: CardInfos?
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Pop Series", preferredLargeTitle: true)
        viewModel = DetailViewModel()
        viewModel?.fetchDetails(id: viewModel?.discoverMovies?.id ?? 0)
        cardInfos = CardInfos()
        loadCard()
    }
    
    func loadCard() {
        if discoverMovies != nil {
            cardInfos?.setupCardMovies(mainView: self.view, infos: discoverMovies!)
        } else if seriesPop != nil {
            cardInfos?.setupCardPop(mainView: self.view, infos: seriesPop!)
        } else {
            cardInfos?.setupCardOnAir(mainView: self.view, infos: seriesOnAir!)
        }
        setupImage()
    }
    
    func setupImage() {
        if seriesPop?.backdropPath != nil {
            if let backdropPath = seriesPop?.backdropPath {
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else {
            if let backdropPath = discoverMovies?.backdropPath {
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }
    }
}
