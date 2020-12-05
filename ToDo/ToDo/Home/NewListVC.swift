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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏导航栏背景色和线条
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationItem.leftBarButtonItem?.target = self
//        navigationController?.navigationItem.leftBarButtonItem?.action = Selector("cancelAction")
        
        selectedIconBg.clipsToBounds = true
        selectedIconBg.layer.cornerRadius = 50.0
        inputBgView.clipsToBounds = true
        inputBgView.layer.cornerRadius = 8.0
        
        inputTF.becomeFirstResponder()
//        inputTF.textColor = .red
        inputTF.returnKeyType = .done
    }
    
    // MARK: - Actions
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        if let strCount = inputTF.text?.count, strCount > 0 {
            let alertC: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alertC.addAction(UIAlertAction(title: "Discard Changes", style: .default, handler: { (alertAction) in
                self.navigationController?.dismiss(animated: true, completion: nil)
            }))
        }
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        inputTF.resignFirstResponder()
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDelegate.persistentContainer.viewContext
        let newList = List(context: context)
        newList.title = inputTF.text ?? ""
        newList.count = "10"
        newList.icon = "iconTest"
        newList.color = "red"
        
        do {
            try context.save()
            print("Save successed!")
        } catch {
            print("Save Error: ", error)
        }
        
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
}

extension NewListVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let strCount: Int  = textField.text?.count ?? 0
        if textField == inputTF {
            if strCount >= 10 {
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
