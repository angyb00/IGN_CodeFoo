
import SwiftUI

struct articlesView: View {
    @StateObject var dataModel = ArticlesDataModel()
    var body: some View {
        ScrollView {
            ForEach(dataModel.articles) { article in
                VStack {
                    if dataModel.articles.count > 0 {
                        if let thumbnail = article.thumbnails[0].url {
                            ThumbnailView(url: thumbnail)
                            Text(article.metadata.headline)
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
            dataModel.loadArticles()
        }
    }
}

struct articlesView_Previews: PreviewProvider {
    static var previews: some View {
        articlesView()
    }
}
