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
}

struct SubscriptionCard: View {
    @State private var headline: String = "Let us do the shopping for you!"
    
    private let url = URL(string: "https://publish-p149891-e1546481.adobeaemcloud.com/graphql/execute.json/frescopa/OfferByPath;path=/content/dam/frescopa/en/offers/fall-in-love-my-barista-subscription;variation=%3Cp%3Emain%3C/p%3E;ts=119.44415182073797")!
    
    var body: some View {
        ZStack {
            Image("smallbg")
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 120)
                .opacity(0.7)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .cornerRadius(12)

            VStack(alignment: .leading, spacing: 8) {
                Text("MY BARISTA")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "6F2232"))
                
                Text(headline)
                    .font(.custom("Baskerville", size: 20))
                    .foregroundColor(Color(hex: "6F2232"))
                
                Button(action: {
                    // Subscribe action
                }) {
                    Text("Subscribe")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(hex: "8E2426"))
                }
            }
            .padding()
            .background(Color(hex: "fff").opacity(0.85))
        }
        .background(Color(hex: "F9EAD6").opacity(0.85))
        .cornerRadius(12)
        .padding(.horizontal, 32)
        .onAppear(perform: fetchHeadline)
    }
    
    private func fetchHeadline() {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error:", error)
                return
            }
            guard let data = data else { return }
            print("Raw JSON:", String(data: data, encoding: .utf8) ?? "nil")
            do {
                let decoded = try JSONDecoder().decode(OfferResponse.self, from: data)
                if let headline = decoded.data?.offerByPath?.item?.headline {
                    DispatchQueue.main.async {
                        self.headline = headline
                    }
                } else {
                    print("Headline not found in decoded JSON")
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
        VStack(alignment: .leading, spacing: 20) {
            SubscriptionCard()
                .previewLayout(.sizeThatFits)
                .padding(.horizontal, 32.0)
            Spacer()
        }
        
    }
}
