//
//  OverlayViewController.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 20/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    
    let nib = "OverlayViewController"
    var infos: ResultSeries!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()

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
    
}
