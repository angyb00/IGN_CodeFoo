import SwiftUI

struct ThumbnailView: View {
    @State var data: Data?
    let url: String

    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .frame(width: 340, height: 190)
        }
        else {
            Image(systemName: "clock")
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

struct thumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(url: "https://assets1.ignimgs.com/2021/05/21/junkmodokpattonoswaltoothumbv1-1621532192207-1621637198922_compact.jpeg")
    }
}
