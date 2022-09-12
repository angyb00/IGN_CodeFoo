import SwiftUI

struct articlesToggle: View {
    var body: some View {
        Image(systemName: "chart.bar.doc.horizontal")
            .font(.largeTitle)
            .padding(.leading)
        Text("ARTICLES")
            .font(.title)
            .bold()
    }
}

struct videosToggle: View {
    var body: some View {
        Image(systemName: "play")
            .font(.largeTitle)
            .padding(.leading)
        Text("VIDEOS")
            .font(.title)
            .bold()
            .padding(.trailing)
    }
}

struct Logos_Previews: PreviewProvider {
    static var previews: some View {
        videosToggle()
    }
}
