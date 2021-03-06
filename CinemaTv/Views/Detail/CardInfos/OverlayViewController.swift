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
    @IBOutlet weak var wereWatchCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    let nib = "OverlayViewController"
    var seriesPop: ResultSeries?
    var seriesOnAir: ResultSeriesOnAir!
    var discoverMovies: ResultDiscover!
    var discoverSeries: ResultDiscoverSeries!
    var overlayViewModel: OverlayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupCollections()
        overlayViewModel = OverlayViewModel()
        overlayViewModel?.delegate = self
        overlayViewModel?.fetchDetailsSeries(id: seriesPop?.id ?? 0)
        if discoverMovies != nil {
            overlayViewModel?.fetchCastMovies(id: discoverMovies.id ?? 0)
        } else if seriesPop != nil {
            overlayViewModel?.fetchSeriesCast(id: seriesPop?.id ?? 0)
        } else if seriesOnAir != nil {
            overlayViewModel?.fetchSeriesCast(id: seriesOnAir.id ?? 0)
        } else if discoverSeries != nil {
            overlayViewModel?.fetchSeriesCast(id: discoverSeries?.id ?? 0)
        }
    }
    
    required init(seriesPop: ResultSeries? = nil,
                  seriesOnAir: ResultSeriesOnAir? = nil,
                  discoverMovies: ResultDiscover? = nil,
                  discoverSeries: ResultDiscoverSeries? = nil ) {
        super.init(nibName: nib, bundle: Bundle(for: OverlayViewController.self))
        self.seriesPop = seriesPop
        self.seriesOnAir = seriesOnAir
        self.discoverMovies = discoverMovies
        self.discoverSeries = discoverSeries
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

extension OverlayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollections() {
        wereWatchCollectionView.dataSource = self
        wereWatchCollectionView.delegate = self
        wereWatchCollectionView.register(WereWatchCollectionViewCell.loadNib(), forCellWithReuseIdentifier: WereWatchCollectionViewCell.identifier())
        (wereWatchCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 65, height: 55)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCollectionViewCell.loadNib(), forCellWithReuseIdentifier: CastCollectionViewCell.identifier())
        (castCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 65, height: 75)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wereWatchCollectionView {
            return overlayViewModel?.networks.count ?? 0
        } else {
            return overlayViewModel?.cast.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == wereWatchCollectionView {
            let cellWereWatch = collectionView.dequeueReusableCell(withReuseIdentifier: WereWatchCollectionViewCell.identifier(), for: indexPath) as! WereWatchCollectionViewCell
            let serie = (overlayViewModel?.networks[indexPath.item])
            cellWereWatch.prepareCell(with: serie!)
            return cellWereWatch
        } else {
            let cellCast = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.identifier(), for: indexPath) as! CastCollectionViewCell
            let cast = (overlayViewModel?.cast[indexPath.item])
            cellCast.prepareCell(with: cast!)
            
            return cellCast
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: overlayViewModel?.details?.homepage ?? "https://apple.com") else { return }

        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension OverlayViewController: OverlayViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.wereWatchCollectionView.reloadData()
            self.castCollectionView.reloadData()
        }
    }
    
    func errorList() {
        
    }
    
    
}
