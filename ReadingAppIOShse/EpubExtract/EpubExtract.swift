//
//  EpubExtract.swift
//  ReadingAppIOShse
//
//  Created by Павел Вяльцев on 16.12.2022.
//

import Foundation
import EpubExtractor

class EpubExtract {
    private let epubExtractor = EPubExtractor()
    
    var epubName: String? {
        didSet {
            self.epubExtractor.delegate = self
            let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let destinationURL = URL(string: destinationPath!)?.appendingPathComponent(epubName!)
            self.epubExtractor.extractEpub(epubURL: Bundle.main.url(forResource: epubName, withExtension: "epub")!, destinationFolder: destinationURL!)
        }
    }
    
    var epub: Epub? {
        didSet {
            self.epubPlainChapters = self.generatePlainChapters(chapters: self.epub?.chapters ?? [])
        }
    }
    
    fileprivate var epubPlainChapters: [(chapter: ChapterItem, indentationLevel: Int)] = []
    
    private func generatePlainChapters(chapters: [ChapterItem], currentIndentationLevel: Int = 0) -> [(chapter: ChapterItem, indentationLevel: Int)] {
        return chapters.reduce([], { (result, chapter) -> [(chapter: ChapterItem, indentationLevel: Int)] in
            var result = result
            
            result.append((chapter, currentIndentationLevel))
            
            result.append(contentsOf: self.generatePlainChapters(chapters: chapter.subChapters, currentIndentationLevel: currentIndentationLevel + 1))
            
            return result
        })
    }
}

extension EpubExtract: EpubExtractorDelegate {
    func epubExactorDidExtractEpub(_ epub: Epub) {
        self.epub = epub
    }
    
    func epubExtractorDidFail(error: Error?) {
        print("error while extracting the epub: \(String(describing: error))")
    }
}
