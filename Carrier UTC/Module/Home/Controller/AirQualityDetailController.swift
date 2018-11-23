//
//  AirQualityDetailController.swift
//  Carrier UTC
//
//  Created by Ram Niwas on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class AirQualityDetailController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    internal var viewModel: AirQualityModelling?
    
    var  airQualityList = [AirQualityModele]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setUp()
    }

    //MARK: - Private Methods
    private func setUp() {
        
        if self.viewModel == nil {
            self.viewModel = AirQualityModeleView()
        }
        getAirQualityList()
        registerNib()
    }
    
    private func registerNib() {
        self.tableView.register(UINib(nibName: "AirQualityCell", bundle: nil), forCellReuseIdentifier: "AirQualityCell")
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getAirQualityList(){
        
        self.viewModel?.getAirQualityDetails(userListHandler: { [weak self] (response, isSuccess, msg) in
            
            self?.airQualityList = response
            print(response)
        })
}
}

// MARK: Table view Delegates

extension AirQualityDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airQualityList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualityCell", for: indexPath) as! AirQualityCell
        
        cell.qualityTypeLabel.text = airQualityList[indexPath.row].name! + " " + "\(airQualityList[indexPath.row].level!)"
        cell.descriptionLabel.text = airQualityList[indexPath.row].display_text
        cell.qualityTypeLabel.textColor = UIColor.colorWith(hexString:airQualityList[indexPath.row].color! )

        
        return cell
    }
}
