import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

func mapRange(value: Double, start: Double = 0, end: Double =  0) -> Double {
    
    let targetRangeMin: Double = start
    let targetRangeMax: Double = end
    
    // Linear transformation
    let mappedValue = (value - targetRangeMin)/(targetRangeMax-targetRangeMin)
    
    return mappedValue
}

struct InfiniteSun: View {
    var hue: Double = Double.random(in: 35...52)
    @State var duration: Int = 0 {
        didSet {
            withAnimation {
                            end1 = mapRange(value: Double(duration), start: 0, end: 300_000)
                            end2 = mapRange(value: Double(duration), start: 300_001, end: 1_800_000)
                            end3 = mapRange(value: Double(duration), start: 1_800_001, end: 5_400_000)
                            end4 = mapRange(value: Double(duration), start: 5_400_001, end: 10_800_000)
                        }
        }
    }
    init(duration: Int) {
        self.duration = duration
        end1 = mapRange(value: Double(duration), start: 0, end: 300_000)
        end2 = mapRange(value: Double(duration), start: 300_001, end: 1_800_000)
        end3 = mapRange(value: Double(duration), start: 1_800_001, end: 5_400_000)
        end4 = mapRange(value: Double(duration), start: 5_400_001, end: 10_800_000)
    }
    
    @State var sections: Double = 1
    
    @State var end1: Double
    @State var end2: Double
    @State var end3: Double
    @State var end4: Double
    
    
    
    var body: some View {
        let calculatedHue = hue / 360
        let hslColor1 = Color(hue: calculatedHue, saturation: 0.4, brightness: 1)
        let hslColor2 = Color(hue: calculatedHue, saturation: 0.52, brightness: 1)
        let hslColor3 = Color(hue: calculatedHue, saturation: 0.72, brightness: 1)
        let hslColor4 = Color(hue: calculatedHue, saturation: 0.88, brightness: 1)
        
        Button("Random Time") {
            duration = Int.random(in: 0...10_800_000)
        }
        
        
        ZStack {
            Circle()
                .trim(from: 0, to: end1)
                .rotation(.degrees(-90))
                .stroke(hslColor1 ,style: StrokeStyle(lineWidth: 55, lineCap: .round))
                .frame(width: 60, height: 60)
            Circle()
                .trim(from: 0, to: end2)
                .rotation(.degrees(-90))
                .stroke(hslColor2 ,style: StrokeStyle(lineWidth: 55, lineCap: .round))
                .frame(width: 160, height: 160)
            Circle()
                .trim(from: 0, to: end3)
                .rotation(.degrees(-90))
                .stroke(hslColor3 ,style: StrokeStyle(lineWidth: 55, lineCap: .round))
                .frame(width: 260, height: 260)
            Circle()
                .trim(from: 0, to: end4)
                .rotation(.degrees(-90))
                .stroke(hslColor4 ,style: StrokeStyle(lineWidth: 45, lineCap: .round))
                .frame(width: 340, height: 340)
        }.padding(12)
        Slider(value: durationDouble, in: 0...10_800_000, step: 1)
                       .padding()
        
        
    }
    private var durationDouble: Binding<Double> {
            Binding(
                get: { Double(duration) },
                set: { duration = Int($0) }
            )
        }

}



let threeMn: Int = 3 * 1000 * 60
#Preview {
    InfiniteSun(duration: threeMn)
}


