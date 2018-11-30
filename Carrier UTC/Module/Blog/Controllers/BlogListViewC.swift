//
//  BlogListViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 30/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BlogListViewC: BaseViewC {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblBlog: UITableView!
    
    internal var viewModel : BlogListViewModelling!
    var categoryId = 0
    var totalRecords = 0
    var pageIndex = 1
    var categoryName = ""
    var arrBlog = [BlogModel]() {
        didSet {
            self.tblBlog.reloadData()
        }
    }

    //MARK: - View Life Cycle
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
        recheckVM()
        registerNib()
        self.tblBlog.emptyDataSetSource = self
        self.tblBlog.emptyDataSetDelegate = self
        self.lblHeader.text = categoryName
        apiCallBlogList()
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = BlogListVM()
        }
    }
    
    private func registerNib() {
        self.tblBlog.register(UINib(nibName: "CellBlog", bundle: nil), forCellReuseIdentifier: "CellBlog")
    }
    
    private func apiCallBlogList() {
        self.viewModel.getBlogList(categoryId: categoryId, pageIndex: pageIndex) { [weak self] (blogList, total, success, msg) in
             guard self != nil else { return }
            if success {
                if self?.pageIndex == 1 {
                    self?.arrBlog = blogList
                } else {
                    for i in 0 ..< blogList.count {
                        let dict = blogList[i]
                        self?.arrBlog.append(dict)
                    }
                }
                self?.totalRecords = total
            } else {
                Alert.Alert(msg, okButtonTitle: "Ok", target: self)
            }
        }
    }
    
    //MARL:- IBAction Method
    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension BlogListViewC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBlog.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBlog", for: indexPath) as! CellBlog
        cell.lblDesc.numberOfLines = 3
        cell.setUpBlog(blogData: arrBlog[indexPath.row])
        cell.delegate = self
        cell.btnRead.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= -40 && totalRecords > arrBlog.count {
            pageIndex = pageIndex + 1
            self.apiCallBlogList()
        }
    }
}

extension BlogListViewC: BlogDelegate {
    func tapRead(_ sender: UIButton) {
        if let detailViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "BlogDetailViewC") as? BlogDetailViewC {
            detailViewC.dataBlog = arrBlog[sender.tag]
            self.navigationController?.pushViewController(detailViewC, animated: true)
        }
    }
    
    func tapFacebook(_ sender: UIButton) {
        let data = arrBlog[sender.tag]
        let content = "\(String(describing: data.heading)) \n \(data.desc)"
        Helper.shareToFacebook(image: data.event_image!, content: content)
    }
    
    func tapInstagram(_ sender: UIButton) {
        
    }
}

extension BlogListViewC: DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let txtAttributes: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.font: UIFont.font(name: .Montserrat, weight: .Regular, size: .size_15), NSAttributedString.Key.foregroundColor: UIColor.black]
        let placeholderText = NSAttributedString(string: "No Blogs Found", attributes: txtAttributes)
        return placeholderText
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attString = NSAttributedString(string: "Refresh", attributes: [ NSAttributedString.Key.font: UIFont.font(name: .Montserrat, weight: .Regular, size: .size_15), NSAttributedString.Key.foregroundColor: UIColor.backgroundColor])
        return attString
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.pageIndex = 1
        self.apiCallBlogList()
    }
}
