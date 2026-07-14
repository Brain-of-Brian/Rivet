import SwiftUI

enum SkyBluePalette: String, CaseIterable {
    case SkyGlow
    case SummerSky
    case ClearWater
    case CoastalTeal
    
    var color: Color {
        switch self {
        case .SkyGlow:
            return Color(red: 188/255, green: 230/255, blue: 255/255)
        case .SummerSky:
            return Color(red: 124/255, green: 208/255, blue: 255/255)
        case .ClearWater:
            return Color(red: 66/255,  green: 178/255, blue: 236/255)
        case .CoastalTeal:
            return Color(red: 26/255,  green: 149/255, blue: 205/255)
        }
    }
}
enum MidnightNavyPalette: String, CaseIterable {
    case AbyssalBlack
    case MidnightNavy
    case DeepMariner
    case GlowingCobalt
    
    var color: Color {
        switch self {
        case .AbyssalBlack:
            return Color(red: 3/255, green: 11/255, blue: 30/255)
        case .MidnightNavy:
            return Color(red: 13/255, green: 31/255, blue: 77/255)
        case .DeepMariner:
            return Color(red: 26/255, green: 53/255, blue: 124/255)
        case .GlowingCobalt:
            return Color(red: 44/255, green: 82/255, blue: 178/255)
        }
    }
}
enum IceWhitePalette: String, CaseIterable {
    case PureSnow
    case GlacierFrost
    case PowderIce
    case ArcticBreeze
    
    var color: Color {
        switch self {
        case .PureSnow:
            return Color(red: 255/255, green: 255/255, blue: 255/255)
        case .GlacierFrost:
            return Color(red: 244/255, green: 249/255, blue: 252/255)
        case .PowderIce:
            return Color(red: 227/255, green: 239/255, blue: 245/255)
        case .ArcticBreeze:
            return Color(red: 197/255, green: 220/255, blue: 232/255)
        }
    }
}
enum OceanBluePalette: String, CaseIterable {
    case DeepNavy
    case OceanBlue
    case ScubaCyan
    case Seafoam
    
    var color: Color {
        switch self {
        case .DeepNavy:
            return Color(red: 11/255, green: 45/255, blue: 114/255)
        case .OceanBlue:
            return Color(red: 9/255, green: 146/255, blue: 194/255)
        case .ScubaCyan:
            return Color(red: 10/255, green: 196/255, blue: 224/255)
        case .Seafoam:
            return Color(red: 235/255, green: 244/255, blue: 246/255)
        }
    }
}

// tasks saved on the phone w appstorage
// each task is name:::description, tasks joined w |||
func getTasks(_ raw: String) -> [String] {
    if raw == "" {
        return []
    }
    return raw.components(separatedBy: "|||")
}

func makeTasksRaw(_ list: [String]) -> String {
    list.joined(separator: "|||")
}

func getTaskName(_ packed: String) -> String {
    let parts = packed.components(separatedBy: ":::")
    if parts.count >= 1 {
        return parts[0]
    }
    return packed
}

func getTaskDescription(_ packed: String) -> String {
    let parts = packed.components(separatedBy: ":::")
    if parts.count >= 2 {
        return parts[1]
    }
    // old tasks that were just one string
    return packed
}

func makePackedTask(_ name: String, _ description: String) -> String {
    name + ":::" + description
}

// which tasks have the X — indexes as strings
func getDoneIndexes(_ raw: String) -> [Int] {
    if raw == "" {
        return []
    }
    var result: [Int] = []
    for part in raw.components(separatedBy: "|||") {
        if let n = Int(part) {
            result.append(n)
        }
    }
    return result
}

func makeDoneRaw(_ list: [Int]) -> String {
    var parts: [String] = []
    for n in list {
        parts.append(String(n))
    }
    return parts.joined(separator: "|||")
}

