//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

final class DiscoverSeriesHomeViewController: UIViewController, Storyboaded {
    var mainViewModel: SeriesViewModel!
    var favoriteMovies: MoviesDataModel!
    var dataSource: DiscoverSeriesHomeManager?
    
    var label: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var onAirCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando Séries..."
        configureNavbar()
        mainViewModel = SeriesViewModel()
        mainViewModel.delegate = self
        mainViewModel.fetchPopularSeries()
        mainViewModel.fetchSeriesOnAir()
        mainViewModel.fetchDiscoverSeries()
    }
    
    func saveSerieFavorite(indexPath: IndexPath) {
        let data = mainViewModel.discoverSeries[indexPath.row]
        favoriteMovies = MoviesDataModel(context: context)
        favoriteMovies?.movieName = data.name
        favoriteMovies?.movieImage = data.backdropPath
        favoriteMovies?.movieDescription = data.overview
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func configureNavbar() {
        configureNavigationBar(
            largeTitleColor: .white,
            backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1),
            tintColor: .white,
            title: "TV Shows",
            preferredLargeTitle: true
        )
    }
    
    private func configCollections() {
        setupCollectionView(series: mainViewModel.discoverSeries)
    }
}

extension DiscoverSeriesHomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollectionView(series: [ResultDiscoverSeries]) {
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.register(PopularCollectionViewCell.loadNib(), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier())
        (popularCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 200)
        popularCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        onAirCollectionView.dataSource = self
        onAirCollectionView.delegate = self
        onAirCollectionView.register(OnTheAirCollectionViewCell.loadNib(), forCellWithReuseIdentifier: OnTheAirCollectionViewCell.identifier())
        (onAirCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 150, height: 200)
        onAirCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        discoverCollectionView.delegate = self
        dataSource = DiscoverSeriesHomeManager(discoverSeries: series)
        discoverCollectionView.dataSource = dataSource
        discoverCollectionView.register(DiscoverSeriesCollectionViewCell.loadNib(), forCellWithReuseIdentifier: DiscoverSeriesCollectionViewCell.identifier())
        (discoverCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 182, height: 261)
        discoverCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case popularCollectionView:
            return mainViewModel.seriesPopular.count
        case onAirCollectionView:
            return mainViewModel.seriesOnAir.count
        default:
            return mainViewModel.discoverSeries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case popularCollectionView:
            let cellPopular = collectionView.dequeueReusableCell(
                withReuseIdentifier: PopularCollectionViewCell.identifier(),
                for: indexPath) as! PopularCollectionViewCell
            let serie = mainViewModel.seriesPopular[indexPath.item]
            cellPopular.prepareCell(with: serie)
            return cellPopular
        case onAirCollectionView:
            let cellOnAir = collectionView.dequeueReusableCell(
                withReuseIdentifier: OnTheAirCollectionViewCell.identifier(),
                for: indexPath) as! OnTheAirCollectionViewCell
            let serieOnAir = mainViewModel.seriesOnAir[indexPath.item]
            cellOnAir.prepareCell(with: serieOnAir)
            return cellOnAir
        default:
            let discoverCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiscoverSeriesCollectionViewCell.identifier(),
                for: indexPath) as! DiscoverSeriesCollectionViewCell
            let discoverSeries = mainViewModel.discoverSeries[indexPath.item]
            discoverCell.setupCell(tvShow: discoverSeries)
            return discoverCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case popularCollectionView:
            let serie = mainViewModel.seriesPopular[indexPath.item]
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailSeries(popSeries: serie)
        case onAirCollectionView:
            let serie = mainViewModel.seriesOnAir[indexPath.item]
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailSeriesOnAir(onAirSeries: serie)
        default:
            let serie = mainViewModel.discoverSeries[indexPath.item]
            let coordinator = MainCoordinator(navigationController: self.navigationController!)
            coordinator.detailDiscoverSeries(discoverSeries: serie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case popularCollectionView:
            if indexPath.item == (mainViewModel.seriesPopular.count ) - 10 {
                mainViewModel.popularPage += 1
                mainViewModel.fetchPopularSeries()
            }
        case onAirCollectionView:
            if indexPath.item == (mainViewModel.seriesOnAir.count ) - 10 {
                mainViewModel.seriesOnAirPage += 1
                mainViewModel.fetchSeriesOnAir()
            }
        default:
            if indexPath.item == (mainViewModel.discoverSeries.count ) - 10 {
                mainViewModel.discoverPage += 1
                mainViewModel.fetchDiscoverSeries()
            }
        }
    }
}

extension DiscoverSeriesHomeViewController: MainViewModelDelegate {
    func successDiscoverSeries() {
        DispatchQueue.main.async {
            //TODO: - implementar direito
            self.configCollections()
            self.discoverCollectionView.reloadData()
        }
    }
    
    func successListOnAir() {
        DispatchQueue.main.async {
            //TODO: - implementar direito
            self.configCollections()
            self.onAirCollectionView.reloadData()
        }
    }
    
    func successListPopular() {
        DispatchQueue.main.async {
            //TODO: - implementar direito
            self.configCollections()
            self.popularCollectionView.reloadData()
        }
    }
    func errorList() {
        DispatchQueue.main.async {
            self.label.text = "Não existem filmes"
            self.onAirCollectionView.reloadData()
            self.popularCollectionView.reloadData()
        }
    }
}
