//
//  DictumCell.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/29.
//

import UIKit

class DictumCell: UITableViewCell {
    @IBOutlet weak var item: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var iconBg: UIView!
    @IBOutlet weak var bg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.clear
        self.bg.layer.masksToBounds = true
        self.bg.layer.cornerRadius = 8
        self.iconBg.layer.masksToBounds = true
        self.iconBg.layer.cornerRadius = self.iconBg.bounds.size.width / 2
    }
    
    func setCellContent() {
        self.item.text = "100"
        self.content.text = "已绑定邮箱成功的账号，浮标中显示未绑定，此时在浮标中通过邮箱修改密码成功，然后返回登入界面，在登入界面再修改一次密码，返回登入界面，会自动生成一个不符合账号规则的账号，实际也无法登入游戏"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