// same delete for every task screen — pulls one task out + fixes done indexes
func deleteTaskAt(_ index: Int, tasksRaw: inout String, doneRaw: inout String) {
    var tasks = getTasks(tasksRaw)
    if index < 0 || index >= tasks.count {
        return
    }
    tasks.remove(at: index)
    tasksRaw = makeTasksRaw(tasks)
    
    var newDones: [Int] = []
    for d in getDoneIndexes(doneRaw) {
        if d < index {
            newDones.append(d)
        } else if d > index {
            newDones.append(d - 1)
        }
    }
    doneRaw = makeDoneRaw(newDones)
}

// same save for every task screen
func saveTaskAt(_ index: Int, name: String, description: String, tasksRaw: inout String) {
    var tasks = getTasks(tasksRaw)
    if index < 0 || index >= tasks.count {
        return
    }
    tasks[index] = makePackedTask(name, description)
    tasksRaw = makeTasksRaw(tasks)
}

// bottom buttons every task page always uses (shells for now)
struct TaskScreenBottomActions: View {
    var body: some View {
        VStack(spacing: 12) {
            Button {
                // confirm done — empty shell for now
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Text("Confirm task is done")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
            
            Button {
                // AI break it down — empty shell for now
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 55)
                        .foregroundStyle(ContentView.Background1)
                    Text("AI break it down")
                        .font(.headline)
                        .foregroundStyle(IceWhitePalette.PureSnow.color)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
    }
}

// Delete + Save toolbar — same for every task detail screen going forward
struct TaskScreenToolbarModifier: ViewModifier {
    var index: Int
    @Binding var name: String
    @Binding var text: String
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("doneIndexes") var doneRaw = ""
    @Environment(\.dismiss) var dismiss
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Delete") {
                        var tasksCopy = tasksRaw
                        var donesCopy = doneRaw
                        deleteTaskAt(index, tasksRaw: &tasksCopy, doneRaw: &donesCopy)
                        tasksRaw = tasksCopy
                        doneRaw = donesCopy
                        dismiss()
                    }
                    .foregroundStyle(.red)
                    
                    Button("Save") {
                        var tasksCopy = tasksRaw
                        saveTaskAt(index, name: name, description: text, tasksRaw: &tasksCopy)
                        tasksRaw = tasksCopy
                    }
                }
            }
    }
}

extension View {
    // slap the standard task features on any future task page
    func taskScreenFeatures(index: Int, name: Binding<String>, text: Binding<String>) -> some View {
        modifier(TaskScreenToolbarModifier(index: index, name: name, text: text))
    }
}

let startingTasks = "Finish design brief:::Review feedback and ship the brief|||Reply to team messages:::Catch up on Slack and email|||15-min walk outside:::Take a short walk to reset|||Review feedback notes:::Go through notes from design review|||Draft revised homepage:::Update the homepage layout|||Send to Jordan for review:::Send the latest draft over"

// look toggles can all be on at once
// fullColors = one solid palette color (no gradient mixes)
// contrast = summersky on dark, midnight navy on white
// simplify = strip extra UI / tighter headers

// when UI is drawn on the phone canvas then scaled up (iPad),
// we fake a phone notch inset so headers match iPhone
private struct DesignSafeTopKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0
}

extension EnvironmentValues {
    var designSafeTop: CGFloat {
        get { self[DesignSafeTopKey.self] }
        set { self[DesignSafeTopKey.self] = newValue }
    }
}

func modeAccent(contrastOn: Bool, fullColorsOn: Bool) -> Color {
    if contrastOn {
        return SkyBluePalette.SummerSky.color
    }
    return OceanBluePalette.OceanBlue.color
}

func modeDarkSolid() -> Color {
    MidnightNavyPalette.MidnightNavy.color
}

func modeLightBg() -> Color {
    IceWhitePalette.PureSnow.color
}

func modeWashBg(contrastOn: Bool, fullColorsOn: Bool) -> Color {
    if contrastOn {
        return IceWhitePalette.PureSnow.color
    }
    if fullColorsOn {
        return IceWhitePalette.GlacierFrost.color
    }
    return IceWhitePalette.PowderIce.color
}

