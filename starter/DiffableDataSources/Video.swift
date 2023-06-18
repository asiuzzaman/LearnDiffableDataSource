
import UIKit

class Video: Hashable {
  
  static func == (lhs: Video, rhs: Video) -> Bool {
    lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    // 2
    hasher.combine(id)
  }
  
  var id = UUID()
  var title: String
  var thumbnail: UIImage?
  var lessonCount: Int
  var link: URL?
  
  init(title: String, thumbnail: UIImage? = nil, lessonCount: Int, link: URL?) {
    self.title = title
    self.thumbnail = thumbnail
    self.lessonCount = lessonCount
    self.link = link
  }
}

// MARK: - Video Sample Data
