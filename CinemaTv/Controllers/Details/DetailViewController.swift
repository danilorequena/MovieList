//
//  DetailSeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 03/04/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    weak var coordinator: DetailCoordinator?
    var titleNavigation: String?
    var titleSeriesNav: String?
    var seriesPop: ResultPopularSeries?
    var seriesOnAir: ResultSeriesOnAir?
    var discoverMovies: ResultDiscover?
    var discoverSeries: ResultDiscoverSeries?
    var viewModel: DetailViewModel
    private var favoriteMovies: MoviesDataModel?
    
    private var imgBackdrop = UIImageView.Factory.build(
        contentMode: .scaleAspectFill,
        accessibilityIdentifier: "imgBackdrop"
    )
    
    init(
        discoverMovies: ResultDiscover? = nil,
        seriesPop: ResultPopularSeries? = nil,
        seriesOnAir: ResultSeriesOnAir? = nil,
        discoverSeries: ResultDiscoverSeries? = nil,
        viewModel: DetailViewModel
    ) {
        self.discoverMovies = discoverMovies
        self.seriesPop = seriesPop
        self.seriesOnAir = seriesOnAir
        self.discoverSeries = discoverSeries
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBarButtonItem()
        viewModel = DetailViewModel()
        viewModel.setNavigation(controller: self, title: titleNavigation ?? "")
        viewModel.cardConfig = CardConfig(view: self.view)
        loadCard()
    }
    
    private func loadCard() {
        if discoverMovies != nil {
            viewModel.cardConfig?.setupCardMovies(infos: discoverMovies!)
        } else if seriesPop != nil {
            viewModel.cardConfig?.setupCardPop(mainView: self.view, infos: seriesPop!)
        } else if seriesOnAir != nil {
            viewModel.cardConfig?.setupCardOnAir(mainView: self.view, infos: seriesOnAir!)
        } else if discoverSeries != nil {
            viewModel.cardConfig?.setupCardDiscoverSeries(mainView: self.view, infos: discoverSeries!)
        }
        setupImage()
    }
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up.heart.fill"),
            style: .plain,
            target: self,
            action: #selector(saveSerieFavorite)
        )
    }
    
    @objc
    private func saveSerieFavorite() {
        favoriteMovies = MoviesDataModel(context: context)
        favoriteMovies?.movieName = discoverMovies?.title
        favoriteMovies?.movieImage = discoverMovies?.backdropPath
        favoriteMovies?.movieDescription = discoverMovies?.overview
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupImage() {
        if seriesPop?.backdropPath != nil {
            if let posterPath = seriesPop?.posterPath {
                guard let posterURL = URL(string: Constants.basePosters + posterPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if discoverMovies?.backdropPath != nil {
            if let posterPath = discoverMovies?.posterPath {
                guard let posterURL = URL(string: Constants.basePosters + posterPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if seriesOnAir?.backdropPath != nil {
            if let posterPath = seriesOnAir?.posterPath {
                guard let posterURL = URL(string: Constants.basePosters + posterPath) else {return}
                do {
                    let data = try Data(contentsOf: posterURL)
                    self.imgBackdrop.image = UIImage(data: data)
                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        } else if discoverSeries?.backdropPath != nil {
            if let posterPath = discoverSeries?.posterPath {
                guard let posterURL = URL(string: Constants.basePosters + posterPath) else {return}
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

extension DetailViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(imgBackdrop)
    }
    
    func setupConstraints() {
        imgBackdrop.bindFrameToSuperviewSafeBounds()
    }
}
