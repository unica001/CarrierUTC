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
        viewHeader.addShadowInHeader()
    }
    
    private func registerNib() {
        self.tblBlogCategory.register(UINib(nibName: "BlogCategoryCell", bundle: nil), forCellReuseIdentifier: "BlogCategoryCell")
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapSearch(_ sender: UIButton) {
    }
}

extension BlogCategoryViewC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCategoryCell", for: indexPath) as! BlogCategoryCell
        return cell
    }
}
