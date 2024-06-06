import SwiftUI
import CoreMotion

func mapRange(value: Double, start: Double = 0, end: Double = 0) -> Double {
    let targetRangeMin: Double = start
    let targetRangeMax: Double = end
    // Linear transformation
    let mappedValue = (value - targetRangeMin) / (targetRangeMax - targetRangeMin)
    return mappedValue
}


struct CustomCircle: View {
    var trimEnd: CGFloat = 1.0
    var color: Color
    var lineWidth: CGFloat
    var size: CGFloat
    var opacity: Double = 1.0
    var isFive: Bool = false
    
    var shadowOpacity: Double = 0
    var shadowRadius: Double = 10
    var shadowColor: Color = Color(red: 0.656, green: 0.515, blue: 0.014)
    var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    
    @EnvironmentObject var motionManager: MotionManager

    var body: some View {
        Circle()
            .trim(from: 0, to: trimEnd)
            .rotation(.degrees(-90))
            .stroke(color, style: StrokeStyle(lineWidth: calculatedWidth(Double(trimEnd), target: Double(lineWidth), isFive: isFive), lineCap: .round))
            .frame(width: size, height: size)
            .opacity(opacity)
            .shadow(color: shadowColor.opacity(shadowOpacity), radius: shadowRadius, x: motionManager.shadowOffset.width, y: motionManager.shadowOffset.height)
            .padding(10)
    }
}

func calculatedWidth(_ value: Double, target: Double, isFive: Bool = false) -> Double {
    if value < 0.0005 {
        return value * 55
    } else {
        return target
    }
}


struct InfiniteSun: View {
    var hue: Double
    @StateObject private var motionManager = MotionManager()
    @Binding var duration: Int? {
        didSet {
            withAnimation {
                end1 = mapRange(value: Double(duration ?? 0), start: 0, end: 280_000)
                end2 = mapRange(value: Double(duration ?? 0), start: 300_001, end: 1_800_000)
                end3 = mapRange(value: Double(duration ?? 0), start: 1_800_001, end: 5_400_000)
                end4 = mapRange(value: Double(duration ?? 0), start: 5_400_001, end: 10_800_000)
            }
        }
    }

    init(hue: Double, duration: Binding<Int?>) {
        self.hue = hue
        self._duration = duration
        self._end1 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 0, end: 300_000))
        self._end2 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 300_001, end: 1_800_000))
        self._end3 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 1_800_001, end: 5_400_000))
        self._end4 = State(initialValue: mapRange(value: Double(duration.wrappedValue ?? 0), start: 5_400_001, end: 10_800_000))
    }

    @State private var end1: Double
    @State private var end2: Double
    @State private var end3: Double
    @State private var end4: Double

    var body: some View {
        let calculatedHue = hue / 360
        let hslColor1 = Color(hue: calculatedHue, saturation: 0.4, brightness: 1)
        let hslColor2 = Color(hue: calculatedHue, saturation: 0.52, brightness: 1)
        let hslColor3 = Color(hue: calculatedHue, saturation: 0.72, brightness: 1)
        let hslColor4 = Color(hue: calculatedHue, saturation: 0.90, brightness: 1)
        let bgColor = hslColor1

        ZStack {

            //strokes
            CustomCircle(color: bgColor, lineWidth: 2, size: 280, opacity: 0.6)
            CustomCircle(color: bgColor, lineWidth: 2, size: 340, opacity: 0.6)
            CustomCircle(color: bgColor, lineWidth: 2, size: 178, opacity: 0.6)
            CustomCircle(color: bgColor, lineWidth: 2, size: 80, opacity: 0.75)

            
            //backgrounds
            CustomCircle(trimEnd: 1, color: bgColor, lineWidth: 30, size: 311, opacity: 0.1)
            CustomCircle(trimEnd: 1, color: bgColor, lineWidth: 50, size: 231, opacity: 0.25)
            CustomCircle(trimEnd: 1, color: bgColor, lineWidth: 50, size: 131, opacity: 0.4)
            CustomCircle(trimEnd: 1, color: bgColor, lineWidth: 40, size: 41, opacity: 0.1)
           
          
            
            
            CustomCircle(trimEnd: end4, color: hslColor4, lineWidth: 30, size: 311, shadowOpacity: 0)
            CustomCircle(trimEnd: end3, color: hslColor3, lineWidth: 50, size: 231, shadowOpacity:0.2)
            CustomCircle(trimEnd: end2, color: hslColor2, lineWidth: 50, size: 131,shadowOpacity:0.2)
            CustomCircle(trimEnd: end1, color: hslColor1, lineWidth: 40, size: 41, isFive: true, shadowOpacity:0.2)
            
            
            
            
        }
        .onChange(of: duration, updateEndValues)
        .environmentObject(motionManager)
    }

    private func updateEndValues() {
        withAnimation{
            end1 = mapRange(value: Double(duration ?? 0), start: 0, end: 300_000)
            end2 = mapRange(value: Double(duration ?? 0), start: 300_001, end: 1_800_000)
            end3 = mapRange(value: Double(duration ?? 0), start: 1_800_001, end: 5_400_000)
            end4 = mapRange(value: Double(duration ?? 0), start: 5_400_001, end: 10_800_000)
        }
    }
}



