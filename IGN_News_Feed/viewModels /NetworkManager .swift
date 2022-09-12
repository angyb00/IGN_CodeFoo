import Foundation
import UIKit

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

private extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}

class ImageRequest: NetworkRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }

    func execute(withCompletion completion: @escaping (UIImage?) -> Void) {
        load(url, withCompletion: completion)
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return wrapper?.data
    }

    func execute(withCompletion completion: @escaping ([Resource.ModelType]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var filter: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://ign-apis.herokuapp.com")!
        components.path = methodPath
        components.queryItems = [
            URLQueryItem(name: "startIndex", value: "30"),
            URLQueryItem(name: "count", value: "5")
        ]
        if let filter = filter {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        return components.url!
    }
}

struct VideoResources: APIResource {
    typealias ModelType = Video
    var methodPath: String {
        return "/videos"
    }

    var id: String?

    var filter: String?
}

struct ArticleResources: APIResource {
    typealias ModelType = Article
    var methodPath: String {
        return "/articles"
    }

    var id: String?
    var filter: String?
}
