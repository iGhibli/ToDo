//
//  StyleBaseView.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/29.
//

import UIKit

enum SquareType: String {
    case dictum = "flame.fill"
    case today = "note"
    case scheduled = "calendar"
    case all = "tray.fill"
    case flagged = "flag.fill"
    case normal = "exclamationmark.triangle"
}

class SquareView: UIView {
    
    private lazy var iconBg: UIView = {
        let iconBg = UIView()
        return iconBg
    }()
    
    private lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .white
        return icon
    }()
    
    private lazy var num: UILabel = {
        let num = UILabel()
        num.font = UIFont(name: "ArialRoundedMTBold", size: 8)
        num.textColor = .white
        return num
    }()
    
    private lazy var item: UILabel = {
        let item = UILabel()
        item.font = UIFont(name: "ArialRoundedMTBold", size: 25)
        item.textColor = .black
        item.textAlignment = .right
        return item
    }()
    private lazy var content: UILabel = {
        let content = UILabel()
        content.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        content.textColor = .lightGray
        content.textAlignment = .left
        return content
    }()
    
    var squareModel = SquareModel() {
        didSet {
            
            icon.image = UIImage(systemName: squareModel.type.rawValue)
            num.isHidden = true
            item.isHidden = false
            
            switch squareModel.type {
            case .dictum:
                iconBg.backgroundColor = .red
                item.isHidden = true
                content.text = squareModel.content
            case .today:
                iconBg.backgroundColor = UIColor(red:0.20, green:0.48, blue:0.97, alpha:1.00)
                item.text = squareModel.content
                content.text = "Today"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "d"
                num.text = dateFormatter.string(from: Date())
                num.isHidden = false
            case .scheduled:
                iconBg.backgroundColor = .red
                item.text = squareModel.content
                content.text = "Scheduled"
            case .all:
                iconBg.backgroundColor = .darkGray
                item.text = squareModel.content
                content.text = "All"
            case .flagged:
                iconBg.backgroundColor = .orange
                item.text = squareModel.content
                content.text = "Flagged"
            default:
                iconBg.backgroundColor = .orange
                item.text = squareModel.content
                content.text = "Default"
            }
            
        }
    }

    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    // MARK: Subviews Setup
    func setupSubViews() {
        
        backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        
        addSubview(iconBg)
        addSubview(item)
        addSubview(content)
        iconBg.addSubview(icon)
        iconBg.addSubview(num)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        iconBg.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(12)
            make.width.height.equalTo(32)
        }
        
        item.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(icon)
            make.right.equalTo(self).offset(-15)
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.left.right.equalTo(self).offset(12)
            make.bottom.equalTo(self)
        }
        
        icon.snp.makeConstraints { (make) in
            make.center.equalTo(iconBg)
            make.width.height.equalTo(20)
        }
        
        num.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconBg)
            make.centerY.equalTo(iconBg).offset(1)
        }
        
        iconBg.layer.masksToBounds = true
        iconBg.layer.cornerRadius = 32/2
    }
}
