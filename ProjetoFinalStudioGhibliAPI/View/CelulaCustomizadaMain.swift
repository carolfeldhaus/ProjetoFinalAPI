//
//  CelulaCustomizadaMain.swift
//  ProjetoFinalStudioGhibliAPI
//
//  Created by Caroline Feldhaus de Souza on 31/10/21.
//

import UIKit
import SnapKit

class CelulaCustomizadaMain: UITableViewCell {
    
    @IBOutlet weak var uITituloMain: UILabel!
    @IBOutlet weak var uIDescription: UILabel!
    @IBOutlet weak var uIImageMain: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//usando SnaoKit para as constraints
        uITituloMain.snp.makeConstraints { make in
            
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-15)
            make.left.equalTo(uIImageMain.snp.right).offset(-5)
            make.bottom.equalTo(uIDescription.snp.top).offset(-10)
            
        }
        
        uIDescription.snp.makeConstraints { make in
            
            make.top.equalTo(uITituloMain.snp.bottom).offset(5)
            make.left.equalTo(uIImageMain.snp.right).offset(-5)
            make.right.equalTo(self).offset(-15)
            make.bottom.greaterThanOrEqualTo(self).offset(-10)
            
        }
        
       uIImageMain.snp.makeConstraints { make in
            
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
        
        

