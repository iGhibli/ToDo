//
//  NewListCVLayout.swift
//  ToDo
//
//  Created by iGhibli on 2020/12/8.
//

import UIKit

class NewListCVLayout: UICollectionViewFlowLayout {
    var itemW: CGFloat = (UIScreen.main.bounds.width - 30.0) / 6.0
    var itemH: CGFloat { itemW }
    
    override init() {
        super.init()
        // 设置每一个item大小
        self.itemSize = CGSize(width: itemW, height: itemH)
        // 设置滚动方向
        self.scrollDirection = .vertical
        // 设置item左右间距
        self.minimumLineSpacing = 0
        // 设置item上下间距
        self.minimumInteritemSpacing = 0
    }
    
    override func prepare() {
        // 苹果推荐对一些布局的准备操作放在这里
        self.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // 设置每一个item大小
        self.itemSize = CGSize(width: itemW, height: itemH)
        // 设置滚动方向
        self.scrollDirection = .vertical
        // 设置item左右间距
        self.minimumLineSpacing = 0
        // 设置item上下间距
        self.minimumInteritemSpacing = 0
//        fatalError("💥💥💥init(coder:) has not been implemented💥💥💥")
    }
    
}
