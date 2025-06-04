import SwiftUI

struct WelcomeSection: View {
    var displayName: String?
    var greeting: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let name = displayName, !name.isEmpty {
                Text("\(greeting), \(name)")
                    .font(.custom("Baskerville", size: 36))
                    .foregroundColor(Color(hex: "6F2232"))
            } else {
                Text("\(greeting)")
                    .font(.custom("Baskerville", size: 36))
                    .foregroundColor(Color(hex: "6F2232"))
            }
            Text("Your Frescopa Smart Machine")
                .font(.custom("Baskerville", size: 24))
                .foregroundColor(Color(hex: "6F2232"))
                .padding(.top ,8)
        }
        .padding(.top)
        .padding(.horizontal, 32.0)
    }
}

struct WelcomeSection_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeSection(displayName: "Mark", greeting: "Good morning")
            .previewLayout(.sizeThatFits)
    }
}
