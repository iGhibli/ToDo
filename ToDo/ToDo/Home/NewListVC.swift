//
//  NewListVC.swift
//  ToDo
//
//  Created by iGhibli on 2020/12/3.
//

import UIKit

class NewListVC: UIViewController {

    @IBOutlet weak var selectedIconBg: UIView!
    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var inputBgView: UIView!
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var doneBtnItem: UIBarButtonItem!
    @IBOutlet weak var collection: UICollectionView!
    
    var colorSelectedIndex: Int = 0
    var iconSelectedIndex: Int = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏导航栏背景色和线条
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        doneBtnItem.isEnabled = false
        
        selectedIconBg.clipsToBounds = true
        selectedIconBg.layer.cornerRadius = 50.0
        inputBgView.clipsToBounds = true
        inputBgView.layer.cornerRadius = 8.0
        
        inputTF.becomeFirstResponder()
        inputTF.returnKeyType = .done
        
        inputTF.textColor = ListColor[colorSelectedIndex]
        selectedIconBg.backgroundColor = ListColor[colorSelectedIndex]
        selectedIcon.image = UIImage(systemName: ListIcon[iconSelectedIndex], withConfiguration: UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.bold))
        
        collection.register(NewListCVCell.self, forCellWithReuseIdentifier: NewListCVCell.reuseIdentifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(notification:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    @objc func textFieldTextDidChange(notification: Notification) {
        if let textField: UITextField = notification.object as? UITextField {
            if let strCount = textField.text?.count, strCount > 0 {
                doneBtnItem.isEnabled = true
            }else {
                doneBtnItem.isEnabled = false
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        if let strCount = inputTF.text?.count, strCount > 0 {
            let alertC: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alertC.addAction(UIAlertAction(title: "Discard Changes", style: .destructive, handler: { (alertAction) in
                self.navigationController?.dismiss(animated: true, completion: nil)
            }))
            alertC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertC, animated: true, completion: nil)
        }else {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        inputTF.resignFirstResponder()

        let newList = List(context: context)
        newList.title = inputTF.text ?? ""
        newList.count = "0"
        newList.icon = ListIcon[iconSelectedIndex]
        newList.color = ListColorStr[colorSelectedIndex]
        
        do {
            try context.save()
            Logger.success("CoreData Save successed!")
        } catch {
            Logger.error("CoreData Save Error: \(error)")
        }
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension NewListVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == inputTF {
            let strCount: Int  = textField.text?.count ?? 0
            if strCount >= 10, string.count > 0 {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let strCount: Int  = textField.text?.count ?? 0
        if strCount > 0 {
            textField.resignFirstResponder()
            return true
        }else {
            return false
        }
    }
}

// MARK: - UICollectionView
extension NewListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return min(ListColorStr.count, ListColor.count)
        }else {
            return ListIcon.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewListCVCell.reuseIdentifier, for: indexPath) as! NewListCVCell
        if indexPath.section == 0 {
            cell.cellType = .color(ListColor[indexPath.item])
            cell.cellIsSelect = indexPath.item == colorSelectedIndex
        }else {
            cell.cellType = .icon(ListIcon[indexPath.item])
            cell.cellIsSelect = indexPath.item == iconSelectedIndex
        }
        return cell
    }
}

extension NewListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 点击事件
        if indexPath.section == 0, indexPath.item != colorSelectedIndex {
            let oldSelectCell: NewListCVCell = collectionView.cellForItem(at: IndexPath(item: colorSelectedIndex, section: 0)) as! NewListCVCell
            oldSelectCell.cellIsSelect = false
            colorSelectedIndex = indexPath.item
            inputTF.textColor = ListColor[colorSelectedIndex]
            selectedIconBg.backgroundColor = ListColor[colorSelectedIndex]
            let newSelectCell: NewListCVCell = collectionView.cellForItem(at: indexPath) as! NewListCVCell
            newSelectCell.cellIsSelect = true
        }else if indexPath.section == 1, indexPath.item != iconSelectedIndex {
            let oldSelectCell: NewListCVCell = collectionView.cellForItem(at: IndexPath(item: iconSelectedIndex, section: 1)) as! NewListCVCell
            oldSelectCell.cellIsSelect = false
            iconSelectedIndex = indexPath.item
            selectedIcon.image = UIImage(systemName: ListIcon[iconSelectedIndex], withConfiguration: UIImage.SymbolConfiguration.init(weight: UIImage.SymbolWeight.bold))
            let newSelectCell: NewListCVCell = collectionView.cellForItem(at: indexPath) as! NewListCVCell
            newSelectCell.cellIsSelect = true
        }else {
            
        }
    }
}
