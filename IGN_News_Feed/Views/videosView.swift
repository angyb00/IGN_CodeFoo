
import SwiftUI

struct videoThumbnailView: View {
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

struct videosView: View {
    @StateObject var videos = getVideos()
    var body: some View {
        ScrollView {
                ForEach(videos.video.data, id: \.self) { video in
                    VStack {
                        if videos.video.data.count > 0 {
                            if let title = video.metadata.title {
                                videoThumbnailView(url: video.thumbnails[0].url)
                                Text(title)
                                    .bold()
                                    .font(.body)
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
            videos.getData()
        }
    }
}


struct articlesLogo: View {
    var body: some View {
        Image(systemName: "chart.bar.doc.horizontal")
            .font(.largeTitle)
            .padding(.leading)
        Text("ARTICLES")
            .font(.title)
            .bold()
            .padding(.trailing)
    }
}

struct videosView_Previews: PreviewProvider {
    static var previews: some View {
        videosView()
    }
}
