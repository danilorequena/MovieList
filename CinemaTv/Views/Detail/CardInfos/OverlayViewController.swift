//
//  OverlayViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 20/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit
import SafariServices

class OverlayViewController: UIViewController {

    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var networksCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    private let nib = "OverlayViewController"
    private var seriesPop: ResultPopularSeries?
    private var seriesOnAir: ResultSeriesOnAir!
    private var discoverMovies: ResultDiscover!
    private var discoverSeries: ResultDiscoverSeries!
    private var overlayViewModel: OverlayViewModel?
    
    private var castManager: CastManager?
    private var networksManager: ProvidersManager?
    
    required init(
        seriesPop: ResultPopularSeries? = nil,
        seriesOnAir: ResultSeriesOnAir? = nil,
        discoverMovies: ResultDiscover? = nil,
        discoverSeries: ResultDiscoverSeries? = nil,
        overlayViewModel: OverlayViewModel
    ) {
        super.init(nibName: nib, bundle: Bundle(for: OverlayViewController.self))
        self.seriesPop = seriesPop
        self.seriesOnAir = seriesOnAir
        self.discoverMovies = discoverMovies
        self.discoverSeries = discoverSeries
        self.overlayViewModel = overlayViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        overlayViewModel = OverlayViewModel()
        overlayViewModel?.delegate = self
        if discoverMovies != nil {
            overlayViewModel?.fetchCastMovies(id: discoverMovies.id ?? 0)
            overlayViewModel?.fetchWatchProviders(id: discoverMovies.id ?? 0)
        } else if seriesPop != nil {
            overlayViewModel?.fetchSeriesCast(id: seriesPop?.id ?? 0)
            overlayViewModel?.fetchWatchProviders(id: seriesPop?.id ?? 0)
        } else if seriesOnAir != nil {
            overlayViewModel?.fetchSeriesCast(id: seriesOnAir.id ?? 0)
            overlayViewModel?.fetchWatchProviders(id: seriesOnAir.id ?? 0)
        } else if discoverSeries != nil {
            overlayViewModel?.fetchSeriesCast(id: discoverSeries?.id ?? 0)
            overlayViewModel?.fetchWatchProviders(id: discoverSeries?.id ?? 0)
        }
        setupCollections()
    }
    
    func setupLabels() {
        if seriesPop != nil {
            labelTitle.text = seriesPop?.name
            labelOverview.text = seriesPop?.overview
            
            let string = NSMutableAttributedString()
            let attributes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.blue]
            let attributes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red]
            let attributes3 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
            
            if seriesPop?.voteAverage ?? 0.0 > 5 {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(seriesPop?.voteAverage ?? 0.0), attributes: attributes1))
            } else {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(seriesPop?.voteAverage ?? 0.0), attributes: attributes2))
            }
            labelAverage.attributedText = string
        } else if discoverMovies != nil {
            labelTitle.text = discoverMovies.title
            labelOverview.text = discoverMovies.overview
            
            let string = NSMutableAttributedString()
            let attributes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.blue]
            let attributes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red]
            let attributes3 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
            
            if discoverMovies.voteAverage! > 5 {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(discoverMovies.voteAverage!), attributes: attributes1))
            } else {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(discoverMovies.voteAverage!), attributes: attributes2))
            }
            labelAverage.attributedText = string
            
        } else if seriesOnAir != nil {
            labelTitle.text = seriesOnAir.name
            labelOverview.text = seriesOnAir.overview
            
            let string = NSMutableAttributedString()
            let attributes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.blue]
            let attributes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red]
            let attributes3 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
            
            if seriesOnAir.voteAverage! > 5 {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(seriesOnAir.voteAverage!), attributes: attributes1))
            } else {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(seriesOnAir.voteAverage!), attributes: attributes2))
            }
            labelAverage.attributedText = string
            
        } else if discoverSeries != nil {
            labelTitle.text = discoverSeries?.name
            labelOverview.text = discoverSeries?.overview
            
            let string = NSMutableAttributedString()
            let attributes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.blue]
            let attributes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red]
            let attributes3 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
            
            if discoverSeries.voteAverage! > 5 {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(discoverSeries.voteAverage!), attributes: attributes1))
            } else {
                string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
                string.append(NSAttributedString(string: String(discoverSeries.voteAverage!), attributes: attributes2))
            }
            labelAverage.attributedText = string
        }
    }
    
    private func setupCollections() {
        networksManager = ProvidersManager(viewModel: overlayViewModel!)
        networksCollectionView.dataSource = networksManager
        networksCollectionView.delegate = networksManager
        
        castManager = CastManager(viewModel: overlayViewModel!)
        castCollectionView.delegate = castManager
        castCollectionView.dataSource = castManager
        (castCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 65, height: 75)
    }
    
    @IBAction func goToTrailerTapped(_ sender: Any) {
        if seriesPop != nil {
            let vc = TrailerViewController(videoID: seriesPop?.id ?? 0, media: "tv")
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        } else if discoverMovies != nil {
            let vc = TrailerViewController(videoID: discoverMovies?.id ?? 0, media: "movie")
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        } else if seriesOnAir != nil {
            let vc = TrailerViewController(videoID: seriesOnAir?.id ?? 0, media: "tv")
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true, completion: nil)
        }
    }
}

extension OverlayViewController: OverlayViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.networksCollectionView.reloadData()
            self.castCollectionView.reloadData()
        }
    }
    
    func errorList() {
        DispatchQueue.main.async {
            self.networksCollectionView.reloadData()
            self.castCollectionView.reloadData()
        }
    }
}
