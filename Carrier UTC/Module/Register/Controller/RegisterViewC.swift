//
//  RegisterViewC.swift
//  Carrier UTC
//
//  Created by Shilpa Sharma on 26/11/18.
//  Copyright © 2018 Indigo. All rights reserved.
//

import UIKit

class RegisterViewC: BaseViewC {
    //MARK: - IBOutlet
    @IBOutlet weak var tblRegister: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    
    var arrInfo = [RegisterStruct]()
    internal var viewModel: RegisterViewModelling?
    
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
        recheckVM()
        viewHeader.addShadowInHeader()
        if let arr = self.viewModel?.prepareRegisterFields() {
            self.arrInfo = arr
            self.tblRegister.reloadData()
        }
    }
    
    private func recheckVM() {
        if self.viewModel == nil {
            self.viewModel = RegisterVM()
        }
    }
    
    private func registerNib() {
        self.tblRegister.register(UINib(nibName: "CellRegisterFields", bundle: nil), forCellReuseIdentifier: "CellRegisterFields")
        self.tblRegister.register(UINib(nibName: "CellSubmit", bundle: nil), forCellReuseIdentifier: "CellSubmit")
        self.tblRegister.register(UINib(nibName: "RegisterHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RegisterHeaderView")
        self.tblRegister.register(UINib(nibName: "RegisterFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "RegisterFooterView")
    }
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: RegisterHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RegisterHeaderView" ) as! RegisterHeaderView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView: RegisterFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "RegisterFooterView" ) as! RegisterFooterView
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row == 3) ? 170 : 49
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSubmit", for: indexPath) as! CellSubmit
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellRegisterFields", for: indexPath) as! CellRegisterFields
            let data = arrInfo[indexPath.row]
            cell.setUpData(regiter: data)
            cell.txtField.delegate = self
            if data.type == RegisterType.Phone {
                cell.txtField.addToolbarWithButtonTitled(title: "Done", forTarget: self, selector: #selector(self.tapDone))
            }
            return cell
        }
       
    }
}

extension RegisterViewC: SubmitDelegate {
    func tapTerms(sender: UIButton) {
        let index = Helper.getIndexPathFor(view: sender, tableView: tblRegister)
        var data = self.arrInfo[(index?.row)!]
        if let isTerms = data.isTerms, isTerms == true {
            data.isTerms = false
        } else {
            data.isTerms = true
        }
        
    }
    
    func tapSubmit(sender: UIButton) {
        self.viewModel?.validateFields(dataStore: arrInfo, validHandler: { [weak self]  (param, msg, isValid) in
            guard self != nil else { return }
            if isValid {
                print(param)
                self?.viewModel?.register(param: param, registerHandler: { [weak self] (response, success, message) in
                    guard self != nil else { return }
                    if success {
                        
                    }
                })
            } else {
                Alert.Alert(msg, okButtonTitle: "Ok", target: self)
            }
        })
    }
}

extension RegisterViewC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        
//        let newLength = (textField.text?.count)! + string.count - range.length
        let str = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        
        
        if let index = Helper.getIndexPathFor(view: textField, tableView: self.tblRegister) {
//            switch self.arrInfo[index.row].type {
//            case .Name? :
//                if string != filtered {
//                    return false
//                }
//                self.arrInfo[index.row].value = self.arrInfo[index.row].value
//                break
//            default:
                self.arrInfo[index.row].value = str
//                break
//            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = Helper.getIndexPathFor(view: textField, tableView: self.tblRegister) else {
            return true
        }
        let lastRowIndex = self.tblRegister.numberOfRows(inSection: 0) - 1
        
        if currentIndexPath.row != lastRowIndex {
            var nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            textField.resignFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
}
