//
//  TableCell.swift
//  Assmenent Test
//
//  Created by Ghayoor Abbas on 29/12/2021.
//

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet weak var movieTitle:UILabel!
    @IBOutlet weak var movieDate:UILabel!
    @IBOutlet weak var movieImage:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
