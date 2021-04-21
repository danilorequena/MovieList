//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, Storyboaded {

    @IBOutlet weak var imgBackdrop: UIImageView!
    
    weak var coordinator: DetailCoordinator?
    var titleNavigation: String?
    var titleSeriesNav: String?
    var seriesPop: ResultPopularSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var discoverSeries: ResultDiscoverSeries?
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel()
//        viewModel?.fetchDetails(id: viewModel?.discoverMovies?.id ?? 0)
        viewModel?.setNavigation(controller: self, title: titleNavigation ?? "")
        viewModel?.cardConfig = CardConfig(view: self.view)
        loadCard()
    }
    
    private func loadCard() {
        if discoverMovies != nil {
            viewModel?.cardConfig?.setupCardMovies(infos: discoverMovies!)
        } else if seriesPop != nil {
            viewModel?.cardConfig?.setupCardPop(mainView: self.view, infos: seriesPop!)
        } else if seriesOnAir != nil {
            viewModel?.cardConfig?.setupCardOnAir(mainView: self.view, infos: seriesOnAir!)
        } else if discoverSeries != nil {
            viewModel?.cardConfig?.setupCardDiscoverSeries(mainView: self.view, infos: discoverSeries!)
        }
        setupImage()
    }
    
    private func setupImage() {
        if seriesPop?.backdropPath != nil {
            if let backdropPath = seriesPop?.backdropPath {
                guard let posterURL = URL(string: Constants.basePosters + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if discoverMovies?.backdropPath != nil {
            if let backdropPath = discoverMovies?.backdropPath {
                guard let posterURL = URL(string: Constants.basePosters + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if seriesOnAir?.backdropPath != nil {
            if let backdropPath = seriesOnAir?.backdropPath {
                guard let posterURL = URL(string: Constants.basePosters + backdropPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if discoverSeries?.backdropPath != nil {
            if let backdropPath = discoverSeries?.backdropPath {
                guard let posterURL = URL(string: Constants.basePosters + backdropPath) else {return}
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
