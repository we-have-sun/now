import SwiftUI

func mapRange(value: Double, start: Double = 0, end: Double =  0) -> Double {
    
    let targetRangeMin: Double = start
    let targetRangeMax: Double = end
    
    // Linear transformation
    let mappedValue = (value - targetRangeMin)/(targetRangeMax-targetRangeMin)
    
    return mappedValue
}

struct InfiniteSun: View {
    var hue: Double = 20
    @Binding var duration: Int? {
        didSet {
            withAnimation {
                            end1 = mapRange(value: Double(duration ?? 0), start: 0, end: 300_000)
                            end2 = mapRange(value: Double(duration ?? 0), start: 300_001, end: 1_800_000)
                            end3 = mapRange(value: Double(duration ?? 0), start: 1_800_001, end: 5_400_000)
                            end4 = mapRange(value: Double(duration ?? 0), start: 5_400_001, end: 10_800_000)
                        }
        }
    }
    init(duration: Binding<Int?>) {
            self._duration = duration
            self._end1 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 0, end: 300_000))
            self._end2 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 300_001, end: 1_800_000))
            self._end3 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 1_800_001, end: 5_400_000))
            self._end4 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 5_400_001, end: 10_800_000))
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
                .stroke(hslColor1 ,style: StrokeStyle(lineWidth: calculatedWidth(end1), lineCap: .round))
                .frame(width: 60, height: 60)
            Circle()
                .trim(from: 0, to: end2)
                .rotation(.degrees(-90))
                .stroke(hslColor2 ,style: StrokeStyle(lineWidth: calculatedWidth(end2), lineCap: .round))
                .frame(width: 160, height: 160)
            Circle()
                .trim(from: 0, to: end3)
                .rotation(.degrees(-90))
                .stroke(hslColor3 ,style: StrokeStyle(lineWidth: calculatedWidth(end3), lineCap: .round))
                .frame(width: 260, height: 260)
            Circle()
                .trim(from: 0, to: end4)
                .rotation(.degrees(-90))
                .stroke(hslColor4 ,style: StrokeStyle(lineWidth: calculatedWidth(end4), lineCap: .round))
                .frame(width: 340, height: 340)
        }.padding(12)
        Slider(value: durationDouble, in: 0...10_800_000, step: 1)
                       .padding()
        
        
    }
    func calculatedWidth(_ value: Double) -> Double{
        if (value < 0.005) {
          return value*60
        }
        else{
            return 55
        }
    }
    private var durationDouble: Binding<Double> {
            Binding(
                get: { Double(duration ?? 0) },
                set: { duration = Int($0) }
            )
        }

}


