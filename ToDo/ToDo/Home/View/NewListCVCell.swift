//
//  NewListCVCell.swift
//  ToDo
//
//  Created by iGhibli on 2020/12/7.
//

import UIKit

class NewListCVCell: UICollectionViewCell {
    
    var selectBg: UIView = {
        let selectBg = UIView()
        selectBg.backgroundColor = .white
        selectBg.layer.masksToBounds = true
        selectBg.layer.cornerRadius = 25.0
        selectBg.layer.borderWidth = 3.0
        selectBg.layer.borderColor = UIColor.systemGray3.cgColor
        return selectBg
    }()
    
    var topBg: UIView = {
        let topBg = UIView()
        topBg.layer.masksToBounds = true
        topBg.layer.cornerRadius = 19.0
        return topBg
    }()
    
    var icon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .darkGray
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    var cellType: NewListCVCellType = .color(.red) {
        didSet {
            switch cellType {
            case let .color(color):
                icon.isHidden = true
                topBg.backgroundColor = color
            case let .icon(iconName):
                let image = UIImage(systemName: iconName, withConfiguration: UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.bold))
                icon.image = image
                icon.isHidden = false
                topBg.backgroundColor = .systemGray6
            }
        }
    }
    
    var cellIsSelect: Bool = false {
        didSet {
            selectBg.isHidden = !cellIsSelect
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(selectBg)
        self.addSubview(topBg)
        topBg.addSubview(icon)
        selectBg.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        selectBg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        topBg.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(38)
        }
        
        icon.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("💥💥💥init(coder:) has not been implemented💥💥💥")
    }
    
    static let reuseIdentifier: String = String(describing: self)
}

enum NewListCVCellType {
    case color(UIColor)
    case icon(String)
}
