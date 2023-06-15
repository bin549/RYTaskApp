import Foundation

protocol GDHeaderDelegate {
    func openAddItemPopup()
}

protocol GDNewItemDelegate {
    func addItemToList(text:String)
}

protocol GDListCellDelegate {
    func toggleToDo(toDo:ToDo)
}
 
