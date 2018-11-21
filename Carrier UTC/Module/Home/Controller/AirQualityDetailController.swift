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
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    //MARK: - Private Methods
    private func setUp() {
        registerNib()
    }
    
    private func registerNib() {
        self.tableView.register(UINib(nibName: "AirQualityCell", bundle: nil), forCellReuseIdentifier: "AirQualityCell")
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}


// MARK: Table view Delegates

extension AirQualityDetailController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirQualityCell", for: indexPath) as! AirQualityCell
        return cell
    }
}
