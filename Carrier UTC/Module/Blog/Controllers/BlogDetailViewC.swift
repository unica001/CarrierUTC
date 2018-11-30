//
//  BlogDetailViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 30/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BlogDetailViewC: BaseViewC {
 
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblBlogDetail: UITableView!
    
    var dataBlog : BlogModel!
    
    //View Life Cycle
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
        self.viewHeader.addShadowInHeader()
        self.tblBlogDetail.emptyDataSetSource = self
        self.tblBlogDetail.emptyDataSetDelegate = self
        self.tblBlogDetail.reloadData()
    }
    
    private func registerNib() {
        self.tblBlogDetail.register(UINib(nibName: "CellBlog", bundle: nil), forCellReuseIdentifier: "CellBlog")
    }
    
    
    //MARK: - IBAction Methods
    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}


extension BlogDetailViewC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBlog", for: indexPath) as! CellBlog
        cell.setUpBlog(blogData: dataBlog)
        cell.btnRead.isHidden = true
        cell.selectionStyle = .none
        return cell
    }

}

extension BlogDetailViewC: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let txtAttributes: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font: UIFont.font(name: .Montserrat, weight: .Regular, size: .size_15), NSAttributedString.Key.foregroundColor: UIColor.black]
        let placeholderText = NSAttributedString(string: "No Blog Found", attributes: txtAttributes)
        return placeholderText
    }

}
