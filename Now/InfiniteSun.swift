import SwiftUI

func mapRange(value: Double, start: Double = 0, end: Double = 0) -> Double {
    let targetRangeMin: Double = start
    let targetRangeMax: Double = end
    // Linear transformation
    let mappedValue = (value - targetRangeMin) / (targetRangeMax - targetRangeMin)
    return mappedValue
}

struct InfiniteSun: View {
    var hue: Double
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

        ZStack {
            Circle()
                .trim(from: 0, to: end1)
                .rotation(.degrees(-90))
                .stroke(hslColor1, style: StrokeStyle(lineWidth: calculatedWidth(end1), lineCap: .round))
                .frame(width: 50, height: 50)
            Circle()
                .trim(from: 0, to: end2)
                .rotation(.degrees(-90))
                .stroke(hslColor2, style: StrokeStyle(lineWidth: calculatedWidth(end2), lineCap: .round))
                .frame(width: 140, height: 140)
            Circle()
                .trim(from: 0, to: end3)
                .rotation(.degrees(-90))
                .stroke(hslColor3, style: StrokeStyle(lineWidth: calculatedWidth(end3), lineCap: .round))
                .frame(width: 230, height: 230)
            Circle()
                .trim(from: 0, to: end4)
                .rotation(.degrees(-90))
                .stroke(hslColor4, style: StrokeStyle(lineWidth: (calculatedWidth(end4)-20), lineCap: .round))
                .frame(width: 310, height: 310)
        }
        .padding(12)
        .onChange(of: duration, updateEndValues)
    }

    private func updateEndValues() {
        withAnimation{
            end1 = mapRange(value: Double(duration ?? 0), start: 0, end: 300_000)
            end2 = mapRange(value: Double(duration ?? 0), start: 300_001, end: 1_800_000)
            end3 = mapRange(value: Double(duration ?? 0), start: 1_800_001, end: 5_400_000)
            end4 = mapRange(value: Double(duration ?? 0), start: 5_400_001, end: 10_800_000)
        }
    }

    func calculatedWidth(_ value: Double) -> Double {
        if value < 0.0005 {
            return value * 55
        } else {
            return 50
        }
    }
}



