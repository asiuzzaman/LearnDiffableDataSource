
import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var thumbnailView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  
  var video: Video? {
    didSet {
      thumbnailView.image = video?.thumbnail
      titleLabel.text = video?.title
      subtitleLabel.text = "\(video?.lessonCount ?? 0) lessons"
    }
  }
}
