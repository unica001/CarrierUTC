//
//  BlogCategoryViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class BlogCategoryViewC: BaseViewC {
    //MARK: - IBOutlet
    @IBOutlet weak var tblBlogCategory: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    
    var arrBlogCategory = [BlogCategoryModel]() {
        didSet {
            self.tblBlogCategory.reloadData()
        }
    }
    internal var viewModel: BlogCategoryViewModelling?
    
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
        recheckVM()
        callApiBlogCategory()
        viewHeader.addShadowInHeader()
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = BlogCategoryVM()
        }
    }
    
    private func registerNib() {
        self.tblBlogCategory.register(UINib(nibName: "BlogCategoryCell", bundle: nil), forCellReuseIdentifier: "BlogCategoryCell")
    }
    
    private func callApiBlogCategory() {
        self.viewModel?.getBlogCategory(allEventListHandler: { [weak self] (blogCategory, success, msg) in
            guard self != nil else { return }
            if success {
                self?.arrBlogCategory = blogCategory
                
            } else {
                Alert.Alert(msg, okButtonTitle: "OK", target: self)
            }
        })
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapSearch(_ sender: UIButton) {
    }
}

extension BlogCategoryViewC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBlogCategory.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCategoryCell", for: indexPath) as! BlogCategoryCell
        cell.setUpBlogCategory(category: arrBlogCategory[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let blogViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "BlogListViewC") as? BlogListViewC {
            let data = arrBlogCategory[indexPath.row]
            blogViewC.categoryId = data.id!
            blogViewC.categoryName = data.name!
            self.navigationController?.pushViewController(blogViewC, animated: true)
        }
    }
}
