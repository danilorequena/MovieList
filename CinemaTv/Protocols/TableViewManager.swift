//
//  TableViewManager.swift
//  CinemaTv
//
//  Created by Danilo Requena on 27/03/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//
import UIKit

protocol TableViewCellRegister: AnyObject {
    func registerCells(for tableView: UITableView)
}

typealias TableViewManager = TableViewCellRegister & UITableViewDataSource & UITableViewDelegate

