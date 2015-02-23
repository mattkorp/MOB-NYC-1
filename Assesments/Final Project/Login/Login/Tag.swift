//
//  Tag.swift
//  Login
//
//  Created by Matthew Korporaal on 2/23/15.
//  Copyright (c) 2015 Matthew Korporaal. All rights reserved.
//

import Foundation
import Parse

class Tag {
    
    // Colors
    var backgroundColor = UIColor.lightGrayColor()
    var tagLightColor = UIColor.whiteColor()
    var tagDarkColor = UIColor(red:0.59, green:0.79, blue:1, alpha:1)
    var tagBorderColor = UIColor(red:0.27, green:0.61, blue:0.99, alpha:1)
    
    func setTagAttributes() {
        AMTagView.appearance().tagColor = tagBorderColor
        AMTagView.appearance().innerTagColor = tagDarkColor
        AMTagView.appearance().textPadding = 14
    }
    func toggleTag(tag: AMTagView, tagList: AMTagListView, var userTags: [String: PFObject], pfObject: PFObject) -> (AMTagListView, [String: PFObject]) {
        tagList.removeTag(tag)
        var tagPostfix = self.getTagPostfixFromAMTagView(tag)
        var tagName = self.getTagNameFromAMTagView(tag)
        var newTag = AMTagView()
        if tagPostfix == " +" {
            // Add to user tag array
            userTags[tagName] = pfObject
            // Add postfix and append to AMTagList
            tagName += " -"
            newTag = tagList.addTag(tagName)
            // Set colors
            newTag.innerTagColor = UIColor.whiteColor()
            newTag.textColor = UIColor(red:0.59, green:0.79, blue:1, alpha:1)
        } else {
            // Remove tag from user's choices
            userTags[tagName] = nil
            // Remove tag from view
            tagList.removeTag(tag)
            tagName += " +"
            newTag = tagList.addTag(tagName)
            // Set colors
            newTag.innerTagColor = UIColor(red:0.59, green:0.79, blue:1, alpha:1)
            newTag.textColor = UIColor.whiteColor()
        }
        
        return (tagList, userTags)
    }
    
    func getTagPostfixFromAMTagView(tag: AMTagView) -> String {
        let (postfixStartIndex, tagName) = getTagNameAndPostfixStartIndex(tag)
        return tagName.substringFromIndex(postfixStartIndex)
    }
    func getTagNameFromAMTagView(tag: AMTagView) -> String {
        let (postfixStartIndex, tagName) = getTagNameAndPostfixStartIndex(tag)
        return tagName.substringToIndex(postfixStartIndex)
    }
    func getTagNameAndPostfixStartIndex(tag: AMTagView) -> (String.Index, String) {
        var tagName = tag.tagText()
        return (advance(tagName.endIndex, -2), tagName)
    }
}