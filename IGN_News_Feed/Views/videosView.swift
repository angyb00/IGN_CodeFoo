
import SwiftUI

struct videosView: View {
    @StateObject var dataModel = VideosDataModel()
    @State var showWebView = false
    var body: some View {
        ScrollView {
            ForEach(dataModel.videos) { video in
                VStack {
                    if dataModel.videos.count > 0 {
                        if let thumbnailUrl = video.thumbnails[0].url {
                            Button {
                                showWebView.toggle()
                            } label: {
                                VStack {
                                    ThumbnailView(url: thumbnailUrl)
                                    Text(video.metadata.title)
                                        .bold()
                                        .font(.body)
                                        .padding(.top)
                                }
                            }.sheet(isPresented: $showWebView) {
                                WebView(url: video.assets[0].url)
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
                                WebView(url: video.assets[0].url)
                            }
                        }
                    }
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 7).stroke(.gray, lineWidth: 0.5))
            }
        }.onAppear {
            dataModel.loadVideos()
        }
    }
}

struct videosView_Previews: PreviewProvider {
    static var previews: some View {
        videosView()
    }
}
