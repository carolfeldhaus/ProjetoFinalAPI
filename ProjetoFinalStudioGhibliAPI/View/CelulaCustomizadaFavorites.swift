//
//  CelulaCustomizadaFavorites.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit
import SnapKit

class CelulaCustomizadaFavorites: UITableViewCell {

    @IBOutlet weak var uiImageFav: UIImageView!
    @IBOutlet weak var uiTitleFav: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    //usando SnapKit para as constraints
            uiTitleFav.snp.makeConstraints { make in
                
                make.top.equalTo(self).offset(10)
                make.right.equalTo(self).offset(-10)
                make.left.equalTo(uiImageFav.snp.right).offset(0)
                make.bottom.equalTo(self).offset(-10)
                
            }
                
            uiImageFav.snp.makeConstraints { make in
                
                make.centerY.equalTo(self).offset(0)
                make.left.equalTo(self).offset(0)
                make.width.equalTo(140)
                make.height.equalTo(130)
            }
            
}
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    }
