import SwiftUI

struct homeView: View {
    @State var showArticles = true
    @State var showVideos = false

    var body: some View {
        VStack {
            Image("ign_logo")
                .frame(maxWidth: .infinity)
                .background(Color("darkRed"))
            VStack {
                HStack {
                    articlesToggle().brightness(showArticles ? 0 : 0.7).onTapGesture {
                        showArticles = true
                        showVideos = false
                    }
                    videosToggle()
                        .brightness(showVideos ? 0 : 0.7)
                        .onTapGesture {
                            showVideos = true
                            showArticles = false
                        }
                }
                Divider()
                if showArticles {
                    articlesView()
                }
                else {
                    videosView()
                }

                Spacer()
            }
        }
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
