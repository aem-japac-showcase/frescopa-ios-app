import SwiftUI

struct DashboardView: View {
    var displayName: String?
    var username: String
    var gender: String? = "undefined"
    var beanLevel: Double = 0.5
    var waterLevel: Double = 0.8
    var cleanLevel: Double = 0.4
    var offerText: String? = "Enjoy your first cup, on us."
    
    @State private var DMorg: String? = nil
    
    private var bannerURL: URL? {
        print("bannerURL")
        let subhead = "CHECK THIS OUT, " + displayName!.uppercased()
        let isMan = 0 == gender?.caseInsensitiveCompare("male").rawValue ?? 1
        print("subhead: \(subhead)")
        print("isMan: \(isMan)")
        guard let DMorg = DMorg else { return nil }
        let urlString =
            "https://\(DMorg)/Frescopa%20Mobile%20App?$subhead=\(subhead)&$headline=\(offerText ?? "We just love making cofee")&$isMan=\(isMan)&wid=2000&hei=2000&qlt=100&fit=constrain&cachebust=123"
        print("url: \(urlString)")
        return URL(string: urlString)
    }
    

    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Navigation header
                NavigationHeader(username: username, onLogout: nil)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Welcome section
                        WelcomeSection(displayName: displayName)
                        
                        // Machine status section
                        MachineStatusSection(beanLevel: beanLevel, waterLevel: waterLevel, cleanLevel: cleanLevel)
                        
                        // Subscription card
                        SubscriptionCard()
                            .cornerRadius(12)
                            .padding(.horizontal, 32)
                        

                        // Promo Banner
                        AsyncImage(url: bannerURL) { image in
                            image
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(maxWidth: .infinity, minHeight: 160, maxHeight: .infinity)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                            
                        
                        // Coffee options grid
                        CoffeeOptionsGrid()
                    }
                    .onAppear {
                        loadDMorg()
                    }
                }
                
                // Tab bar
                
                HStack(spacing: 43) {
                    Spacer()
                    tabItem(icon: "home", isSelected: true)
                    tabItem(icon: "machine", isSelected: false)
                    tabItem(icon: "bean", isSelected: false)
                    tabItem(icon: "cart", isSelected: false)
                    tabItem(icon: "message", isSelected: false)
                    Spacer()
                }
                .padding(.vertical, 28)
                .background(Color(hex: "A33532"))
                .padding(.horizontal, 32)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
   
    
    // Helper function for tab items
    private func tabItem(icon: String, isSelected: Bool) -> some View {
        Button(action: {
            // Tab action
        }) {
            Image(icon)
                .resizable()
                .renderingMode(.template)
                .frame(width: 32, height: 32)
                .foregroundColor(Color(hex: "F4E9DC"))
            
        }
        .background(Color.clear)
    }
    
    private func loadDMorg() {
        if let path = Bundle.main.path(forResource: "endpoints", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let dmorg = dict["dmorg"] as? String {
            self.DMorg = dmorg
        }
    }
    
    
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView(displayName: "Mark", username: "mszulc", gender: "male", beanLevel: 0.5, waterLevel: 0.6, cleanLevel: 0.3, offerText: "Kick off your day with a perfect cup of coffee!")
            DashboardView(displayName: "Sarah", username: "srose", gender: "female", beanLevel: 0.9, waterLevel: 0.2, cleanLevel: 0.1, offerText: "Begin each day with a perfect cup of coffee!")
        }
    }
}
