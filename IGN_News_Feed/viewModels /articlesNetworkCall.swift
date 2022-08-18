import Foundation

class getArticles: ObservableObject {
    var url: String = "https://ign-apis.herokuapp.com/articles?startIndex=30&count=5"

    @Published var article = articleRequest()

    func getData() {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [weak self] data, _, error in

            guard let data = data, error == nil else {
                print("error")
                return
            }
            do {
                let article = try JSONDecoder().decode(articleRequest.self, from: data)

                DispatchQueue.main.async {
                    self?.article = article
                }
            }
            catch {
                print("Failed to convert \(error)")
            }
        })
        task.resume()
    }
}

struct articleRequest: Codable {
    var data: [article] = []
}

struct article: Codable, Hashable {
    var thumbnails: [articleThumbnail]
    var metadata: articleMetadata?
    var authors: [author]
}

struct articleThumbnail: Codable, Hashable {
    var url: String
}

struct articleMetadata: Codable, Hashable {
    var headline: String
    var description: String?
    var publishDate: String
}

struct author: Codable, Hashable {
    var name: String
    var thumbnail: String
}
