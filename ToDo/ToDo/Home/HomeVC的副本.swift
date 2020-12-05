//
//  HomeVC.swift
//  ToDo
//
//  Created by iGhibli on 2020/11/29.
//

import UIKit
import SnapKit
import CoreData

class HomeVC: UIViewController {

    static let ScreenW = UIScreen.main.bounds.width
    
    lazy var squareItems = [SquareModel]()
    
    lazy var items = [ListsModel]()
    lazy var table: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.00)
        table.separatorStyle = .none
        table.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        table.register(ListsCell.nib, forCellReuseIdentifier: ListsCell.reuseIdentifier)
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        table.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.96, alpha:1.00)
        
        let documentPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        print("documentDirectory: ", documentPath1)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        for item in 0...7 {
            var model: ListsModel = ListsModel()
            model.icon = "list.bullet"
            model.title = "Test\(item)"
            model.count = item
            items.append(model)
            
            let newList = List(context: context)
            newList.title = "Test\(item)"
            newList.count = Int16(item)
            newList.icon = "icon"
            newList.color = "color"
            
            do {
                try context.save()
            } catch  {
                print("Error: %@", error)
            }
        }
        
        do {
            var lists = try context.fetch(List.fetchRequest())
            
            print("--- ", lists)
        } catch {
            print("Error: ", error)
        }
        

        setUpSubViews()
        
    }
    
    func setUpSubViews() {
        view.addSubview(table)
        table.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(view)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
        }
    }
    
    

}

// MARK: - @protocol UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "My Lists"
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsCell.reuseIdentifier, for: indexPath) as! ListsCell
        cell.listsModel = items[indexPath.row]
        return cell
    }

    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    optional func numberOfSections(in tableView: UITableView) -> Int
    optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    optional func sectionIndexTitles(for tableView: UITableView) -> [String]?
    optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    */
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Self.ScreenW * 450*2 / 750
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.reuseIdentifier) as? HeaderView
        headerView?.setContent(dictum: "哈哈哈啊啊哈哈哈",
                               today: 1, scheduled: 2, all: 6, flagged: 3)
        return headerView
    }
    
}

/*
 @available(iOS 2.0, *)
 optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
 */
