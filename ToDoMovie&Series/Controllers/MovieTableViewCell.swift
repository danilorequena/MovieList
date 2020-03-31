//
//  MovieTableViewCell.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 30/03/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var lbReleaseDate: UILabel!
    
    //MARK: - Super Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func showCustomCell() {
//        let nib = UINib(nibName: "CustomCell", bundle: nil)
//        
//    }
    
    func prepareCell(with movie: Result) {
        lbTitleMovie.text = movie.title
        lbReleaseDate.text = movie.releaseDate
    }
    
}
