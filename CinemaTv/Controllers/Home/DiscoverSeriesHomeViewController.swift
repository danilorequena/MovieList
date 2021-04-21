//
//  SeriesViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 27/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import JGProgressHUD

final class DiscoverSeriesHomeViewController: UIViewController, Storyboaded {
    var mainViewModel: SeriesViewModel?
    var favoriteMovies: MoviesDataModel?
    var discoverManager: DiscoverSeriesHomeManager?
    var onAirSeriesManager: OnAirSeriesManager?
    var popularSeriesManager: PopularSeriesManager?
    private let hud = JGProgressHUD()
    
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
        mainViewModel?.delegate = self
        mainViewModel?.fetchPopularSeries()
        mainViewModel?.fetchSeriesOnAir()
        mainViewModel?.fetchDiscoverSeries()
    }
    
    func saveSerieFavorite(indexPath: IndexPath) {
        guard let viewModel = mainViewModel else { return }
        let data = viewModel.discoverSeries[indexPath.row]
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
        guard let viewModel = mainViewModel else { return }
        guard let navigation = self.navigationController else { return }
        popularSeriesManager = PopularSeriesManager(
            popularSeries: viewModel.seriesPopular,
            navigationController: navigation,
            viewModel: viewModel
        )
        popularCollectionView.dataSource = popularSeriesManager
        popularCollectionView.delegate = popularSeriesManager
        popularCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        onAirSeriesManager = OnAirSeriesManager(
            onAirSeries: viewModel.seriesOnAir,
            navigationController: navigation,
            viewModel: viewModel
        )
        onAirCollectionView.dataSource = onAirSeriesManager
        onAirCollectionView.delegate = onAirSeriesManager
        onAirCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
        
        discoverManager = DiscoverSeriesHomeManager(
            discoverSeries: viewModel.discoverSeries,
            navigationController: navigation,
            viewModel: viewModel
        )
        discoverCollectionView.delegate = discoverManager
        discoverCollectionView.dataSource = discoverManager
        discoverCollectionView.backgroundColor = #colorLiteral(red: 0.2557122409, green: 0.2745354176, blue: 0.3005027473, alpha: 1)
    }
    
    private func showSimpleHUD() {
        DispatchQueue.main.async {
            self.hud.vibrancyEnabled = true
            self.hud.textLabel.text = "Loading..."
            self.hud.detailTextLabel.text = ""
            self.hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
            self.hud.show(in: self.view)
        }
    }
}

extension DiscoverSeriesHomeViewController: MainViewModelDelegate {
    func successList() {
        self.showSimpleHUD()
        DispatchQueue.main.async {
            self.configCollections()
            self.discoverCollectionView.reloadData()
            self.onAirCollectionView.reloadData()
            self.popularCollectionView.reloadData()
            self.hud.dismiss()
        }
    }

    func errorList() {
        self.present(ErrorViewController(), animated: true, completion: nil)
    }
}
