//
//  SearchViewController.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import UIKit

class SearchViewController: UIViewController {


    private let cellClassName = "TableViewCell"
    private let reuseId = "TableViewCell"

    private var items: [QiitaModel] = []

    @IBOutlet private weak var serchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
        }
    }


    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: reuseId)
            tableView.delegate = self
            tableView.dataSource = self
            serchTextField.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isHidden = true
        indicator.isHidden = true
    }
    @objc func tapSearchButton(_sender: UIResponder) {
        indicator.isHidden = false
        tableView.isHidden = true
        QiitaAPI.shared.get(searchTextField: serchTextField.text!) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let items):
                    self.items = items
                    self.indicator.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()

                }
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    


}
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.shared.showWeb(from: self, qiitaModel: items[indexPath.item])
        return
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellClassName) as?
                TableViewCell else {
            fatalError()
        }
        let qiitaModel = items[indexPath.item]
        cell.congigure(qiitaModel: qiitaModel)
        return cell
    }
}
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