func modeTextOnDark(contrastOn: Bool) -> Color {
    if contrastOn {
        return SkyBluePalette.SummerSky.color
    }
    return IceWhitePalette.PureSnow.color
}

func modeTextOnLight(contrastOn: Bool) -> Color {
    MidnightNavyPalette.MidnightNavy.color
}

// solid when full colors or contrast; gradient when both off
@ViewBuilder
func modeDarkHeaderShape(cornerRadius: CGFloat, contrastOn: Bool, fullColorsOn: Bool) -> some View {
    if fullColorsOn || contrastOn {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundStyle(modeDarkSolid())
    } else {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundStyle(ContentView.Background3)
    }
}

@ViewBuilder
func modeAccentShape(height: CGFloat, cornerRadius: CGFloat, contrastOn: Bool, fullColorsOn: Bool) -> some View {
    if contrastOn || fullColorsOn {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(height: height)
            .foregroundStyle(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
    } else {
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(height: height)
            .foregroundStyle(ContentView.Background1)
    }
}

// title stays clear of the camera; fill still goes edge-to-edge
struct TopSafeHeader<Content: View>: View {
    var cornerRadius: CGFloat
    var contrastOn: Bool
    var fullColorsOn: Bool
    @Environment(\.designSafeTop) var designSafeTop
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        Group {
            if designSafeTop > 0 {
                // scaled phone canvas — use the fake notch inset
                content()
                    .padding(.top, designSafeTop)
            } else {
                // real phone — use the device safe area
                content()
                    .safeAreaPadding(.top)
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            modeDarkHeaderShape(cornerRadius: cornerRadius, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                .ignoresSafeArea(edges: .top)
        }
    }
}

// lays out at a phone size, then scales up so iPad looks the same, just bigger
struct PhoneScaledRoot<Content: View>: View {
    // iPhone 15-ish logical points — everything is designed to this canvas
    let designWidth: CGFloat = 393
    let designHeight: CGFloat = 852
    // under this width, keep native layout (real phones)
    let phoneMaxWidth: CGFloat = 500
    // matches a typical Dynamic Island / notch clearance
    let phoneSafeTop: CGFloat = 59
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geo in
            if geo.size.width <= phoneMaxWidth {
                // real phone — don’t force a fixed canvas
                content()
                    .frame(width: geo.size.width, height: geo.size.height)
            } else {
                // iPad / large screen — same UI scaled to fit
                let scale = min(geo.size.width / designWidth, geo.size.height / designHeight)
                let scaledW = designWidth * scale
                let scaledH = designHeight * scale
                
                ZStack {
                    MidnightNavyPalette.MidnightNavy.color
                    
                    content()
                        .environment(\.designSafeTop, phoneSafeTop)
                        .frame(width: designWidth, height: designHeight)
                        // scale drawing, then expand hit-testing to match
                        .scaleEffect(scale)
                        .frame(width: scaledW, height: scaledH)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView: View {
    static let Background1 = LinearGradient(colors: [OceanBluePalette.DeepNavy.color,OceanBluePalette.OceanBlue.color, OceanBluePalette.ScubaCyan.color, OceanBluePalette.Seafoam.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let Background2 = LinearGradient(colors: [IceWhitePalette.PureSnow.color,IceWhitePalette.GlacierFrost.color, IceWhitePalette.PowderIce.color, IceWhitePalette.ArcticBreeze.color], startPoint: .topTrailing, endPoint: .bottomLeading)
    static let Background3 = LinearGradient(colors: [MidnightNavyPalette.AbyssalBlack.color,MidnightNavyPalette.MidnightNavy.color, MidnightNavyPalette.DeepMariner.color, MidnightNavyPalette.GlowingCobalt.color], startPoint: .topLeading, endPoint: .bottomTrailing)
    // which tab is open
    @AppStorage("tab") var tab = 0
    var body: some View {
        // bottom 3 things are real tabs now
        TabView(selection: $tab) {
            NavigationStack {
                Dashboard()
            }
            .tabItem {
                Text("Dashboard")
                Text("icon")
            }
            .tag(0)
            
            NavigationStack {
                TasksPage()
            }
            .tabItem {
                Text("Tasks")
                Text("icon")
            }
            .tag(1)
            
            NavigationStack {
                SettingsPage()
            }
            .tabItem {
                Text("Settings")
                Text("icon")
            }
            .tag(2)
        }
        .background(MidnightNavyPalette.MidnightNavy.color)
        
    }
}

#Preview {
    ContentView()
}

// settings tab — each one is its own on/off switch (can combine)
struct SettingsPage: View {
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    @Environment(\.designSafeTop) var designSafeTop
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.top, 12)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            Toggle("Simplify", isOn: $simplifyOn)
                .font(.headline)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .tint(OceanBluePalette.OceanBlue.color)
                .padding(.horizontal, 28)
            
            Toggle("Increased contrast", isOn: $contrastOn)
                .font(.headline)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .tint(OceanBluePalette.OceanBlue.color)
                .padding(.horizontal, 28)
            
            Toggle("Full colors", isOn: $fullColorsOn)
                .font(.headline)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .tint(OceanBluePalette.OceanBlue.color)
                .padding(.horizontal, 28)
            
            Spacer()
        }
        .padding(.top, designSafeTop)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(PhoneOrDeviceTopClearance(designSafeTop: designSafeTop))
        .background {
            IceWhitePalette.PureSnow.color
                .ignoresSafeArea()
        }
    }
}

// real phone uses device safe area; scaled canvas uses designSafeTop only
struct PhoneOrDeviceTopClearance: ViewModifier {
    var designSafeTop: CGFloat
    func body(content: Content) -> some View {
        if designSafeTop > 0 {
            content
        } else {
            content.safeAreaPadding(.top)
        }
    }
}

// little app box
struct AppUsageCard: View {
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 80, height: 100)
                .foregroundStyle(modeLightBg())
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(modeDarkSolid())
                Text("Instagram")
                    .font(.caption2)
                    .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
                // screentime number later
                Text("placeholder")
                    .font(.caption2)
                    .foregroundStyle(contrastOn ? MidnightNavyPalette.MidnightNavy.color : Color.red)
            }
        }
    }
}

