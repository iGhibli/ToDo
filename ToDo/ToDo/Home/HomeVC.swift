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

    @IBOutlet weak var table: UITableView!
    
    static let ScreenW = UIScreen.main.bounds.width
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var squareItems = [SquareModel]()
    
    lazy var items = [ListsModel]()
    lazy var lists = [List]()
    
    lazy var table1: UITableView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
        title = "Reminder"
        
//        let mySearchController: UISearchController = UISearchController(searchResultsController: UIViewController())
//        navigationItem.searchController = mySearchController
        
        table.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        table.register(ListsCell.nib, forCellReuseIdentifier: ListsCell.reuseIdentifier)

        for item in 0...7 {
            var model: ListsModel = ListsModel()
            model.icon = "list.bullet"
            model.title = "Test\(item)"
            model.count = item
            items.append(model)
        }
        
        let documentPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        Logger.info("documentDirectory: \(documentPath1)")
        do {
            lists = try context.fetch(List.fetchRequest())
            Logger.success("CoreData Fecth Success: \(lists)")
            table.reloadData()
        } catch {
            Logger.error("CoreData Fecth Error: \(error)")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidChange(notification:)), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: context)
        NotificationCenter.default.addObserver(self, selector: #selector(dataWillSave(notification:)), name: NSNotification.Name.NSManagedObjectContextWillSave, object: context)
        NotificationCenter.default.addObserver(self, selector: #selector(dataDidSave(notification:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: context)
    }
    
    @objc func dataDidChange(notification: Notification) {
        do {
            lists = try context.fetch(List.fetchRequest())
            Logger.success("CoreData Fetch Success: \(lists)")
            table.reloadData()
        } catch {
            Logger.error("CoreData Fetch Error: \(error)")
        }
    }
    
    @objc func dataWillSave(notification: Notification) {
        Logger.info("dataWillSave: \(notification)")
    }
    
    @objc func dataDidSave(notification: Notification) {
        Logger.info("dataDidSave: \(notification)")
    }
    
    
    @IBAction func newReminder(_ sender: UIBarButtonItem) {
        let newListVC: NewListVC = NewListVC()
        let newNaviC: UINavigationController = UINavigationController(rootViewController: newListVC)
        
        self.present(newNaviC, animated: true)
    }
    
    
}

// MARK: - @protocol UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListsCell.reuseIdentifier, for: indexPath) as! ListsCell        
        let list: List = lists[indexPath.row]

        var model: ListsModel = ListsModel()
        model.icon = list.icon!
        model.color = list.color!
        model.title = list.title!
        model.count = Int(list.count!)!
        
        cell.listsModel = model
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
        headerView?.setContent(dictum: "哈哈哈啊啊哈哈哈", today: 1, scheduled: 2, all: 6, flagged: 3)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 8.0
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        let layer: CAShapeLayer = CAShapeLayer()
        let pathRef: CGMutablePath = CGMutablePath()
        let bounds: CGRect = cell.bounds.insetBy(dx:0, dy:0)
        var addLine: Bool = false
        
        if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
            pathRef.addRoundedRect(in: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if (indexPath.row == 0) {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.midY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to:CGPoint(x: bounds.maxX, y: bounds.maxY) )
            addLine = true
        } else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section)-1) {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY), transform: CGAffineTransform())
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to:CGPoint(x: bounds.maxX, y: bounds.minY) )
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }
        
        layer.path = pathRef
        layer.fillColor = UIColor.white.cgColor
        
        if (addLine == true) {
            let lineLayer: CALayer = CALayer()
            let lineHeight: CGFloat = (1.0 / UIScreen.main.scale)
            lineLayer.frame = CGRect(x:bounds.minX + 10 , y:bounds.size.height-lineHeight, width:bounds.size.width-10, height:lineHeight)
            lineLayer.backgroundColor = tableView.separatorColor?.cgColor
            layer.addSublayer(lineLayer)
        }
        let tempCellBGView: UIView = UIView(frame: bounds)
        tempCellBGView.layer.insertSublayer(layer, at: 0)
        tempCellBGView.backgroundColor = UIColor.clear
        cell.backgroundView = tempCellBGView
    }
    
}
