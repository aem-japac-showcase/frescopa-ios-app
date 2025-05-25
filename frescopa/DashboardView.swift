import SwiftUI

struct DashboardView: View {
    var displayName: String?
    var username: String
    var gender: String? = "undefined"
    var beanLevel: Double = 0.5
    var waterLevel: Double = 0.8
    var cleanLevel: Double = 0.4
    var offerText: String? = "Enjoy your first cup, on us."
    
    
    var bannerURL: URL {
        
        let subhead = "CHECK THIS OUT, " + displayName!.uppercased()

        let isMan = 0 == gender?.caseInsensitiveCompare("male").rawValue ?? 1
        
        return URL(string: "https://s7ap1.scene7.com/is/image/adobeanz/Frescopa%20Mobile%20App?$subhead=\(subhead)&$headline=\(offerText ?? "We just love making cofee")&$isMan=\(isMan)&wid=2000&hei=2000&qlt=100&fit=constrain&cachebust=123")!
    }
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<22: return "Good evening"
        default: return "Hello"
        }
    }
    
    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Navigation header
                HStack {
                    Image("hamburger")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(hex: "6F2232"))
                        .frame(width: 33, height: 27)
                    
                    Spacer()
                
                    // Logo
                    HStack(spacing: 10) {
                        Image("FrescopaLogotype")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 185, height: 51)
                    }
                    
                    Spacer()
                    
                    // User profile icon
                    Image(username)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .onTapGesture {
                            // Add logout logic
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                windowScene.windows.first?.rootViewController = UIHostingController(rootView: LoginView())
                                windowScene.windows.first?.makeKeyAndVisible()
                            }
                        }
                }
                .padding(.horizontal, 32)
                .padding(.vertical, 12)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.3), radius: 1)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Welcome section
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
                        
                        // Machine status section
                        HStack(alignment: .top, spacing: 12) {

                            Spacer()

                            // Status indicators
                            VStack(alignment: .center, spacing: 16) {
                                // Bean level
                                HStack(spacing: 5) {
                                    Image("bean")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(Color(hex: "6F2232"))
                                        .frame(width: 21, height: 14.5)
                                    
                                    Spacer()
                                    
                                    ProgressView(value: beanLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 20)
                                        .clipShape(Capsule())
                                }
                                
                                // Water level
                                HStack(spacing: 5) {
                                    Image("droplet")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(Color(hex: "6F2232"))
                                        .frame(width: 12, height: 19.1)
                                    
                                    Spacer()
                                    
                                    ProgressView(value: waterLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 20)
                                        .clipShape(Capsule())
                                }
                                
                                // Clean level
                                HStack(spacing: 5) {
                                    Image("clean")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(Color(hex: "6F2232"))
                                        .frame(width: 15, height: 20)
                                    
                                    Spacer()
                                    
                                    ProgressView(value: cleanLevel)
                                        .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "6F2232")))
                                        .background(Color(hex: "E6D2C3"))
                                        .frame(width: 140, height: 20)
                                        .clipShape(Capsule())
                                }
                            }
                            .padding(.top, 12)
                            
                            
                            // Coffee machine image
                            Image("FrescopaSmartMachine")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110, height: 110)
                                .padding(0)
                            
                            Spacer()

                        }
                        .padding(.horizontal, 32.0)
                        
                        // Subscription card
                        VStack(alignment: .leading, spacing: 8) {
                            Text("MY BARISTA")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(hex: "6F2232"))
                            
                            Text("Let us do the shopping for you")
                                .font(.custom("Baskerville", size: 18))
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(hex: "F9EAD6"))
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
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            // Option 1
                            coffeeOption(name: "Frescopa Special", coffeeImage: "asset-5")
                            
                            // Option 2
                            coffeeOption(name: "Black Coffee", coffeeImage: "asset-4")
                            
                            // Option 3
                            coffeeOption(name: "Espresso", coffeeImage: "asset-3")
                            
                            // Option 4
                            coffeeOption(name: "Cappuccino", coffeeImage: "asset-2")
                            
                            // Option 5
                            coffeeOption(name: "Milk", coffeeImage: "asset-1")
                            
                            // Option 6
                            coffeeOption(name: "Water", coffeeImage: "asset-6")
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 80) // Extra space for tab bar
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
    
    // Helper function for coffee options
    private func coffeeOption(name: String, coffeeImage: String) -> some View {
        VStack {
            Image(coffeeImage)
                .resizable()
                .scaledToFit()
                .frame(width: 57, height: 99)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Text(name)
                .font(.custom("Baskerville", size: 16))
                .foregroundColor(Color(hex: "6F2232"))
                .multilineTextAlignment(.leading)
                .frame(width: 57 , height: 38)
                .padding(0)
                
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
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
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView(displayName: "Mark", username: "mszulc", gender: "male", beanLevel: 0.5, waterLevel: 0.6, cleanLevel: 0.3, offerText: "Kick off your day with a perfect cup of coffee!")
            DashboardView(displayName: "Sarah", username: "srose", gender: "female", beanLevel: 0.9, waterLevel: 0.2, cleanLevel: 0.1, offerText: "Begin each day with a perfect cup of coffee!")
        }
    }
}
