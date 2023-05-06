//
//  TableViewCell.swift
//  QiitaAPI
//
//  Created by koala panda on 2023/05/05.
//

import UIKit

final class TableViewCell: UITableViewCell {
    @IBOutlet private weak var iconView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconView.image = nil
    }
    func congigure(qiitaModel: QiitaModel) {
        // 画像の挿入
        let iconImageURL = qiitaModel.user.profileImageURL
        downloadImage(iconImageURL)

        self.titleLabel.text = qiitaModel.title
    }
    func downloadImage(_ imageURL: URL) {
        // URLを元に画像データ取得
        let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            if let imageData = data {
                DispatchQueue.main.async {
                    // 画像データをUIImageに変換
                    self.iconView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }


}
