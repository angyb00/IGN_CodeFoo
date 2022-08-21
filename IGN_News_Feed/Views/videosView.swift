
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
    @State var showWebView = false
    var body: some View {
        ScrollView {
            ForEach(videos.video.data, id: \.self) { video in
                VStack {
                    if videos.video.data.count > 0 {
                        if let thumbnailUrl = video.thumbnails[0].url {
                            Button {
                                showWebView.toggle()
                            } label: {
                                VStack {
                                    videoThumbnailView(url: thumbnailUrl)
                                    Text(video.metadata.title)
                                        .bold()
                                        .font(.body)
                                        .padding(.top)
                                }
                            }.sheet(isPresented: $showWebView) {
                                WebView(url: URL(string: video.assets[0].url)!)
                            }
                        }
                        else {
                            Button {
                                showWebView.toggle()
                            } label: {
                                VStack {
                                    Text("No thumbnail")
                                    Text(video.metadata.title)
                                        .bold()
                                        .font(.body)
                                        .padding(.top)
                                }
                            }.sheet(isPresented: $showWebView) {
                                WebView(url: URL(string: video.assets[0].url)!)
                            }
                        }
                    }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(.gray, lineWidth: 0.5))
            }
        }.onAppear {
            videos.getData()
        }
    }
}

struct videosView_Previews: PreviewProvider {
    static var previews: some View {
        videosView()
    }
}
