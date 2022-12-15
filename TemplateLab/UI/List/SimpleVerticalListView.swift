//
//  SimpleVerticalListView.swift
//  TemplateLab
//
//  Created by 염태규 on 2022/11/27.
//

import Foundation
import UIKit

protocol BaseUIData {
    //    let id: String
    var size: CGSize { get }
    func set(view: BaseView?)
    static var view: BaseView { get }
}

extension BaseUIData {
    
    static func registerCell<T>(type: T.Type, tableView: UITableView) where T: BaseUIData {
        tableView.register(SimpleTableViewCell<T>.self, forCellReuseIdentifier: String(describing: SimpleTableViewCell<T>.self))
    }
    
    static func registerHeaderFooterView<T>(type: T.Type, tableView: UITableView) where T: BaseUIData {
        tableView.register(SimpleTableViewHeaderFooterView<T>.self, forHeaderFooterViewReuseIdentifier: String(describing: SimpleTableViewHeaderFooterView<T>.self))
    }
    
    func tableViewCell<T>(type: T.Type, tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SimpleTableViewCell<T> where T : BaseUIData {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? SimpleTableViewCell<T> {
            cell.set(data: self as! T)
            return cell
        }
        return SimpleTableViewCell<T>()
    }
    
    func tableViewHeaderFooterView<T>(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> SimpleTableViewHeaderFooterView<T> where T : BaseUIData {
        if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? SimpleTableViewHeaderFooterView<T> {
            cell.set(data: self as! T)
            return cell
        }
        return SimpleTableViewHeaderFooterView<T>()
    }
}

struct SimpleSectionUIData: BaseUIData, Hashable {
    var size: CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func set(view: BaseView?) {
    }
    static var view: BaseView {
        return BaseView()
    }
    
    var id: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct SampleUIData: BaseUIData {
    
    var size: CGSize
    func set(view: BaseView?) {
        if let view = view as? ILVButton {
            
        }
    }
    
    static var view: BaseView {
        let view = ILVButton()
        return view
    }
}

class SimpleVerticalListView<T: BaseUIData>: BaseView, UITableViewDataSource, UITableViewDelegate {
    
    let table_main = UITableView(frame: .zero, style: .grouped)
    var datas: [SampleUIData] = []
    
    override func initViews(parent: BaseViewController?) {
        addSubview(table_main)
        table_main.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        table_main.delegate = self
        table_main.dataSource = self
        table_main.separatorStyle = .none
    }
    
    func set(datas: [SampleUIData]) {
        self.datas = datas
        T.registerCell(type: T.self, tableView: table_main)
        T.registerHeaderFooterView(type: T.self, tableView: table_main)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        return data.tableViewCell(type: T.self, tableView: tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

class SimpleTableViewHeaderFooterView<T: BaseUIData>: UITableViewHeaderFooterView {
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var view = BaseView()
    func initViews() {
        view = T.view
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(data: T) {
        data.set(view: view)
    }
}

class SimpleTableViewCell<T: BaseUIData>: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var view = BaseView()
    func initViews() {
        view = T.view
        addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func set(data: T) {
        data.set(view: view)
    }
}
