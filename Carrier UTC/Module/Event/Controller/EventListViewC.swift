//
//  EventListViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 21/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class EventListViewC: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet weak var collectionViewUpcoming: UICollectionView!
    @IBOutlet weak var collectionViewPast: UICollectionView!
    
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
        registerNib()
    }
    
    private func registerNib() {
        collectionViewUpcoming.register(UINib(nibName: "CellEvent", bundle: nil), forCellWithReuseIdentifier: "CellEvent")
        collectionViewPast.register(UINib(nibName: "CellEvent", bundle: nil), forCellWithReuseIdentifier: "CellEvent")
    }
    
    //MARK: - IBAction Methods
    @IBAction func tapSearch(_ sender: UIButton) {
        if let searchEventViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "SearchEventViewC") as? SearchEventViewC {
            self.navigationController?.pushViewController(searchEventViewC, animated: true)
        }
    }
}

extension EventListViewC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == collectionViewUpcoming) ? 10 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellEvent", for: indexPath) as! CellEvent
        cell.layer.cornerRadius = 6
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let searchEventViewC = Constant.kStoryboardEvent.instantiateViewController(withIdentifier: "EventDetailViewC") as? EventDetailViewC {
            self.navigationController?.pushViewController(searchEventViewC, animated: true)
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: collectionView.frame.size.height) // The size of one cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // margin between cells
    }
}
