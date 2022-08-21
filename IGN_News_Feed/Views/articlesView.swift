
import SwiftUI

struct articleThumbnailView: View {
    @State var data: Data?
    let url: String

    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 340, height: 190)
        }
        else {
            Image(systemName: "video")
                .background(.gray)
                .scaledToFit()
                .onAppear { getData() }
        }
    }

    private func getData() {
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) {
            data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

struct articlesView: View {
    @StateObject var articles = getArticles()
    var body: some View {
        ScrollView {
            ForEach(articles.article.data, id: \.self) { article in
                VStack {
                    if articles.article.data.count > 0 {
                        if let metadata = article.metadata {
                            articleThumbnailView(url: article.thumbnails[0].url)
                            Text(metadata.headline)
                                .bold()
                                .padding(.top)
                        }
                    }
                    else {
                        Text("View is still loading")
                    }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(.gray, lineWidth: 0.5))
            }
        }.onAppear {
            articles.getData()
        }
    }
}

struct articlesView_Previews: PreviewProvider {
    static var previews: some View {
        articlesView()
    }
}
