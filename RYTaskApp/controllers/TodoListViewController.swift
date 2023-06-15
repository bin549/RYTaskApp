import UIKit

class TodoListViewController: UIViewController, GDHeaderDelegate, GDNewItemDelegate {
    lazy var bg:UIView = {
        let view = GDGradient()
        view.layer.cornerRadius = tbInset
        return view
    }()
    var bgBottom:NSLayoutConstraint!
    let header = GDHeaderView(title: "待办事项", subtitle: "剩下4项")
    let popup = GDNewItemPopup()
    let tbInset:CGFloat = 16
    let listTable = GDTableView()
    let CELL_ID = "cell_id"
    var listData:[ToDo] = [ToDo]()
    var keyboardHeight:CGFloat = 333
    
    func openAddItemPopup() {
        popup.animatePopup()
    }
    
    func notInList(text:String) -> Bool {
        var isNotInList = true
        self.listData.forEach { (toDo) in
            if toDo.title == text {
                isNotInList = false
            }
        }
        return isNotInList
    }
    
    func addItemToList(text:String) {
        if (notInList(text:text)) {
            let newItem = ToDo(id: self.listData.count, title: text, status: false)
            self.listData.append(newItem)
            self.listTable.reloadData()
            self.updateHeaderItemsLeft()
            self.popup.textField.text = ""
            self.popup.animatePopup()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.keyboardHeight = keyboardSize.height
    }
    
    func updateHeaderItemsLeft() {
        header.itemsLeft = 0
        self.listData.forEach { (toDo) in
            if !toDo.status { header.itemsLeft += 1}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listData = []
        let newItem1 = ToDo(id: self.listData.count, title: "买咖啡", status: false)
        let newItem2 = ToDo(id: self.listData.count, title: "吃苹果", status: true)
        listData.append(newItem1)
        listData.append(newItem2)
        self.updateHeaderItemsLeft()
        view.backgroundColor = .gray
        view.addSubview(header)
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
        bgBottom = bg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        bgBottom.isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        view.addSubview(popup)
        popup.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        popup.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        popup.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        popup.heightAnchor.constraint(equalToConstant: 80).isActive = true
        openAddItemPopup()
        view.addSubview(listTable)
        listTable.leftAnchor.constraint(equalTo: bg.leftAnchor, constant: tbInset).isActive = true
        listTable.topAnchor.constraint(equalTo: bg.topAnchor, constant: tbInset).isActive = true
        listTable.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: tbInset * -1).isActive = true
        listTable.rightAnchor.constraint(equalTo: bg.rightAnchor, constant: tbInset * -1).isActive = true
        popup.textField.delegate = self
        popup.delegate = self
        header.delegate = self
        listTable.delegate = self
        listTable.dataSource = self
        listTable.register(GDListCell.self, forCellReuseIdentifier: CELL_ID)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension TodoListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        var heightToAnimate = -keyboardHeight - 20
        if textField == popup.textField {
            popup.animateView(transform: CGAffineTransform(translationX: 0, y: -keyboardHeight), duration: 0.5)
            heightToAnimate -= 80
        }
        self.bgBottom.constant = heightToAnimate
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.bgBottom.constant = -100
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        if textField == popup.textField {
            popup.animateView(transform: CGAffineTransform(translationX: 0, y: 0), duration: 0.6)
        }
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource, GDListCellDelegate {
    func toggleToDo(toDo updateToDo:ToDo) {
        let newListData = self.listData.map { (oldToDo) -> ToDo in
            if oldToDo.id == updateToDo.id {
                var newToDo = oldToDo
                newToDo.status = updateToDo.status
                newToDo.title = updateToDo.title
                return newToDo
            }
            return oldToDo
        }
        self.listData = newListData
        self.listTable.reloadData()
        self.updateHeaderItemsLeft()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        return "Done"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleForHeader = GDLabel(color: .black, size: 20, frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        if section == 0 {
            titleForHeader.text = "待办任务"
        } else {
            titleForHeader.text = "已完成"
        }
        return titleForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        self.listData.forEach { (toDo) in
            if section == 0 && !toDo.status {
                count += 1
            } else if (section == 1 && toDo.status) {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! GDListCell
        cell.delegate = self
        cell.textField.delegate = self
        var itemsForSection:[ToDo] = []
        self.listData.forEach { (toDo) in
            if indexPath.section == 0 && !toDo.status {
                itemsForSection.append(toDo)
            } else if (indexPath.section == 1 && toDo.status) {
                itemsForSection.append(toDo)
            }
        }
        cell.toDo = itemsForSection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
}
