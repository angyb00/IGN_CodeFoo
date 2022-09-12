import Foundation

struct Wrapper<T: Decodable>: Decodable {
    let data: [T]
}

struct Video {
    let id: String
    let thumbnails: [VideoThumbnails]
    let metadata: VideoInfo
    let assets: [VideoAssets]
}

extension Video: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id = "contentId"
        case thumbnails
        case metadata
        case assets
    }
}

struct VideoThumbnails: Codable {
    let url: String
    let size: String
}

struct VideoInfo: Codable {
    let title: String
    let description: String?
    let publishDate: String
}

struct VideoAssets: Codable {
    let url: String
    let height: Int
    let width: Int
    let bitrate: Int
}
