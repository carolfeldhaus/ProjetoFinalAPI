//
//  FavoriteTableViewCell.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static var favoriteCell = "celulaCustomizada"

    @IBOutlet weak var uiImageFav: UIImageView!
    @IBOutlet weak var uiTitleFav: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
