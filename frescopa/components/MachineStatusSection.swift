import SwiftUI

struct MachineStatusSection: View {
    var beanLevel: Double
    var waterLevel: Double
    var cleanLevel: Double
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Spacer()
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
            Image("FrescopaSmartMachine")
                .resizable()
                .scaledToFit()
                .frame(width: 110, height: 110)
                .padding(0)
            Spacer()
        }
        .padding(.horizontal, 32.0)
    }
}

struct MachineStatusSection_Previews: PreviewProvider {
    static var previews: some View {
        MachineStatusSection(beanLevel: 0.5, waterLevel: 0.8, cleanLevel: 0.4)
            .previewLayout(.sizeThatFits)
    }
}
