//
//  HeaderView.swift
//  ToDo
//
//  Created by iGhibli on 2020/12/1.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var dictumView: SquareView!
    @IBOutlet weak var todayView: SquareView!
    @IBOutlet weak var scheduledView: SquareView!
    @IBOutlet weak var allView: SquareView!
    @IBOutlet weak var flaggedView: SquareView!
    
    func setContent(dictum: String, today: Int, scheduled: Int, all: Int, flagged: Int) {
        dictumView.squareModel = SquareModel.init(type: .dictum, content: dictum)
        todayView.squareModel = SquareModel.init(type: .today, content: "\(today)")
        scheduledView.squareModel = SquareModel.init(type: .scheduled, content: "\(scheduled)")
        allView.squareModel = SquareModel.init(type: .all, content: "\(all)")
        flaggedView.squareModel = SquareModel.init(type: .flagged, content: "\(flagged)")
    }
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static let reuseIdentifier: String = String(describing: self)
}
