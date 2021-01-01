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
    var titleNavigation: String?
    var titleSeriesNav: String?
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var discoverSeries: ResultDiscoverSeries?
    var cardInfos: CardInfos?
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel()
//        viewModel?.fetchDetails(id: viewModel?.discoverMovies?.id ?? 0)
        viewModel?.setNavigation(controller: self, title: titleNavigation ?? "")
        cardInfos = CardInfos()
        loadCard()
    }
    
    func loadCard() {
        if discoverMovies != nil {
            cardInfos?.setupCardMovies(mainView: self.view, infos: discoverMovies!)
        } else if seriesPop != nil {
            cardInfos?.setupCardPop(mainView: self.view, infos: seriesPop!)
        } else if seriesOnAir != nil {
            cardInfos?.setupCardOnAir(mainView: self.view, infos: seriesOnAir!)
        } else if discoverSeries != nil {
            cardInfos?.setupCardDiscoverSeries(mainView: self.view, infos: discoverSeries!)
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
        } else if discoverMovies?.backdropPath != nil {
            if let backdropPath = discoverMovies?.backdropPath {
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if seriesOnAir?.backdropPath != nil {
            if let backdropPath = seriesOnAir?.backdropPath {
                guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if discoverSeries?.backdropPath != nil {
            if let backdropPath = discoverSeries?.backdropPath {
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
