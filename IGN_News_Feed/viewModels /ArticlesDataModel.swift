import Foundation

class ArticlesDataModel: ObservableObject {
    @Published private(set) var articles: [Article] = []
    @Published private(set) var isLoading = false

    private var request: APIRequest<ArticleResources>?

    func loadArticles() {
        guard !isLoading else { return }
        isLoading = true
        let resource = ArticleResources()
        let request = APIRequest(resource: resource)
        self.request = request
        request.execute { [weak self] articles in
            self?.articles = articles ?? []
            self?.isLoading = false
        }
    }
}
