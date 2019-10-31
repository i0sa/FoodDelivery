//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Osama on 10/24/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: CustomTabBar!
    
    lazy var viewModel: ViewControllerViewModel = {
       return ViewControllerViewModel()
    }()
    
    public enum HomeSections: CaseIterable {
        case topItems
        case restData
    }

    
    func displayError(_ text: String){
        let alert = UIAlertController(title: text, message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "done", style: .default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        tabBar.delegate = self
        configure()
        if(traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: tableView)
        }

        // Do any additional setup after loading the view.
    }
    
    func configure(){
        viewModel.displayError = { [weak self] title in
            self?.displayError(title)
        }
        viewModel.didGetData = { [weak self] in
            self?.tableView.reloadData()
            if let cell = self?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RestTypesCell{
                cell.collectionView.reloadData()
            }

        }
        viewModel.didGetResturantsData = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integersIn: 1...1), with: .left)
        }
        
        viewModel.showLoading = { [weak self] in
            self?.view.makeToastActivity(.center)
        }
        
        viewModel.hideLoading = { [weak self] in
            self?.view.hideToastActivity()
        }
        
    }
    
    func registerCells(){
        tableView.registerHeaderNib(cellClass: CityHeaderCell.self)
        tableView.registerCellNib(cellClass: RestTypesCell.self)
        
        tableView.registerHeaderNib(cellClass: ResturantsHeaderCell.self)
        tableView.registerCellNib(cellClass: ResturantCell.self)
    }
    
    
    func didSelectItem(_ item: CircleModel){
//        getResturantData(for: item)
        viewModel.didSelectResturant(item)
    }

    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let header = tableView.headerView(forSection: 0) {
            let headerOffset = tableView.rectForRow(at: IndexPath(row: 0, section: 0))
            let mySecondOffset = headerOffset.origin.y
            let offset = 1 - (scrollView.contentOffset.y / mySecondOffset)
            header.alpha = offset
        }
        
        if let header = tableView.headerView(forSection: 1) as? ResturantsHeaderCell{
            let headerOffset = tableView.rectForHeader(inSection: 1)
            let mySecondOffset = headerOffset.origin.y
            let offset = (scrollView.contentOffset.y / mySecondOffset)
            print(offset)

            if(offset >= 1) {
                header.containerView.layer.mask = nil
                tableView.backgroundColor = .white
            } else {
                header.containerView.layer.mask = header.cornerMask
                tableView.backgroundColor = .clear
            }
        }
    }


}
