
import UIKit

class ListViewCell: UITableViewCell {
    
    
    @IBOutlet weak var textBox: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