// one task row — tap anywhere (circle or text) opens detail once
struct TaskRow: View {
    var index: Int
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("doneIndexes") var doneRaw = ""
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        let dones = getDoneIndexes(doneRaw)
        let isChecked = dones.contains(index)
        
        // only one link so it doesn’t push the page twice
        NavigationLink(destination: TaskDetailPage(index: index)) {
            HStack(alignment: .top) {
                ZStack {
                    Circle()
                        .stroke(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn), lineWidth: contrastOn ? 3 : 2)
                        .frame(width: 18, height: 18)
                    if isChecked {
                        Text("X")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                    }
                }
                .padding(.top, 2)
                
                if index < tasks.count {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(getTaskName(tasks[index]))
                            .font(.headline)
                            .foregroundStyle(isChecked ? .gray : modeTextOnLight(contrastOn: contrastOn))
                            .lineLimit(1)
                        // full description under the name
                        Text(getTaskDescription(tasks[index]))
                            .font(.caption)
                            .foregroundStyle(isChecked ? .gray : modeTextOnLight(contrastOn: contrastOn))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(modeLightBg())
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

struct Dashboard: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(spacing: 0) {
            // top dark header — hug content so simplify isn’t a giant empty block
            TopSafeHeader(cornerRadius: simplifyOn ? 40 : 60, contrastOn: contrastOn, fullColorsOn: fullColorsOn) {
                VStack {
                    if simplifyOn {
                        // only Dashboard + start focus, tighter
                        Text("Dashboard")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 12)
                        
                        NavigationLink(destination: FocusSetupPage()) {
                            ZStack {
                                modeAccentShape(height: 48, cornerRadius: 30, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                Text("Start Focus session")
                                    .font(.headline)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 14)
                        .padding(.bottom, 18)
                    } else {
                        HStack{
                            Text("Dashboard")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            Spacer()
                            ZStack {
                                modeAccentShape(height: 36, cornerRadius: 20, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                    .frame(width: 100)
                                Text("placeholder")
                                    .font(.caption)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 12)
                        
                        // screentime
                        Text("placeholder")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 20)
                        
                        Text("SCREEN TIME TODAY")
                            .font(.caption)
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                        
                        // goes to focus setup
                        NavigationLink(destination: FocusSetupPage()) {
                            ZStack {
                                modeAccentShape(height: 55, cornerRadius: 30, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                Text("Start Focus session")
                                    .font(.headline)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .padding(.bottom, 20)
                    }
                }
            }
            
            
            // app cards — hidden in simplify so tasks sit higher
            if !simplifyOn {
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundStyle(modeWashBg(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                    HStack(spacing: 12){
                        AppUsageCard()
                        AppUsageCard()
                        AppUsageCard()
                        AppUsageCard()
                    }
                }
                .frame(height: 120)
                .padding(.top, 4)
                .padding(.horizontal, 10)
            }
            
            // tasks — only this list scrolls
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(modeWashBg(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                
                VStack{
                    if !simplifyOn {
                        HStack {
                            
                            Text("TODAY'S TASKS")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
                                .padding(.leading, 20)
                            
                            Spacer()
                            NavigationLink(destination: NewTaskPage()) {
                                Text("+ Add task")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundStyle(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 15)
                    }
                    
                    List {
                        ForEach(0..<tasks.count, id: \.self) { i in
                            TaskRow(index: i)
                                .listRowInsets(EdgeInsets())
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .padding(.top, simplifyOn ? 4 : 0)
                    
                }
            }
            .frame(maxHeight: .infinity)
            
            
        }
        .background(modeLightBg())
    }
}
#Preview {
    Dashboard()
}

struct TasksPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("doneIndexes") var doneRaw = ""
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        let dones = getDoneIndexes(doneRaw)
        // how many left (not finished yet)
        var remaining = 0
        for i in 0..<tasks.count {
            if !dones.contains(i) {
                remaining += 1
            }
        }
        return VStack(spacing: 0) {
            TopSafeHeader(cornerRadius: simplifyOn ? 40 : 60, contrastOn: contrastOn, fullColorsOn: fullColorsOn) {
                VStack {
                    if simplifyOn {
                        // just Tasks + add task, tighter
                        Text("Tasks")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 12)
                        
                        NavigationLink(destination: NewTaskPage()) {
                            ZStack {
                                modeAccentShape(height: 48, cornerRadius: 30, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                Text("Add Task")
                                    .font(.headline)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 14)
                        .padding(.bottom, 18)
                    } else {
                        HStack{
                            Text("Tasks")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            Spacer()
                            ZStack {
                                modeAccentShape(height: 36, cornerRadius: 20, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                    .frame(width: 100)
                                Text("placeholder")
                                    .font(.caption)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 12)
                        
                        Text("\(remaining)")
                            .font(.system(size: 72, weight: .bold))
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 20)
                        
                        Text("TASKS REMAINING")
                            .font(.caption)
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                        
                        NavigationLink(destination: NewTaskPage()) {
                            ZStack {
                                modeAccentShape(height: 55, cornerRadius: 30, contrastOn: contrastOn, fullColorsOn: fullColorsOn)
                                Text("Add Task")
                                    .font(.headline)
                                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .padding(.bottom, 20)
                    }
                }
            }
            
            // remove button under the blue header — clears tasks with an X
            Button {
                var newTasks: [String] = []
                let dones = getDoneIndexes(doneRaw)
                for i in 0..<tasks.count {
                    if !dones.contains(i) {
                        newTasks.append(tasks[i])
                    }
                }
                tasksRaw = makeTasksRaw(newTasks)
                doneRaw = ""
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(height: 50)
                        .foregroundStyle(modeDarkSolid())
                    Text("Remove")
                        .font(.headline)
                        .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                }
            }
            .padding(.horizontal, 25)
            .padding(.top, 4)
            .padding(.bottom, 8)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundStyle(modeWashBg(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                
                // only the tasks scroll
                List {
                    ForEach(0..<tasks.count, id: \.self) { i in
                        TaskRow(index: i)
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .frame(maxHeight: .infinity)
        }
        .background(modeLightBg())
    }
}

#Preview {
    TasksPage()
}

struct NewTaskPage: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("tab") var tab = 0
    @Environment(\.dismiss) var dismiss
    @State var taskName = ""
    @State var taskText = ""
    // 1 easy 10 hard
    @State var difficulty = 5
    
    var difficultyLabel: String {
        if difficulty <= 3 {
            return "Easy"
        } else if difficulty <= 7 {
            return "Medium"
        } else {
            return "Hard"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // task name
            TextField("Task name", text: $taskName)
                .font(.title2)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
            
            // description
            TextField("Describe what you need to get done.", text: $taskText)
                .font(.title3)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            
            Text("TASK")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            Divider()
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 50)
                    .foregroundStyle(SkyBluePalette.SkyGlow.color)
                HStack {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(OceanBluePalette.OceanBlue.color)
                    Text(difficultyLabel)
                        .font(.body)
                        .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            
            Text("DIFFICULTY")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
            
            // balls 1-10 left easy right hard
            HStack(spacing: 8) {
                ForEach(1...10, id: \.self) { n in
                    Button {
                        difficulty = n
                    } label: {
                        Circle()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(n <= difficulty ? (n <= 3 ? SkyBluePalette.SkyGlow.color : (n <= 7 ? OceanBluePalette.OceanBlue.color : MidnightNavyPalette.MidnightNavy.color)) : IceWhitePalette.ArcticBreeze.color)
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(IceWhitePalette.PureSnow.color)
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // save then go right to dashboard
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // name required, description optional
                    let name = taskName.trimmingCharacters(in: .whitespacesAndNewlines)
                    if name == "" {
                        return
                    }
                    var tasks = getTasks(tasksRaw)
                    tasks.append(makePackedTask(name, taskText))
                    tasksRaw = makeTasksRaw(tasks)
                    taskName = ""
                    taskText = ""
                    tab = 0
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewTaskPage()
    }
}

// page when u click a task — always uses the shared task features
struct TaskDetailPage: View {
    var index: Int
    @AppStorage("tasks") var tasksRaw = startingTasks
    @State var name = ""
    @State var text = ""
    
    var body: some View {
        VStack(spacing: 0) {
            // edit the name
            TextField("Task name", text: $name)
                .font(.title2)
                .bold()
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
            
            // edit the description
            TextField("Describe what you need to get done.", text: $text)
                .font(.title3)
                .foregroundStyle(MidnightNavyPalette.MidnightNavy.color)
                .padding(.horizontal, 20)
            
            Spacer()
            
            // same bottom buttons every time
            TaskScreenBottomActions()
        }
        .background(IceWhitePalette.PureSnow.color)
        .taskScreenFeatures(index: index, name: $name, text: $text)
        .onAppear {
            let tasks = getTasks(tasksRaw)
            if index < tasks.count {
                name = getTaskName(tasks[index])
                text = getTaskDescription(tasks[index])
            }
        }
    }
}

#Preview {
    TaskDetailPage(index: 0)
}

// bottom for all apps mode
struct FocusSetupAllAppsBottom: View {
    @AppStorage("tasks") var tasksRaw = startingTasks
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    var body: some View {
        let tasks = getTasks(tasksRaw)
        VStack(alignment: .leading, spacing: 16) {
            if !simplifyOn {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 90)
                        .foregroundStyle(modeLightBg())
                    VStack(spacing: 6) {
                        Text("All apps blocked")
                            .font(.headline)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
                        Text("Distracting apps stay locked until you're done")
                            .font(.caption)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.6))
                    }
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("UNTIL DONE")
                        .font(.caption)
                        .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.6))
                    Spacer()
                    Text("placeholder")
                        .font(.caption)
                        .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.6))
                }
                .padding(.horizontal, 20)
            }
            
            ForEach(0..<tasks.count, id: \.self) { i in
                TaskRow(index: i)
            }
        }
    }
}

// bottom for select apps mode
struct FocusSetupSelectAppsBottom: View {
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !simplifyOn {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 44)
                        .foregroundStyle(modeLightBg())
                    HStack {
                        Text("Search apps...")
                            .font(.body)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.5))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, 20)
            }
            
            AppSelectRow(name: "Amazon")
            AppSelectRow(name: "Calendar")
            AppSelectRow(name: "Chrome")
            AppSelectRow(name: "Discord")
            AppSelectRow(name: "FaceTime")
            
            if !simplifyOn {
                Text("BREAKS")
                    .font(.caption)
                    .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.6))
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                HStack(spacing: 0) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(modeLightBg())
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(height: 40)
                            .foregroundStyle(modeLightBg())
                        Text("placeholder")
                            .font(.subheadline)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct AppSelectRow: View {
    var name: String
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 36, height: 36)
                .foregroundStyle(modeDarkSolid())
            Text(name)
                .font(.body)
                .foregroundStyle(modeTextOnLight(contrastOn: contrastOn))
            Spacer()
            Circle()
                .stroke(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn), lineWidth: contrastOn ? 3 : 2)
                .frame(width: 22, height: 22)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct FocusSetupPage: View {
    // switches the bottom half
    @State var showSelectApps = false
    @AppStorage("simplifyOn") var simplifyOn = false
    @AppStorage("contrastOn") var contrastOn = false
    @AppStorage("fullColorsOn") var fullColorsOn = true
    
    
    var body: some View {
        VStack(spacing: 0) {
            TopSafeHeader(cornerRadius: simplifyOn ? 32 : 40, contrastOn: contrastOn, fullColorsOn: fullColorsOn) {
                VStack(alignment: .leading, spacing: 8) {
                    if simplifyOn {
                        Text("Focus Setup")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 12)
                        
                        Text("Finish design brief")
                            .font(.title3)
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.bottom, 14)
                    } else {
                        HStack {
                            Text("Focus Setup")
                                .font(.title3)
                                .bold()
                                .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            Spacer()
                        }
                        .padding(.top, 12)
                        
                        Text(showSelectApps ? "FOCUSING ON" : "STARTING WITH")
                            .font(.caption)
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                            .padding(.top, 20)
                        
                        Text("Finish design brief")
                            .font(.title)
                            .bold()
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                        
                        Text("placeholder")
                            .font(.caption)
                            .foregroundStyle(modeTextOnDark(contrastOn: contrastOn))
                    }
                }
                .padding(.horizontal, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if !simplifyOn {
                        Text("WHAT TO BLOCK")
                            .font(.caption)
                            .foregroundStyle(modeTextOnLight(contrastOn: contrastOn).opacity(0.6))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                    
                    // these just flip the bottom
                    HStack(spacing: 0) {
                        Button {
                            showSelectApps = false
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? modeLightBg() : modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                                Text("All apps")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? modeTextOnLight(contrastOn: contrastOn) : (contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn)))
                            }
                        }
                        
                        Button {
                            showSelectApps = true
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 44)
                                    .foregroundStyle(showSelectApps ? modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn) : modeLightBg())
                                Text("Select apps")
                                    .font(.subheadline)
                                    .foregroundStyle(showSelectApps ? (contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn)) : modeTextOnLight(contrastOn: contrastOn))
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, simplifyOn ? 16 : 0)
                    
                    if showSelectApps {
                        FocusSetupSelectAppsBottom()
                    } else {
                        FocusSetupAllAppsBottom()
                    }
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 55)
                    .foregroundStyle(modeAccent(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
                Text("Start Focus Session")
                    .font(.headline)
                    .foregroundStyle(contrastOn ? modeTextOnLight(contrastOn: contrastOn) : modeTextOnDark(contrastOn: contrastOn))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .background(modeWashBg(contrastOn: contrastOn, fullColorsOn: fullColorsOn))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    FocusSetupPage()
}

