//
//  EventDetailViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class EventDetailViewC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tblEventDetail: UITableView!
    @IBOutlet weak var btnInterested: UIButton!
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Private Methods
    private func setUp() {
        registerNib()
    }
    
    private func registerNib() {
        self.tblEventDetail.register(UINib(nibName: "CellEventDetail", bundle: nil), forCellReuseIdentifier: "CellEventDetail")
        let nibName = UINib(nibName: "EventImageView", bundle: nil)
        self.tblEventDetail.register(nibName, forHeaderFooterViewReuseIdentifier: "EventImageView")
    }

    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapInterested(_ sender: UIButton) {
    }
    
    @IBAction func tapTwitter(_ sender: UIButton) {
    }
    
    @IBAction func tapFacebook(_ sender: UIButton) {
    }
}

extension EventDetailViewC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EventImageView" ) as! EventImageView
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellEventDetail", for: indexPath) as! CellEventDetail
        return cell
    }
}
