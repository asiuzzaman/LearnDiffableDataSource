import UIKit
// 1
class Section: Hashable {
  var id = UUID()
  // 2
  var title: String
  var videos: [Video]
  
  init(title: String, videos: [Video]) {
    self.title = title
    self.videos = videos
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Section, rhs: Section) -> Bool {
    lhs.id == rhs.id
  }
    
}

extension Section {
  static var allSections: [Section] = [
    Section(title: "SwiftUI", videos: [
      Video(
        title: "SwiftUI",
        thumbnail: UIImage(named: "swiftui"),
        lessonCount: 37,
        link: URL(string: "https://www.raywenderlich.com/4001741-swiftui")
      )
    ]),
    Section(title: "UIKit", videos: [
      Video(
        title: "Demystifying Views in iOS",
        thumbnail: UIImage(named: "views"),
        lessonCount: 26,
        link:
        URL(string:
          "https://www.raywenderlich.com/4518-demystifying-views-in-ios")
      ),
      Video(
        title: "Reproducing Popular iOS Controls",
        thumbnail: UIImage(named: "controls"),
        lessonCount: 31,
        link: URL(string: """
          https://www.raywenderlich.com/5298-reproducing
          -popular-ios-controls
          """)
      )
    ]),
    Section(title: "Frameworks", videos: [
      Video(
        title: "Fastlane for iOS",
        thumbnail: UIImage(named: "fastlane"),
        lessonCount: 44,
        link: URL(string:
          "https://www.raywenderlich.com/1259223-fastlane-for-ios")
      ),
      Video(
        title: "Beginning RxSwift",
        thumbnail: UIImage(named: "rxswift"),
        lessonCount: 39,
        link: URL(string:
          "https://www.raywenderlich.com/4743-beginning-rxswift")
      )
    ]),
    Section(title: "Miscellaneous", videos: [
      Video(
        title: "Data Structures & Algorithms in Swift",
        thumbnail: UIImage(named: "datastructures"),
        lessonCount: 29,
        link: URL(string: """
          https://www.raywenderlich.com/977854-data-structures
          -algorithms-in-swift
        """)
      ),
      Video(
        title: "Beginning ARKit",
        thumbnail: UIImage(named: "arkit"),
        lessonCount: 46,
        link: URL(string:
          "https://www.raywenderlich.com/737368-beginning-arkit")
      ),
      Video(
        title: "Machine Learning in iOS",
        thumbnail: UIImage(named: "machinelearning"),
        lessonCount: 15,
        link: URL(string: """
          https://www.raywenderlich.com/1320561-machine-learning-in-ios
        """)
      ),
      Video(
        title: "Push Notifications",
        thumbnail: UIImage(named: "notifications"),
        lessonCount: 33,
        link: URL(string:
          "https://www.raywenderlich.com/1258151-push-notifications")
      ),
    ])
  ]
}

