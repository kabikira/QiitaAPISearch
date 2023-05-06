//
//  WebViewController.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    private var qiitaModel: QiitaModel?
    func configure(qiitaModel: QiitaModel) {
        self.qiitaModel = qiitaModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let qiitaModel = qiitaModel else {
            return
        }
        webView.load(URLRequest(url: qiitaModel.url))

    }
    



}
