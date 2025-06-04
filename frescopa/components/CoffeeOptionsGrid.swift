import SwiftUI

struct CoffeeOptionsGrid: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            coffeeOption(name: "Frescopa Special", coffeeImage: "asset-5")
            coffeeOption(name: "Black Coffee", coffeeImage: "asset-4")
            coffeeOption(name: "Espresso", coffeeImage: "asset-3")
            coffeeOption(name: "Cappuccino", coffeeImage: "asset-2")
            coffeeOption(name: "Milk", coffeeImage: "asset-1")
            coffeeOption(name: "Water", coffeeImage: "asset-6")
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
    }
    
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
}

struct CoffeeOptionsGrid_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeOptionsGrid()
            .previewLayout(.sizeThatFits)
    }
}
