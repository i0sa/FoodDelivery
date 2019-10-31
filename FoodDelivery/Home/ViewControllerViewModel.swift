//
//  ViewControllerViewModel.swift
//  FoodDelivery
//
//  Created by Osama on 10/31/19.
//  Copyright © 2019 Osama Gamal. All rights reserved.
//

import Foundation

class ViewControllerViewModel{
    var didGetData: ( () -> () )?
    var didGetResturantsData: ( () -> () )?
    var showLoading: ( () -> () )?
    var hideLoading: ( () -> () )?
    var displayError: ( (_ title: String) -> () )?

    var network: NetworkClientProtocol
    
    var Resturants: [Resturant]?{
        didSet{
            didGetResturantsData?()
        }
    }
    var data: Home?{
        didSet{
            didGetData?()
        }
    }

    func viewDidLoad(){
        getTopData()
    }
    
    init(network: NetworkClientProtocol = NetworkClientNew()) {
        self.network = network
    }
    
    private func loadFirstData(){
        if let firstItem = self.data?.types?.first {
            self.getResturantData(for: firstItem)
            self.data?.types?[0].isSelected = true
        }
        
    }
    
    private func getTopData(){
//        self.view.makeToastActivity(.center)
        self.showLoading?()
        network.performRequest(Home.self, router: .Home, success: { (models) in
            self.hideLoading?()
            self.data = models
            self.loadFirstData()
//
        }) { (error) in
            self.hideLoading?()
            guard let error = error as? BaseError else { return }
            if case .other(let error) = error {
                self.displayError?(error )
            } else {
                self.displayError?(error.MyDescription)
            }
            
        }
    }
    
    public func didSelectResturant(_ item: CircleModel) {
        getResturantData(for: item)
    }
    
    private func getResturantData(for restType: CircleModel){
        guard let id = restType.id else { return }
        self.showLoading?()
        network.performRequest([Resturant].self, router: .RestData(id: id), success: { (models) in
            self.hideLoading?()
            self.Resturants = models
//            
            print(models)
        }) { (error) in
            self.hideLoading?()
            self.displayError?(error.localizedDescription)
        }
    }
}
