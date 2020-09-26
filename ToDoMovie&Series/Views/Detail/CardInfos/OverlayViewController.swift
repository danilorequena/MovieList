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
    var infos: ResultSeries!
    var overlayViewModel: OverlayViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupCollections()
        overlayViewModel = OverlayViewModel()
        overlayViewModel?.delegate = self
        overlayViewModel?.fetchDetailsSeries(id: infos.id!)
    }
    
    required init(infos: ResultSeries) {
        super.init(nibName: nib, bundle: Bundle(for: OverlayViewController.self))
        self.infos = infos
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabels() {
        labelTitle.text = infos.name
        labelOverview.text = infos.overview
        
        let string = NSMutableAttributedString()
        let attributes1 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.blue]
        let attributes2 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.red]
        let attributes3 = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 14), NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.black]
        
        if infos.voteAverage! > 5 {
            string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
            string.append(NSAttributedString(string: String(infos.voteAverage!), attributes: attributes1))
        } else {
            string.append(NSAttributedString(string: "Average: ", attributes: attributes3))
            string.append(NSAttributedString(string: String(infos.voteAverage!), attributes: attributes2))
        }
        labelAverage.attributedText = string
    }
    
    
    @IBAction func goToTrailerTapped(_ sender: Any) {
        let vc = TrailerViewController(videoID: infos.id!)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true, completion: nil)
    }
    
}

extension OverlayViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func setupCollections() {
        wereWatchCollectionView.dataSource = self
        wereWatchCollectionView.delegate = self
        wereWatchCollectionView.register(WereWatchCollectionViewCell.loadNib(), forCellWithReuseIdentifier: WereWatchCollectionViewCell.identifier())
        (wereWatchCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: 65, height: 55)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == wereWatchCollectionView {
            return overlayViewModel?.networks.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WereWatchCollectionViewCell.identifier(), for: indexPath) as! WereWatchCollectionViewCell
        let serie = (overlayViewModel?.networks[indexPath.item])
        cell.prepareCell(with: serie!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: overlayViewModel?.details?.homepage ?? "https://apple.com") else {
             return
        }

        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        print("toquei aqui nessa merda")
    }
}

extension OverlayViewController: OverlayViewModelDelegate {
    func successList() {
        DispatchQueue.main.async {
            self.wereWatchCollectionView.reloadData()
        }
    }
    
    func errorList() {
        
    }
    
    
}
