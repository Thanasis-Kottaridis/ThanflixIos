//
//  LanguageManager.swift
//  Allios-ios
//

import Foundation

public enum Language: String, CaseIterable {
    case en, el
    
    var acceptLanguage: String {
        switch self {
        case .en:
            return "en-US"
        case .el:
            return "el-GR"
        }
    }
}

public class LanguageManager {
    
    private struct Defaults {
        static let keyCurrentLanguage = "KeyCurrentLanguage"
        static let appleLanguages = "AppleLanguages" // system localization variable...
    }
    
    public static let shared: LanguageManager = LanguageManager()
    
    private var localeBundle: Bundle?
    private var language: Language = .el
    
    public var currentLanguage: Language {
        return language
    }
    
    public var acceptLanguage: String {
        return language.acceptLanguage
    }
    
    public var currentLocale: Locale {
        return Locale(
            identifier: currentLanguage.rawValue
        )
    }
    
    // MARK: - Init
    private init() {
        
        if let currentLanguageValue = UserDefaults.standard.string(forKey: Defaults.keyCurrentLanguage),
           let language = Language(rawValue: currentLanguageValue) {
            switchToLanguage(language, notify: false)
        } else {
            switchToLanguage(.el, notify: false)
        }
    }
    
    public func switchToLanguage(_ lang: Language, notify: Bool = true) {
        language = lang
        let currentLanguage = language.rawValue
//        UserDefaults.standard.setValue(currentLanguage, forKey: Defaults.appleLanguages)
        UserDefaults.standard.setValue(currentLanguage, forKey: Defaults.keyCurrentLanguage)
        
        setLocaleWithLanguage(currentLanguage)
        
        if notify {
            NotificationCenter.default.post(name: .languageChanged, object: nil)
        }
    }
    
    public func getLocalBundle() -> Bundle {
        if let bundle = localeBundle {
            return bundle
        } else {
            return .main
        }
    }

    private func setLocaleWithLanguage(_ selectedLanguage: String) {
        if let pathSelected = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"),
            let bundleSelected = Bundle(path: pathSelected) {
            localeBundle = bundleSelected
        } else if let pathDefault = Bundle.main.path(forResource: Language.en.rawValue, ofType: "lproj"),
            let bundleDefault = Bundle(path: pathDefault) {
            localeBundle = bundleDefault
        }
    }
}
