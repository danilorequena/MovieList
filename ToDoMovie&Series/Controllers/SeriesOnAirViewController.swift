//
//  SeriesOnAirViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class SeriesOnAirViewController: UIViewController {

    @IBOutlet weak var ivSeriesOnAir: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var viewContainerMessage: UIView!
    @IBOutlet weak var scrollOverview: UIScrollView!
    
    let seriesOnAirViewController = "SeriesOnAirViewController"
    var series: ResultSeriesOnAir
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: #colorLiteral(red: 0.1628865302, green: 0.1749416888, blue: 0.1923300922, alpha: 1), tintColor: .white, title: "Series OnAir", preferredLargeTitle: true)
        setupOverview()
        setupImage()
    }
    
    required init(series: ResultSeriesOnAir) {
        self.series = series
        super.init(nibName: seriesOnAirViewController, bundle: Bundle(for: SeriesOnAirViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupOverview() {
        lbTitle.text = series.name
        lbMessage.text = series.overview
        lbMessage.textColor = .white
        viewContainerMessage.clipsToBounds = true
        let path = UIBezierPath(roundedRect: viewContainerMessage.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        viewContainerMessage.layer.mask = maskLayer
        viewContainerMessage.backgroundColor = #colorLiteral(red: 0.0341934419, green: 0.04082306338, blue: 0.06327024648, alpha: 0.5)
    }
    
    func setupImage() {
        if let posterPath = series.posterPath {
            guard let posterURL = URL(string: "https://image.tmdb.org/t/p/original/" + posterPath) else {return}
            do {
                let data = try Data(contentsOf: posterURL)
                self.ivSeriesOnAir.image = UIImage(data: data)
            } catch let jsonErr {
                print(jsonErr)
            }
        }
    }
    
    @IBAction func goToTrailer(_ sender: Any) {
        let vc = TrailerViewController(videoID: series.id ?? 30)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
