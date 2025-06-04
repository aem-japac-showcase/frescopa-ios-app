import SwiftUI

struct OfferResponse: Decodable {
    let data: OfferData?
}

struct OfferData: Decodable {
    let offerByPath: OfferByPath?
}

struct OfferByPath: Decodable {
    let item: OfferItem?
}

struct OfferItem: Decodable {
    let headline: String?
    let detail: OfferDetail?
    let callToAction: String?
}

struct OfferDetail: Decodable {
    let plaintext: String?
}

struct SubscriptionCard: View {
    @State private var headline: String = "Let us do the shopping for you!"
    @State private var detailText: String? = nil
    @State private var callToAction: String = "Subscribe"
    @State private var showDetails: Bool = false
    @State private var publishUrl: String? = nil
    
    private var url: URL? {
        guard let publishUrl = publishUrl else { return nil }
        let urlString = "https://\(publishUrl).adobeaemcloud.com/graphql/execute.json/frescopa/OfferByPath;path=/content/dam/frescopa/en/offers/fall-in-love-my-barista-subscription;variation=%3Cp%3Emain%3C/p%3E;ts=119.44415182073797"
        return URL(string: urlString)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("smallbg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .background(Color(hex: "F9EAD6"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 8) {
                Text("MY BARISTA")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "6F2232"))
                
                Text(headline)
                    .font(.custom("Baskerville", size: 30))
                    .foregroundColor(Color(hex: "6F2232"))
                    .frame(maxHeight: .infinity, alignment: .leading)
                
                if let detailText = detailText {
                    Text(detailText)
                        .font(.custom("Roboto", size: 16))
                        .foregroundColor(Color(hex: "6F2232"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button(action: {
                    showDetails = true
                }) {
                    Text(callToAction)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 28)
                        .padding(.vertical, 10)
                        .background(Color(hex: "DC6E52"))
                        .clipShape(Capsule())
                }
                .padding(.top, 12)
            }
            .padding(20)
            .onAppear {
                loadPublishUrl()
                fetchContent()
            }
        }
    }
    
    private func loadPublishUrl() {
        if let path = Bundle.main.path(forResource: "endpoints", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let publishUrl = dict["publishurl"] as? String {
            self.publishUrl = publishUrl
        }
    }
    
    private func fetchContent() {
        guard let url = url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error)
                return
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(OfferResponse.self, from: data)
                if let item = decoded.data?.offerByPath?.item {
                    if let headline = item.headline {
                        DispatchQueue.main.async {
                            self.headline = headline
                        }
                    }
                    if let detail = item.detail?.plaintext {
                        DispatchQueue.main.async {
                            self.detailText = detail
                        }
                    }
                    if let cta = item.callToAction {
                        DispatchQueue.main.async {
                            self.callToAction = cta
                        }
                    }
                } else {
                    print("Headline or detail not found in decoded JSON")
                }
            } catch {
                print("Decoding error:", error)
            }
        }
        task.resume()
    }
}

struct SubscriptionCard_Previews: PreviewProvider {
    static var previews: some View {
            SubscriptionCard()
                .cornerRadius(12)
                .padding(.horizontal, 32)
        }
}
