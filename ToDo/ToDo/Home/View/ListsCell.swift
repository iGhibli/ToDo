//
//  ListsCell.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/30.
//

import UIKit

class ListsCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var iconBg: UIView!
    
    var listsModel = ListsModel() {
        didSet {
            icon.image = UIImage(systemName: listsModel.icon)
            item.text = listsModel.title
            count.text = "\(listsModel.count)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconBg.layer.masksToBounds = true
        iconBg.layer.cornerRadius = iconBg.bounds.size.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static let reuseIdentifier: String = String(describing: self)
}
